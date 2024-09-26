import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_completa/models/section.dart';

class GerenciadorHome extends ChangeNotifier{

  GerenciadorHome(){
    _loadingSections();
  }

  List<Section> _sections=[];
  List<Section> _editingSections=[];

  bool loading = false;
  bool editing = false;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> _loadingSections() async{
    firebaseFirestore.collection("home").orderBy("pos").snapshots().listen((snapshot) {
      _sections.clear();
      for(final DocumentSnapshot documentSnapshot in snapshot.docs){
        _sections.add(Section.fromDocument(documentSnapshot));
      }
      notifyListeners();
    });
  }

  void addSection (Section sessao){
    _editingSections.add(sessao);
    notifyListeners();
  }

  void removerSection(Section sessao){
    _editingSections.remove(sessao);
    notifyListeners();
  }

  List<Section> get sections {
    if(editing){
      return _editingSections;
    }
    return _sections;
  }

  void enterEditing(){
    editing = true;
    _editingSections = _sections.map((s) => s.clone()).toList();
    notifyListeners();
  }

  void saveEditing()async{
    bool valid = true;
    for(final section in _editingSections){
      if(!section.valid()){
        valid = false;
      }
    }
    if(!valid){
     return;
    }

    loading = true;
    notifyListeners();
    int pos = 0;
    for(final section in _editingSections){
      await section.save(pos);
      pos++;
    }

    for(final section in List.from(_sections)){
      if(_editingSections.any((element)=> element.id == section.id)){
        await section.delete();
      }
    }
    loading = false;
    editing = false;
    notifyListeners();
  }

  void descardEditing(){

    editing = false;
    notifyListeners();
  }
}