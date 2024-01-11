import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_cubit/Cubit/notes_state.dart';
import 'package:notes_app_cubit/Database/dbhelper.dart';
import 'package:notes_app_cubit/Models/notesmodel.dart';

class NotesCubit extends Cubit<NotesState>{
  DbHelper dbHelper;
  NotesCubit({required this.dbHelper}):super(InitialState());


  addNotes(NotesModel newnote)async{
    emit(LoadingState());
    bool check=await dbHelper.addNotes(newnote);
    if(check){
      var notes=await dbHelper.getNotes();
      emit(LoadedState(arrnotes: notes));
    }
    else{
      emit(ErrorState(errormsg: "Data Has Not Be Added in Database"));
    }
  }
  getAllNotes()async{
    emit(LoadingState());
    var db=await dbHelper.getNotes();
    emit(LoadedState(arrnotes: db));
  }
  Future<void>updateNotes(int id, String title,String desc)async{
    bool check=await dbHelper
        .updateNote(NotesModel(id: id,title: title, desc: desc));
    if(check){
      emit(LoadedState(arrnotes: await dbHelper.getNotes()));
    }
    else{
      emit(ErrorState(errormsg: 'Error in update Notes'));
    }
  }
  Future<void>deleteNotes(int id)async{
    bool check= await dbHelper.deleteNote(id);
    if(check){
      emit(LoadedState(arrnotes: await dbHelper.getNotes()));
    }
    else{
      emit(ErrorState(errormsg: 'Note not delete'));
    }
  }
}