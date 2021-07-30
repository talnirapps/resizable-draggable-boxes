import 'package:flutter/material.dart';
import 'package:resizablebox/box_settings.dart';

class ResizeWidget extends StatefulWidget {
  final Size? imageSize;
  final BoxSettings settings;

  ResizeWidget({required this.imageSize, required this.settings});

  @override
  _ResizeWidgetState createState() => _ResizeWidgetState();
}

class _ResizeWidgetState extends State<ResizeWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.imageSize == null
        ? Center()
        : ResizableWidget(
            imageSize: widget.imageSize,
            settings: widget.settings,
            child: Center(),
          );
  }
}

class ResizableWidget extends StatefulWidget {
  ResizableWidget(
      {required this.child, required this.imageSize, required this.settings});

  final Widget child;
  final Size? imageSize;
  final BoxSettings settings;

  @override
  _ResizableWidgetState createState() => _ResizableWidgetState();
}

const ballDiameter = 10.0;

class _ResizableWidgetState extends State<ResizableWidget> {
  late double height;
  late double width;
  bool isCorner = false;

  late double top;
  late double left;

  late double widthFactor;
  late double heightFactor;

  @override
  Widget build(BuildContext context) {
    _init();

    double calcBallDiameter = height / 10;
    double dragDiameter = 4 * height / 10;
    double? widgetHeight = widget.imageSize?.height; //context.size?.height;
    double? widgetWidth = widget.imageSize?.width; //context.size?.width;
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: Container(
            height: height,
            width: width,

            decoration: BoxDecoration(
              // color: Colors.blueGrey,
              border: Border.all(
                width: 2,
                color: colorScheme.primaryVariant,
              ),
              borderRadius: BorderRadius.circular(0.0),
            ),

            // need tp check if draggable is done from corner or sides
            child: isCorner
                ? FittedBox(
                    child: widget.child,
                  )
                : Center(
                    child: widget.child,
                  ),
          ),
        ),
        // top left
        Positioned(
          top: top - dragDiameter / 2,
          left: left - dragDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              print("onDrag top left");
              var mid = (dx + dy) / 2;
              var newHeight = height - 2 * mid;
              var newWidth = width - 2 * mid;

              if (!_validate(
                  width: newWidth > 0 ? newWidth : 0,
                  top: top + mid,
                  height: newHeight > 0 ? newHeight : 0,
                  left: left + mid,
                  widgetHeight: widgetHeight,
                  widgetWidth: widgetWidth)) {
                return;
              }

              setState(() {
                isCorner = true;
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top + mid;
                left = left + mid;
              });
            },
            handlerWidget: HandlerWidget.VERTICAL,
            ballDiameter: calcBallDiameter,
            dragDiameter: dragDiameter,
          ),
        ),
        // top middle
        Positioned(
          top: top - dragDiameter / 2,
          left: left + width / 2 - dragDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              print("onDrag top middle");
              var newHeight = height - dy;
              if (!_validate(
                  width: width,
                  top: top + dy,
                  height: newHeight > 0 ? newHeight : 0,
                  left: left,
                  widgetWidth: widgetWidth,
                  widgetHeight: widgetHeight)) {
                return;
              }

              setState(() {
                isCorner = false;

                height = newHeight > 0 ? newHeight : 0;
                top = top + dy;
              });
            },
            handlerWidget: HandlerWidget.HORIZONTAL,
            ballDiameter: calcBallDiameter,
            dragDiameter: dragDiameter,
          ),
        ),
        // top right
        Positioned(
          top: top - dragDiameter / 2,
          left: left + width - dragDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              print("onDrag top right");
              var mid = (dx + (dy * -1)) / 2;
              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;
              if (!_validate(
                  width: newWidth > 0 ? newWidth : 0,
                  top: top - mid,
                  height: newHeight > 0 ? newHeight : 0,
                  left: left - mid,
                  widgetHeight: widgetHeight,
                  widgetWidth: widgetWidth)) {
                return;
              }

              setState(() {
                isCorner = true;
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
            handlerWidget: HandlerWidget.VERTICAL,
            ballDiameter: calcBallDiameter,
            dragDiameter: dragDiameter,
          ),
        ),
        // center right
        Positioned(
          top: top + height / 2 - dragDiameter / 2,
          left: left + width - dragDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              print("onDrag center right");
              var newWidth = width + dx;

              if (!_validate(
                  width: newWidth > 0 ? newWidth : 0,
                  top: top,
                  height: height,
                  left: left,
                  widgetHeight: widgetHeight,
                  widgetWidth: widgetWidth)) {
                return;
              }

              setState(() {
                isCorner = false;

                width = newWidth > 0 ? newWidth : 0;
              });
            },
            handlerWidget: HandlerWidget.HORIZONTAL,
            ballDiameter: calcBallDiameter,
            dragDiameter: dragDiameter,
          ),
        ),
        // bottom right
        Positioned(
          top: top + height - dragDiameter / 2,
          left: left + width - dragDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              print("onDrag bottom right");
              var mid = (dx + dy) / 2;
              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;
              if (!_validate(
                  width: newWidth > 0 ? newWidth : 0,
                  top: top - mid,
                  height: newHeight > 0 ? newHeight : 0,
                  left: left - mid,
                  widgetHeight: widgetHeight,
                  widgetWidth: widgetWidth)) {
                return;
              }

              setState(() {
                isCorner = true;

                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
            handlerWidget: HandlerWidget.VERTICAL,
            ballDiameter: calcBallDiameter,
            dragDiameter: dragDiameter,
          ),
        ),
        // bottom center
        Positioned(
          top: top + height - dragDiameter / 2,
          left: left + width / 2 - dragDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              print("onDrag bottom center");
              var newHeight = height + dy;
              if (!_validate(
                  width: width,
                  top: top,
                  height: newHeight > 0 ? newHeight : 0,
                  left: left,
                  widgetHeight: widgetHeight,
                  widgetWidth: widgetWidth)) {
                return;
              }
              setState(() {
                isCorner = false;

                height = newHeight > 0 ? newHeight : 0;
              });
            },
            handlerWidget: HandlerWidget.HORIZONTAL,
            ballDiameter: calcBallDiameter,
            dragDiameter: dragDiameter,
          ),
        ),
        // bottom left
        Positioned(
          top: top + height - dragDiameter / 2,
          left: left - dragDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              print("onDrag bottom left");
              var mid = ((dx * -1) + dy) / 2;

              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;
              if (!_validate(
                  width: newWidth > 0 ? newWidth : 0,
                  top: top - mid,
                  height: newHeight > 0 ? newHeight : 0,
                  left: left - mid,
                  widgetHeight: widgetHeight,
                  widgetWidth: widgetWidth)) {
                return;
              }

              setState(() {
                isCorner = true;

                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
            handlerWidget: HandlerWidget.VERTICAL,
            ballDiameter: calcBallDiameter,
            dragDiameter: dragDiameter,
          ),
        ),
        //left center
        Positioned(
          top: top + height / 2 - dragDiameter / 2,
          left: left - dragDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              print("onDrag left center");
              var newWidth = width - dx;
              if (!_validate(
                  width: newWidth > 0 ? newWidth : 0,
                  top: top,
                  height: height,
                  left: left + dx,
                  widgetHeight: widgetHeight,
                  widgetWidth: widgetWidth)) {
                return;
              }
              setState(() {
                isCorner = false;

                width = newWidth > 0 ? newWidth : 0;
                left = left + dx;
              });
            },
            handlerWidget: HandlerWidget.HORIZONTAL,
            ballDiameter: calcBallDiameter,
            dragDiameter: dragDiameter,
          ),
        ),
        // center center
        Positioned(
          top: top + height / 2 - dragDiameter / 2,
          left: left + width / 2 - dragDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              print("onDrag center center");
              if (!_validate(
                  width: width,
                  top: top + dy,
                  height: height,
                  left: left + dx,
                  widgetHeight: widgetHeight,
                  widgetWidth: widgetWidth)) {
                return;
              }
              setState(() {
                isCorner = false;

                top = top + dy;
                left = left + dx;
              });
            },
            handlerWidget: HandlerWidget.VERTICAL,
            ballDiameter: calcBallDiameter,
            dragDiameter: dragDiameter,
          ),
        ),
      ],
    );
  }

  _init() {
    if (widget.imageSize != null) {
      widthFactor = widget.settings.width.toDouble() / widget.imageSize!.width;
      heightFactor =
          widget.settings.height.toDouble() / widget.imageSize!.height;
    }
    height = widget.settings.y2.toDouble() / heightFactor;
    width = widget.settings.x2.toDouble() / widthFactor;
    top = widget.settings.y1.toDouble() / heightFactor;
    left = widget.settings.x1.toDouble() / widthFactor;
    print("top $top left $left height: $height width: $width");
  }

  bool _validate({
    required double top,
    required double left,
    required double width,
    required double height,
    required double? widgetHeight,
    required double? widgetWidth,
  }) {
    print("widgetHeight $widgetHeight widgetWidth $widgetWidth ");
    final bottom = top + height;
    final right = left + width;
    print(
        "($left, $top) ($left, ${top + height}) (${left + width}, ${top + height}) (${left + width}, $top)");

    if (width < 50) {
      return false;
    }
    if (height < 50) {
      return false;
    }

    if (left < 0) {
      return false;
    }
    if (top < 0) {
      return false;
    }
    if (widgetHeight != null && bottom > widgetHeight) {
      return false;
    }
    if (widgetWidth != null && right > widgetWidth) {
      return false;
    }

    widget.settings.y2 = (height * heightFactor).toInt();
    widget.settings.x2 = (width * widthFactor).toInt();
    widget.settings.y1 = (top * heightFactor).toInt();
    widget.settings.x1 = (left * widthFactor).toInt();

    return true;
  }
}

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall(
      {required this.onDrag,
      required this.handlerWidget,
      required this.ballDiameter,
      required this.dragDiameter,
      Key? key});

  final Function onDrag;
  final HandlerWidget handlerWidget;
  final double ballDiameter;
  final double dragDiameter;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

enum HandlerWidget { HORIZONTAL, VERTICAL }

class _ManipulatingBallState extends State<ManipulatingBall> {
  double initX = 0;
  double initY = 0;

  _handleDrag(details) {}

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  _onPanDown(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _onLongPressStart(details) {}

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onLongPressStart: _onLongPressStart,
      onPanDown: _onPanDown,
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: SizedBox(
        width: widget.dragDiameter,
        height: widget.dragDiameter,
        child: Stack(
          children: [
            Container(
              width: widget.dragDiameter,
              height: widget.dragDiameter,
              decoration: BoxDecoration(
                // color: Colors.lightBlue,
                border: Border.all(
                    color: colorScheme.onBackground.withOpacity(0.01)),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: widget.ballDiameter,
                height: widget.ballDiameter,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: widget.handlerWidget == HandlerWidget.VERTICAL
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
