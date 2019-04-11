import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedPreferencesObj {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _kUsernamePrefs = "username";

    /// ----------------------------------------------------------
  /// Method that saves the username
  /// ----------------------------------------------------------
  Future<bool> setUsername(String value) async {
	final SharedPreferences prefs = await SharedPreferences.getInstance();

	return prefs.setString(_kUsernamePrefs, value);
  }

   /// ------------------------------------------------------------
  /// Method that returns the username
  /// ------------------------------------------------------------
  Future<String> getUsername() async {
	final SharedPreferences prefs = await SharedPreferences.getInstance();

	return prefs.getString(_kUsernamePrefs);
  }


}