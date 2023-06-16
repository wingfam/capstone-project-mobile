class notificationDTO {
  notificationDTO({
    required this.message ,
   });

  notificationDTO.fromJson(dynamic json) {
    message = json['message'];

  }
  // late String date;
  late String message;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;

    return map;
  }

}