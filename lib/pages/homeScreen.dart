// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapps/components/theme.dart';
import 'package:newsapps/controllers/homeController.dart';
import 'package:newsapps/pages/detailScreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:like_button/like_button.dart';

import '../components/widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget topHeadLines(String url, String title) {
      return Row(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(left: 8),
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: url,
                      placeholder: (context, url) {
                        return pictureSkeleton(80, 80);
                      },
                    )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      title,
                      style: blackTextStyle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
            margin: EdgeInsets.only(top: 24, left: 12, right: 12),
            height: 100,
            width: 280,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor)),
          ),
          // Expanded(child: LikeButton())
        ],
      );
    }

    Widget newsCard(String url, String title) {
      return Row(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(left: 8),
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: url,
                      placeholder: (context, url) {
                        return Padding(
                            padding: EdgeInsets.all(10),
                            child: pictureSkeleton(80, 80));
                      },
                    )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      title,
                      style: blackTextStyle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
            margin: EdgeInsets.only(top: 24, left: 12, right: 12),
            height: 100,
            width: 280,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor)),
          ),
          Expanded(child: LikeButton(
            onTap: (isLiked) {
              return Get.find<HomeController>()
                  .onLikeButtonTapped(isLiked, context);
            },
          ))
        ],
      );
    }

    Widget newsCardSkeleton() {
      return Container(
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: Color(0xffd6d8da),
              highlightColor: Color(0xffF9F6EE),
              child: Container(
                color: Colors.grey,
                width: 80,
                height: 80,
                margin: EdgeInsets.only(left: 8),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Shimmer.fromColors(
                  baseColor: Color(0xffd6d8da),
                  highlightColor: Color(0xffF9F6EE),
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                    ),
                    width: 165,
                    height: 20,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Color(0xffd6d8da),
                  highlightColor: Color(0xffF9F6EE),
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                    ),
                    width: 165,
                    height: 20,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Color(0xffd6d8da),
                  highlightColor: Color(0xffF9F6EE),
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                    ),
                    width: 165,
                    height: 20,
                  ),
                ),
              ],
            )
          ],
        ),
        margin: EdgeInsets.only(top: 24, left: 12, right: 12),
        height: 100,
        width: 280,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor)),
      );
    }

    return SafeArea(child: GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'News Apps',
                    style:
                        blackTextStyle.copyWith(fontWeight: bold, fontSize: 18),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.red,
                  highlightColor: Colors.yellow,
                  child: Container(
                    margin: EdgeInsets.only(left: 12, right: 12, top: 24),
                    child: GestureDetector(
                      onTap: () {
                        controller.getTopHeadLines();
                      },
                      child: Text(
                        'Top Headlines',
                        style: blackTextStyle.copyWith(
                            fontWeight: bold, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(10, (index) {
                        if (controller.isLoading == true) {
                          return newsCardSkeleton();
                        } else {
                          return GestureDetector(
                            onTap: () {
                              Get.to(DetailScreen(index, 'headlines'));
                            },
                            child: topHeadLines(
                                controller.article[index].urlToImage!,
                                controller.article[index].title!),
                          );
                        }
                      })),
                ),
                Container(
                  margin: EdgeInsets.only(left: 12, right: 12, top: 24),
                  child: Text(
                    'News About Certain Topic',
                    style:
                        blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, bottom: 12, top: 24),
                  child: Container(
                    width: Get.width - 24,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue)),
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                controller.searchFunction();
                              },
                              controller: controller.searchController,
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search),
                                  hintText: 'Cari Berita Disini'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          await controller.searchFunction();
                        },
                        child: Text('Cari'))),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: (controller.newArticle.isEmpty)
                      ? Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Text(
                            'Berita Yang Anda Cari Tidak ada Silahkan mencari dengan kata kunci yang lebih jelas',
                            style: errorTextStyle.copyWith(fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : (controller.newArticle.length < 10)
                          ? Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Text(
                                'Berita Yang Anda Cari Memiliki kurang dari 10 sumber sehingga tidak valid',
                                style: errorTextStyle.copyWith(fontSize: 30),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Column(
                              children: List.generate(10, (index) {
                                if (controller.isLoading == true) {
                                  return newsCardSkeleton();
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(DetailScreen(index, 'news'));
                                    },
                                    child: newsCard(
                                        '${controller.newArticle[index].urlToImage}',
                                        '${controller.newArticle[index].title}'),
                                  );
                                }
                              }),
                            ),
                )
              ],
            ),
          ),
        ),
      );
    }));
  }
}
