import 'package:animal/view/upload_form/components/input_field.dart';
import 'package:animal/view_model/controllers/user_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<UserDetailsController>(context, listen: false).getCurrentLocation();
    Provider.of<UserDetailsController>(context, listen: false).getPostalCode();

  }
  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<UserDetailsController>(context, listen: false);
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  child: Container(
                    height: 420,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Personal Details',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InputField(
                            hint: 'Your Name',
                            controller: controller.name,
                            title: 'Name',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InputField(
                            hint: 'abc@gmail.com',
                            controller: controller.email,
                            title: 'Email',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  hint: 'Your Age',
                                  controller: controller.age,
                                  type: TextInputType.number,
                                  title: 'Age',
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: InputField(
                                hint: 'Postal Code',
                                controller: controller.postalCode,
                                title: 'Location',
                                enabled: false,
                                type: TextInputType.number,
                                postFix: GestureDetector(
                                    onTap: () => controller.getPostalCode(),
                                    child: const Icon(
                                      Icons.location_on_rounded,
                                      color: Colors.green,
                                    )),
                              )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () => controller.saveUser(context: context),
                            child: Card(
                              color: Colors.yellow,
                              child: SizedBox(
                                height: 50,
                                width: MediaQuery.sizeOf(context).width,
                                child: const Center(
                                  child: Text(
                                    'Continue',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Consumer<UserDetailsController>(builder: (context, value, child) {
              return value.loading ? Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                color: Colors.black26,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(value.loadingMsg,style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),)
                    ],
                  ),
                ),
              ) : SizedBox.shrink();
            },)
          ],
        ),
      ),
    );
  }
}
