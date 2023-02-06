import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapps/components/theme.dart';
import 'package:newsapps/components/widget.dart';
import 'package:newsapps/controllers/detailController.dart';
import 'package:newsapps/controllers/homeController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class DetailScreen extends StatelessWidget {
  final int index;
  final String type;
  const DetailScreen(this.index, this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();

    return GetBuilder<DetailController>(builder: (controller) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                height: 200,
                child: CachedNetworkImage(
                    placeholder: (context, url) {
                      return pictureSkeleton(Get.width, 200);
                    },
                    fit: BoxFit.cover,
                    imageUrl: (type == 'headlines')
                        ? homeController.article[index].urlToImage!
                        : homeController.newArticle[index].urlToImage!),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Center(
                    child: Text(
                  (type == 'headlines')
                      ? '${homeController.article[index].title}'
                      : '${homeController.newArticle[index].title}',
                  textAlign: TextAlign.center,
                  style:
                      blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
                )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Text(
                  (type == 'headlines')
                      ? 'Author : ${homeController.article[index].author}'
                      : 'Author : ${homeController.newArticle[index].author}',
                  style: blackTextStyle.copyWith(fontWeight: bold),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    (type == 'headlines')
                        ? 'Full Url : ${homeController.article[index].url}'
                        : 'Full Url : ${homeController.newArticle[index].url}',
                    style: blackTextStyle.copyWith(fontWeight: bold),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: Divider(),
              ),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                child: Text(
                  //using lorem ipsum because the api only retturn 200 char on content
                  (type == 'headlines')
                      ? '${homeController.article[index].content} \n\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'
                      : '${homeController.newArticle[index].content} \n\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                  style: blackTextStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      if (type == 'headlines') {
                        controller
                            .onTapLink('${homeController.article[index].url}');
                      } else {
                        controller.onTapLink(
                            '${homeController.newArticle[index].url}');
                      }
                    },
                    child: Text(
                      'Kunjungi Link',
                      style: whiteTextStyle,
                    )),
              )
            ],
          ),
        ),
      );
    });
  }
}
