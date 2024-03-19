import 'package:animal/view_model/controllers/authentication_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Provider.of<AuthenticationController>(context,listen: false);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/cabbage.png',
                    height: 250,
                    ),
                     Text('Reconnect with\nGoodness',textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      height: 0
                    ),),
                    const SizedBox(height: 300,),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                  ),
                  child: SizedBox(
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          const Text('Let\'s get started',style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),),
                          const SizedBox(height: 20,),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: controller.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    color: Colors.grey
                                  )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        color: Colors.grey
                                    )
                                ),
                                hintText: '+91-1234-567890',
                                  hintStyle: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey
                                  ),

                                  // prefixIcon: const SizedBox(
                                  //   width: 15,
                                  //   height: 45,
                                  //   child: Align(
                                  //     alignment: Alignment.centerLeft,
                                  //     child: Padding(
                                  //       padding: EdgeInsets.only(left: 20,top: 5),
                                  //       child: Text('91',style: TextStyle(
                                  //         fontWeight: FontWeight.bold
                                  //       ),),
                                  //     )),
                                  // ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          const Text('OTP will be sent on this number',style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ),),
                          const SizedBox(height: 20,),
                          GestureDetector(
                            onTap: () => controller.getOtp(context: context),
                            child: Card(
                              color: Colors.yellow,
                              child: SizedBox(
                                height: 50,
                                width: MediaQuery.sizeOf(context).width,
                                child: const Center(
                                  child: Text('Get OTP',style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),
                          const Text('By continuing, you agree our Terms & Conditions and Privacy & Legal Policy',style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey
                          ),),

                        ],
                      ),
                    ),
                  ),
                )
            ),
            Consumer<AuthenticationController>(builder: (context, value, child) {
             return value.numberLoading ? Container(
               height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                color: Colors.black26,
                child: const Center(
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      color: Colors.white70,
                    ),
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
