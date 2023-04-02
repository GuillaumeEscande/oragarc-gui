import 'package:equatable/equatable.dart';

abstract class CompetitionViewEvent extends Equatable {
  const CompetitionViewEvent();
  @override
  List<Object?> get props => [];
}

class CompetitionViewInit extends CompetitionViewEvent {}

class CompetitionViewAdd extends CompetitionViewEvent {
  final String name;

  const CompetitionViewAdd(this.name);
  @override
  List<Object?> get props => [name];
}

class CompetitionViewDelete extends CompetitionViewEvent {
  final String id;

  const CompetitionViewDelete(this.id);
  @override
  List<Object?> get props => [id];
}

class CompetitionViewSelect extends CompetitionViewEvent {
  final String id;

  const CompetitionViewSelect(this.id);
  @override
  List<Object?> get props => [id];
}
