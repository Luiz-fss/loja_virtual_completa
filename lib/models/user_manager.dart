import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_completa/helpers/firebase_errors.dart';
import 'package:loja_virtual_completa/models/user.dart';

class UserManager extends ChangeNotifier{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  UserManager(){
    _loadCurrentUser();
  }

  UserModel? user;

  bool _loading = false;

  bool get loading => _loading;

  bool get isLoggedIn => user != null;

  Future<void> signIn({UserModel? user, Function? onFail, Function? onSuccess}) async{
    loading = true;
   try{
     if(user!.email !=null && user.password != null) {
       final UserCredential result = await _auth.signInWithEmailAndPassword(
         email: user.email!, password: user.password!);

       await _loadCurrentUser(firebaseUser: result.user);

       onSuccess!();
     }
   }on FirebaseAuthException catch(e){
     if(onFail!=null){
       onFail(getErrorString(e.code.toUpperCase()));
     }
   }
    loading = false;
  }

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? firebaseUser})async{
    User? currentUser = firebaseUser ?? await _auth.currentUser;
    if(currentUser !=null){
      final DocumentSnapshot docUser =
      await firestore.collection("users").doc(currentUser.uid).get();
      user = UserModel.fromDocument(docUser);

      final docAdmin = await firestore.collection("admins").doc(user?.id).get();
      if(docAdmin.exists){
        user?.admin = true;
      }
      print(user?.admin);
      notifyListeners();
    }
  }

  Future<void> signUp({UserModel? userModel, Function? onFail, Function? onSuccess}) async{
    loading = true;

   try{
     if(userModel != null && userModel.email != null && userModel.password != null){

       UserCredential result = await _auth.createUserWithEmailAndPassword(
           email: userModel.email!, password: userModel.password!);
       userModel.id = result.user?.uid;
       await userModel.saveData();
       this.user = userModel;
       if(onSuccess != null){
         onSuccess();
       }
     }
   }on FirebaseAuthException catch(e){
     if(onFail != null){
       onFail(getErrorString(e.code.toUpperCase()));
     }
   }
   loading = false;
  }

  void signOut(){
    _auth.signOut();
    user = null;
    notifyListeners();
  }

  bool get adminEnable => user != null && user!.admin;

  void facebookLogin(){}
}