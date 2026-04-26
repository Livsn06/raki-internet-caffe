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
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
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

    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Icon(Icons.person, size: 100),
              const Text(
                "Change password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              Text(
                'Warning: Changing your password will force you to log you out',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              vGap(16),
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
              vGap(16),
              PrimaryButton(
                label: "Update Password",
                loadingLabel: "Loading...",
                onTap: () async {
                  await update();
                },
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
