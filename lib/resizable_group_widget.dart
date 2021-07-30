import 'package:flutter/material.dart';
import 'package:resizablebox/menu_widget.dart';
import 'package:resizablebox/box_settings.dart';
import 'package:resizablebox/resize_widget.dart';
import 'package:resizablebox/measure_size.dart';

class ResizableGroupWidget extends StatefulWidget {
  ResizableGroupWidget({Key? key}) : super(key: key);

  @override
  _ResizableGroupWidgetState createState() => _ResizableGroupWidgetState();
}

class _ResizableGroupWidgetState extends State<ResizableGroupWidget> {
  Size? imageSize;
  WindowSelection? _currentWindow = WindowSelection.window1;
  List<BoxSettings> boxSettings = [];

  @override
  void initState() {
    if (boxSettings.isEmpty) {
      BOX_DEFAULT_SETTINGS.forEach((element) {
        boxSettings.add(BoxSettings.fromJson(element));
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentWindow = _currentWindow;
    BoxSettings motionSettings = boxSettings[0];
    if (currentWindow != null) {
      motionSettings = boxSettings[currentWindow.index];
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Resizable Boxes"),
      ),
      body: boxSettings.isEmpty
          ? CircularProgressIndicator()
          : Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.onBackground,
                    ),
                    child: Stack(
                      children: [
                        MeasureSize(
                          onChange: (size) {
                            print("MeasureSize onChange: $size");
                            setState(() {
                              imageSize = size;
                            });
                          },
                          child: Image.network(
                              'https://picsum.photos/id/1/350/250'),
                        ),
                        if (currentWindow != null &&
                            boxSettings[currentWindow.index].switchEnable == 1)
                          ResizeWidget(
                            imageSize: imageSize,
                            settings: motionSettings,
                          )
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 10.0),
                Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.0),
                      child: Column(
                        children: [
                          MenuWidget(
                            setCurrentWindow: _setCurrentWindow,
                            boxSettings: boxSettings,
                          ),
                        ],
                      ),
                    ))
                // ResizeWidget(),
              ],
            ),
    );
  }

  _setCurrentWindow(currentWindow) {
    setState(() {
      _currentWindow = currentWindow;
    });
  }
}