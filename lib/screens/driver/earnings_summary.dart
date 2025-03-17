import 'package:flutter/material.dart';

class EarningsSummaryPage extends StatelessWidget {
  final List<Map<String, String>> transactions = [
    {"trip": "Trip #1234", "amount": "\$45", "date": "March 10, 2025"},
    {"trip": "Trip #1235", "amount": "\$30", "date": "March 9, 2025"},
    {"trip": "Trip #1236", "amount": "\$60", "date": "March 8, 2025"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Earnings Summary", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Total Earnings", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Total Earnings Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 5,
              color: Colors.green[100],
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("\$2,350", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green[900])),
                    const SizedBox(height: 5),
                    Text("This Month", style: TextStyle(fontSize: 16, color: Colors.green[700])),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text("Recent Transactions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // Recent Transactions List
            Expanded(
              child: transactions.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                itemCount: transactions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return _buildEarningsTile(transaction["trip"]!, transaction["amount"]!, transaction["date"]!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📌 Earnings Tile for Each Transaction
  Widget _buildEarningsTile(String trip, String amount, String date) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        title: Text(trip, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        subtitle: Text(date, style: TextStyle(color: Colors.grey[600])),
        trailing: Text(amount, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[700])),
      ),
    );
  }

  // 📌 Empty State when there are no transactions
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.attach_money, size: 60, color: Colors.grey[400]),
          const SizedBox(height: 10),
          Text(
            "No Transactions Found",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
