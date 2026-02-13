import 'package:flutter/material.dart';
import 'package:flutter_picasso/flutter_picasso.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DrawingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {

  final PicassoController controller = PicassoController();

  Widget _colorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        controller.disableEraser();
        controller.setColor(color);
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.pink),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade500,
          title: Text("Flutter Picasso",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
      body: Column(
        children: [

          Expanded(
            child: PicassoCanvas(controller: controller),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.grey.shade200,
            child: Column(
              children: [

                // COLOR PICKER ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    _colorCircle(Colors.black),
                    _colorCircle(Colors.red),
                    _colorCircle(Colors.blue),
                    _colorCircle(Colors.green),
                    _colorCircle(Colors.orange),
                    _colorCircle(Colors.purple),

                  ],
                ),

                const SizedBox(height: 8),

                // ACTION BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    IconButton(
                      icon: const Icon(Icons.undo),
                      onPressed: controller.undo,
                    ),

                    IconButton(
                      icon: const Icon(Icons.redo),
                      onPressed: controller.redo,
                    ),

                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: controller.clear,
                    ),

                    IconButton(
                      icon: const Icon(Icons.auto_fix_high), // eraser icon
                      onPressed: () {
                        controller.enableEraser();
                      },
                    ),


                    IconButton(
                      icon: const Icon(Icons.cleaning_services), // eraser
                      onPressed: () {
                        controller.disableEraser();
                      },
                    ),

                  ],
                ),
              ],
            ),
          )


        ],
      ),
    );
  }
}
