// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDoModel _$ToDoModelFromJson(Map<String, dynamic> json) => ToDoModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      completedDate: json['completedDate'] == null
          ? null
          : DateTime.parse(json['completedDate'] as String),
      isDone: json['isDone'] as bool,
    );

Map<String, dynamic> _$ToDoModelToJson(ToDoModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date?.toIso8601String(),
      'completedDate': instance.completedDate?.toIso8601String(),
      'isDone': instance.isDone,
    };
