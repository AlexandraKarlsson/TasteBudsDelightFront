import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/widgets/styles.dart';

import '../data/setting_data.dart';

class SettingsPage extends StatefulWidget {
  static const String PATH = '/settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _backendAddressController;
  TextEditingController _backendPortController;
  TextEditingController _imageAddressController;
  TextEditingController _imagePortController;
  bool _isInitialized = false;
  SettingData _settingData;

  @override
  void initState() {
    super.initState();
    _backendAddressController = TextEditingController();
    _backendPortController = TextEditingController();
    _imageAddressController = TextEditingController();
    _imagePortController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _isInitialized = true;
      _settingData = Provider.of<SettingData>(context);
      _backendAddressController.text = _settingData.backendAddress;
      _backendPortController.text = _settingData.backendPort;
      _imageAddressController.text = _settingData.imageAddress;
      _imagePortController.text = _settingData.imagePort;
    }
  }

  void dispose() {
    _backendAddressController.dispose();
    _backendPortController.dispose();
    _imageAddressController.dispose();
    _imagePortController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: Text('Inställningar')),
      body: Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Kommunikation', style: optionStyle),
                ),
                TextField(
                  controller: _backendAddressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Server adress',
                  ),
                  onChanged: (address) {
                    _settingData.backendAddress = address;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _backendPortController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Server port',
                  ),
                  onChanged: (port) {
                    _settingData.backendPort = port;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _imageAddressController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Bild server adress',
                        ),
                        onChanged: (server) {
                          _settingData.imageAddress = server;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _imagePortController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Bild server port',
                        ),
                        onChanged: (port) {
                          _settingData.imagePort = port;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    );
  }
}