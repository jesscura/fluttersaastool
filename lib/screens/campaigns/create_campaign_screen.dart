import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateCampaignScreen extends StatefulWidget {
  const CreateCampaignScreen({super.key});

  @override
  State<CreateCampaignScreen> createState() => _CreateCampaignScreenState();
}

class _CreateCampaignScreenState extends State<CreateCampaignScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _fromNameController = TextEditingController();
  final _fromEmailController = TextEditingController();
  final _replyToController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Campaign'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Campaign Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Campaign Name',
                  hintText: 'Enter campaign name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter campaign name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Email Subject',
                  hintText: 'Enter email subject',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email subject';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              
              Text(
                'Sender Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              
              TextFormField(
                controller: _fromNameController,
                decoration: const InputDecoration(
                  labelText: 'From Name',
                  hintText: 'Your name or company',
                ),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _fromEmailController,
                decoration: const InputDecoration(
                  labelText: 'From Email',
                  hintText: 'sender@example.com',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter from email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _replyToController,
                decoration: const InputDecoration(
                  labelText: 'Reply-To Email',
                  hintText: 'reply@example.com',
                ),
              ),
              const SizedBox(height: 32),
              
              Text(
                'Email Content',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Email Content',
                  hintText: 'Write your email content here...',
                  alignLabelWithHint: true,
                ),
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: _saveDraft,
                    child: const Text('Save as Draft'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _continue,
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveDraft() {
    if (_formKey.currentState!.validate()) {
      // Save draft logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Campaign saved as draft')),
      );
      context.pop();
    }
  }

  void _continue() {
    if (_formKey.currentState!.validate()) {
      // Continue to next step logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Continuing to next step...')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _subjectController.dispose();
    _fromNameController.dispose();
    _fromEmailController.dispose();
    _replyToController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
