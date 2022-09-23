import 'package:chato/core/utils/color_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
          title: Text('contacts',
      style: TextStyle(
        fontSize: 18.sp,
      ),
      ).tr()),
      body: _body());

  Widget _body() {
    if (_permissionDenied) {
      return  Center
      (child: Text('Permission denied'.tr(),
        style: TextStyle(fontSize: 16.sp,

    ),
    ));
    }
    if (_contacts == null) {
      return
      // ignore: prefer_const_constructors
      Center(child: const CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: _contacts!.length,
        itemBuilder: (context, i) => ListTile(
            title: Text(_contacts![i].displayName),
            onTap: () async {
              Contact? fullContact =
              await FlutterContacts.getContact(_contacts![i].id);
              Navigator.pop(context,fullContact);


            }));
  }
}
