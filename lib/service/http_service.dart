import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../screens/dashboard.dart';
import '../screens/sign_up_step2.dart';
import '../screens/verify_email.dart';
import '../screens/welcome_screen.dart';


class HttpService {
  static final _client = http.Client();

  static var _loginUrl = Uri.parse('http://10.0.2.2:5000//login');

  static var _verifyUrl = Uri.parse('http://10.0.2.2:5000/verify-code');
  static var _signUpStep1Url = Uri.parse('http://10.0.2.2:5000/signup-step1');
   static var _signUpStep2Url = Uri.parse('http://10.0.2.2:5000/signup-step2');
  static var _verifyDocument = Uri.parse('http://10.0.2.2:5000/verify-document');
  static var _forgetPassword = Uri.parse('http://10.0.2.2:5000/forgot-password');
  static var _resetPassword = Uri.parse('http://10.0.2.2:5000//reset-password');
  

  static signupStep1(username,email,password,retypePassword,mobileNumber, context) async {
    var map =  <String, String>{};
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    map['retype_password'] = retypePassword;
    map['mobile_number'] = mobileNumber;
    http.Response response = await _client.post(_signUpStep1Url, body: map);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      if (response.statusCode != 400) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => VerifyEmail(email: email)));
      } else {
        EasyLoading.showError(json['status']);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
  static verifyCode(email, context) async {
    var map =  <String, String>{};
    map['email'] = email;
    http.Response response = await _client.post(_verifyUrl, body: map);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      if (json['status'] == 'Verification successful. Please complete the signup process.') {
       EasyLoading.showSuccess(json['status']);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SignUpStep2Screen()));
      } else {
        EasyLoading.showError(json['status']);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  static login(email, pass, context) async {
    var map =  <String, String>{};
    map['email'] = email;
    map['password'] = pass;
    http.Response response = await _client.post(_loginUrl, body: map);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['status'] == 'Login successful. You can access the dashboard now.') {
        await EasyLoading.showError(json['status']);
      } else {
        await EasyLoading.showSuccess(json['status']);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()));
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
  static signupStep2(email,instituteName ,address,udiseCode,document, context) async {
    http.MultipartRequest request = await http.MultipartRequest('POST',_signUpStep2Url);
    request.files.add(await http.MultipartFile.fromPath('document', document));
    request.fields['email'] = email;
    request.fields['institute_name'] = instituteName;
    request.fields['address'] = address;
    request.fields['udise_code'] = udiseCode;
    var response = await request.send();
    if (response.statusCode == 200) {

      if (response.statusCode != 400) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        EasyLoading.showError(
            "Error Code : ${response.statusCode.toString()}");
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
  static verifyDocument(username, context) async {
    var map =  <String, String>{};
    map['username'] = username;

    http.Response response = await _client.post(_signUpStep2Url, body:map);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      if (response.statusCode != 400) {
        await EasyLoading.showSuccess(json['status']);
      } else {
        EasyLoading.showError(json['status']);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
  static verifyEmailCode(email,verificationCode, context) async {
    var map =  <String, String>{};
    map['email'] = email;
    map['verification_code'] = verificationCode;

    http.Response response = await _client.post(_verifyUrl, body:map);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      if (response.statusCode != 400) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SignUpStep2Screen()));

      } else {
        EasyLoading.showError(json['status']);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
  static forgotPassword(email, context) async {
    var map =  <String, String>{};
    map['email'] = email;
    http.Response response = await _client.post(_forgetPassword, body:map);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      if (response.statusCode != 400) {
        await EasyLoading.showSuccess(json['status']);
      } else {
        EasyLoading.showError(json['status']);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
  static resetPassword(email,resetToken,newPassword, context) async {
    var map =  <String, String>{};
    map['email'] = email;
    map['reset_token'] = resetToken;
    map['new_password'] = newPassword;
    http.Response response = await _client.post(_resetPassword, body:map);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      if (response.statusCode != 400) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        EasyLoading.showError(json['status']);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
  static verifyDocCode(username,verificationCode, context) async {
    var map =  <String, String>{};
    map['username'] = username;
    map['verification_code'] = verificationCode;

    http.Response response = await _client.post(_verifyUrl, body:map);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      if (response.statusCode != 400) {
        await EasyLoading.showSuccess(json['status']);

      } else {
        EasyLoading.showError(json['status']);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
}
