
import 'dart:convert';

import 'package:flutter/material.dart';



import 'package:flutter/material.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/features/debug_menu/entity/log_model.dart';
import 'package:nomix/features/debug_menu/entity/network_log_model.dart';
import 'package:nomix/features/debug_menu/presentation/widgets/log_item_card.dart';
import 'package:nomix/features/debug_menu/presentation/widgets/request_log_details.dart';
import 'package:nomix/features/debug_menu/presentation/widgets/response_log_details.dart';

class ResponseLogDetails extends StatelessWidget {

  const ResponseLogDetails({super.key, 
    required this.networkLogModel
  });

  final NetworkLogEntity networkLogModel;

  String prettyPrintJson(dynamic jsonString) {
    try {
      return _printJson(
          jsonDecode(
              _convertToJsonStringQuotes(raw: jsonString as String)
          )
      );
    } catch(_) {
      return jsonString as String;
    }
  }

  String _convertToJsonStringQuotes({required String raw}) {
    String jsonString = raw;

    /// add quotes to json string
    jsonString = jsonString.replaceAll('{', '{"');
    jsonString = jsonString.replaceAll(': ', '": "');
    jsonString = jsonString.replaceAll(', ', '", "');
    jsonString = jsonString.replaceAll('}', '"}');

    /// remove quotes on object json string
    jsonString = jsonString.replaceAll('"{"', '{"');
    jsonString = jsonString.replaceAll('"}"', '"}');

    /// remove quotes on array json string
    jsonString = jsonString.replaceAll('"[{', '[{');
    jsonString = jsonString.replaceAll('}]"', '}]');

    return jsonString;
  }

  String _printJson(dynamic jsonObject, {int indent = 0}) {
    String prettyString = '';
    if (jsonObject is Map) {
      prettyString += "{\n";
      int index = 0;
      jsonObject.forEach((dynamic key, dynamic value) {
        if (value is String) {
          prettyString += "${" " * (indent + 2)}\"$key\": \"$value\"";
        } else {
          prettyString +=
          "${" " * (indent + 2)}\"$key\": ${_printJson(value, indent: indent + 2)}";
        }
        if (index < jsonObject.length - 1) {
          prettyString += ",\n";
        } else {
          prettyString += "\n";
        }
        index++;
      });
      prettyString += "${" " * indent}}";
    } else if (jsonObject is List) {
      prettyString += "[\n";
      for (var i = 0; i < jsonObject.length; i++) {
        prettyString +=
        "${" " * (indent + 2)}${_printJson(jsonObject[i], indent: indent + 2)}";
        if (i < jsonObject.length - 1) {
          prettyString += ",\n";
        } else {
          prettyString += "\n";
        }
      }
      prettyString += "${" " * indent}]";
    } else {
      prettyString += jsonObject.toString();
    }
    return prettyString;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          LogItemCard(
            title: 'Result',
            details: '${networkLogModel.statusCode}',
          ),
          LogItemCard(
            title: 'Headers',
            details: '${networkLogModel.responseHeaders}',
          ),
          LogItemCard(
            title: 'Body',
            details: prettyPrintJson(networkLogModel.responseBody),
          )
        ],
      ),
    );
  }
}