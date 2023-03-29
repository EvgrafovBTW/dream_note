import 'package:dream_note/screens/consecutive_screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsnew/flutter_whatsnew.dart';

import '../../utils.dart';

class DreamWhatsNew extends StatelessWidget {
  final String version;
  const DreamWhatsNew({
    required this.version,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: WhatsNewPage(
        title: Text('Что нового в версии $version?'),
        items: [
          const ListTile(
            leading: Icon(Icons.lock),
            title: Text('Защищенный режим'),
            subtitle: Text(
                'Можно не боятся, что кто-то подсмотрит за превью Ваишх снов!'),
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Изменение дополнительного цвета'),
            subtitle: const Text('Для более точной настройки'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              platformNavigateTo(
                screen: const SettingsScreen(),
                context: context,
              );
            },
          ),
          const ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Добавление снов в избранное'),
            subtitle: Text('Чтобы важное было под рукой'),
          ),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Профиль пользователя'),
            subtitle: Text('Если хочется закрепить сны за собой наверняка'),
          ),
        ],
        buttonText: const Text('Продолжить'),
      ),
    );
  }
}
