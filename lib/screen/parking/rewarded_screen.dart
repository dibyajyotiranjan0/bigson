import 'package:bigsangrup/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RewarderdScreen extends StatefulWidget {
  const RewarderdScreen({super.key});

  @override
  State<RewarderdScreen> createState() => _RewarderdScreenState();
}

class _RewarderdScreenState extends State<RewarderdScreen>  with SingleTickerProviderStateMixin{
   late AnimationController _controller;
  late Animation<double> _iconSizeAnimation;

  @override
  void initState() {
    super.initState();
    
   _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Animation duration
    );

    _iconSizeAnimation = Tween<double>(begin: 100, end: 180).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
     _controller.forward(); 
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(radius: 100,backgroundColor: Colo.greycolorCode, 
              child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Icon(
                Icons.check,
                color: Colors.green,
                size: _iconSizeAnimation.value, // Animated size
              );
            },
          ),),
              SizedBox(height: 15,),
              Text("Your Parking Space Create Successfully",textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge,),
              SizedBox(height: 20,),
              ElevatedButton(
                                  onPressed: (){
                                    context.go("/home/parking",extra: {"id":"0"});
                                  },
                                  style: ElevatedButton.styleFrom(
                                    // padding: EdgeInsets.only(left: 4,right: 4),
                                    backgroundColor: Colo.primaryColor,
                                    foregroundColor: Colo.white,
                                    iconColor: Colo.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                    )
                                  ),
                                  child: Text("Go Parking"),
                                  // icon: Icon(Icons.local_parking),
                                  ),
                                  SizedBox(height: 10,),
                                  TextButton(
                                  onPressed: (){
                                    context.go("/home",extra: {"id":"0"});
                                  },
                                  style: TextButton.styleFrom(
                                    // padding: EdgeInsets.only(left: 4,right: 4),
                                    // backgroundColor: Colo.primaryColor,
                                    foregroundColor: Colo.black,
                                    iconColor: Colo.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                    )
                                  ),
                                  child: Text("Go Home",style: Theme.of(context).textTheme.bodyLarge,),
                                  // icon: Icon(Icons.local_parking),
                                  )
            ],
          ),
        )
      ),
    );
  }
}