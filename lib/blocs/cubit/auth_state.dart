part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Map<String, dynamic> data; 
  final bool isLoggedIn;

  const AuthSuccess(this.data , this.isLoggedIn);


}

class AuthProfile extends AuthState {
  final UserModel user; 
  

  const AuthProfile(this.user);
}

class AuthFailed extends AuthState{
  final Map<String, dynamic> error;

  const AuthFailed(this.error);

}

class AuthUpdate extends AuthState{
  final UserModel user; 
  final String message;
  

  const AuthUpdate(this.user , this.message);

}


