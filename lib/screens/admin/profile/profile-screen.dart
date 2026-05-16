import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/components/password-form-field.dart';
import 'package:raki_internet_cafe/components/primary-button.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/providers/admin-profile-provider.dart';
import 'package:raki_internet_cafe/screens/admin/auth-screen.dart';
import 'package:raki_internet_cafe/utils/gap.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const _green = Color(0xFF2E7D32);
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _green,
      ),
      body: ProfileScreenBody(),
    );
  }
}

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AdminProfileProvider>();
    final formKey = context.watch<AdminProfileProvider>().formKey;
    final password = context.watch<AdminProfileProvider>().password;
    final confirmPassword = context
        .watch<AdminProfileProvider>()
        .confirmPassword;
    final isShowPassword = context.watch<AdminProfileProvider>().showPassword;
    final isLoading = context.watch<AdminProfileProvider>().isLoading;

    Future<void> update() async {
      final isUpdated = await authProvider.updatePassword();
      if (!context.mounted) return;
      if (isUpdated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password updated successfully!")),
        );
        await Future.delayed(const Duration(seconds: 4));
        authProvider.resetProvider();

        if (!context.mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AuthScreen()),
          (route) => false,
        );
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update password!")),
        );
        return;
      }
    }

    const _green = Color(0xFF2E7D32);
    const _orange = Color(0xFFF57C00);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 760;
        final maxWidth = isWide ? 700.0 : constraints.maxWidth - 32.0;

        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 20.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CircleAvatar(
                        radius: isWide ? 48 : 40,
                        backgroundColor: _green.withOpacity(0.12),
                        child: Icon(
                          Icons.person,
                          size: isWide ? 48 : 40,
                          color: _green,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        "Change password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Warning: Changing your password will force you to log you out',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      vGap(18),
                      PasswordFormField(
                        label: "New Password",
                        controller: password,
                        isShowPassword: isShowPassword,
                        isLoading: isLoading,
                        toggleShowPassword: authProvider.toggleShowPassword,
                        validator: authProvider.passwordValidator,
                      ),
                      vGap(12),
                      PasswordFormField(
                        label: "Confirm Password",
                        controller: confirmPassword,
                        isShowPassword: isShowPassword,
                        isLoading: isLoading,
                        toggleShowPassword: authProvider.toggleShowPassword,
                        validator: authProvider.confirmPasswordValidator,
                      ),
                      vGap(20),
                      PrimaryButton(
                        label: "Update Password",
                        loadingLabel: "Updating...",
                        onTap: () async {
                          await update();
                        },
                        isLoading: isLoading,
                        backgroundColor: _orange,
                        foregroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
