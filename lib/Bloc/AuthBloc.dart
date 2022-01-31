import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mengaji/Model/UserModel.dart';
import 'package:mengaji/Service/AuthService.dart';

part 'AuthState.dart';
class AuthCubit extends Cubit<AuthState>{
  AuthCubit() : super(AuthInitial());
  
  void login({required String email,required String password})async{
    try{
      emit(AuthLoading());
      UserModel? userModel = await AuthService().login(password: password, email: email);
      if(userModel != null){
        emit(AuthSuccess(userModel));
      }else{
        emit(AuthFailed("Login Failed"));
      }
    }catch(e){
      emit(AuthFailed("Error Login"));
    }
  }
  void register({required  String email,required String password, required String name,required String date})async{
    try{
      emit(AuthLoading());
      UserModel user = await AuthService().register(email: email, password: password, name: name, date: date);
      emit(AuthSuccess(user));
    }catch(e){
      emit(AuthFailed("Register Failed"));
    }
  }
  void logout()async{
    try{
      emit(AuthLoading());
      await AuthService().signOut();
      emit(AuthLogoutSuccess());
    }catch(e){
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurretUer(String id)async{
    try{
      UserModel user = await AuthService().getuserById(id);
      emit(AuthSuccess(user));
    }catch(e){
      emit(AuthFailed(e.toString()));
    }
  }
}