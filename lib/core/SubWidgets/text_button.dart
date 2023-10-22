import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:threego/app/app_router.dart';

import '../../../Data/Models/organizer_model.dart';

class TextButtonNavigateOrganizerInfo extends StatelessWidget {
  const TextButtonNavigateOrganizerInfo({
    super.key,
    required this.organizerItem,
  });

  final OrganizerModel organizerItem;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft),
        onPressed: () {
          AutoRouter.of(context).push(OrganizerInfoRoute(organizerModel: organizerItem));
        },
        child: Text(organizerItem.organizerName.toString()));
  }
}
