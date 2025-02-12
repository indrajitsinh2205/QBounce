



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_store_bloc/statistics_store_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_store_bloc/statistics_store_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_store_bloc/statistics_store_view_model/statistics_store_view_model.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_event.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_state.dart';
import 'package:q_bounce/screens/state_screen_view/statistics_update_bloc/statistics_update_view_model/statistics_update_view_model.dart';

import '../contact_us_view_model/contact_us_view_model.dart';
import 'contact_us_event.dart';
import 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  // Constructor
  ContactUsBloc() : super(ContactUsInitial()) {
    on<FetchContactUs>(_onFetchstatisticsUpdate);
  }

  Future<void> _onFetchstatisticsUpdate(FetchContactUs event, Emitter<ContactUsState> emit) async {
    emit(ContactUsLoading());
    try {
      final response = await ContactUsViewModel().postContactUs(event.postData);
      print("statisticsEditResponse1 ${response}");
      if (response != null) {
        emit(ContactUsLoaded(response));
      } else {
        emit(ContactUsError('Something went Wrong'));
      }
    } catch (e) {
      emit(ContactUsError('An unexpected error occurred: $e'));
    }
  }

}
// TODO Implement this library.