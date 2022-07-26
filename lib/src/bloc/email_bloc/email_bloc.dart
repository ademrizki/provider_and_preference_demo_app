import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'email_event.dart';
part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc() : super(EmailInitial()) {
    on<EmailEvent>(
      (event, emit) async {
        emit(EmailLoading());

        final SharedPreferences preferences =
            await SharedPreferences.getInstance();

        final String email = preferences.getString('email')!;

        emit(EmailSuccess(email));
      },
    );
  }
}
