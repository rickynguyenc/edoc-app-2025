import 'package:flutter/material.dart';

extension GenericExt<T> on T {
  R let<R>(R Function(T t) transform) => transform(this);

  R? safeCast<R>() => this is R ? (this as R) : null;
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map?.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class RightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final oneThirdWidth = size.width / 3.0;
    final path = Path()
      ..lineTo(0.0, size.height)
      ..lineTo(oneThirdWidth, size.height)
      ..lineTo(oneThirdWidth * 2, size.height)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(oneThirdWidth * 2, 0.0)
      ..lineTo(oneThirdWidth, 0.0)
      // ..lineTo(0.0, size.height / 2)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class KeyValues {
  dynamic key;
  String value;
  KeyValues(this.key, this.value);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class PageLink {
  final String sorting;
  final int skipCount;
  final int maxResultCount;
  final String filter;
  final String? categoryId;
  final String? type; // my document filter
  PageLink({
    this.sorting = 'Lastest',
    this.skipCount = 0,
    this.maxResultCount = 20,
    this.filter = '',
    this.categoryId,
    this.type,
  });
  // toJson
  Map<String, dynamic> toJson() {
    return {
      'filter': filter,
      'sorting': sorting,
      'skipCount': skipCount,
      'maxResultCount': maxResultCount,
      'categoryId': categoryId,
      'type': type,
    };
  }

  // copy with
  PageLink copyWith({
    String? sorting,
    int? skipCount,
    int? maxResultCount,
    String? filter,
    String? categoryId,
    String? type,
  }) {
    return PageLink(
      sorting: sorting ?? this.sorting,
      skipCount: skipCount ?? this.skipCount,
      maxResultCount: maxResultCount ?? this.maxResultCount,
      filter: filter ?? this.filter,
      categoryId: categoryId ?? this.categoryId,
      type: type ?? this.type,
    );
  }

  PageLink setNullCategoryId({
    String? sorting,
    int? skipCount,
    int? maxResultCount,
    String? filter,
    String? categoryId,
    String? type,
  }) {
    return PageLink(sorting: sorting ?? this.sorting, skipCount: skipCount ?? this.skipCount, maxResultCount: maxResultCount ?? this.maxResultCount, filter: filter ?? this.filter, categoryId: null);
  }
}

class PageLink2 {
  final String? sorting;
  final int skipCount;
  final int maxResultCount;
  final String? filter;
  final String? categoryId;
  final String? type; // my document filter
  PageLink2({
    this.sorting,
    this.skipCount = 0,
    this.maxResultCount = 10,
    this.filter,
    this.categoryId,
    this.type,
  });
  // toJson
  Map<String, dynamic> toJson() {
    return {
      'filter': filter,
      'sorting': sorting,
      'skipCount': skipCount,
      'maxResultCount': maxResultCount,
      'categoryId': categoryId,
      'type': type,
    };
  }

  // copy with
  PageLink2 copyWith({
    String? sorting,
    int? skipCount,
    int? maxResultCount,
    String? filter,
    String? categoryId,
    String? type,
  }) {
    return PageLink2(
      sorting: sorting ?? this.sorting,
      skipCount: skipCount ?? this.skipCount,
      maxResultCount: maxResultCount ?? this.maxResultCount,
      filter: filter ?? this.filter,
      categoryId: categoryId ?? this.categoryId,
      type: type ?? this.type,
    );
  }
}
