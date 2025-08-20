import 'dart:io';
import 'package:flutter/material.dart';


Widget profileWithEdit({
  File? imageFile,
  String? imageUrl, // nullable network image
  required VoidCallback onEdit,
  double size = 100,
  String defaultAssetImage = 'assets/defaultImg.jpg',
}) {
  ImageProvider imageProvider;

  if (imageFile != null) {
    imageProvider = FileImage(imageFile); // picked file
  } else if (imageUrl != null && imageUrl.isNotEmpty) {
    imageProvider = NetworkImage(imageUrl); // ✅ use network image correctly
  } else {
    imageProvider = AssetImage(defaultAssetImage); // default asset
  }

  return Stack(
    children: [
      CircleAvatar(radius: size / 2, backgroundImage: imageProvider),

      // Edit button
      Positioned(
        bottom: 0,
        right: 0,
        child: GestureDetector(
          onTap: onEdit,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            padding: const EdgeInsets.all(6),
            child: const Icon(Icons.edit, size: 16, color: Colors.white),
          ),
        ),
      ),
    ],
  );
}
