import 'package:dream_note/logic/blocs/app_settings/bloc/app_settings_bloc.dart';
import 'package:dream_note/screens/profile_screen.dart';
import 'package:dream_note/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).size.height;
    AppSettingsBloc appSettingsBloc = BlocProvider.of<AppSettingsBloc>(context);
    TextStyle settingLabelStyle = TextStyle(fontSize: sHeight * 0.03);

    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(leading: const BackButton()),
          body: SizedBox.expand(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Wrap(
                  runSpacing: 40,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ночной режим',
                          style: settingLabelStyle,
                        ),
                        PlatformSwitch(
                          value: state.isDarkMode,
                          onChanged: (v) {
                            appSettingsBloc.add(ToggleDarkMode(v));
                          },
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        showPlatformModalSheet(
                          context: context,
                          builder: (context) => MainColorChangeSheet(
                              appSettingsBloc: appSettingsBloc),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Цветовая схема',
                            style: settingLabelStyle,
                          ),
                          SettingsColorPane(
                            side: sHeight * 0.05,
                            color: state.primaryColor,
                            isDarkMode: state.isDarkMode,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showPlatformModalSheet(
                          context: context,
                          builder: (context) => AdditionalColorChangeSheet(
                              appSettingsBloc: appSettingsBloc),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  Text(
                                    'Дополнительная цветовая схема',
                                    style: settingLabelStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SettingsColorPane(
                            side: sHeight * 0.05,
                            color: state.onPrimaryColor,
                            isDarkMode: state.isDarkMode,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: inProductionNotif,
                      child: Opacity(
                        opacity: 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Защищенный режим',
                              style: settingLabelStyle,
                            ),
                            Checkbox(value: false, onChanged: (v) {})
                          ],
                        ),
                      ),
                    ),
                    /*
                    ChangeNameSheet(
                      isDarkMode: state.isDarkMode,
                      // nameController: nameController,
                      // lastNameController: lastNameController,
                    )*/
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MainColorChangeSheet extends StatelessWidget {
  const MainColorChangeSheet({
    super.key,
    required this.appSettingsBloc,
  });

  final AppSettingsBloc appSettingsBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Ночной режим'),
                      PlatformSwitch(
                        value: state.isDarkMode,
                        onChanged: (v) {
                          appSettingsBloc.add(ToggleDarkMode(v));
                        },
                      ),
                    ],
                  ),
                  PlatformTextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Закрыть'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SettingsColorChoosePanel(
                isDarkMode: state.isDarkMode,
              ),
            ),
          ],
        );
      },
    );
  }
}

class AdditionalColorChangeSheet extends StatelessWidget {
  const AdditionalColorChangeSheet({
    super.key,
    required this.appSettingsBloc,
  });

  final AppSettingsBloc appSettingsBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Ночной режим'),
                      PlatformSwitch(
                        value: state.isDarkMode,
                        onChanged: (v) {
                          appSettingsBloc.add(ToggleDarkMode(v));
                        },
                      ),
                    ],
                  ),
                  PlatformTextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Закрыть'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SettingsColorChoosePanel(
                isDarkMode: state.isDarkMode,
                mode: ChangeColorMode.additional,
              ),
            ),
          ],
        );
      },
    );
  }
}

class SettingsColorChoosePanel extends StatelessWidget {
  final ChangeColorMode mode;
  final bool isDarkMode;

  const SettingsColorChoosePanel({
    required this.isDarkMode,
    this.mode = ChangeColorMode.main,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void applyChoosenColor(Color color) {
      if (mode == ChangeColorMode.main) {
        BlocProvider.of<AppSettingsBloc>(context)
            .add(ChangeMainAppColor(color));
      }
      if (mode == ChangeColorMode.additional) {
        BlocProvider.of<AppSettingsBloc>(context)
            .add(ChangeAdditionalAppColor(color));
      }
    }

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      children: [
        for (var color in settingsColors)
          GestureDetector(
            onTap: () {
              applyChoosenColor(color);
            },
            child: SettingsColorPane(color: color, isDarkMode: isDarkMode),
          ),
      ],
    );
  }
}

class SettingsColorPane extends StatelessWidget {
  final bool isDarkMode;
  final Color color;
  final double side;

  const SettingsColorPane({
    super.key,
    this.side = 50,
    required this.color,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: side,
      height: side,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: isDarkMode ? Colors.white54 : Colors.black54,
        ),
      ),
    );
  }
}

enum ChangeColorMode { main, additional }
