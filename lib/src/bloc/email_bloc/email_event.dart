part of 'email_bloc.dart';

abstract class EmailEvent extends Equatable {
  const EmailEvent();
}

class GetEmail extends EmailEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
