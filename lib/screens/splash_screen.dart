import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_up/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    // TODO: implement initState
    goAhead();
    super.initState();
  }
  void goAhead() async {
    List<ConnectivityResult> result = [];
    try{
      result = await _connectivity.checkConnectivity();
      if(result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi)){
        Future.delayed(const Duration(milliseconds: 1200),() {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> HomeScreen()), (route) => false);
        });
      }else{
        internetPop();
      }
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Image.asset('assets/images/splashbg1.jpg',),
         Text('MOVIES UP',style: GoogleFonts.bungee(fontSize: size.height * 0.05,color: Colors.black),)
       ],
      ),
    );
  }

  void internetPop() {
     ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No internet connection'),
      ),
    );
     Future.delayed(const Duration(seconds: 10),() =>goAhead());
  }
}
