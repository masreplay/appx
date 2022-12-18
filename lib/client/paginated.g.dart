// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paginated<T> _$PaginatedFromJson<T extends dynamic>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Paginated<T>(
      result: (json['result'] as List<dynamic>).map(fromJsonT).toList(),
      total: json['total'] as int,
    );
