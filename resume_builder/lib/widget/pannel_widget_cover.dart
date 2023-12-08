import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:resume_builder/controller/cover_controller.dart';

import '../controller/global_controller.dart';

class PanelWidgetCover extends StatefulWidget {
  final ScrollController controller;
  final CoverController globalController;
  final VoidCallback callBack;
  const PanelWidgetCover({super.key, required this.controller, required this.globalController, required this.callBack});

  @override
  State<PanelWidgetCover> createState() => _PanelWidgetCoverState();
}

class _PanelWidgetCoverState extends State<PanelWidgetCover> {

  @override
  Widget build(BuildContext context) => ListView(
    controller: widget.controller,
    padding: EdgeInsets.zero,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 8,
              decoration: BoxDecoration(
                color: Color(widget.globalController.color.value),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Pick a color'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Color(widget.globalController.color.value),
                          onColorChanged: (Color color) {
                            setState(() {
                              widget.globalController.color.value = color.value;
                            });
                            widget.callBack();
                          },
                          pickerAreaHeightPercent: 0.8,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(widget.globalController.color.value),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text("Select Color")
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.globalController.updateFontWeight(FontWeight.w100);
                    widget.callBack();
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text("A", style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w100,
                      ),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.globalController.updateFontWeight(FontWeight.w300);
                    widget.callBack();
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text("A", style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w300,
                      ),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.globalController.updateFontWeight(FontWeight.w500);
                    widget.callBack();
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text("A", style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.globalController.updateFontWeight(FontWeight.w700);
                    widget.callBack();
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text("A", style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.globalController.updateFontWeight(FontWeight.bold);
                    widget.callBack();
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text("A", style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.globalController.updateFontWeight(FontWeight.w900);
                    widget.callBack();
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text("A", style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                      ),),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    ],
  );
}
