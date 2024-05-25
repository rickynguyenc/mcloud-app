import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ResetPasswordScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());
    final _newPassword = useState('');
    final _confirmNewPassword = useState('');

    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your new password';
                }
                return null;
              },
              onChanged: (value) => _newPassword.value = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Confirm New Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please confirm your new password';
                }
                if (value != _newPassword.value) {
                  return 'Passwords do not match';
                }
                return null;
              },
              onChanged: (value) => _confirmNewPassword.value = value,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: Implement reset password logic
                }
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
