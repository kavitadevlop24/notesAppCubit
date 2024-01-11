import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_cubit/Cubit/notes_cubit.dart';

class UpdateNotes extends StatefulWidget {
  // bunddle passing
  int id;
  String title;
  String desc;
 UpdateNotes({required this.id, required this.title,required this.desc});

  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController=TextEditingController();
    TextEditingController descController=TextEditingController();
    titleController.text=widget.title;
    descController.text=widget.desc;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           TextField(
             controller: titleController,
           ),
          TextField(
            controller: descController,
          ),
          ElevatedButton(onPressed: (){
             BlocProvider.of<NotesCubit>(context).updateNotes(widget.id, widget.title, widget.desc);
          }, child: Text('update'))
        ],
      ),
    );
  }
}
