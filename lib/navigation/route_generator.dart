import 'package:flutter/material.dart';
import 'package:socialrecipe/screen/authentication/screens/log_in_screen.dart';
import 'package:socialrecipe/utils/app_pages.dart';
import 'package:socialrecipe/screen/authentication/screens/forget_password_screen.dart';
import 'package:socialrecipe/screen/authentication/screens/sign_up_screen.dart';
import 'package:socialrecipe/screen/bookmark_recipe/screens/recipe_detail_screen.dart';
import 'package:socialrecipe/screen/chat/screens/chat_messages_screen.dart';
import 'package:socialrecipe/screen/chat/screens/contacts_list_screen.dart';
import 'package:socialrecipe/screen/comment/screens/comments_screen.dart';
import 'package:socialrecipe/screen/create_recipe_post/screens/create_recipe_post_screen.dart';
import 'package:socialrecipe/screen/home/screens/home_screen.dart';
import 'package:socialrecipe/screen/profile/screens/edit_profile_screen.dart';
import 'package:socialrecipe/screen/profile/screens/followers_screen.dart';
import 'package:socialrecipe/screen/profile/screens/following_screen.dart';
import 'package:socialrecipe/screen/profile/screens/profile_screen.dart';
import 'package:socialrecipe/screen/recipe_feed/widgets/recipe_post_detail_screen.dart';
import 'package:socialrecipe/screen/search_user/screens/search_user_screen.dart';
import 'package:socialrecipe/screen/settings/screens/settings_screen.dart';
import 'package:socialrecipe/screen/splash/screens/splash_screen.dart';
import 'package:socialrecipe/src/models/data_class_models/recipe_model.dart';
import 'package:socialrecipe/src/models/recipe_post_model.dart';
import 'package:socialrecipe/src/models/user_model.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppPages.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case AppPages.splashPath:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case AppPages.signupPath:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      case AppPages.loginPath:
        return MaterialPageRoute(
          builder: (context) => const LogInScreen(),
        );
      case AppPages.profilePath:
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(
            userId: args as String,
          ),
        );
      case AppPages.commentsPath:
        return MaterialPageRoute(
          builder: (context) => CommentsScreen(
            recipePost: args as RecipePostModel,
          ),
        );
      case AppPages.createPostRecipePath:
        return MaterialPageRoute(
          builder: (context) => const CreateRecipePostScreen(),
        );
      case AppPages.editProfilePath:
        return MaterialPageRoute(
          builder: (context) => EditProfileScreen(
            user: args as UserModel,
          ),
        );
      case AppPages.auth:
        return MaterialPageRoute(
          builder: (context) => const LogInScreen(),
        );

      case AppPages.postDetails:
        return MaterialPageRoute(
          builder: (context) => RecipePostDetailScreen(
            recipePost: args as RecipePostModel,
          ),
        );

      case AppPages.recipeDetails:
        return MaterialPageRoute(
          builder: (context) => RecipeDetailScreen(
            recipe: args as RecipeModel,
          ),
        );
      case AppPages.contactsPath:
        return MaterialPageRoute(
          builder: (context) => ContactsListScreen(),
        );
      case AppPages.chatPath:
        return MaterialPageRoute(
          builder: (context) => ChatMessagesScreen(
            user: args as UserModel,
          ),
        );
      case AppPages.settingsPath:
        return MaterialPageRoute(
          builder: (context) => SettingsScreen(),
        );
      case AppPages.searchUserPath:
        return MaterialPageRoute(
          builder: (context) => const SearchUserScreen(),
        );
      case AppPages.recipePostDetails:
        return MaterialPageRoute(
          builder: (context) => RecipePostDetailScreen(
            recipePost: args as RecipePostModel,
          ),
        );
      case AppPages.forgetPasswordPath:
        return MaterialPageRoute(
          builder: (context) => ForgetPasswordScreen(
            isForget: args as bool,
          ),
        );
      case AppPages.followersPath:
        return MaterialPageRoute(
          builder: (context) => FollowersScreen(user: args as UserModel),
        );
      case AppPages.followingPath:
        return MaterialPageRoute(
          builder: (context) => FollowingScreen(user: args as UserModel),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: ((context) => Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Error'),
            ),
            body: const Center(
              child: Text('Page not found'),
            ),
          )),
    );
  }
}
