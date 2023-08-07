import 'package:json_annotation/json_annotation.dart';
import 'package:notesample/note_model/note_model.dart';

//import 'datum.dart';

part 'get_all_data_response.g.dart';

@JsonSerializable()
class GetAllDataResponse {
  @JsonKey(name: 'data')
  List<NoteModel> data;

  GetAllDataResponse({this.data = const []});

  factory GetAllDataResponse.fromJson(Map<String, dynamic> json) {
    return _$GetAllDataResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetAllDataResponseToJson(this);
}
