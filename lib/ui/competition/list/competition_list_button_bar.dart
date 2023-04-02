import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_bloc.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_event.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_state.dart';

import 'competition_list_add_dialog_box.dart';

class CompetitionButtonBottomBar extends StatelessWidget {
  const CompetitionButtonBottomBar({super.key});

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
          showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<CompetitionViewBloc>(context),
                  child: const AddCompetitionNameDialogBox()));
        },
        child: const Text("Ajouter"));
  }
}

class _DeleteCompetitionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompetitionViewBloc, CompetitionViewState>(
        builder: (context, state) {
      if (state is CompetitionListSelection) {
        return ElevatedButton(
            onPressed: () {
              final Logger logger = Logger("Add button");
              logger.fine("Add button pressed");
              context
                  .read<CompetitionViewBloc>()
                  .add(CompetitionViewDelete(state.competition.id));
            },
            child: const Text("Supprimer"));
      }
      return const ElevatedButton(onPressed: null, child: Text("Supprimer"));
    });
  }
}
