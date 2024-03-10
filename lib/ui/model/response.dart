// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';


class ResponseBody {
  bool status;
  String? codeError;
  dynamic body;
  String? errorMsg;
  String? successMsg;

  ResponseBody({
    required this.status,
    required this.body,
    this.errorMsg,
    this.codeError,
    this.successMsg
  });

  factory ResponseBody.fromJson(String str) => ResponseBody.fromMap(json.decode(str));

  String toJson() => json.encode(
    {
      "status": status,
      "body": body,
      "errorMsg": errorMsg,
      "codeError": codeError,
      "successMsg": successMsg
    }
  );

  factory ResponseBody.fromMap(Map<String, dynamic> json) => ResponseBody(
      status: json["status"],
      body: json["body"],
      errorMsg: json["errorMsg"],
      codeError: json["codeError"],
      successMsg: json['successMsg']
  );

  Map<String, dynamic> toMap() => {
      "status": status,
      "body": body,
      "errorMsg": errorMsg,
      "codeError": codeError,
      "successMsg": successMsg
      };
}
