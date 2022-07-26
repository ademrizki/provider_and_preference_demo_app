part of 'name_bloc.dart';

abstract class NameEvent extends Equatable {
  const NameEvent();
}

class GetName extends NameEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
