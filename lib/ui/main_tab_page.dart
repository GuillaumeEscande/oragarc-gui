import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'archer/archer_page.dart';
import 'competition/competition_page.dart';
import 'competition/state/competition_view_bloc.dart';
import 'export/export_page.dart';
import 'result/result_page.dart';
import 'target/target_page.dart';
import 'package:orgarc_core/orgarc_core.dart';

class MainTabPage extends StatelessWidget {
  const MainTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CompetitionViewBloc>(
            create: (_) => CompetitionViewBloc(
                CompetitionApiImpl(CompetitionStorageInMemory())),
          ),
        ],
        child: DefaultTabController(
            length: 5,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                          Text('Competitions'),
                          SizedBox(width: 8),
                          Icon(Icons.calendar_month),
                        ])),
                    Tab(
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                          Text('Archers'),
                          SizedBox(width: 8),
                          Icon(Icons.assignment_ind),
                        ])),
                    Tab(
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                          Text('Targets'),
                          SizedBox(width: 8),
                          Icon(Icons.explore),
                        ])),
                    Tab(
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                          Text('Results'),
                          SizedBox(width: 8),
                          Icon(Icons.hotel_class),
                        ])),
                    Tab(
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                          Text('Export'),
                          SizedBox(width: 8),
                          Icon(Icons.backup),
                        ])),
                  ],
                ), //TabBar
              ),
              body: TabBarView(
                children: [
                  const CompetitionsPage(),
                  ArchersPage(),
                  const TargetsPage(),
                  const ResultsPage(),
                  const ExportPage(),
                ],
              ),
            )));
  }
}
