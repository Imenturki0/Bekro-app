import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final nameController = TextEditingController();
//final SubjectController= TextEditingController();
final emailController = TextEditingController();
final messageController = TextEditingController();

class contact_form extends StatelessWidget {
  late String nameSurname;
  late String mail;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  Future sendEmail(String name, String email, String message) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_dqz0454';
    const templateId = 'template_vqmpuqo';
    const userId = 'MrzcivEWWjw-H6hYR';
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json'
        }, //This line makes sure it works for all platforms.
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_message': message
          }
        }));
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.0, top: 30.0),
              child: Text('Talk to us :)',
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF660935),
                      fontWeight: FontWeight.w600)),
            ),
          ),
          //
          TextFormField(
            controller: nameController,
            decoration: kTextFieldDecoration.copyWith(hintText: 'NAME SURNAME'),
            //keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: emailController,
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'MAIL',
            ),
            //keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            maxLines: 5,
            controller: messageController,
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'Writing part...',
            ),
            //keyboardType: TextInputType.emailAddress,
          ),
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final response = await sendEmail(nameController.value.text,
                      emailController.value.text, messageController.value.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    response == 200
                        ? const SnackBar(
                            content: Text('Message Sent!'),
                            backgroundColor: Colors.green)
                        : const SnackBar(
                            content: Text('Failed to send message!'),
                            backgroundColor: Colors.red),
                  );
                  nameController.clear();
                  emailController.clear();
                  messageController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  backgroundColor: mainAppColor),
              child: const Text('send to us')),
        ],
      ),
    );
  }
}
