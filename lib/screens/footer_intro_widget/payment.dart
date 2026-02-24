import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/payment_model.dart';
import '../../providers/session_provider.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SessionProvider>().loadPayments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payments"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: _buildContent(session),
      ),
    );
  }

  Widget _buildContent(SessionProvider session) {
    if (session.isLoadingPayments) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ============================
          /// PAID PAYMENTS
          /// ============================
          const Text(
            "Paid Payments",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          if (session.paidPayments.isEmpty)
            const Text("No payments done.")
          else
            _buildPaymentList(session.paidPayments, isPaid: true),

          const SizedBox(height: 20),

          /// ============================
          /// UPCOMING PAYMENTS
          /// ============================
          const Text(
            "Upcoming Payments",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          if (session.upcomingPayments.isEmpty)
            const Text("No upcoming payments.")
          else
            _buildPaymentList(session.upcomingPayments, isPaid: false),
        ],
      ),
    );
  }

  Widget _buildPaymentList(List<PaymentModel> payments, {required bool isPaid}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: payments.length,
      itemBuilder: (context, index) {
        final payment = payments[index];

        return _buildPaymentCard(payment, isPaid);
      },
    );
  }

  Widget _buildPaymentCard(PaymentModel payment, bool isPaid) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isPaid ? Colors.green : Colors.orange,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Amount
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  color: isPaid ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  "${payment.amount.toStringAsFixed(2)} \$",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isPaid ? Colors.green : Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// Course
            Row(
              children: [
                const Icon(Icons.book, size: 18),
                const SizedBox(width: 8),
                Text("Course: ${payment.courseName}"),
              ],
            ),

            const SizedBox(height: 5),

            /// Child
            Row(
              children: [
                const Icon(Icons.person, size: 18),
                const SizedBox(width: 8),
                Text("Child: ${payment.childName}"),
              ],
            ),

            const SizedBox(height: 5),

            /// Date
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18),
                const SizedBox(width: 8),
                Text(_formatDate(payment.date)),
              ],
            ),

            const SizedBox(height: 10),

            /// Status
            Row(
              children: [
                Icon(
                  isPaid ? Icons.check_circle : Icons.schedule,
                  color: isPaid ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  isPaid ? "Paid" : "To Pay",
                  style: TextStyle(
                    color: isPaid ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}