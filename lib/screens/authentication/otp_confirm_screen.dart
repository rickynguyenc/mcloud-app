import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class OTPConfirmScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());
    final _otp = useState('');

    return Scaffold(
      appBar: AppBar(title: Text('OTP Confirmation')),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'OTP'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the OTP';
                }
                return null;
              },
              onChanged: (value) => _otp.value = value,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: Implement OTP confirmation logic
                }
              },
              child: Text('Confirm OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
