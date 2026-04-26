import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/components/app-logo.dart';
import 'package:raki_internet_cafe/components/password-form-field.dart';
import 'package:raki_internet_cafe/components/primary-button.dart';
import 'package:raki_internet_cafe/core/routing-controls.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/providers/admin-auth-provider.dart';
import 'package:raki_internet_cafe/utils/gap.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<AdminAuthProvider>().resetProvider();
            RouteControls.pushAndRemoveUntil(
              context,
              RouteScreens.productScreen,
            );
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Admin Panel",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        backgroundColor: Colors.black,
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

    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      color: UIColors.primaryColor,
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLogo(scale: 2.5),
              vGap(16),
              Text(
                "Authorize Admin",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Only authorized admin can access the admin panel",
                style: Theme.of(context).textTheme.bodyMedium,
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
              vGap(24),
              PrimaryButton(
                label: "Authorize & Access Admin Panel",
                loadingLabel: "Authorizing...",
                onTap: () async {
                  await authorize();
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
