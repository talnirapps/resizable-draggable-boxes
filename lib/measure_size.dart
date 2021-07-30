import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef void OnWidgetSizeChange(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size oldSize = Size.zero;
  final OnWidgetSizeChange onChange;

  MeasureSizeRenderObject({required this.onChange});

  @override
  void performLayout() {
    super.performLayout();

    if (child != null) {
      Size newSize = child!.size;
      if (oldSize == newSize) return;
      oldSize = newSize;
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        onChange(newSize);
      });
    }
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    required this.onChange,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange: onChange);
  }
}
