import 'package:flutter/material.dart';

import '../../colorpalettes/palette.dart';
import '../../widgets/textfield.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        centerTitle: true,
        title: GestureDetector(
          onTap: () {},
          child: const Text(
            'Forget Password',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            //color: Colors.red,
            child: buildTextField(Icons.email, "Tutor Name", false, false,
                password, TextInputType.name),
          ),
          Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffFE876C),
                  Color(0xffFD5D37),
                ],
              ),
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
            child: FlatButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
              child: Text(
                'Verify Email',
                style: whiteTextStyle.copyWith(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
