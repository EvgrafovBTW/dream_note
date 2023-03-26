import 'package:dream_note/screens/consecutive_screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).size.height;
    return SizedBox.expand(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: CircleAvatar(
                        radius: sHeight / 12,
                        child: Text(
                          'UN',
                          style: TextStyle(fontSize: sHeight * 0.04),
                        ),
                      ),
                    ),
                    Text(
                      'User Sample Name',
                      style: TextStyle(fontSize: sHeight * 0.04),
                      overflow: TextOverflow.clip,
                    ),
                    /*
                    PlatformElevatedButton(
                      onPressed: () {
                        appSettingsBloc.add(const ChangeMainAppColor(Colors.teal));
                      },
                      child: Text('defaut'),
                    ),
                    PlatformElevatedButton(
                      onPressed: () {
                        appSettingsBloc.add(const ChangeMainAppColor(Colors.red));
                      },
                      child: Text('red'),
                    ),
                    PlatformElevatedButton(
                      onPressed: () {
                        appSettingsBloc.add(const ChangeMainAppColor(Colors.green));
                      },
                      child: Text('green'),
                    ),
                    BlocBuilder<AppSettingsBloc, AppSettingsState>(
                      builder: (context, state) {
                        return ;
                      },
                    ),
                    Text('datadatadatadatadatadata'),
                    */
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: PlatformIconButton(
                  onPressed: () => Navigator.push(
                    context,
                    platformPageRoute(
                      material: (context, platform) => MaterialPageRouteData(),
                      cupertino: (context, platform) =>
                          CupertinoPageRouteData(),
                      context: context,
                      builder: (context) => const SettingsScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.settings),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
