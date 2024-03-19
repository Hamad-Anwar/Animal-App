import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../view_model/controllers/post_controller.dart';
import 'input_field.dart';

class AnimalForm extends StatelessWidget {
  const AnimalForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PostAnimalController>(context,listen: false);
    var local=AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15,),
        InputField(
          title: local.age,
          controller: controller.age,
          type: TextInputType.number,
          hint: local.age_of_animal,
        ),
        const SizedBox(height: 15,),
        SizedBox(
          width: MediaQuery
              .sizeOf(context)
              .width,
          child: Row(
            children: [
              Expanded(
                child: InputField(
                  type: TextInputType.number,
                  title: local.price,
                  controller: controller.price,
                  hint: local.price,
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: InputField(
                  type: TextInputType.number,
                  title: local.milk,
                  controller: controller.milk,
                  hint: local.milk_in_kg,
                ),
              ),

            ],
          ),
        ),
        const SizedBox(height: 15,),
        InputField(
          title: local.child_produced,
          controller: controller.noOfChildProduced,
          type: TextInputType.number,
          hint: local.no_of_times_child_produced,
        ),
        const SizedBox(height: 15,),
        InputField(
          title: local.address,
          controller: controller.address,
          hint: local.enter_location,
        ),
        const SizedBox(height: 15,),
        InputField(
          title: local.description,
          controller: controller.description,
          hint: local.other_details_of_animal,
        ),
        const SizedBox(height: 15,),
      ],
    );
  }
}
