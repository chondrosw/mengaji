import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mengaji/Model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference userReference = FirebaseFirestore.instance.collection("/users");


  Future<UserModel?> login(
      {
      required String password,

      required String email}) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      UserModel user = await this.getuserById(userCredential.user!.uid);
      prefs.setString("user_id", userCredential.user!.uid);
      return user;
    }catch(e){
      throw e;
    }
  }

  Future<UserModel> register({required String email,required String password, required String name,required String date})async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      UserModel user = UserModel(userCredential.user?.uid,password: password, email: email, name: name, date: date);
      prefs.setString("user_id", userCredential.user!.uid);
      await this.setUser(user);
      return user;
    }catch(e){
      throw e;
    }
  }

  Future<void> signOut()async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("user_id");
      firebaseAuth.signOut();
    }catch(e){
      throw e;
    }
  }

  Future<void> setUser(UserModel userModel)async{
    try{

     await userReference.doc(userModel.id).set({
        'email':userModel.email,
        'name':userModel.name,
        'password':userModel.password,
        'date':userModel.date
      });
    }catch(e){
      print("Set User Error");
    }
  }
  Future<UserModel> getuserById(String id)async{
    try{
      DocumentSnapshot snapshot = await userReference.doc(id).get();
      return UserModel(id, password: snapshot['password'], email: snapshot['email'], name: snapshot['name'], date: snapshot['date']);
    }catch(e){
      throw e;
    }
  }


}
