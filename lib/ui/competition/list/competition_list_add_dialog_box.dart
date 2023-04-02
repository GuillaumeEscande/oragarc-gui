import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_bloc.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_event.dart';

class AddCompetitionNameDialogBox extends StatefulWidget {
  const AddCompetitionNameDialogBox({super.key});

  @override
  State<AddCompetitionNameDialogBox> createState() =>
      _AddCompetitionNameDialogBoxState();
}

class _AddCompetitionNameDialogBoxState
    extends State<AddCompetitionNameDialogBox> {
  final _competitionNameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Ajouter"),
      actionsOverflowButtonSpacing: 20,
      actions: [
        ElevatedButton(
            onPressed: () {
              context
                  .read<CompetitionViewBloc>()
                  .add(CompetitionViewAdd(_competitionNameCtrl.text));
              Navigator.pop(context);
            },
            child: const Text("Ajouter")),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Annuler")),
      ],
      content: TextField(
        controller: _competitionNameCtrl,
        autofocus: true,
        onSubmitted: (value) {
          context.read<CompetitionViewBloc>().add(CompetitionViewAdd(value));
          Navigator.pop(context);
        },
        decoration: const InputDecoration(
          labelText: 'Nom',
          hintText: 'Nom de la competition',
        ),
      ),
    );
  }
}
