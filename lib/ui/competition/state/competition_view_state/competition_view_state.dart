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
  final String id;
  const CompetitionListSelection(this.id);
  @override
  List<Object> get props => [id];
}
