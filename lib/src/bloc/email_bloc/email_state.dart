part of 'email_bloc.dart';

abstract class EmailState extends Equatable {
  const EmailState();
}

class EmailInitial extends EmailState {
  @override
  List<Object> get props => [];
}

class EmailLoading extends EmailState {
  @override
  List<Object> get props => [];
}

class EmailSuccess extends EmailState {
  final String email;

  const EmailSuccess(this.email);

  @override
  List<Object> get props => [email];
}
