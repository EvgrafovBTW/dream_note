import 'package:dream_note/logic/blocs/app_settings/bloc/app_settings_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettingsBloc appSettingsBloc = BlocProvider.of<AppSettingsBloc>(context);
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
        ],
      ),
    );
  }
}
