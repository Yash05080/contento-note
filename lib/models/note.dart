import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'note.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  int id;

  @HiveField(1)
  String text;

  Note({required this.id, required this.text});
}
