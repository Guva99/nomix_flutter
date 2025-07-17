import 'package:flutter/material.dart';

import '../../mad_inspector.dart';

class SettingsFiltersContent extends StatefulWidget {
  const SettingsFiltersContent({super.key});

  @override
  State<SettingsFiltersContent> createState() => _SettingsFiltersContentState();
}

class _SettingsFiltersContentState extends State<SettingsFiltersContent> {
  String getStatusCodeNameByEnum(StatusFilterEnum value) {
    String result = '';
    switch (value) {
      case StatusFilterEnum.informational:
        {
          result = 'Informational responses (100 – 199)';
        }
      case StatusFilterEnum.successful:
        {
          result = 'Successful responses (200 – 299)';
        }
      case StatusFilterEnum.redirection:
        {
          result = 'Redirection messages (300 – 399)';
        }
      case StatusFilterEnum.clientError:
        {
          result = 'Client error responses (400 – 499)';
        }
      case StatusFilterEnum.serverError:
        {
          result = 'Server error responses (500 – 599)';
        }

    }
    return result;
  }

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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Material(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Статусы:', style: const TextStyle(fontSize: 24)),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  ...List<Widget>.generate(StatusFilterEnum.values.length, (int index) {
                    final bool selected = MadInspectorNetworkModule.statusFilterMap.contains(
                      StatusFilterEnum.values[index],
                    );
                    return Theme(
                      data: ThemeData(useMaterial3: true),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            selected
                                ? MadInspectorNetworkModule.removeStatusFromFilter(StatusFilterEnum.values[index])
                                : MadInspectorNetworkModule.addStatusToFilter(StatusFilterEnum.values[index]);
                          },
                          child: ChoiceChip(
                            label: Text(getStatusCodeNameByEnum(StatusFilterEnum.values[index])),
                            selected: selected,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Запросы', style: const TextStyle(fontSize: 24)),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  ...List<Widget>.generate(MethodEnum.values.length, (int index) {
                    final bool selected = MadInspectorNetworkModule.methodFilterMap.contains(MethodEnum.values[index]);
                    return Theme(
                      data: ThemeData(useMaterial3: true),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            selected
                                ? MadInspectorNetworkModule.removeMethodFromFilter(MethodEnum.values[index])
                                : MadInspectorNetworkModule.addMethodToFilter(MethodEnum.values[index]);
                          },
                          child: ChoiceChip(label: Text(MethodEnum.values[index].name), selected: selected),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  // backgroundColor: context.themeC.grey400,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Закрыть'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
