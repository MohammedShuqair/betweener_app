import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import 'main_app_view.dart';

class AddLinkScreen extends StatefulWidget {
  static String id = '/AddLinkScreen';
  const AddLinkScreen({super.key});

  @override
  State<AddLinkScreen> createState() => _AddLinkScreenState();
}

class _AddLinkScreenState extends State<AddLinkScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void add_link() {
    if (_formKey.currentState!.validate()) {
      final body = {
        'title': titleController.text,
        'link': linkController.text,
        'username': userNameController.text
      };

      addLink(body).catchError(
        (err) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(err.toString()),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
      Navigator.pushNamed(context, MainAppView.id);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text('Add Link'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: titleController,
                hint: 'snapchat',
                label: 'title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 22,
              ),
              CustomTextFormField(
                controller: userNameController,
                hint: 'user_name',
                label: 'username',
              ),
              const SizedBox(
                height: 22,
              ),
              CustomTextFormField(
                controller: linkController,
                hint: 'https://www.snapchat.com',
                label: 'link',
                autofillHints: const [AutofillHints.password],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 46,
              ),
              SecondaryButtonWidget(
                onTap: add_link,
                width: 200,
                text: 'Add Link ',
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
