import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starwears/models/celebrity.dart';
import 'package:starwears/services/celebrities_service.dart';

part 'celebrity_event.dart';
part 'celebrity_state.dart';

class CelebrityBloc extends Bloc<CelebrityEvent, CelebrityState> {
  CelebritiesService celebrityService = CelebritiesService();
  CelebrityBloc() : super(CelebrityInitial()) {
    on<GetCelebrities>((event, emit) async {
      try {
        List<Celebrity> celebrities = await celebrityService.getCelebrities();
        emit(CelebritiesReady(celebrities: celebrities));
      } catch (e) {
        emit(CelebritiesFailed(error: e.toString()));
        print(e.toString());
      }
    });
  }
}
