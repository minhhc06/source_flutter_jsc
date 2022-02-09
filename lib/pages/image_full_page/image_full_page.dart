import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/size_util.dart';

class ImageFullPage extends StatefulWidget {
  final String url;
  const ImageFullPage({Key? key, required this.url}) : super(key: key);

  @override
  _ImageFullPageState createState() => _ImageFullPageState();
}

class _ImageFullPageState extends State<ImageFullPage> with BaseComponents {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: 'imageHero',
                child: CachedNetworkImage(
                  imageUrl: widget.url,
                  placeholder: (context, url) => Container(
                    color: Colors.grey,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
                left: SizeUtil.padding16,
                top: SizeUtil.padding32,
                child: Container(
                  decoration: myBoxDecoration(),
                  child: IconButton(
                    padding: EdgeInsets.all(4),
                    constraints: BoxConstraints(),

                    icon: const Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ), onPressed: () {
                    Navigator.pop(context);
                  },
                  ),
                )),
          ],
        ),
        onTap: () {

        },
      ),
    );
  }
}
