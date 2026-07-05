import 'package:json_annotation/json_annotation.dart';

part 'education_model.g.dart';

@JsonSerializable()
class EducationModel {
  EducationModel({
    required this.title,
    required this.sourceImage,
    required this.ask,
    required this.ask1,
    required this.diingat,
    required this.diingat1,
    required this.gejala,
    required this.gejala1,
    required this.penyebab,
    required this.penyebab1,
    required this.tanda,
    required this.tanda1,
    required this.penanganan,
    required this.penanganan1,
  });
  factory EducationModel.fromJson(Map<String, dynamic> json) =>
      _$EducationModelFromJson(json);
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'source_image')
  String sourceImage;
  @JsonKey(name: 'ask')
  String ask;
  @JsonKey(name: 'ask_1')
  String ask1;
  @JsonKey(name: 'diingat')
  String diingat;
  @JsonKey(name: 'diingat_1')
  String diingat1;
  @JsonKey(name: 'gejala')
  String gejala;
  @JsonKey(name: 'gejala_1')
  String gejala1;
  @JsonKey(name: 'penyebab')
  String penyebab;
  @JsonKey(name: 'penyebab_1')
  String penyebab1;
  @JsonKey(name: 'penanganan')
  String penanganan;
  @JsonKey(name: 'penanganan_1')
  String penanganan1;
  @JsonKey(name: 'tanda')
  String tanda;
  @JsonKey(name: 'tanda_1')
  String tanda1;

  Map<String, dynamic> toJson() => _$EducationModelToJson(this);
}
