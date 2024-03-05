
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key, required this.hint, required this.controller,  this.title, this.type, this.postFix});
  final TextInputType? type;
  final String? title;
  final String hint;
  final TextEditingController controller;
  final Widget? postFix;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       if(title!=null) Text(title!, style: const TextStyle(
            fontWeight: FontWeight.bold
        ),),
        if(title!=null)  const SizedBox(height: 10,),
        SizedBox(
          height: 45,
          child: Container(
            padding: const EdgeInsets.only(left: 15,),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Colors.black26
                )
            ),
            child: TextFormField(
              cursorColor: Colors.blue,
              keyboardType: type,
              controller: controller,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(

                contentPadding: const EdgeInsets.only(bottom: 10),
                hintText: hint,
                suffixIcon: postFix,
                hintStyle: const TextStyle(
                  fontSize: 12,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        )
      ],
    );
  }
}
