import 'package:flutter/material.dart';
import 'package:flutter_spinkit_szw/widget/core/AnimStyle.dart';
import 'package:flutter_spinkit_szw/widget/core/LoadingWidget.dart';

void main() {
  runApp(ShowcasePage());
}

class AnimData {
  final AnimStyle style;
  final Color bg;
  AnimData(this.style, this.bg);
}

class ShowcasePage extends StatelessWidget {
  final list = <AnimData>[
    AnimData(AnimStyle.PULSE, Colors.grey), AnimData(AnimStyle.DOUBLE_BOUNCE, Colors.orange),
    AnimData(AnimStyle.TRIPLE_BOUNCE, Colors.pink), AnimData(AnimStyle.SOUND_WAVE, Colors.black),
    AnimData(AnimStyle.CHASING_DOTS, Colors.yellow), AnimData(AnimStyle.CUBE_GRID, Colors.purple),
    AnimData(AnimStyle.BEADS_SCALE, Colors.lightBlueAccent), AnimData(AnimStyle.BEADS_FADING, Colors.green),
    AnimData(AnimStyle.CIRCLE_3D, Colors.blueGrey), AnimData(AnimStyle.CUBE_3D, Colors.indigo),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("flutter-spinkit-szw"),
          backgroundColor: Colors.grey[900],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(list.length, (index) =>
                  getWidgetOf(list[index])
              )
            )
          ),
        ),
      ),
    );
  }
}

Widget getWidgetOf(AnimData data)  => Column(children: [
  Text(
    data.style.toString().substring(10),
    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  ),
  SizedBox(height: 10),
  LoadingWidget(
    size: 150, bgColor: data.bg,
    animStyle: data.style,
  ),
  SizedBox(height: 40),
]);
