import 'package:flutter/material.dart';
import 'package:resizablebox/box_settings.dart';

enum WindowSelection { window1, window2, window3, window4 }

class MenuWidget extends StatefulWidget {
  final Function setCurrentWindow;
  final List<BoxSettings> boxSettings;

  MenuWidget(
      {required this.setCurrentWindow, required this.boxSettings, Key? key})
      : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  WindowSelection? _currentWindow = WindowSelection.window1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: OptionTypeWidget(settings: widget.boxSettings[0]),
          leading: Radio<WindowSelection>(
            value: WindowSelection.window1,
            groupValue: _currentWindow,
            onChanged: (WindowSelection? value) {
              setState(() {
                _currentWindow = value;
                widget.setCurrentWindow(_currentWindow);
              });
            },
          ),
          trailing: Switch(
            value: widget.boxSettings[0].switchEnable == 1,
            onChanged: (value) {
              setState(() {
                widget.boxSettings[0].switchEnable = value ? 1 : 0;
                widget.setCurrentWindow(_currentWindow);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ),
        ListTile(
          title: OptionTypeWidget(settings: widget.boxSettings[1]),
          leading: Radio<WindowSelection>(
            value: WindowSelection.window2,
            groupValue: _currentWindow,
            onChanged: (WindowSelection? value) {
              setState(() {
                _currentWindow = value;
                widget.setCurrentWindow(_currentWindow);
              });
            },
          ),
          trailing: Switch(
            value: widget.boxSettings[1].switchEnable == 1,
            onChanged: (value) {
              setState(() {
                widget.boxSettings[1].switchEnable = value ? 1 : 0;
                widget.setCurrentWindow(_currentWindow);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ),
        ListTile(
          title: OptionTypeWidget(settings: widget.boxSettings[2]),
          leading: Radio<WindowSelection>(
            value: WindowSelection.window3,
            groupValue: _currentWindow,
            onChanged: (WindowSelection? value) {
              setState(() {
                _currentWindow = value;
                widget.setCurrentWindow(_currentWindow);
              });
            },
          ),
          trailing: Switch(
            value: widget.boxSettings[2].switchEnable == 1,
            onChanged: (value) {
              setState(() {
                widget.boxSettings[2].switchEnable = value ? 1 : 0;
                widget.setCurrentWindow(_currentWindow);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ),
        ListTile(
          title: OptionTypeWidget(settings: widget.boxSettings[3]),
          leading: Radio<WindowSelection>(
            value: WindowSelection.window4,
            groupValue: _currentWindow,
            onChanged: (WindowSelection? value) {
              setState(() {
                _currentWindow = value;
                widget.setCurrentWindow(_currentWindow);
              });
            },
          ),
          trailing: Switch(
            value: widget.boxSettings[3].switchEnable == 1,
            onChanged: (value) {
              setState(() {
                widget.boxSettings[3].switchEnable = value ? 1 : 0;
                widget.setCurrentWindow(_currentWindow);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ),
      ],
    );
  }
}

enum OptionType { optionA, optionB }

extension OptionTypeExtension on OptionType {
  int get value {
    switch (this) {
      case OptionType.optionA:
        return 1;
      case OptionType.optionB:
        return 3;
      default:
        return 0;
    }
  }

  String get name {
    switch (this) {
      case OptionType.optionA:
        return "Option A";
      case OptionType.optionB:
        return "Option B";
      default:
        return "None";
    }
  }
}

class OptionTypeWidget extends StatefulWidget {
  final BoxSettings settings;

  const OptionTypeWidget({required this.settings, Key? key}) : super(key: key);

  @override
  State<OptionTypeWidget> createState() => _OptionTypeWidgetState();
}

class _OptionTypeWidgetState extends State<OptionTypeWidget> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.settings.type == OptionType.optionA.value
        ? OptionType.optionA.name
        : OptionType.optionB.name;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Type: ", style: textTheme.bodyText2),
          DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: colorScheme.primaryVariant),
            underline: Container(
              height: 2,
              color: colorScheme.primary,
            ),
            onChanged: (String? newValue) {
              setState(() {
                widget.settings.type = newValue == OptionType.optionA.name
                    ? OptionType.optionA.value
                    : OptionType.optionB.value;
                dropdownValue = newValue!;
              });
            },
            items: <String>[
              "Option A",
              "Option B",
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
