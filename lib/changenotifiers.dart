import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';

class changes with ChangeNotifier{
   Iterable<Contact> contacts;
  getcontactupdates() async{
    contacts = await ContactsService.getContacts();
    notifyListeners();
  }

}