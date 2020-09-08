import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lotus_led_inventory/model/file_data.dart';
import 'package:lotus_led_inventory/model/shared_prefs.dart';
import 'package:lotus_led_inventory/screens/about_app/about_app.dart';
import 'package:lotus_led_inventory/screens/help_and_support/help_and_support.dart';
import 'package:lotus_led_inventory/screens/inventory/inventory.dart';
import 'package:lotus_led_inventory/screens/welcome/policies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool loading;

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                  child: DrawerHeader(
                    padding: EdgeInsets.only(left: 16.0),
                    margin: EdgeInsets.zero,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Lotus LED Inventory',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading:
                      loading ? CircularProgressIndicator() : Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    final prefs = await SharedPreferences.getInstance();
                    final jsonString = prefs.getString(SharedPrefs.FILE);

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Inventory(
                          FileData.fromJson(
                            jsonString == null ? {} : json.decode(jsonString),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HelpAndSupport(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About App'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => AboutApp(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Policies(),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
