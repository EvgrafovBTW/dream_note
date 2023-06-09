// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dream_note/logic/blocs/app_settings/bloc/app_settings_bloc.dart';
import 'package:dream_note/models/user_model.dart';
import 'package:dream_note/screens/consecutive_screens/favorite_dreams.dart';
import 'package:dream_note/screens/consecutive_screens/user_credentials_change.dart';
import 'package:dream_note/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:dream_note/screens/consecutive_screens/settings_screen.dart';

import '../logic/blocs/user/bloc/user_bloc.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).size.height;
    TextEditingController nameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    return SizedBox.expand(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        String getUserName() {
                          String name = '';
                          if (state.user != null) {
                            name = state.user!.name;
                            if (state.user!.lastName != null) {
                              name = '$name ${state.user!.lastName}';
                            }
                          } else {
                            name = 'Неизвестный пользователь';
                          }
                          return name;
                        }

                        String getUserAbName() {
                          String abName = '';
                          if (state.user != null) {
                            abName = state.user!.name[0];
                            if (state.user!.lastName != null) {
                              abName = '$abName${state.user!.lastName![0]}';
                            }
                          } else {
                            abName = '?';
                          }
                          return abName;
                        }

                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            platformPageRoute(
                              material: (context, platform) =>
                                  MaterialPageRouteData(),
                              cupertino: (context, platform) =>
                                  CupertinoPageRouteData(),
                              context: context,
                              builder: (context) => const SettingsScreen(),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: CircleAvatar(
                                    radius: sHeight / 15,
                                    child: Text(
                                      getUserAbName(),
                                      style:
                                          TextStyle(fontSize: sHeight * 0.04),
                                    ),
                                  ),
                                ),
                                Text(
                                  getUserName(),
                                  style: TextStyle(fontSize: sHeight * 0.04),
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                        ProfileMenuCard(
                          'Избранное',
                          onTap: () {
                            platformNavigateTo(
                              context: context,
                              screen: const FavoriteDreamsScreen(),
                            );
                          },
                          icon: const Icon(
                            Icons.favorite_outline,
                          ),
                        ),
                        ProfileMenuCard(
                          'Заполнить профиль',
                          onTap: () {
                            platformNavigateTo(
                              context: context,
                              screen: const UserCredentialsScreen(),
                            );
                          },
                          icon: const Icon(
                            Icons.person_outline,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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

class ProfileMenuCard extends StatelessWidget {
  final String label;
  final Widget? icon;
  final VoidCallback onTap;
  const ProfileMenuCard(
    this.label, {
    this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: icon != null
                    ? FittedBox(
                        child: icon!,
                      )
                    : const SizedBox(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangeNameSheet extends StatefulWidget {
  final bool isDarkMode;
  // final TextEditingController nameController;
  // final TextEditingController lastNameController;
  const ChangeNameSheet({
    Key? key,
    required this.isDarkMode,
    // required this.nameController,
    // required this.lastNameController,
  }) : super(key: key);

  @override
  State<ChangeNameSheet> createState() => _ChangeNameSheetState();
}

class _ChangeNameSheetState extends State<ChangeNameSheet> {
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  @override
  void initState() {
    nameController = TextEditingController();
    lastNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 20,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.isDarkMode ? Colors.white54 : Colors.black54,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Введите имя',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.isDarkMode ? Colors.white54 : Colors.black54,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: TextField(
            controller: lastNameController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Введите фамилию',
            ),
          ),
        ),
        PlatformTextButton(
          onPressed: () {},
          child: const Text('Обновить имя пользователя'),
        )
      ],
    );
  }
}
