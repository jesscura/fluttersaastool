import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_drawer.dart';
import '../../models/deal.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deals Pipeline')),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: DealStage.values.map((stage) => _buildStageColumn(context, stage)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/deals/create'),
        icon: const Icon(Icons.add),
        label: const Text('New Deal'),
      ),
    );
  }

  Widget _buildStageColumn(BuildContext context, DealStage stage) {
    return Container(
      width: 300,
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                stage.name.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ...List.generate(
            2,
            (index) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text('Deal ${index + 1}'),
                subtitle: Text('\$${(index + 1) * 1000}'),
                onTap: () => context.go('/deals/${index + 1}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
