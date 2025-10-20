import 'package:get_it/get_it.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:vacuum_bunnies/data/services/api/api_client.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final api = GetIt.instance<ApiClient>();

  final _emailKey = const TextFieldKey('email');
  final _passwordKey = const TextFieldKey('password');

  String _message = "";
  bool _waiting = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      onSubmit: (context, values) async {
        String? email = _emailKey[values];
        String? password = _passwordKey[values];
        setState(() {
          _waiting = true;
        });
        final response = await api.login(email!, password!);
        if (response.user != null) {
          setState(() {
            _message = "Logged in as ${response.user?.email}";
          });
        } else {
          setState(() {
            _message = "Invalid credentials";
          });
        }
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FormField(
              key: _emailKey,
              label: const Text('Email'),
              hint: const Text('Enter your email'),
              validator: const LengthValidator(min: 4),
              child: const TextField(

              ),

            ),
            const SizedBox(height: 16),
            FormField(
              key: _passwordKey,
              label: const Text('Password'),
              validator: const LengthValidator(min: 8),
              child: const TextField(
                obscureText: true,
              ),
            ),
            const SizedBox(height: 16),
            Text(_message),
            FormErrorBuilder(
              builder: (context, errors, child) {
                return PrimaryButton(
                  onPressed: errors.isEmpty ? () => context.submitForm() : null,
                  child: const Text('Login'),
                );
              },
            )
          ],
        ),
      ),

    );
  }
}
