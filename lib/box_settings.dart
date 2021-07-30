const BOX_DEFAULT_SETTINGS = [
  {
    "index": 0,
    "switch": 1,
    "x1": 10,
    "y1": 10,
    "x2": 1279,
    "y2": 719,
    "width": 1280,
    "height": 720,
    "type": 3,
  },
  {
    "index": 1,
    "switch": 0,
    "x1": 10,
    "y1": 10,
    "x2": 1279,
    "y2": 719,
    "width": 1280,
    "height": 720,
    "type": 1,
  },
  {
    "index": 2,
    "switch": 0,
    "x1": 10,
    "y1": 10,
    "x2": 320,
    "y2": 240,
    "width": 1280,
    "height": 720,
    "type": 1,
  },
  {
    "index": 3,
    "switch": 0,
    "x1": 10,
    "y1": 10,
    "x2": 1279,
    "y2": 719,
    "width": 1280,
    "height": 720,
    "type": 1,
  }
];

class BoxSettings {
  int index = 0;
  int switchEnable = 0;
  int x1 = 0;
  int y1 = 0;
  int x2 = 0;
  int y2 = 0;
  int width = 0;
  int height = 0;
  int type = 0;

  BoxSettings(
      {required this.index,
      required this.switchEnable,
      required this.x1,
      required this.y1,
      required this.x2,
      required this.y2,
      required this.width,
      required this.height,
      required this.type});

  BoxSettings.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    switchEnable = json['switch'];
    x1 = json['x1'];
    y1 = json['y1'];
    x2 = json['x2'];
    y2 = json['y2'];
    width = json['width'];
    height = json['height'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['index'] = index;
    data['switch'] = switchEnable;
    data['x1'] = x1;
    data['y1'] = y1;
    data['x2'] = x2;
    data['y2'] = y2;
    data['width'] = width;
    data['height'] = height;
    data['type'] = type;
    return data;
  }
}
