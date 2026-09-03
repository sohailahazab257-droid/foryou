import 'package:flutter/material.dart';
import 'package:foryou/cart/cart.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar:AppBar(
                backgroundColor:Color(0xffd4edff),
                title:Row(
                    children: [
                      Container(
                          width:50,height:50,
                          decoration:BoxDecoration(shape:BoxShape.circle),
                          child: ClipOval(
                            child: Image.asset("assets/WhatsApp Image 2026-09-03 at 6.10.41 PM.jpeg",fit:BoxFit.cover,),
                          )),
                      SizedBox(width:10,),
                      Column(
                        children: [
                          Text("Welcome Back",style:TextStyle(color: Color(0xff6a6a6a),fontSize:15),),
                          Text("$Name",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize: 15),)
                        ],
                      ),
                      SizedBox(width:142,),
                      Container(
                          width:50,height:50,
                          decoration:BoxDecoration(shape:BoxShape.circle,color:Color(0xffd4edff),border:Border.all(color: Color(0xff89b9f8),width:1)),
                          child:IconButton(onPressed:(){Navigator.push(context,MaterialPageRoute(builder: (context) => Cart()));},icon:Icon(Icons.shopping_cart,color:Color(0xff89b9f8),))
                      ),
                    ]
                )),
            body: Column(
              children: [
                Container(
                  width:double.infinity,height:double.infinity,
                  decoration:BoxDecoration(image: DecorationImage(image: AssetImage("assets/WhatsApp Image 2026-09-03 at 2.01.32 PM.jpeg"),
                    repeat:ImageRepeat.repeat,
                  )),
                ),
              ],
            )
        ));
  }
}