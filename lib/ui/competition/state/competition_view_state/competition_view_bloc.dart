import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orgarc_core/orgarc_core.dart';

import 'competition_view_event.dart';
import 'competition_view_state.dart';

class CompetitionViewBloc
    extends Bloc<CompetitionViewEvent, CompetitionViewState> {
  final CompetitionApiImpl _competitionAPI;

  CompetitionViewBloc(this._competitionAPI)
      : super(CompetitionListState(List<Competition>.empty())) {
    on<CompetitionViewInit>(_onInit);
    on<CompetitionViewAdd>(_onAdded);
  }
  void _onInit(
      CompetitionViewInit event, Emitter<CompetitionViewState> emit) async {
    emit(CompetitionListState(_competitionAPI.getAllCompetitions()));
  }

  void _onAdded(
      CompetitionViewAdd event, Emitter<CompetitionViewState> emit) async {
    Competition competition = _competitionAPI.createCompetition(event.name);
    _competitionAPI.updateCompetition(competition);

    emit(CompetitionListState(List.from(_competitionAPI.getAllCompetitions())));
  }
}
