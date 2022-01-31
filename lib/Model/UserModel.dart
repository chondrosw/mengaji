import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  String? id;
  String? email;
  String? name;
  String? password;
  String? date;

  UserModel( this.id,{required this.password,required this.email,required this.name,required this.date});

  @override
  // TODO: implement props
  List<Object?> get props => [email,name,password,date];
}