class PublicEventResponse {
  final List<Event> events;
  final Pagination pagination;

  PublicEventResponse({required this.events, required this.pagination});

  factory PublicEventResponse.fromJson(Map<String, dynamic> json) {
    return PublicEventResponse(
      events:
          (json['events'] as List?)?.map((e) => Event.fromJson(e)).toList() ??
          [],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : Pagination(),
    );
  }

  Map<String, dynamic> toJson() => {
    'events': events.map((e) => e.toJson()).toList(),
    'pagination': pagination.toJson(),
  };
}

class Event {
  final String id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String type;
  final String image128Url;
  final String status;
  final DateTime? resolvedAt;
  final DateTime? resolutionDate;
  final String? resolutionSource;
  final List<Market> markets;
  final List<String> hashtags;
  final List<String> countryCodes;
  final List<String> regions;
  final double totalVolume;
  final DateTime createdAt;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.type,
    required this.image128Url,
    required this.status,
    this.resolvedAt,
    this.resolutionDate,
    this.resolutionSource,
    required this.markets,
    required this.hashtags,
    required this.countryCodes,
    required this.regions,
    required this.totalVolume,
    required this.createdAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      category: json['category'] ?? "",
      type: json['type'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
      image128Url: json['image128Url'] ?? "",
      status: json['status'] ?? "",
      resolvedAt: json['resolvedAt'] != null
          ? DateTime.tryParse(json['resolvedAt'])
          : null,
      resolutionDate: json['resolutionDate'] != null
          ? DateTime.tryParse(json['resolutionDate'])
          : null,
      resolutionSource: json['resolutionSource'],
      markets:
          (json['markets'] as List?)?.map((m) => Market.fromJson(m)).toList() ??
          [],
      hashtags:
          (json['hashtags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      countryCodes:
          (json['countryCodes'] as List?)?.map((e) => e.toString()).toList() ??
          [],
      regions:
          (json['regions'] as List?)?.map((e) => e.toString()).toList() ?? [],
      totalVolume: (json['totalVolume'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
    'imageUrl': imageUrl,
    'image128Url': image128Url,
    'type': type,
    'status': status,
    'resolvedAt': resolvedAt?.toIso8601String(),
    'resolutionDate': resolutionDate?.toIso8601String(),
    'resolutionSource': resolutionSource,
    'markets': markets.map((e) => e.toJson()).toList(),
    'hashtags': hashtags,
    'countryCodes': countryCodes,
    'regions': regions,
    'totalVolume': totalVolume,
    'createdAt': createdAt.toIso8601String(),
  };
}

class Market {
  final String id;
  final String title;
  final String rules;
  final String imageUrl;
  final String image128Url;
  final double yesBuyPrice;
  final double noBuyPrice;
  final int yesPriceForEstimate;
  final int noPriceForEstimate;
  final String status;
  final String? resolvedOutcome;
  final double volumeValueYes;
  final double volumeValueNo;
  final int yesProfitForEstimate;
  final int noProfitForEstimate;

  Market({
    required this.id,
    required this.title,
    required this.rules,
    required this.imageUrl,
    required this.image128Url,
    required this.yesBuyPrice,
    required this.noBuyPrice,
    required this.yesPriceForEstimate,
    required this.noPriceForEstimate,
    required this.status,
    this.resolvedOutcome,
    required this.volumeValueYes,
    required this.volumeValueNo,
    required this.yesProfitForEstimate,
    required this.noProfitForEstimate,
  });

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      rules: json['rules'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
      image128Url: json['image128Url'] ?? "",
      yesBuyPrice: (json['yesBuyPrice'] as num?)?.toDouble() ?? 0.0,
      noBuyPrice: (json['noBuyPrice'] as num?)?.toDouble() ?? 0.0,
      yesPriceForEstimate: json['yesPriceForEstimate'] ?? 0,
      noPriceForEstimate: json['noPriceForEstimate'] ?? 0,
      status: json['status'] ?? "",
      resolvedOutcome: json['resolvedOutcome'],
      volumeValueYes: (json['volumeValueYes'] as num?)?.toDouble() ?? 0.0,
      volumeValueNo: (json['volumeValueNo'] as num?)?.toDouble() ?? 0.0,
      yesProfitForEstimate: json['yesProfitForEstimate'] ?? 0,
      noProfitForEstimate: json['noProfitForEstimate'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'rules': rules,
    'imageUrl': imageUrl,
    'image128Url': image128Url,
    'yesBuyPrice': yesBuyPrice,
    'noBuyPrice': noBuyPrice,
    'yesPriceForEstimate': yesPriceForEstimate,
    'noPriceForEstimate': noPriceForEstimate,
    'status': status,
    'resolvedOutcome': resolvedOutcome,
    'volumeValueYes': volumeValueYes,
    'volumeValueNo': volumeValueNo,
    'yesProfitForEstimate': yesProfitForEstimate,
    'noProfitForEstimate': noProfitForEstimate,
  };
}

class Pagination {
  final int page;
  final int size;
  final int totalCount;
  final int lastPage;

  Pagination({
    this.page = 0,
    this.size = 0,
    this.totalCount = 0,
    this.lastPage = 0,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] ?? 0,
      size: json['size'] ?? 0,
      totalCount: json['totalCount'] ?? 0,
      lastPage: json['lastPage'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'page': page,
    'size': size,
    'totalCount': totalCount,
    'lastPage': lastPage,
  };
}
