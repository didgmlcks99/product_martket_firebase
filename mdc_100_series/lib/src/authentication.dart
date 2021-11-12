import 'package:flutter/material.dart';
import 'package:shrine/src/widgets.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class Authentication extends StatelessWidget {
  const Authentication({
    required this.loginState,
    this.email,
    required this.startLoginFlow,
    required this.signInAnonymously,
    required this.signWithGoogle,
    required this.signOut,
  });

  final ApplicationLoginState loginState;
  final String? email;
  final void Function() startLoginFlow;
  final void Function(
      void Function(Exception e) error
      ) signInAnonymously;
  final void Function(
      void Function(Exception e) error
      ) signWithGoogle;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          child: const Text('Google'),
          style: ElevatedButton.styleFrom(
            primary : Colors.red,
          ),
          onPressed: () async {
            startLoginFlow();
            signWithGoogle(
                    (e) => _showErrorDialog(context, 'Failed to sign in', e)
            );
          },
        ),
        const SizedBox(height: 12.0),
        ElevatedButton(
          child: const Text('Guest'),
          style: ElevatedButton.styleFrom(
            primary : Colors.grey,
          ),
          onPressed: () async {
            startLoginFlow();
            signInAnonymously(
                    (e) => _showErrorDialog(context, 'Failed to sign in', e)
            );
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: const Text('logout'),
          style: ElevatedButton.styleFrom(
            primary : Colors.pink,
          ),
          onPressed: () async {
            signOut();
          },
        ),
      ],
    );
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            StyledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }
}