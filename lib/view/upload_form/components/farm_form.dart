import 'package:animal/view/upload_form/components/input_field.dart';
import 'package:animal/view_model/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class FarmForm extends StatelessWidget {
   FarmForm({super.key});
  @override
  Widget build(BuildContext context) {
    final controller=Provider.of<PostAnimalController>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15,),
        InputField(hint: 'dd/mm/yyyy', controller:controller.startDate ,title: AppLocalizations.of(context)!.start_date,
        enabled: false,
          postFix: GestureDetector(
              onTap: () => controller.pickStartDate(context: context),
              child: Icon(Icons.calendar_month,color: Colors.black26,)),
        ),
        SizedBox(height: 15,),
        InputField(hint: 'dd/mm/yyyy', controller: controller.endDate,title: AppLocalizations.of(context)!.end_date,
        enabled: false,
        postFix: GestureDetector(
          onTap: () => controller.pickEndDate(context: context),
            child: Icon(Icons.calendar_month,color: Colors.black26,)),
        ),
        SizedBox(height: 15,),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Row(
            children: [
              Expanded(child: InputField(hint: AppLocalizations.of(context)!.price_per_kg_dozen, controller: controller.farmPrice,
              title: AppLocalizations.of(context)!.price,
              )),
              SizedBox(width: 10,),
              Expanded(child: InputField(hint: AppLocalizations.of(context)!.acre, controller: controller.acre,
                title: 'Acre',
              )),
            ],
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}
