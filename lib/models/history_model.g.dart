// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
  adhdScore: (json['ADHD_score'] as num).toDouble(),
  asdScore: (json['ASD_score'] as num).toDouble(),
  disleksiaScore: (json['DISLEKSIA_score'] as num).toDouble(),
  tunagrahitaScore: (json['TUNAGRAHITA_score'] as num).toDouble(),
  createdAt: json['creation_time'] as String,
);

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'ADHD_score': instance.adhdScore,
      'ASD_score': instance.asdScore,
      'DISLEKSIA_score': instance.disleksiaScore,
      'TUNAGRAHITA_score': instance.tunagrahitaScore,
      'creation_time': instance.createdAt,
    };
