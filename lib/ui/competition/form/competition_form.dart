import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orgarc_core/orgarc_core.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_state/competition_view_bloc.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_state/competition_view_state.dart';

class CompetitionForm extends StatelessWidget {
  const CompetitionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompetitionViewBloc, CompetitionViewState>(
        buildWhen: (previous, current) => current is CompetitionListSelection,
        builder: (context, state) {
          if (state is CompetitionListSelection) {
            var competition = state.competition;
            return _CompetitionEditForm(competition);
          }
          return Container();
        });
  }
}

class _CompetitionEditForm extends StatelessWidget {
  final Competition _competition;
  const _CompetitionEditForm(this._competition);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(controller: TextEditingController(text: _competition.name)),
    ]);
  }
}
