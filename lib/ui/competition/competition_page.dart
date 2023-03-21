import 'package:flutter/material.dart';

import 'form/competition_form.dart';
import 'list/competition_list.dart';

class CompetitionsPage extends StatelessWidget {
  const CompetitionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Expanded(child: CompetitionList()),
        Expanded(child: CompetitionForm()),
      ],
    );
  }
}
