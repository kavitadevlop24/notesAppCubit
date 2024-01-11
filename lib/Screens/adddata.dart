 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_cubit/Cubit/notes_cubit.dart';
import 'package:notes_app_cubit/Cubit/notes_state.dart';
import 'package:notes_app_cubit/Models/notesmodel.dart';
import 'package:notes_app_cubit/Widgets/uihelper.dart';

class AddData extends StatefulWidget {
   const AddData({Key? key}) : super(key: key);

   @override
   State<AddData> createState() => _AddDataState();
 }

 class _AddDataState extends State<AddData> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Add Data"),
         centerTitle:true,
       ),
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
          UiHelper.CustomTextField(titleController, "Enter Title", Icons.title),
         UiHelper.CustomTextField(descController, "Enter Description", Icons.description),
         SizedBox(height: 20,),
         ElevatedButton(onPressed: (){
           var title=titleController.text.toString();
           var desc=descController.text.toString();
           context.read<NotesCubit>().addNotes(NotesModel(title: title, desc: desc));
           Navigator.pop(context);
         }, child: Text("Save Data"))
       ],),
     );
   }
 }
