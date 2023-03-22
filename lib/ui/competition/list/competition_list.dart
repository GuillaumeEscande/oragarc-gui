import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:orgarc_core/orgarc_core.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_state/competition_view_bloc.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_state/competition_view_event.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_state/competition_view_state.dart';

class CompetitionList extends StatelessWidget {
  const CompetitionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Expanded(
        child: _CompetitionSelectList(),
      ),
      SizedBox(height: 50, child: _CompetitionButtonBottomBar())
    ]);
  }
}

class _CompetitionSelectList extends StatefulWidget {
  const _CompetitionSelectList();

  @override
  State<_CompetitionSelectList> createState() => _CompetitionSelectListState();
}

class _CompetitionSelectListState extends State<_CompetitionSelectList> {
  final int selectedItem;

  _CompetitionSelectListState() : selectedItem = -1;

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
                  var competition = state.competitions[index];
                  return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        selectedItem == index;
                        context
                            .read<CompetitionViewBloc>()
                            .add(CompetitionViewSelect(competition.id));
                      },
                      child: _SelectableCompetitionListItem(competition));
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
          showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<CompetitionViewBloc>(context),
                  child: const _AddCompetitionNameDialogBox()));
        },
        child: const Text("Ajouter"));
  }
}

class _AddCompetitionNameDialogBox extends StatefulWidget {
  const _AddCompetitionNameDialogBox({super.key});

  @override
  State<_AddCompetitionNameDialogBox> createState() =>
      _AddCompetitionNameDialogBoxState();
}

class _AddCompetitionNameDialogBoxState
    extends State<_AddCompetitionNameDialogBox> {
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
        decoration: const InputDecoration(
          labelText: 'Nom',
          hintText: 'Nom de la competition',
        ),
      ),
    );
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

class _SelectableCompetitionListItem extends StatelessWidget {
  final Competition _competition;
  const _SelectableCompetitionListItem(this._competition);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompetitionViewBloc, CompetitionViewState>(
        buildWhen: (previous, current) => current is CompetitionListSelection,
        builder: (context, state) {
          var isSelected = false;
          if (state is CompetitionListSelection) {
            if (state.competition == _competition) {
              isSelected = true;
            }
          }
          if (isSelected) {
            return ColoredBox(
                color: Colors.lightBlue,
                child: CompetitionListItem(_competition));
          } else {
            return CompetitionListItem(_competition);
          }
        });
  }
}

class CompetitionListItem extends StatelessWidget {
  final Competition _competition;
  const CompetitionListItem(this._competition, {super.key});

  @override
  Widget build(BuildContext context) {
    var content = SizedBox(
        height: 50, child: Center(child: Text('Entry ${_competition.name}')));

    return content;
  }
}
