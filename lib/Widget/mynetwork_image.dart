import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Constants/Global_Variables.dart';

Widget myNetworkImage(BuildContext context, {required String imgurl}) {
  return CachedNetworkImage(
    imageUrl: imgurl,
    placeholder: (context, url) => CircularProgressIndicator(
      color: GlobalVariables.secondaryColor,
    ),
    errorWidget: (context, url, error) => Icon(
      Icons.error,
      color: Colors.grey,
    ),
  );
}
