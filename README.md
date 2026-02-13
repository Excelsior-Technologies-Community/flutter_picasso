## 🎨 flutter_picasso


flutter_picasso is a lightweight Flutter drawing & sketching library that provides a customizable paint canvas for doodling, signatures, whiteboards, handwriting apps and annotation tools.

It removes the need to manually handle gestures, strokes, repaint cycles, and canvas math.

Just add the widget and you instantly get a fully working drawing board.

---------------


## ✨ Feature Preview

- 🖌 Freehand finger drawing
- 🌈 Multi-color brush support
- ✨ Smooth curves (Bezier smoothing)
- ↩️ Undo & Redo
🧹 Clear canvas
🧽 Real eraser (transparent pixel removal)
📏 Adjustable stroke width
🎛 Controller-based API
⚡ Realtime rendering (no lag)
🪟 Transparent background support
🖼 Export drawing as image (PNG)

--------------

## 🎬 Preview



https://github.com/user-attachments/assets/410c7638-98d5-436f-89a3-44024ccab090



------------------

## 📦 Installation

Add this to your pubspec.yaml:
```
dependencies:
  flutter_picasso:
    git:
      url: https://github.com/Excelsior-Technologies-Community/flutter_picasso/tree/stage
```
then run:
```
flutter pub get
```

-----------------

## 📁 File Structure
```
flutter_picasso/
│
├─ lib/
│   ├─ flutter_picasso.dart            # Main export file
│   │
│   └─ src/
│       ├─ controller/
│       │    └─ picasso_controller.dart    # Canvas controller (undo, redo, tools)
│       │
│       ├─ models/
│       │    ├─ draw_point.dart            # Single touch point
│       │    └─ stroke.dart                # Stroke data (points, color, width, eraser)
│       │
│       ├─ painter/
│       │    └─ picasso_painter.dart       # Drawing engine (CustomPainter)
│       │
│       ├─ widgets/
│       │    └─ picasso_canvas.dart        # Main drawing widget
│       │
│       └─ utils/
│            └─ image_exporter.dart        # Export canvas to PNG
│
├─ example/
│   └─ main.dart                           # Example usage
│
├─ pubspec.yaml
├─ README.md
└─ LICENSE

```

-----------------------------

## 🚀 Usage
```
import 'package:flutter/material.dart';
import 'package:flutter_picasso/flutter_picasso.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {

  final PicassoController controller = PicassoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Picasso")),
      body: Column(
        children: [

          Expanded(
            child: PicassoCanvas(
              controller: controller,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              IconButton(
                icon: const Icon(Icons.undo),
                onPressed: controller.undo,
              ),

              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: controller.clear,
              ),
            ],
          )
        ],
      ),
    );
  }
}
```

------------------------

## 🎨 Change Brush Color
```
controller.disableEraser();
controller.setColor(Colors.red);
```

----------------------------

## 🧽 Use Eraser
```
controller.enableEraser();
```

---------------------------------

## 🖼 Export Drawing as Image
```
Uint8List? imageBytes = await controller.exportImage();
```

------------------------------

## 🧩 Canvas Widget Properties

| Property          | Type              | Required | Description                                      |
| ----------------- | ----------------- | -------- | ------------------------------------------------ |
| `controller`      | PicassoController | Yes      | Controls drawing actions                         |
| `backgroundColor` | Color?            | No       | Optional background. Leave null for transparency |


------------------------------

## 📜 MIT License
```
Copyright (c) 2025

Permission is hereby granted, free of charge, to any person obtaining a copy
of this flutter_picasso library and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
```

































