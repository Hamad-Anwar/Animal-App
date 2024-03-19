import 'package:animal/model/animal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({super.key, required this.dataModel});
  final AnimalPostModel dataModel;
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dataModel.name.toString(),style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
              ),),
              Row(
                children: [
                  Text('\$ ${dataModel.price}',style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 13
                  ),),
                  const SizedBox(width: 10,),
                   Text(local.market,style: const TextStyle(
                    color: Colors.grey,
                  ),),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.location_on_rounded,color: Colors.black26,size: 20,),
                  const SizedBox(width: 5,),
                  const Text('0 km'),
                  const SizedBox(width: 10,),
                  Text(dataModel.address.toString(),style: const TextStyle(
                      color: Colors.grey
                  ),),
                ],
              )

            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async{

            },
            child: Container(
              height:40,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.blue,
                ),
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_calling_3_rounded,color: Colors.
                    white,size: 20,),
                  const SizedBox(width: 10,),
                  Text(local.call,style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13
                  ),),
                  const SizedBox(width: 10,),

                ],
              ),
            ),
          ),
          const SizedBox(width: 10,),
          GestureDetector(
            onTap: () async{
            },
            child: Container(
              height:40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.green.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Icon(FontAwesomeIcons.whatsapp,color: Colors.white,),
            ),
          ),

        ],
      ),
    );
  }
}