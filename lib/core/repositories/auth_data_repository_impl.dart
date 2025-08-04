import 'dart:async';
import 'dart:convert';

import 'package:nomix/core/database/constants_hive_box.dart';
import 'package:nomix/core/database/hive_key_constants.dart';
import 'package:nomix/core/repositories/auth_data_repository.dart';
import 'package:nomix/core/utils/get_it_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart' show prefs;

class AuthDataRepositoryImpl with HiveKeyConstants implements AuthDataRepository {
  @override
  Future<void> deleteTokenAccess() async {
    GetItUtils.hive.deleteByKey<String>(boxName: HiveBoxConstants.stringBox, key: accessToken);
  }

  @override
  Future<String?> getTokenAccess() async {
    final String? jsonString = await GetItUtils.hive.getString(key: accessToken) ?? '';
    GetItUtils.logger.w('getTokenAccess:$jsonString ');
    if (jsonString == null || jsonString == '') return null;

    return jsonString;
  }

  @override
  void saveTokenAccess(String token) {
    GetItUtils.hive.saveString(key: accessToken, value: token);
  }
}
