import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/core/notify_data.dart';
import 'package:provider/provider.dart';
import '../../core/constances.dart';
import '../../providers/session_provider.dart';
import '../../widgets/app_scaffold.dart';

class Presentation extends StatefulWidget {
  const Presentation({super.key});

  @override
  State<Presentation> createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  String _selectedCategory = '';

  List<String> _categories = [];

  void changeCategoryInialise(NotifyData notifyData) {
    if (notifyData.currentLanguage == Constant.languageEN) {
      _categories = [
        ConstantPresentation.CategoryRequestInformationEN,
        ConstantPresentation.CategoryComplainEN,
        ConstantPresentation.CategorySuggestionEN,
        ConstantPresentation.CategoryOtherEN
      ];
      _selectedCategory = ConstantPresentation.CategoryRequestInformationEN;
    } else {
      _categories = [
        ConstantPresentation.CategoryRequestInformationFR,
        ConstantPresentation.CategoryComplainFR,
        ConstantPresentation.CategorySuggestionFR,
        ConstantPresentation.CategoryOtherFR
      ];
      _selectedCategory = ConstantPresentation.CategoryRequestInformationFR;
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
      const SnackBar(
          content: Text((notifyData.currentLanguage == Constant.languageEN
              ? ConstantPresentation.EmailSentEN
              : ConstantPresentation.EmailSentFR))),
    );

    _subjectController.clear();
    _contentController.clear();
    setState(() {
      _selectedCategory = notifyData.currentLanguage == Constant.languageEN
          ? ConstantPresentation.CategoryRequestInformationEN
          : ConstantPresentation.CategoryRequestInformationFR;
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();
    final notifyData = context.watch<NotifyData>();
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
                child: Text((notifyData.currentLanguage == Constant.languageEN
                    ? ConstantPresentation.Learn4KidsEN
                    : ConstantPresentation.Learn4KidsFR)),
              ),
            ),
            const SizedBox(height: 10),

            /// ===============================
            /// 1. PRESENTATION SECTION
            /// ===============================
            const Text(
              (notifyData.currentLanguage == Constant.languageEN
                  ? ConstantPresentation.Welcome2Learn4KidsEN
                  : ConstantPresentation.Welcome2Learn4KidsFR),
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 10),

            const Text(
              (notifyData.currentLanguage == Constant.languageEN
                  ? ConstantPresentation.WelcomeMessageEN
                  : ConstantPresentation.WelcomeMessageFR),
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            /// ===============================
            /// 2. LATEST NEWS
            /// ===============================
            const Text(
              (notifyData.currentLanguage == Constant.languageEN
                  ? ConstantPresentation.LatestNewsEN
                  : ConstantPresentation.LatestNewsFR),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 10),

            if (newsList.isEmpty)
              const Text(
                  (notifyData.currentLanguage == Constant.languageEN
                      ? ConstantPresentation.NoNewsAvailableEN
                      : ConstantPresentation.NoNewsAvailableFR),
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
            const Text(
              (notifyData.currentLanguage == Constant.languageEN
                  ? ConstantPresentation.ContactUsEN
                  : ConstantPresentation.ContactUsFR),
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
                    decoration: const InputDecoration(
                      labelText:
                          (notifyData.currentLanguage == Constant.languageEN
                              ? ConstantPresentation.SubjectEN
                              : ConstantPresentation.SubjectFR),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty
                        ? (notifyData.currentLanguage == Constant.languageEN
                            ? ConstantPresentation.EnterSubjectEN
                            : ConstantPresentation.EnterSubjectFR)
                        : null,
                  ),

                  const SizedBox(height: 10),

                  /// Category
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(
                      labelText:
                          (notifyData.currentLanguage == Constant.languageEN
                              ? ConstantPresentation.CategoryEN
                              : ConstantPresentation.CategoryEN),
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
                    decoration: const InputDecoration(
                      labelText:
                          (notifyData.currentLanguage == Constant.languageEN
                              ? ConstantPresentation.ContentEN
                              : ConstantPresentation.ContentFR),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty
                        ? (notifyData.currentLanguage == Constant.languageEN
                            ? ConstantPresentation.EnterMessageEN
                            : ConstantPresentation.EnterMessageFR)
                        : null,
                  ),

                  const SizedBox(height: 15),

                  /// Send Button
                  ElevatedButton(
                    onPressed: _sendRequest,
                    style: Constant.getTitle3ButtonStyle(),
                    child: const Text(
                        (notifyData.currentLanguage == Constant.languageEN
                            ? ConstantPresentation.SendEN
                            : ConstantPresentation.SendFR)),
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
