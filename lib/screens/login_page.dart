
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';

import '../service/http_service.dart';


enum Auth { sigin, signup , forget}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
   String username = "";
   String email = "";
   String password = "";
   String retypePassword = "";
   String mobileNumber = "";
   String resetToken = "";
   String newPassword = "";
  Auth _auth = Auth.sigin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true, 
        body: SingleChildScrollView(
          child: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
          children: [
            Container(
              height: 520,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/img.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Positioned(
                    top: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Hello Again !",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              shadows: <Shadow>[
                                const Shadow(
                                  offset: Offset(1.0, 2.0),
                                  blurRadius: 2.0,
                                  color: Colors.white,
                                ),
                              ]),
                        ).text.bold.size(32).make(),
                        Text(
                          "Welcome Back, We’ve been\n            waiting for you.",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ).text.bold.size(16).make(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_auth == Auth.signup)
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                      shape: BoxShape.rectangle),
                  child: Form(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create your Account",
                            style: GoogleFonts.lato(color: Color(0xff9163D7)),
                          ).text.size(24).bold.make().p(20),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.symmetric(horizontal: 50),
                            child: VxTextField(
                              hint: "Username",
                              onChanged: (value) {
                                setState(() {
                                  username = value;
                                });
                              },
                            ).p(20),
                          ),

                          Padding(
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 50),
                            child: VxTextField(
                              hint: "Email",
                              onChanged: (value){
                              setState(() {
                                email=value;
                              });

                              },

                            ).p(20),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.symmetric(horizontal: 50),
                            child: VxTextField(
                              hint: "Mobile no.",
                              onChanged: (value) {
                                setState(() {
                                  mobileNumber = value;
                                });
                              },
                            ).p(20),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.symmetric(horizontal: 50),
                            child: VxTextField(
                              hint: "Password",
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                            ).p(20),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.symmetric(horizontal: 50),
                            child: VxTextField(
                              hint: "Re-Type Password",
                              onChanged: (value) {
                                setState(() {
                                  retypePassword = value;
                                });
                              },
                            ).p(20),
                          ),
                          TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                )),
                                minimumSize: MaterialStateProperty.all(Size(
                                    MediaQuery.of(context).size.width - 20, 49)),
                                backgroundColor:
                                    MaterialStateProperty.all(Color(0xff9163D7))),
                            child: Text(
                              "Login",
                              style: GoogleFonts.lato(color: Colors.white),
                            ).text.make(),
                            onPressed: () async {
                              //passing the textfield values to signupStep1 api
                              await HttpService.signupStep1(
                                  username,
                                  email,
                                  password,
                                  retypePassword,
                                  mobileNumber,
                                  context);

//navigating next page for verification of email
                            },
                          ).p12(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account ? ",
                                style: GoogleFonts.lato(),
                              ).text.gray500.make(),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _auth = Auth.sigin;
                                    });
                                  },
                                  child: const Text(
                                    "LogIn",
                                    style: TextStyle(color: Color(0xff9163D7)),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            if(_auth == Auth.forget)
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24)),
                      shape: BoxShape.rectangle),
                  child: Form(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: GoogleFonts.lato(color: Color(0xff9163D7)),
                          ).text.size(24).bold.make().p(20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                hintText: '   Email',
                                fillColor: Color(0xFFE7D8F8),
                                filled: true,
                              ),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                hintText: '  Reset Token',
                                fillColor: Color(0xFFE7D8F8),
                                filled: true,
                              ),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              onChanged: (value) {
                                resetToken = value;
                              },
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                hintText: '  New Password',
                                fillColor: Color(0xFFE7D8F8),
                                filled: true,
                              ),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              onChanged: (value) {
                                newPassword = value;
                              },
                            ),
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ), backgroundColor: Color(0xff9163D7),
                              minimumSize: Size(
                                MediaQuery.of(context).size.width - 40, // Adjust the width here
                                49,
                              ),
                            ),
                            onPressed: () async {
                              await HttpService.resetPassword(email, resetToken,retypePassword, context);
                            },
                            child: Text(
                              "Login",
                              style: GoogleFonts.lato(color: Colors.white),
                            ).text.make(),
                          ).p(20), // Padding on all sides

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account ? ",
                                style: GoogleFonts.lato(),
                              ).text.gray500.make(),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _auth = Auth.signup;
                                    });
                                  },
                                  child: const Text(
                                    "SignUp",
                                    style: TextStyle(color: Color(0xff9163D7)),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            if (_auth == Auth.sigin)
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                      shape: BoxShape.rectangle),
                  child: Form(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: GoogleFonts.lato(color: Color(0xff9163D7)),
                          ).text.size(24).bold.make().p(20),

                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  color: Color(0xFFE7D8F8),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none, // Remove the outline border
                                      hintText: '   Email',
                                      contentPadding: EdgeInsets.only(left: 16)
                                  ),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                ),
                              )
                          ),

                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  color: Color(0xFFE7D8F8),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none, // Remove the outline border
                                      hintText: '   Password',
                                      contentPadding: EdgeInsets.only(left: 16)
                                  ),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                ),
                              )
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  HttpService.forgotPassword(email, context);
                                  setState(() {
                                    _auth = Auth.forget;
                                  });
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff9163D7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ), backgroundColor: Color(0xff9163D7),
                              minimumSize: Size(
                                MediaQuery.of(context).size.width - 40, // Adjust the width here
                                49,
                              ),
                            ),
                            onPressed: () async {
                              await HttpService.login(username, password, context);
                            },
                            child: Text(
                              "Login",
                              style: GoogleFonts.lato(color: Colors.white),
                            ).text.make(),
                          ).p(20), // Padding on all sides

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account ? ",
                                style: GoogleFonts.lato(),
                              ).text.gray500.make(),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _auth = Auth.signup;
                                    });
                                  },
                                  child: const Text(
                                    "SignUp",
                                    style: TextStyle(color: Color(0xff9163D7)),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

          ],
      ),
    ),
        ));
  }
}
