import 'package:get_it/get_it.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:vacuum_bunnies/data/services/api/api_client.dart';
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final api = GetIt.instance<ApiClient>();

  final _emailKey = const TextFieldKey('email');
  final _passwordKey = const TextFieldKey('password');
  final _confirmPasswordKey = const TextFieldKey('confirmPassword');

  String _message = "";
  bool _waiting = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      onSubmit: (context, values) async {
        String? email = _emailKey[values];
        String? password = _passwordKey[values];
        String? confirmPassword = _confirmPasswordKey[values];
        setState(() {
          _waiting = true;
        });
        if (password == confirmPassword) {
          final response = await api.signUp(email!, password!);
          if (response.user != null) {
            setState(() {
              _message = "Registered and logged in as ${response.user?.email}";
            });
            }
            else {
              setState(() {
                _message = "Invalid credentials";
              });
            }
          }
          else {
            setState(() {
              _message = "Passwords don't match";
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
                child: const TextField(),
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
              FormField(
                key: _confirmPasswordKey,
                label: const Text('Confirm Password'),
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
                    child: _waiting ? SizedBox(width: 30, child: CircularProgressIndicator(backgroundColor: Theme.of(context).colorScheme.secondary,)) : const Text('Register'),
                  );
                },
              )
            ],
          ),
        ),
    );
  }
}
