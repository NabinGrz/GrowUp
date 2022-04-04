import 'package:flutter/material.dart';
import 'package:growupadmin/colorpalettes/palette.dart';
import 'package:growupadmin/screen/videoPostScreen.dart/camera_button_widget.dart';
import 'package:growupadmin/screen/videoPostScreen.dart/gallery_button_widget.dart';

class SourcePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        title: const Text('Select Source'),
      ),
      body: ListView(
        children: [
          CameraButtonWidget(),
          GalleryButtonWidget(),
        ],
      ),
    );
  }
}
