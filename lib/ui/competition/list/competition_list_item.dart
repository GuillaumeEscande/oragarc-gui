import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orgarc_core/orgarc_core.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_bloc.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_state.dart';

class SelectableCompetitionListItem extends StatelessWidget {
  final Competition _competition;
  const SelectableCompetitionListItem(this._competition, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompetitionViewBloc, CompetitionViewState>(
        buildWhen: (previous, current) {
      if (current is CompetitionListSelection) {
        return true;
      }
      if (current is CompetitionListNoSelection) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      var isSelected = false;
      if (state is CompetitionListSelection) {
        if (state.competition == _competition) {
          isSelected = true;
        }
      }
      if (state is CompetitionListNoSelection) {
        isSelected = false;
      }

      if (isSelected) {
        return ColoredBox(
            color: Colors.lightBlue, child: _CompetitionListItem(_competition));
      } else {
        return _CompetitionListItem(_competition);
      }
    });
  }
}

class _CompetitionListItem extends StatelessWidget {
  final Competition _competition;
  const _CompetitionListItem(this._competition);

  @override
  Widget build(BuildContext context) {
    var content = SizedBox(
        height: 50, child: Center(child: Text('Entry ${_competition.name}')));

    return content;
  }
}
