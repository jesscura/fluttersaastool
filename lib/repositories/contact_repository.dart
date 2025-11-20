import 'package:uuid/uuid.dart';
import '../models/contact.dart';

class ContactRepository {
  static final ContactRepository _instance = ContactRepository._internal();
  static ContactRepository get instance => _instance;
  
  ContactRepository._internal();

  final _uuid = const Uuid();
  final List<Contact> _contacts = [];

  /// Get all contacts
  Future<List<Contact>> getContacts({
    ContactStatus? status,
    String? search,
    List<String>? tags,
  }) async {
    var contacts = List<Contact>.from(_contacts);

    if (status != null) {
      contacts = contacts.where((c) => c.status == status).toList();
    }

    if (search != null && search.isNotEmpty) {
      contacts = contacts.where((c) =>
        c.email.toLowerCase().contains(search.toLowerCase()) ||
        (c.firstName?.toLowerCase().contains(search.toLowerCase()) ?? false) ||
        (c.lastName?.toLowerCase().contains(search.toLowerCase()) ?? false) ||
        (c.company?.toLowerCase().contains(search.toLowerCase()) ?? false)
      ).toList();
    }

    if (tags != null && tags.isNotEmpty) {
      contacts = contacts.where((c) =>
        tags.any((tag) => c.tags.contains(tag))
      ).toList();
    }

    return contacts;
  }

  /// Get contact by ID
  Future<Contact?> getContactById(String id) async {
    try {
      return _contacts.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get contact by email
  Future<Contact?> getContactByEmail(String email) async {
    try {
      return _contacts.firstWhere((c) => c.email == email);
    } catch (e) {
      return null;
    }
  }

  /// Create new contact
  Future<Contact> createContact({
    required String email,
    String? firstName,
    String? lastName,
    String? company,
    String? phoneNumber,
    List<String> tags = const [],
    Map<String, dynamic> customFields = const {},
  }) async {
    // Check if contact already exists
    final existing = await getContactByEmail(email);
    if (existing != null) {
      throw Exception('Contact with this email already exists');
    }

    final now = DateTime.now();
    final contact = Contact(
      id: _uuid.v4(),
      email: email,
      firstName: firstName,
      lastName: lastName,
      company: company,
      phoneNumber: phoneNumber,
      tags: tags,
      customFields: customFields,
      createdAt: now,
    );

    _contacts.add(contact);
    return contact;
  }

  /// Update contact
  Future<Contact> updateContact(Contact contact) async {
    final index = _contacts.indexWhere((c) => c.id == contact.id);
    if (index != -1) {
      _contacts[index] = contact;
      return contact;
    }
    throw Exception('Contact not found');
  }

  /// Delete contact
  Future<void> deleteContact(String id) async {
    _contacts.removeWhere((c) => c.id == id);
  }

  /// Import contacts from list
  Future<Map<String, dynamic>> importContacts(List<Map<String, dynamic>> contactsData) async {
    int added = 0;
    int updated = 0;
    int skipped = 0;
    final errors = <String>[];

    for (var data in contactsData) {
      try {
        final email = data['email'] as String?;
        if (email == null || email.isEmpty) {
          skipped++;
          continue;
        }

        final existing = await getContactByEmail(email);
        if (existing != null) {
          // Update existing contact
          final updated_contact = existing.copyWith(
            firstName: data['firstName'] as String?,
            lastName: data['lastName'] as String?,
            company: data['company'] as String?,
            phoneNumber: data['phoneNumber'] as String?,
          );
          await updateContact(updated_contact);
          updated++;
        } else {
          // Create new contact
          await createContact(
            email: email,
            firstName: data['firstName'] as String?,
            lastName: data['lastName'] as String?,
            company: data['company'] as String?,
            phoneNumber: data['phoneNumber'] as String?,
          );
          added++;
        }
      } catch (e) {
        errors.add('Error processing contact: ${e.toString()}');
        skipped++;
      }
    }

    return {
      'added': added,
      'updated': updated,
      'skipped': skipped,
      'errors': errors,
    };
  }

  /// Export contacts to list
  Future<List<Map<String, dynamic>>> exportContacts() async {
    return _contacts.map((c) => c.toJson()).toList();
  }

  /// Add tag to contact
  Future<Contact> addTag(String contactId, String tag) async {
    final contact = await getContactById(contactId);
    if (contact == null) {
      throw Exception('Contact not found');
    }

    if (!contact.tags.contains(tag)) {
      final updated = contact.copyWith(
        tags: [...contact.tags, tag],
      );
      return updateContact(updated);
    }

    return contact;
  }

  /// Remove tag from contact
  Future<Contact> removeTag(String contactId, String tag) async {
    final contact = await getContactById(contactId);
    if (contact == null) {
      throw Exception('Contact not found');
    }

    final updated = contact.copyWith(
      tags: contact.tags.where((t) => t != tag).toList(),
    );
    return updateContact(updated);
  }

  /// Get contact statistics
  Future<Map<String, dynamic>> getStatistics() async {
    final total = _contacts.length;
    final active = _contacts.where((c) => c.status == ContactStatus.active).length;
    final unsubscribed = _contacts.where((c) => c.status == ContactStatus.unsubscribed).length;
    final bounced = _contacts.where((c) => c.status == ContactStatus.bounced).length;

    return {
      'total': total,
      'active': active,
      'unsubscribed': unsubscribed,
      'bounced': bounced,
    };
  }
}
