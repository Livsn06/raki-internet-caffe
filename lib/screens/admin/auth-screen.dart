import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/components/app-logo.dart';
import 'package:raki_internet_cafe/components/password-form-field.dart';
import 'package:raki_internet_cafe/components/primary-button.dart';
import 'package:raki_internet_cafe/core/routing-controls.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/providers/admin-auth-provider.dart';
import 'package:raki_internet_cafe/screens/layout/product-screen.dart';
import 'package:raki_internet_cafe/utils/gap.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const _green = Color(0xFF2E7D32);
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<AdminAuthProvider>().resetProvider();
            RouteControls.pushAndRemoveUntil(context, ProductScreen());
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Admin Panel",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _green,
      ),

      body: const AuthScreenBody(),
    );
  }
}

class AuthScreenBody extends StatelessWidget {
  const AuthScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AdminAuthProvider>();
    final formKey = context.watch<AdminAuthProvider>().formKey;
    final password = context.watch<AdminAuthProvider>().password;
    final isShowPassword = context.watch<AdminAuthProvider>().showPassword;
    final isLoading = context.watch<AdminAuthProvider>().isLoading;

    Future<void> authorize() async {
      final isAuthorized = await authProvider.authorize();
      if (isAuthorized) {
        authProvider.resetProvider();
        if (!context.mounted) return;
        RouteControls.pushAndRemoveUntil(
          context,
          RouteScreens.adminPanelScreen,
        );
        return;
      } else {
        if (!context.mounted) return;
        authProvider.clearPassword();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Authorization failed. Incorrect password"),
          ),
        );
      }
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 20.0,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: const Color(0xFF2E7D32),
                      child: AppLogo(scale: 1.5),
                    ),
                    vGap(16),
                    Text(
                      "Authorize Admin",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Only authorized admin can access the admin panel",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    vGap(16),
                    PasswordFormField(
                      label: "Password",
                      controller: password,
                      isLoading: isLoading,
                      isShowPassword: isShowPassword,
                      toggleShowPassword: authProvider.toggleShowPassword,
                      validator: authProvider.passwordValidator,
                    ),
                    vGap(20),
                    PrimaryButton(
                      label: "Authorize & Access Admin Panel",
                      loadingLabel: "Authorizing...",
                      onTap: () async {
                        await authorize();
                      },
                      isLoading: isLoading,
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        authProvider.resetProvider();
                        RouteControls.pushAndRemoveUntil(
                          context,
                          ProductScreen(),
                        );
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFFF57C00),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
