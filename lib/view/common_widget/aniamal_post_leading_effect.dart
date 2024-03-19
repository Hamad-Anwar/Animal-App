import 'package:animal/view/common_widget/shimmer_effect.dart';
import 'package:flutter/material.dart';

class AnimalPostLoadingEffect extends StatelessWidget {
  const AnimalPostLoadingEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ShimmerEffect(child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black26,
            ),),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerEffect(child: Container(
                  height: 10,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black26,
                  ),
                )),
                SizedBox(height: 5,),
                ShimmerEffect(child: Container(
                  height: 10,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black26,
                  ),
                )),

              ],
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: 10,),
        Expanded(child: ShimmerEffect(child: Container(
          decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(20)
          ),
        ))),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerEffect(child: Container(
                    height: 10,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black26,
                    ),
                  )),
                  SizedBox(height: 5,),
                  ShimmerEffect(child: Container(
                    height: 10,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black26,
                    ),
                  )),
                  SizedBox(height: 5,),
                  ShimmerEffect(child: Container(
                    height: 10,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black26,
                    ),
                  )),

                ],
              ),
              Spacer(),
              ShimmerEffect(child: Container(
                height:40,
                width: 100,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),

                ),
              ),),
              SizedBox(width: 10,),
              ShimmerEffect(child: Container(
                height:40,
                width: 40,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),

                ),
              ),),
            ],
          ),
        )
      ],
    );
  }
}
