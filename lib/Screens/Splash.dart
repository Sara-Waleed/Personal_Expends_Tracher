import 'package:flutter/material.dart';

import 'PersonalExpense.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: Image.asset("assets/images/no_transaction.gif",fit: BoxFit.fill,)),
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             SizedBox(height: 400,),
             GestureDetector(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalExpense(),));
               },
               child: Center(
                 child: Container(
                   height: 50,
                   width: 100,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                     color:Theme.of(context).primaryColor,
                   ),

                   child: Center(child: Text("Let's Go")),
                 ),
               ),
             ),

           ],
         ),
        ],
      ),
    );
  }
}
