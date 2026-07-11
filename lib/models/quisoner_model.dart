import 'package:json_annotation/json_annotation.dart';

part 'quisoner_model.g.dart';

@JsonSerializable()
class QuisonerModel {
  QuisonerModel({required this.id, required this.gejala});
  factory QuisonerModel.fromJson(Map<String, dynamic> json) =>
      _$QuisonerModelFromJson(json);
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'gejala')
  String gejala;

  Map<String, dynamic> toJson() => _$QuisonerModelToJson(this);
}
