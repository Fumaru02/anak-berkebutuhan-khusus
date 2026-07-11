// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quisoner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuisonerModel _$QuisonerModelFromJson(Map<String, dynamic> json) =>
    QuisonerModel(
      id: (json['id'] as num).toInt(),
      gejala: json['gejala'] as String,
    );

Map<String, dynamic> _$QuisonerModelToJson(QuisonerModel instance) =>
    <String, dynamic>{'id': instance.id, 'gejala': instance.gejala};
