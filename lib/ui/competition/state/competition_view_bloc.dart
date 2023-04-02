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
    on<CompetitionViewSelect>(_onSelect);
    on<CompetitionViewDelete>(_onDelete);
  }

  void _onInit(
      CompetitionViewInit event, Emitter<CompetitionViewState> emit) async {
    emit(CompetitionListState(_competitionAPI.getAllCompetitions()));
    emit(CompetitionListNoSelection());
  }

  void _onAdded(
      CompetitionViewAdd event, Emitter<CompetitionViewState> emit) async {
    Competition competition = _competitionAPI.createCompetition(event.name);
    _competitionAPI.updateCompetition(competition);

    var competitions =
        List<Competition>.from(_competitionAPI.getAllCompetitions());

    emit(CompetitionListState(competitions));
    emit(CompetitionListSelection(competitions.last));
  }

  void _onSelect(
      CompetitionViewSelect event, Emitter<CompetitionViewState> emit) async {
    emit(
        CompetitionListSelection(_competitionAPI.getCompetitionById(event.id)));
  }

  void _onDelete(
      CompetitionViewDelete event, Emitter<CompetitionViewState> emit) async {
    Competition competition = _competitionAPI.getCompetitionById(event.id);
    _competitionAPI.deleteCompetition(competition);

    var competitions =
        List<Competition>.from(_competitionAPI.getAllCompetitions());

    emit(CompetitionListState(competitions));
    if (competitions.isNotEmpty) {
      emit(CompetitionListSelection(competitions.last));
    } else {
      emit(CompetitionListNoSelection());
    }
  }
}
