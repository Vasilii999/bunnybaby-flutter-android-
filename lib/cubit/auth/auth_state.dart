
part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState{}

class AuthLoading extends AuthState{}

class AuthCodeSent extends AuthState{}

class AuthSuccess extends AuthState{}

class AuthFailure extends AuthState{
  final String message;

  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}