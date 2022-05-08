import 'dart:html';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
class ImagePick extends StatefulWidget {
  const ImagePick({Key? key}) : super(key: key);

  @override
  State<ImagePick> createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  final imageStorage = FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
