// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class Relationship {
 final String state;
 final int bidAmount;
 final int clientId;

  Relationship({
   required this.state,
   required this.bidAmount,
   required this.clientId
  });
  static Relationship fromJson(dynamic json) {
      return Relationship(
         state : json["state"],
          bidAmount: json.containsKey("bid")
              ? json["bid"]!= null ? json["bid"]["bidAmount"].toInt(): 0:0,
          clientId: json.containsKey("bid")
              ? json["bid"] != null? json["bid"]["clientId"]
              : -10:-10);
    }
}