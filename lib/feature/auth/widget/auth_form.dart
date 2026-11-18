import 'package:flutter/material.dart';

/// Name (sign up only), email and password fields with validation and a
/// submit button.
class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.isSignUp,
    required this.onSubmitted,
  });

  final bool isSignUp;

  /// Called when the form is valid and the button is pressed.
  final VoidCallback onSubmitted;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _hidePassword = true;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmitted();
    }
  }

  String? _requiredValidator(String? value) {
    return (value == null || value.trim().isEmpty) ? 'Required' : null;
  }

  String? _emailValidator(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) return 'Required';
    if (!text.contains('@') || !text.contains('.')) return 'Enter a valid email';

    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (value.length < 6) return 'At least 6 characters';

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (widget.isSignUp) ...[
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Name',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              validator: _requiredValidator,
            ),
            const SizedBox(height: 14),
          ],
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(Icons.mail_outline_rounded),
            ),
            validator: _emailValidator,
          ),
          const SizedBox(height: 14),
          TextFormField(
            obscureText: _hidePassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _hidePassword = !_hidePassword),
                icon: Icon(
                  _hidePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
            ),
            validator: _passwordValidator,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submit,
              child: Text(widget.isSignUp ? 'Sign up' : 'Login'),
            ),
          ),
        ],
      ),
    );
  }
}
