import '../../../core/constants/strings.dart';
import 'package:flutter/material.dart';

class MyPopoutMenu extends StatelessWidget {
  const MyPopoutMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await showMenu<String>(useRootNavigator: true, context: context, position: RelativeRect.fromLTRB(0, 0, 0, 0), items: const [
            PopupMenuItem(
              value: 'nameEn',
              child: Text('nameEn'),
            ),
            PopupMenuItem(
              value: 'nameAr',
              child: Text('nameAr'),
            ),
            PopupMenuItem(
              value: 'authorName',
              child: Text('authorName'),
            )
          ]).then((value) {
            if (value != null) {
              Navigator.pushNamed(context, searchScreen, arguments: value);
            }
          });
        },
        icon: const Icon(Icons.search));
  }
}
