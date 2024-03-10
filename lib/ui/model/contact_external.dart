// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';



class ContactExternal {
  String phone;
  String displayName;
  ContactExternal({
    required this.phone,
    required this.displayName,

  });

  factory ContactExternal.fromJson(String str) => ContactExternal.fromMap(json.decode(str));

  factory ContactExternal.fromMap(Map<String, dynamic> json) => ContactExternal(
      displayName: json["displayName"],
      phone: json["phone"],
  );


}
