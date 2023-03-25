import 'dart:math';

import 'package:dream_note/logic/blocs/app_load/bloc/app_load_bloc.dart';
import 'package:dream_note/logic/blocs/app_settings/bloc/app_settings_bloc.dart';
import 'package:dream_note/logic/blocs/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:dream_note/screens/main_screen.dart';
import 'package:dream_note/screens/new_dream_screen.dart';
import 'package:dream_note/screens/profile_screen.dart';
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
    BottomNavigationBloc bottomNavigationBloc =
        BlocProvider.of<BottomNavigationBloc>(context);
    AppSettingsBloc appSettingsBloc = BlocProvider.of<AppSettingsBloc>(context);

    onPageTapped(int index) {
      bottomNavigationBloc.add(BottomNavTap(index));
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
          // Placeholder(color: settingsState.primaryColor),
          const MainScreen(),
          // Placeholder(color: settingsState.primaryColor),
          const NewDreamScreen(),
          Placeholder(color: settingsState.primaryColor),
          // Placeholder(color: Colors.green),
          const UserProfile(),
        ];
        return PlatformApp(
          material: (context, platform) => MaterialAppData(
            theme: ThemeData(
              colorScheme: ColorScheme(
                brightness: settingsState.isDarkMode
                    ? Brightness.dark
                    : Brightness.light,
                primary: settingsState.primaryColor,
                onPrimary: settingsState.onPrimaryColor,
                secondary: settingsState.primaryColor,
                onSecondary: settingsState.onPrimaryColor,
                error: Colors.red,
                onError: Colors.white,
                background: Colors.white,
                onBackground: Colors.white,
                surface: settingsState.primaryColor,
                onSurface: settingsState.primaryColor,
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
              return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
                builder: (context, state) {
                  return Scaffold(
                    /*
                    floatingActionButton: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                            onPressed: () => appSettingsBloc
                                .add(const ChangeMainAppColor(Colors.red)),
                            child: Icon(Icons.color_lens),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: FloatingActionButton(
                              onPressed: () => appSettingsBloc
                                  .add(const ChangeMainAppColor(Colors.green)),
                              child: Icon(Icons.color_lens),
                            ),
                          )
                        ]),
                        */
                    floatingActionButton: FloatingActionButton(
                      onPressed: () => appSettingsBloc.add(
                          ToggleDarkMode(!appSettingsBloc.state.isDarkMode)),
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
                            Icons.home,
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
                            Icons.find_replace_outlined,
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
        );
      },
    );
  }
}
