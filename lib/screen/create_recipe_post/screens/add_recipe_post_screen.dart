import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:socialrecipe/utils/app_pages.dart';
import 'package:socialrecipe/utils/constants.dart';
import 'package:socialrecipe/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class AddRecipePostScreen extends StatelessWidget {
  const AddRecipePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 22.0).copyWith(bottom: 94),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              child: Lottie.asset("assets/anim/recipe.json"),
            ),
            Text(
              'Create your food recipe',
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(height: 1.1),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                color: settingsProvider.darkMode ? Colors.white : kOrangeColor,
                elevation: 4,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppPages.createPostRecipePath);
                  },
                  child: Ink(
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add Your Recipe',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: settingsProvider.darkMode
                                        ? kOrangeColor
                                        : Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
