import 'dart:io';

import 'package:dream_note/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class NewDreamScreen extends StatelessWidget {
  const NewDreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<DateTime> dateTimeNotifier = ValueNotifier(DateTime.now());
    Size sSize = MediaQuery.of(context).size;
    TextEditingController textController =
        TextEditingController(text: fishText);
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
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: NewDreamTitle(),
                    ),
                    ValueListenableBuilder(
                      valueListenable: dateTimeNotifier,
                      builder: (context, value, child) => GestureDetector(
                        onTap: () async {
                          await showModalBottomSheet(
                            context: context,
                            builder: (c) {
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
                                      onDateTimeChanged: (value) =>
                                          dateTimeNotifier.value = value,
                                      use24hFormat: true,
                                      mode: CupertinoDatePickerMode.date,
                                    ),
                                  ),
                                ],
                              );
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
                          onPressed: () {},
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
      child: TextField(
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
