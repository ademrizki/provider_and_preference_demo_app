part of 'name_bloc.dart';

abstract class NameState extends Equatable {
  const NameState();
}

class Initial extends NameState {
  @override
  List<Object> get props => [];
}

class Loading extends NameState {
  @override
  List<Object> get props => [];
}

class Success extends NameState {
  final String name;

  const Success(this.name);

  @override
  List<Object> get props => [name];
}
