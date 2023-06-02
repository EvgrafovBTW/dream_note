import 'dart:io';

import 'package:dream_note/logic/blocs/dreams/bloc/dreams_bloc.dart';
import 'package:dream_note/models/dream_model.dart';
import 'package:dream_note/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:overlay_support/overlay_support.dart';

class NewDreamScreen extends StatelessWidget {
  const NewDreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<DateTime> dateTimeNotifier = ValueNotifier(DateTime.now());
    Size sSize = MediaQuery.of(context).size;
    TextEditingController textController = TextEditingController();
    TextEditingController titleController = TextEditingController(text: '');
    DreamsBloc dreamsBloc = BlocProvider.of<DreamsBloc>(context);

    void addDream() async {
      if (textController.text.isNotEmpty) {
        await showPlatformDialog(
          material: MaterialDialogData(),
          context: context,
          builder: (context) {
            return DreamTitleDialog(
              titleController: titleController,
              textController: textController,
              dreamsBloc: dreamsBloc,
              dateTime: dateTimeNotifier.value,
            );
          },
        );
      }
    }

    return SafeArea(
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: NewDreamTitle(),
                    ),
                    ValueListenableBuilder(
                      valueListenable: dateTimeNotifier,
                      builder: (context, value, child) => GestureDetector(
                        onTap: () async {
                          await showModalBottomSheet(
                            context: context,
                            builder: (c) {
                              return DreamTimePicker(
                                  dateTimeNotifier: dateTimeNotifier);
                            },
                          );
                        },
                        child: DreamDateTime(
                          date: dateTimeNotifier.value,
                          sSize: sSize,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DreamTextField(
                        textController,
                        flex: 8,
                      ),
                      Flexible(
                        flex: 2,
                        child: FloatingActionButton(
                          onPressed: addDream,
                          child: Icon(
                            Platform.isAndroid
                                ? Icons.arrow_forward
                                : Icons.arrow_forward_ios,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DreamTitleDialog extends StatelessWidget {
  const DreamTitleDialog({
    super.key,
    required this.titleController,
    required this.textController,
    required this.dateTime,
    required this.dreamsBloc,
  });

  final TextEditingController titleController;
  final TextEditingController textController;
  final DateTime dateTime;
  final DreamsBloc dreamsBloc;

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      title: const Text('Укажите название для своего сна'),
      content: Wrap(
        children: [
          const Text('Иначе в качестве названия будет использована дата'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: PlatformTextField(
              controller: titleController,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlatformTextButton(
                onPressed: () {
                  titleController.text = '';
                  Navigator.pop(context);
                },
                child: const Text('Закрыть'),
              ),
              PlatformTextButton(
                onPressed: () {
                  Navigator.pop(context);
                  dreamsBloc.add(
                    DreamAdd(
                      Dream(
                        id: dreamsBloc.state.dreams.length,
                        dreamContent: textController.text,
                        dreamDate: dateTime,
                        moonPhase: 'Убывающая',
                        title: titleController.text.isEmpty
                            ? null
                            : titleController.text,
                      ),
                    ),
                  );
                  textController.text = '';
                  showSimpleNotification(
                    Text(
                        'Ваш сон от ${dateTime.toIso8601String().substring(0, dateTime.toIso8601String().indexOf('T'))} успешно записан'),
                  );
                },
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DreamTimePicker extends StatelessWidget {
  const DreamTimePicker({
    super.key,
    required this.dateTimeNotifier,
  });

  final ValueNotifier<DateTime> dateTimeNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PlatformTextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Закрыть'),
            ),
          ],
        ),
        Expanded(
          child: CupertinoDatePicker(
            onDateTimeChanged: (value) => dateTimeNotifier.value = value,
            use24hFormat: true,
            mode: CupertinoDatePickerMode.date,
          ),
        ),
      ],
    );
  }
}

class DreamTextField extends StatelessWidget {
  final TextEditingController controller;
  final int flex;
  const DreamTextField(
    this.controller, {
    super.key,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: PlatformTextField(
        autofocus: false,
        controller: controller,
        maxLines: null,
      ),
    );
  }
}

class DreamDateTime extends StatelessWidget {
  const DreamDateTime({
    super.key,
    required this.date,
    required this.sSize,
  });

  final DateTime date;
  final Size sSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          date.day.toString(),
          style: TextStyle(
            fontSize: sSize.height * 0.05,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            getMonthName(date.month),
            style: TextStyle(
              fontSize: sSize.height * 0.03,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            date.year.toString(),
            style: TextStyle(
              fontSize: sSize.height * 0.03,
            ),
          ),
        ),
      ],
    );
  }
}

class NewDreamTitle extends StatelessWidget {
  const NewDreamTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          flex: 8,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'Расскажите о своём сне',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Spacer(flex: 2),
      ],
    );
  }
}
