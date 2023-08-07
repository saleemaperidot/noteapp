// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllDataResponse _$GetAllDataResponseFromJson(Map<String, dynamic> json) =>
    GetAllDataResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GetAllDataResponseToJson(GetAllDataResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
