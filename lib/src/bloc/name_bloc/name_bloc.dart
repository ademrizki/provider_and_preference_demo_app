import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'name_event.dart';
part 'name_state.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  NameBloc() : super(Initial()) {
    on<NameEvent>(
      (event, emit) async {
        emit(Loading());

        final SharedPreferences preferences =
            await SharedPreferences.getInstance();

        final String name = preferences.getString('name') ?? 'Name';

        emit(Success(name));
      },
    );
  }
}
