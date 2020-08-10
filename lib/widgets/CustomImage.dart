import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/GlobalVars.dart';

class CustomImage {
  static Widget getProductImage(productImage, {width, height}) {
    if (productImage != null && productImage != "") {
      return Container(
        child: Image.network(
          GlobalVars.imageUrl + productImage,
          width: width ?? 30,
          height: height ?? 30,
          fit: BoxFit.fitHeight,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          },
        ),
      );
    } else {
      return Container(
        child: Icon(
          Icons.image,
          size: 60,
          color: AppTheme.teal_light,
        ),
      );
    }
  }
}