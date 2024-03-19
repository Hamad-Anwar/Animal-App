import 'package:animal/view/home/home_page.dart';
import 'package:animal/view_model/controllers/authentication_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.verificationID, required this.phoneNumber});
  final String verificationID;
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    final controller=Provider.of<AuthenticationController>(context,listen: false);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
                    SizedBox(height: 300,),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                  ),
                  child: SizedBox(
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Text('Enter OTP',style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                          SizedBox(height: 20,),
                          SizedBox(
                            height: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: Colors.grey
                                )
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(child: OtpField(controller: controller.otp1,)),
                                  SizedBox(width: 10,),
                                  Expanded(child: OtpField(controller: controller.otp2,)),
                                  SizedBox(width: 10,),
                                  Expanded(child: OtpField(controller: controller.otp3,)),
                                  SizedBox(width: 10,),
                                  Expanded(child: OtpField(controller: controller.otp4,)),
                                  SizedBox(width: 10,),
                                  Expanded(child: OtpField(controller: controller.otp5,)),
                                  SizedBox(width: 10,),
                                  Expanded(child: OtpField(controller: controller.otp6,)),
                                ],
                              ),
                            )
                          ),
                          SizedBox(height: 10,),
                           Row(
                            children: [
                              Text('OTP has been send to',style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey
                              ),),
                              SizedBox(width: 5,),
                              Text(phoneNumber,style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          const Row(
                            children: [
                              Text('Did\'t receive otp yet',style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey
                              ),),
                              Spacer(),
                              Text('resend',style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          GestureDetector(
                            // onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),)),
                            onTap: () => controller.verifyOtp(context: context, verificationID: verificationID),
                            child: Card(
                              color: Colors.yellow,
                              child: SizedBox(
                                height: 50,
                                width: MediaQuery.sizeOf(context).width,
                                child: Center(
                                  child: Text('Continue',style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text('By continuing, you agree our Terms & Conditions and Privacy & Legal Policy',style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                          ),),

                        ],
                      ),
                    ),
                  ),
                )
            ),
            Consumer<AuthenticationController>(builder: (context, value, child) {
              return value.otpLoading ? Container(
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

class OtpField extends StatelessWidget {
  const OtpField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      maxLength: 1,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        counterText: '',
      ),
      onChanged: (value) {
        if(value.length==1){
          FocusScope.of(context).nextFocus();
        }
      },
    );
  }
}
