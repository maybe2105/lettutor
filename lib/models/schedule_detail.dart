import 'package:json_annotation/json_annotation.dart';
import 'package:lettutor/models/schedule.dart';
import 'package:lettutor/models/schedule_info.dart';

part 'schedule_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class ScheduleDetail {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  String? startPeriod;
  String? endPeriod;
  String? scheduleId;
  ScheduleInfo? scheduleInfo;
  bool? isBooked;
  @JsonKey(nullable: true)
  List<Schedule>? bookingInfo;
  ScheduleDetail();
  factory ScheduleDetail.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleDetailToJson(this);
}
