import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/core/notify_data.dart';
import 'package:provider/provider.dart';
import '../../core/constance_presentation.dart';
import '../../core/constances.dart';
import '../../core/core_translator.dart';
import '../../providers/session_provider.dart';
import '../../widgets/app_scaffold.dart';

class Presentation extends StatefulWidget {
  const Presentation({super.key});

  @override
  State<Presentation> createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  final _formKey = GlobalKey<FormState>();
  Translator translator = Translator();

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  String _selectedCategory = '';

  List<String> _categories = [];

  void changeCategoryInialise(NotifyData notifyData) {
    if (notifyData.currentLanguage == NotifyData.languageEN) {
      _categories = [
        NotifyData.CategoryRequestInformationEN,
        NotifyData.CategoryComplainEN,
        NotifyData.CategorySuggestionEN,
        NotifyData.CategoryOtherEN
      ];
      _selectedCategory = NotifyData.CategoryRequestInformationEN;
    } else {
      _categories = [
        NotifyData.CategoryRequestInformationFR,
        NotifyData.CategoryComplainFR,
        NotifyData.CategorySuggestionFR,
        NotifyData.CategoryOtherFR
      ];
      _selectedCategory = NotifyData.CategoryRequestInformationFR;
    }
  }

  @override
  void initState() {
    super.initState();

    // Load latest news after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SessionProvider>().getLatestNews();
    });
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _sendRequest() async {
    if (!_formKey.currentState!.validate()) return;

    final session = context.read<SessionProvider>();
    final notifyData = context.watch<NotifyData>();

    await session.sendEmail(
      subject: _subjectController.text,
      category: _selectedCategory,
      content: _contentController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(translator.getText('EmailSent'))),
    );

    _subjectController.clear();
    _contentController.clear();
    setState(() {
      _selectedCategory = translator.getText('CategoryRequestInformation');
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();
    final notifyData = context.watch<NotifyData>();
    translator = Translator(status: StatusLangue.CONSTANCE_PRESENTATION, lang: notifyData.currentLanguage);
    final newsList = session.latestNews;
    changeCategoryInialise(notifyData);

    return AppScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: Constant.getTitle1ButtonStyle(),
                child: Text(translator.getText('Learn4Kids')),
              ),
            ),
            const SizedBox(height: 10),

            /// ===============================
            /// 1. PRESENTATION SECTION
            /// ===============================
            Text(
              translator.getText('Welcome2Learn4Kids'),
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 10),

            Text(translator.getText('WelcomeMessage'),
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            /// ===============================
            /// 2. LATEST NEWS
            /// ===============================
            Text(translator.getText('LatestNews'),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 10),

            if (newsList.isEmpty)
              Text(translator.getText('NoNewsAvailable'),
                  style: TextStyle(color: Colors.blue))
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: newsList.length,
                itemBuilder: (_, i) {
                  final news = newsList[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        news.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(news.description),
                          const SizedBox(height: 5),
                          Text(
                            news.date.toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

            const SizedBox(height: 20),

            /// ===============================
            /// 3. CONTACT / REQUEST FORM
            /// ===============================
            Text(translator.getText('ContactUs'),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 10),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  /// Subject
                  TextFormField(
                    controller: _subjectController,
                    decoration:  InputDecoration(
                      labelText:
                          translator.getText('Subject'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty
                        ? translator.getText('EnterSubject')
                        : null,
                  ),

                  const SizedBox(height: 10),

                  /// Category
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      labelText:translator.getText('Category'),
                      border: OutlineInputBorder(),
                    ),
                    items: _categories.map((c) {
                      return DropdownMenuItem(
                        value: c,
                        child: Text(c),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  /// Content
                  TextFormField(
                    controller: _contentController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText:translator.getText('Content'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty
                        ? translator.getText('EnterMessage')
                        : null,
                  ),

                  const SizedBox(height: 15),

                  /// Send Button
                  ElevatedButton(
                    onPressed: _sendRequest,
                    style: Constant.getTitle3ButtonStyle(),
                    child: Text(translator.getText('Send')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
