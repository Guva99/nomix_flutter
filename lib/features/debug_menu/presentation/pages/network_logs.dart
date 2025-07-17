
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/features/debug_menu/mad_inspector.dart';

 import '../widgets/network_log_details.dart';
import '../widgets/network_log_list_item.dart';
import '../widgets/settings_filters_content.dart';

class NetworkLogs extends StatefulWidget {
  const NetworkLogs({super.key});

  @override
  State<NetworkLogs> createState() => _NetworkLogsState();
}

class _NetworkLogsState extends State<NetworkLogs> {
  @override
  void initState() {
    super.initState();
    MadInspectorNetworkModule.updateStream().listen((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CupertinoTextField(
                  placeholder: 'Запрос', // Текст подсказки
                  onChanged: (String text) {
                    MadInspectorNetworkModule.setQuery(text);
                  },
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    MadInspectorNetworkModule.filteredNetworkResponses.clear();
                  });
                },
                icon: const Icon(
                  Icons.delete_forever,
                  color: AppColors.white,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const SettingsFiltersContent();
                      });
                },
                icon: const Icon(
                  Icons.settings,
                  color: AppColors.white,
                )),
          ],
        ),
        Flexible(
          child: ListView.separated(
            itemCount:
                MadInspectorNetworkModule.filteredNetworkResponses.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => NetworkLogDetails(
                                networkLogModel: MadInspectorNetworkModule
                                    .filteredNetworkResponses[index],
                              )));
                },
                child: NetworkLogListItem(
                  networkLogModel:
                      MadInspectorNetworkModule.filteredNetworkResponses[index],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              );
            },
          ),
        ),
      ],
    );
  }
}
