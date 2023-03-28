import 'dart:math';

import 'package:dream_note/logic/blocs/app_load/bloc/app_load_bloc.dart';
import 'package:dream_note/logic/blocs/app_settings/bloc/app_settings_bloc.dart';
import 'package:dream_note/logic/blocs/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:dream_note/logic/blocs/dreams/bloc/dreams_bloc.dart';
import 'package:dream_note/logic/blocs/user/bloc/user_bloc.dart';
import 'package:dream_note/screens/main_screen.dart';
import 'package:dream_note/screens/new_dream_screen.dart';
import 'package:dream_note/screens/profile_screen.dart';
import 'package:dream_note/utils.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppLoadBloc(),
        ),
        BlocProvider(
          create: (context) => BottomNavigationBloc(),
        ),
        BlocProvider(
          create: (context) => AppSettingsBloc(),
        ),
        BlocProvider(
          create: (context) => DreamsBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppLoadBloc appLoadBloc = BlocProvider.of<AppLoadBloc>(context);
    DreamsBloc dreamsBloc = BlocProvider.of<DreamsBloc>(context);
    BottomNavigationBloc bottomNavigationBloc =
        BlocProvider.of<BottomNavigationBloc>(context);
    AppSettingsBloc appSettingsBloc = BlocProvider.of<AppSettingsBloc>(context);

    onPageTapped(int index) {
      if (index != 2) {
        bottomNavigationBloc.add(BottomNavTap(index));
      } else {
        inProductionNotif();
      }
    }

    Future<void> loadAppData() async {
      // print('loading app start');
      appLoadBloc.add(AppLoadStart());

      await Future.delayed(const Duration(seconds: 2));

      appLoadBloc.add(AppLoadComplete());
      // print('loading app complete');
    }

    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, settingsState) {
        List<Widget> pages = [
          const MainScreen(),
          const NewDreamScreen(),
          Placeholder(color: settingsState.primaryColor),
          const UserProfile(),
        ];

        return KeyboardDismisser(
          child: OverlaySupport.global(
            child: PlatformApp(
              material: (context, platform) => MaterialAppData(
                theme: ThemeData(
                  iconTheme: IconThemeData(
                    color: settingsState.onPrimaryColor,
                  ),
                  primaryColorDark: settingsState.primaryColor,
                  primaryColorLight: settingsState.primaryColor,
                  useMaterial3: false,
                  colorScheme: ColorScheme(
                    brightness: settingsState.isDarkMode
                        ? Brightness.dark
                        : Brightness.light,
                    primary: settingsState.primaryColor,
                    onPrimary: Colors.white,
                    secondary: settingsState.primaryColor,
                    onSecondary: Colors.white,
                    error: Colors.red,
                    onError: Colors.white,
                    background: Colors.white,
                    onBackground: Colors.white,
                    surface: settingsState.primaryColor,
                    onSurface: Colors.white,
                  ),
                ),
              ),
              cupertino: (context, platform) => CupertinoAppData(),
              showPerformanceOverlay: false,
              debugShowCheckedModeBanner: false,
              home: BlocBuilder<AppLoadBloc, AppLoadState>(
                builder: (context, state) {
                  if (state is AppLoadInitial) {
                    loadAppData();
                  }
                  if (state is AppLoadInitial || state is AppLoading) {
                    List<Widget> loadingAnimations = [
                      SpinKitSpinningLines(color: settingsState.primaryColor),
                      SpinKitCubeGrid(color: settingsState.primaryColor),
                      SpinKitFoldingCube(color: settingsState.primaryColor),
                      SpinKitWave(color: settingsState.primaryColor),
                    ];
                    return Scaffold(
                      body: Center(
                        child: loadingAnimations[
                            Random().nextInt(loadingAnimations.length - 1)],
                      ),
                    );
                  }
                  return BlocBuilder<BottomNavigationBloc,
                      BottomNavigationState>(
                    builder: (context, state) {
                      return Scaffold(
                        floatingActionButton: FloatingActionButton(
                          heroTag: 'floatingActionButton',
                          onPressed: () => appSettingsBloc.add(ToggleDarkMode(
                              !appSettingsBloc.state.isDarkMode)),
                        ),

                        // backgroundColor: Colors.indigoAccent,
                        body: SizedBox.expand(
                          child: IndexedStack(
                            index: state.pageIndex,
                            children: pages,
                          ),
                        ),
                        bottomNavigationBar: BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          // showSelectedLabels: false,
                          showUnselectedLabels: false,
                          currentIndex: state.pageIndex,
                          onTap: onPageTapped,
                          items: const [
                            BottomNavigationBarItem(
                              icon: Icon(
                                Icons.home_outlined,
                              ),
                              label: 'Главная',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(
                                Icons.book_outlined,
                              ),
                              label: 'Новый сон',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(
                                Icons.search,
                              ),
                              label: 'Поиск',
                            ),

                            // BottomNavigationBarItem(
                            //   icon: Icon(
                            //     Icons.book_outlined,
                            //   ),
                            //   label: 'Лента',
                            // ),
                            BottomNavigationBarItem(
                              icon: Icon(
                                Icons.person_2_outlined,
                              ),
                              label: 'Профиль',
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
