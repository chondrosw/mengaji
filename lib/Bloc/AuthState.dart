part of'AuthBloc.dart';

abstract class AuthState extends Equatable{
  const AuthState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthInitial extends AuthState{}
class AuthLoading extends AuthState{}
class AuthSuccess extends AuthState{
  final UserModel user;
  AuthSuccess(this.user);
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
class AuthLogoutSuccess extends AuthState{}
class AuthFailed extends AuthState{
  final String error;
  AuthFailed(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}