import 'package:uuid/uuid.dart';
import '../models/deal.dart';

class DealRepository {
  static final DealRepository _instance = DealRepository._internal();
  static DealRepository get instance => _instance;
  
  DealRepository._internal();

  final _uuid = const Uuid();
  final List<Deal> _deals = [];

  /// Get all deals
  Future<List<Deal>> getDeals({
    DealStage? stage,
    DealPriority? priority,
    String? assignedTo,
    String? search,
  }) async {
    var deals = List<Deal>.from(_deals);

    if (stage != null) {
      deals = deals.where((d) => d.stage == stage).toList();
    }

    if (priority != null) {
      deals = deals.where((d) => d.priority == priority).toList();
    }

    if (assignedTo != null) {
      deals = deals.where((d) => d.assignedTo == assignedTo).toList();
    }

    if (search != null && search.isNotEmpty) {
      deals = deals.where((d) =>
        d.title.toLowerCase().contains(search.toLowerCase()) ||
        (d.description?.toLowerCase().contains(search.toLowerCase()) ?? false)
      ).toList();
    }

    return deals;
  }

  /// Get deal by ID
  Future<Deal?> getDealById(String id) async {
    try {
      return _deals.firstWhere((d) => d.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Create new deal
  Future<Deal> createDeal({
    required String title,
    String? description,
    required double value,
    String currency = 'USD',
    DealStage stage = DealStage.lead,
    DealPriority priority = DealPriority.medium,
    String? contactId,
    String? assignedTo,
    DateTime? expectedCloseDate,
  }) async {
    final now = DateTime.now();
    final deal = Deal(
      id: _uuid.v4(),
      title: title,
      description: description,
      value: value,
      currency: currency,
      stage: stage,
      priority: priority,
      contactId: contactId,
      assignedTo: assignedTo,
      createdAt: now,
      updatedAt: now,
      expectedCloseDate: expectedCloseDate,
    );

    _deals.add(deal);
    return deal;
  }

  /// Update deal
  Future<Deal> updateDeal(Deal deal) async {
    final index = _deals.indexWhere((d) => d.id == deal.id);
    if (index != -1) {
      _deals[index] = deal.copyWith(updatedAt: DateTime.now());
      return _deals[index];
    }
    throw Exception('Deal not found');
  }

  /// Delete deal
  Future<void> deleteDeal(String id) async {
    _deals.removeWhere((d) => d.id == id);
  }

  /// Move deal to stage
  Future<Deal> moveDealToStage(String dealId, DealStage stage) async {
    final deal = await getDealById(dealId);
    if (deal == null) {
      throw Exception('Deal not found');
    }

    final updated = deal.copyWith(
      stage: stage,
      closedAt: (stage == DealStage.won || stage == DealStage.lost)
          ? DateTime.now()
          : null,
    );

    return updateDeal(updated);
  }

  /// Add activity to deal
  Future<Deal> addActivity({
    required String dealId,
    required ActivityType type,
    required String title,
    String? description,
    DateTime? dueDate,
    String? createdBy,
  }) async {
    final deal = await getDealById(dealId);
    if (deal == null) {
      throw Exception('Deal not found');
    }

    final activity = Activity(
      id: _uuid.v4(),
      dealId: dealId,
      type: type,
      title: title,
      description: description,
      createdAt: DateTime.now(),
      createdBy: createdBy,
      dueDate: dueDate,
    );

    final updated = deal.copyWith(
      activities: [...deal.activities, activity],
    );

    return updateDeal(updated);
  }

  /// Complete activity
  Future<Deal> completeActivity(String dealId, String activityId) async {
    final deal = await getDealById(dealId);
    if (deal == null) {
      throw Exception('Deal not found');
    }

    final updatedActivities = deal.activities.map((a) {
      if (a.id == activityId) {
        return a.copyWith(isCompleted: true);
      }
      return a;
    }).toList();

    final updated = deal.copyWith(activities: updatedActivities);
    return updateDeal(updated);
  }

  /// Get deals by stage (for pipeline view)
  Future<Map<DealStage, List<Deal>>> getDealsByStage() async {
    final result = <DealStage, List<Deal>>{};
    
    for (var stage in DealStage.values) {
      result[stage] = await getDeals(stage: stage);
    }

    return result;
  }

  /// Get deal statistics
  Future<Map<String, dynamic>> getStatistics() async {
    final total = _deals.length;
    final totalValue = _deals.fold(0.0, (sum, deal) => sum + deal.value);
    
    final won = _deals.where((d) => d.stage == DealStage.won).length;
    final wonValue = _deals
        .where((d) => d.stage == DealStage.won)
        .fold(0.0, (sum, deal) => sum + deal.value);

    final lost = _deals.where((d) => d.stage == DealStage.lost).length;
    
    final winRate = (won + lost) > 0 ? (won / (won + lost)) * 100 : 0.0;

    return {
      'total': total,
      'totalValue': totalValue,
      'won': won,
      'wonValue': wonValue,
      'lost': lost,
      'winRate': double.parse(winRate.toStringAsFixed(2)),
    };
  }
}
