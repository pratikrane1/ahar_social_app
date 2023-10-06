import 'package:flutter/material.dart';
import 'package:socialrecipe/screen/authentication/screens/log_in_screen.dart';
import 'package:socialrecipe/utils/theme_colors.dart';
import 'package:socialrecipe/widget/app_button.dart';


class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {

  final int splashDuration = 5;
  // AuthBloc? authBloc;

  @override
  void initState() {
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ThemeColors.whiteColor,
        leading: Icon(Icons.arrow_back_ios,color: Colors.white,),
      ),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              // padding: const EdgeInsets.only(left: 8.0),
              child: Text('Stay connected\nwith your Community',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'OpenSans-ExtraBold',
                    fontWeight: FontWeight.w700),),
            ),
            Image.asset('assets/community.png',fit: BoxFit.cover,),
            // SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 30.0,right: 30.0),
              child: AppButton(
                onPressed: () async {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                      LogInScreen()));
                },
                height: 60,
                width: MediaQuery.of(context).size.width,
                text: const Text('Login',style: TextStyle(
                    color: ThemeColors.buttonColor,
                    fontSize: 18,fontFamily: 'OpenSans-ExtraBold',
                    fontWeight: FontWeight.w700) ,),
                loading: true,
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: ThemeColors.buttonColor, width: 1),
                 backgroundColor: Colors.white,
                 // color:Colors.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(50))),
                ),


              ),
            ),
          ],
        ));
    
  }
}
