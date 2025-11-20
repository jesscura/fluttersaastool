import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../models/campaign.dart';
import '../models/contact.dart';

class EmailService {
  static final EmailService _instance = EmailService._internal();
  static EmailService get instance => _instance;
  
  EmailService._internal();

  // SMTP Configuration
  late SmtpServer _smtpServer;

  void configure({
    required String host,
    required int port,
    required String username,
    required String password,
    bool ssl = true,
  }) {
    _smtpServer = SmtpServer(
      host,
      port: port,
      username: username,
      password: password,
      ssl: ssl,
    );
  }

  /// Send a single email
  Future<bool> sendEmail({
    required String to,
    required String from,
    required String subject,
    required String htmlBody,
    String? textBody,
    String? fromName,
    String? replyTo,
  }) async {
    try {
      final message = Message()
        ..from = Address(from, fromName)
        ..recipients.add(to)
        ..subject = subject
        ..html = htmlBody;

      if (textBody != null) {
        message.text = textBody;
      }

      if (replyTo != null) {
        message.replyTo = [Address(replyTo)];
      }

      await send(message, _smtpServer);
      return true;
    } catch (e) {
      print('Error sending email: $e');
      return false;
    }
  }

  /// Send campaign to multiple recipients
  Future<Map<String, dynamic>> sendCampaign({
    required Campaign campaign,
    required List<Contact> recipients,
    Function(int sent, int total)? onProgress,
  }) async {
    int sent = 0;
    int failed = 0;
    final errors = <String, String>{};

    for (var i = 0; i < recipients.length; i++) {
      final contact = recipients[i];
      
      try {
        final personalizedContent = _personalize(
          campaign.content,
          contact,
        );

        final success = await sendEmail(
          to: contact.email,
          from: campaign.fromEmail,
          fromName: campaign.fromName,
          subject: campaign.subject,
          htmlBody: personalizedContent,
          replyTo: campaign.replyTo,
        );

        if (success) {
          sent++;
        } else {
          failed++;
          errors[contact.email] = 'Failed to send';
        }
      } catch (e) {
        failed++;
        errors[contact.email] = e.toString();
      }

      onProgress?.call(i + 1, recipients.length);
    }

    return {
      'sent': sent,
      'failed': failed,
      'total': recipients.length,
      'errors': errors,
    };
  }

  /// Personalize email content with contact data
  String _personalize(String content, Contact contact) {
    return content
        .replaceAll('{{firstName}}', contact.firstName ?? '')
        .replaceAll('{{lastName}}', contact.lastName ?? '')
        .replaceAll('{{email}}', contact.email)
        .replaceAll('{{company}}', contact.company ?? '')
        .replaceAll('{{fullName}}', contact.fullName);
  }

  /// Verify email address format
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Check if email domain is valid (basic check)
  Future<bool> verifyEmailDomain(String email) async {
    // This is a simplified version - in production, you'd want to
    // do actual DNS MX record lookup
    try {
      final domain = email.split('@').last;
      return domain.isNotEmpty && domain.contains('.');
    } catch (e) {
      return false;
    }
  }
}
