import 'package:animal/res/app_icons.dart';
import 'package:animal/res/app_images.dart';
import 'package:animal/view_model/controllers/reels_page_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';

import '../../model/reels_model.dart';

class Reels extends StatelessWidget {
  const Reels({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ReelPageController>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(
                child: PageView(
              controller: controller.pageController,
              onPageChanged: (value) => controller.changePage(page: value),
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('reels').where('type', isEqualTo: 'farms')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          height: MediaQuery.sizeOf(context).height,
                          width: MediaQuery.sizeOf(context).width,
                          color: Colors.black,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ));
                    }
                    final reels = snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return Reel(
                        videoUrl: data['videoUrl'],
                        userName: data['userName'],
                        title: data['title'],
                        type: data['type'],
                        description: data['description'],
                      );
                    }).toList();

                    return PageView.builder(
                      controller: controller.reelScrollControll,
                      scrollDirection: Axis.vertical,
                      // allowImplicitScrolling: true,
                      itemCount: reels.length,
                      onPageChanged: (value) {
                        controller.setPlay(isPlaying: true);
                      },
                     itemBuilder: (context, index) => ReelItem(reel: reels[index],index: index,),
                    );
                  },
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('reels').where('type', isEqualTo: 'animals')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          height: MediaQuery.sizeOf(context).height,
                          width: MediaQuery.sizeOf(context).width,
                          color: Colors.black,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ));
                    }
                    final reels = snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return Reel(
                        videoUrl: data['videoUrl'],
                        userName: data['userName'],
                        title: data['title'],
                        type: data['type'],
                        description: data['description'],
                      );
                    }).toList();

                    return PageView.builder(
                      scrollDirection: Axis.vertical,
                      allowImplicitScrolling: true,
                      itemCount: reels.length,
                      onPageChanged: (value) {
                        controller.setPlay(isPlaying: true);
                      },
                      itemBuilder: (context, index) => ReelItem(reel: reels[index],index: index,),
                    );
                  },
                ),
              ],
            )),
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Consumer<ReelPageController>(
                      builder: (context, value, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => controller.changePage(page: 0),
                              child: Column(
                                children: [
                                  Text(
                                    'Farms',
                                    style: TextStyle(
                                      color: value.currentPage == 0
                                          ? Colors.white
                                          : Colors.white54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  if (value.currentPage == 0)
                                    Container(
                                      height: 2,
                                      width: 30,
                                      color: Colors.white,
                                    )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            GestureDetector(
                              onTap: () => controller.changePage(page: 1),
                              child: Column(
                                children: [
                                  Text('Animals',
                                      style: TextStyle(
                                        color: value.currentPage == 1
                                            ? Colors.white
                                            : Colors.white54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  if (value.currentPage == 1)
                                    Container(
                                      height: 2,
                                      width: 30,
                                      color: Colors.white,
                                    )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ))),
          ],
        ));
  }
}

class ReelItem extends StatefulWidget {
  final Reel reel;
  final int index;
  ReelItem({required this.reel, required this.index});

  @override
  _ReelItemState createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> {
  late VideoPlayerController _controller;
  // bool get keptAlive => true;
  @override
  void initState() {
    super.initState();
    var reelController =
    Provider.of<ReelPageController>(context, listen: false);
    _controller = VideoPlayerController.network(widget.reel.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        if(reelController.reelScrollControll.page!.toInt()==widget.index){
          _controller.play().then((value) {
            reelController.setPlay(isPlaying: true);
          });
        }

      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var reelController =
        Provider.of<ReelPageController>(context, listen: false);
    return GestureDetector(
      onTap: () {
        if (_controller.value.isPlaying) {
          _controller.pause();
          reelController.setPlay(isPlaying: false);
        } else {
          _controller.play();
          reelController.setPlay(isPlaying: true);
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: _controller.value.isInitialized
                    ? VideoPlayer(_controller)
                    : Container(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        color: Colors.black,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        )))),
          ),
          Consumer<ReelPageController>(
            builder: (context, value, child) => value.isVideoPlaying
                ? SizedBox.shrink()
                : Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white24,
                      size: 120,
                    ),
                  ),
          ),
          Positioned(
            bottom: 10,
            child: Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This is farm reel',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width/1.5,
                    child: ReadMoreText(
                      'An area of land, esp. together with a house and other buildings, used for growing crops or keeping animals. A farm can also be a place where a specific type of animal is raised in large numbers to be sold: a cattle/mink farm. farm.',
                      trimLines: 2,
                      style: TextStyle(
                        color: Colors.white54,

                      ),
                      colorClickableText: Colors.white,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: '  See more',
                      trimExpandedText: '  See less',
                      lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white),
                      moreStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 57,
                  width: 57,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(AppImages.cowImages[0]),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.red,
                            child: Center(
                              child: Icon(Icons.add,size: 13,color: Colors.white,),
                            ),
                      ))
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Column(
                  children: [
                    Icon(Icons.favorite,color: Colors.white,size: 50,),
                    Text('104',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(height: 15),
                Column(
                  children: [
                    Image.asset(AppIcons.comment,height: 40,),
                    Text('10',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                  ],
                ),
                // SizedBox(height: 15),
                // Column(
                //   children: [
                //     Image.asset(AppIcons.save,height: 30,width: 30,fit: BoxFit.fill,),
                //     Text('40',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                //   ],
                // ),
                SizedBox(height: 5),
                Column(
                  children: [
                    Image.asset(AppIcons.share,height: 40,),
                    Text('3',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                  ],
                ),


              ],
            ),
          )
        ],
      ),
    );
  }


}
