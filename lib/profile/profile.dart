import 'package:flutter/material.dart';
import 'package:foryou/home/bar.dart';
import 'package:foryou/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar:AppBar(
              backgroundColor:Color(0xffd4edff),
              title: Text("Profile",style:TextStyle(fontSize:30,fontWeight:FontWeight.bold),)),
          body:Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/WhatsApp Image 2026-09-03 at 10.39.56 PM.jpeg"),
                  repeat: ImageRepeat.repeat,
                ),
              ),
              child:Column(
                children: [
                  Container(
                    width:550,height: 210,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF89b9f8),
                          Colors.white,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          width: 80,
                          height: 80,
                          decoration:BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              "assets/WhatsApp Image 2026-09-03 at 6.10.41 PM.jpeg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          "user name",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "email",
                          style: TextStyle(
                            color: Color(0xff6a6a6a),
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height:15,),
                        Container(
                          height:35,width:100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color:Color(0xFF89b9f8)
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                SizedBox(width: 5,),
                                Icon(Icons.edit,color:Colors.white,),
                                Text("Edit Profile",style:TextStyle(color:Colors.white,fontSize:12) ,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width:400,height:45,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      boxShadow:[BoxShadow(color: Colors.black,blurRadius:0.5)],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Row(
                      children: [
                        SizedBox(width: 5,),
                        Icon(Icons.language,color:Colors.black,),
                        SizedBox(width:10,),
                        Text("Language",style:TextStyle(color: Colors.black,fontSize:20),),
                        SizedBox(width:190,),
                        Icon(Icons.arrow_forward_ios,color:Colors.black,)
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width:400,height:45,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      boxShadow:[BoxShadow(color: Colors.black,blurRadius:0.5)],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Row(
                      children: [
                        SizedBox(width: 5,),
                        Icon(Icons.notifications,color:Colors.black,),
                        SizedBox(width:10,),
                        Text("Notification",style:TextStyle(color: Colors.black,fontSize:20),),
                        SizedBox(width:170,),
                        Icon(Icons.arrow_forward_ios,color:Colors.black,)
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width:400,height:45,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      boxShadow:[BoxShadow(color: Colors.black,blurRadius:0.5)],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Row(
                      children: [
                        SizedBox(width: 5,),
                        Icon(Icons.payment,color:Colors.black,),
                        SizedBox(width:10,),
                        Text("Payment",style:TextStyle(color: Colors.black,fontSize:20),),
                        SizedBox(width:195,),
                        Icon(Icons.arrow_forward_ios,color:Colors.black,)
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width:400,height:45,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      boxShadow:[BoxShadow(color: Colors.black,blurRadius:0.5)],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Row(
                      children: [
                        SizedBox(width: 5,),
                        Icon(Icons.dark_mode,color:Colors.black,),
                        SizedBox(width:10,),
                        Text("Dark Mode",style:TextStyle(color: Colors.black,fontSize:20),),
                        SizedBox(width:175,),
                        Icon(Icons.arrow_forward_ios,color:Colors.black,)
                      ],
                    ),
                  ),
                  SizedBox(height: 25,),
                  Container(
                    width:400,height:45,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      boxShadow:[BoxShadow(color: Colors.black,blurRadius:0.5)],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Row(
                      children: [
                        SizedBox(width: 5,),
                        Icon(Icons.privacy_tip,color:Colors.black,),
                        SizedBox(width:10,),
                        Text("Privacy & Policy",style:TextStyle(color: Colors.black,fontSize:20),),
                        SizedBox(width:127,),
                        Icon(Icons.arrow_forward_ios,color:Colors.black,)
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width:400,height:45,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      boxShadow:[BoxShadow(color: Colors.black,blurRadius:0.5)],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Row(
                      children: [
                        SizedBox(width: 5,),
                        Icon(Icons.info,color:Colors.black,),
                        SizedBox(width:10,),
                        Text("About Us",style:TextStyle(color: Colors.black,fontSize:20),),
                        SizedBox(width:190,),
                        Icon(Icons.arrow_forward_ios,color:Colors.black,)
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width:400,height:45,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      boxShadow:[BoxShadow(color: Colors.black,blurRadius:0.5)],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Row(
                      children: [
                        SizedBox(width: 5,),
                        Icon(Icons.phone,color:Colors.black,),
                        SizedBox(width:10,),
                        Text("Contact Us",style:TextStyle(color: Colors.black,fontSize:20),),
                        SizedBox(width:170,),
                        Icon(Icons.arrow_forward_ios,color:Colors.black,)
                      ],
                    ),
                  ),
                  SizedBox(height: 25,),
              GestureDetector(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: Container(
                    width:400,height:45,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      boxShadow:[BoxShadow(color: Colors.black,blurRadius:0.5)],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Row(
                      children: [
                        SizedBox(width: 5,),
                        Icon(Icons.arrow_circle_left,color:Colors.red,),
                        SizedBox(width:10,),
                        Text("Logout",style:TextStyle(color: Colors.red,fontSize:20),),
                        SizedBox(width:205,),
                        Icon(Icons.arrow_forward_ios,color:Colors.black,)
                      ],
                    ),
                  ),
              ),
            ]
          ),
      ),
          bottomNavigationBar: const Bar(
            currentPage: 'profile',)),
    );
  }
}