import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:orgarc_core/src/competition/model/competition.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_state/competition_view_bloc.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_state/competition_view_event.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_state/competition_view_state.dart';

class CompetitionList extends StatelessWidget {
  const CompetitionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: _CompetitionSelectList(),
      ),
      SizedBox(height: 50, child: _CompetitionButtonBottomBar())
    ]);
  }
}

class _CompetitionSelectList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompetitionViewBloc, CompetitionViewState>(
        buildWhen: (previous, current) => current is CompetitionListState,
        builder: (context, state) {
          if (state is CompetitionListState) {
            return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: state.competitions.length,
                itemBuilder: (BuildContext context, int index) {
                  return CompetitionListItem(state.competitions[index]);
                });
          }
          return Container();
        });
  }
}

class _CompetitionButtonBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        SizedBox(width: 200, child: _AddCompetitionButton()),
        const Spacer(),
        SizedBox(width: 200, child: _DeleteCompetitionButton()),
        const Spacer(),
      ],
    );
  }
}

class _AddCompetitionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          final Logger logger = Logger("Add button");
          logger.fine("Add button pressed");
          context
              .read<CompetitionViewBloc>()
              .add(const CompetitionViewAdd("TEST"));
        },
        child: const Text("Ajouter"));
  }
}

class _DeleteCompetitionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: const Text("Supprimer"));
  }
}

class CompetitionListItem extends StatelessWidget {
  final Competition _competition;
  const CompetitionListItem(this._competition, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50, child: Center(child: Text('Entry ${_competition.name}')));
  }
}
