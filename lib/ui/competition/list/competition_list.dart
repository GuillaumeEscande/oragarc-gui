import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orgarc_core/orgarc_core.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_bloc.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_event.dart';
import 'package:orgarc_gui/ui/competition/state/competition_view_state.dart';

import 'competition_list_button_bar.dart';
import 'competition_list_item.dart';

class CompetitionList extends StatelessWidget {
  const CompetitionList({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CompetitionViewBloc>().add(CompetitionViewInit());
    return Column(children: const [
      Expanded(
        child: _CompetitionSelectList(),
      ),
      SizedBox(height: 50, child: CompetitionButtonBottomBar())
    ]);
  }
}

class _CompetitionSelectList extends StatefulWidget {
  const _CompetitionSelectList();

  @override
  State<_CompetitionSelectList> createState() => _CompetitionSelectListState();
}

class _CompetitionSelectListState extends State<_CompetitionSelectList> {
  List<Competition> _competitions = List.empty();
  final int _selectedItem = -1;

  _CompetitionSelectListState();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompetitionViewBloc, CompetitionViewState>(
        buildWhen: (previous, current) => current is CompetitionListState,
        builder: (context, state) {
          if (state is CompetitionListState) {
            _competitions = state.competitions;
          }

          return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: _competitions.length,
              itemBuilder: (BuildContext context, int index) {
                var competition = _competitions[index];
                return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _selectedItem == index;
                      context
                          .read<CompetitionViewBloc>()
                          .add(CompetitionViewSelect(competition.id));
                    },
                    child: SelectableCompetitionListItem(competition));
              });
        });
  }
}
