import 'package:equatable/equatable.dart';
import 'package:orgarc_core/orgarc_core.dart';

abstract class CompetitionViewState extends Equatable {
  const CompetitionViewState();
  @override
  List<Object> get props => [];
}

class CompetitionListState extends CompetitionViewState {
  final List<Competition> competitions;
  const CompetitionListState(this.competitions);
  @override
  List<Object> get props => [competitions];
}

class CompetitionListSelection extends CompetitionViewState {
  final Competition competition;
  const CompetitionListSelection(this.competition);
  @override
  List<Object> get props => [competition];
}
