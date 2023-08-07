import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:notesample/data/get_all_data_response/get_all_data_response.dart';
import 'package:notesample/data/url.dart';
import 'package:notesample/note_model/note_model.dart';

abstract class apiClass {
  Future<NoteModel?> createNote(NoteModel value);
  Future<List<NoteModel>> getAllNote();
  Future<String> updateNote(NoteModel value);
  Future<void> deleteNote(String id);
}

class NoteDB extends apiClass {
// single ton begin

  NoteDB._internal();
  static NoteDB instance = NoteDB._internal();
  factory() {
    return instance;
  }

  final dio = Dio();
  final _url = url();
  ValueNotifier<List<NoteModel>> noteListNotifier = ValueNotifier([]);
  NoteDB() {
    dio.options =
        BaseOptions(baseUrl: _url.baseurl, responseType: ResponseType.plain);
  }

  @override
  Future<NoteModel?> createNote(NoteModel value) async {
    try {
      final result = await dio.post(_url.create, data: value.toJson());
      final _resultJson = jsonDecode(result.data);
      //print(NoteModel.fromJson(result.data));
      //print(object);
      return NoteModel.fromJson(_resultJson as Map<String, dynamic>);
      //print(result.data);
      // return result.data;
    } on DioError catch (e) {
      print(e.response?.data);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    print(id);
    final result =
        await dio.delete(_url.baseurl + _url.delete.replaceFirst('{id02}', id));
    if (result.data == null) {
      print("not deleted");
    } else {
      getAllNote();
    }
    // return result.data;
  }

  @override
  Future<List<NoteModel>> getAllNote() async {
    print("getAllCalled");
    final result = await dio.get(_url.baseurl + _url.get);
    print(result);
    if (result.data == null) {
      noteListNotifier.value.clear();
      print("null get");
      return [];
    } else {
      //final resultAsJson = jsonDecode(result.data);
      final getAll = GetAllDataResponse.fromJson(result.data);

      print(getAll.data);

      // print("get all from json" + getAll.data.toString());
      noteListNotifier.value.clear();
      noteListNotifier.value.addAll(getAll.data.reversed);
      //print(getAll.data);
      noteListNotifier.notifyListeners();
      return getAll.data;
    }
    // return List<result.data>;
  }

  @override
  Future<String> updateNote(NoteModel value) async {
    //print(value.content);
    final result = await dio.put(_url.update, data: value.toJson());
    print(result.data.toString());
    // final _resultJson = jsonDecode(result.data.toString());
    //print(NoteModel.fromJson(result.data));
    //print(object);
    //getAllNote();
    // return NoteModel.fromJson(result.data as Map<String, dynamic>);
    print("ok");
    return "ok";
  }
}
