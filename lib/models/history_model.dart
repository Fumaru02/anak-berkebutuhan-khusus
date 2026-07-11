import 'package:json_annotation/json_annotation.dart';

part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel {
  HistoryModel({
    required this.adhdScore,
    required this.asdScore,
    required this.disleksiaScore,
    required this.tunagrahitaScore,
    required this.createdAt,
  });
  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);
  @JsonKey(name: 'ADHD_score')
  double adhdScore;
  @JsonKey(name: 'ASD_score')
  double asdScore;
  @JsonKey(name: 'DISLEKSIA_score')
  double disleksiaScore;
  @JsonKey(name: 'TUNAGRAHITA_score')
  double tunagrahitaScore;
  @JsonKey(name: 'creation_time')
  String createdAt;

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
