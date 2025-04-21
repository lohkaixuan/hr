/// 📌 User Model
class User {
  final int id;
  final String name;
  final String email;
  final String? date_joined;
  final String gender;
  final String role;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.date_joined,
    required this.gender,
    required this.role,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['id'].toString()) ,
      name: json['name'],
      email: json['email'],
      date_joined: json['date_joined'] ?? '',
      gender: json['gender'],
      role: json['role'],
      phone: json['phone'],
    );
  }
}

/// 📌 Login Response Model
class LoginResponse {
  final String status;
  final String message;
  final String token;
  final User user;

  LoginResponse({
    required this.status,
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'] ,
      token: json['data']['token'],
      user: User.fromJson(json['data']['user'] ),
    );
  }
}

// /// 📌 Register Response Model
// class RegisterResponse {
//   final String status;
//   final String message;

//   RegisterResponse({
//     required this.status,
//     required this.message,
//   });

//   factory RegisterResponse.fromJson(Map<String, dynamic> json) {
//     return RegisterResponse(
//       status: json['status'] ?? 'error',
//       message: json['message'] ?? '',
//     );
//   }
// }
//


// 📌 Event Model
// class Event {
//   final int id;
//   final String event_name;
//   final String date;
//   final String location;
//   final String time;
//   final String applyBy;
//   final String status;

//   Event({
//     required this.id,
//     required this.event_name,
//     required this.date,
//     required this.location,
//     required this.time,
//     required this.applyBy,
//     required this.status
//   });

//   factory Event.fromJson(Map<String, dynamic> json) {
//     return Event(
//       // id: int.parse(json['event_id'].toString()),
//       id: int.parse(json['event_id'].toString()) ,
//       event_name: json['event_name'],
//       date: json['date'],
//       time: json['time'],
//       location: json['location'],
//       applyBy: json['apply_by'],
//       status: json['status'],
//     );
//   }
// }

// class Events {
//   final int id;  // Event ID should be an integer
//   final String event_name;
//   final String start_date;
//   final String location;
//   final String end_date;
//   final String applyBy;
//   final String status;

//   Events({
//     required this.id,
//     required this.event_name,
//     required this.start_date,
//     required this.end_date,
//     required this.location,
//     required this.applyBy,
//     required this.status
//   });

//   factory Events.fromJson(Map<String, dynamic> json) {
//     return Events(
//       // id: int.parse(json['event_id'].toString()), 
//       id: int.parse(json['event_id'].toString()) ,
//       event_name: json['event_name'],
//       location: json['location'],
//       start_date: json['start_date'],
//       end_date: json['end_date'],
//       applyBy: json['apply_by'],
//       status: json['status'],
//     );
//   }
// }

// /// 📌 Login Response Model
// class EventResponse {
//   final List<Event> eventList;

//   EventResponse({
//     required this.eventList,
//   });

//   factory EventResponse.fromJson(Map<String, dynamic> json) {
//     return EventResponse(
//       eventList: List<Event>.from(
//       json['data'].map((x) => Event.fromJson(x))
//     ),
//     );
//   }
// }

// class EventsResponse {
//   final List<Events> eventsList;

//   EventsResponse({
//     required this.eventsList,
//   });

//   factory EventsResponse.fromJson(Map<String, dynamic> json) {
//     return EventsResponse(
//       eventsList: List<Events>.from(
//       json['data'].map((x) => Events.fromJson(x))
//     ),
//     ); 
//   }
// }
//
class Event {
  final int id;
  final String event_name;
  final String date;
  final String location;
  final String time;
  final String applyBy;
  final String status;

  Event({
    required this.id,
    required this.event_name,
    required this.date,
    required this.location,
    required this.time,
    required this.applyBy,
    required this.status,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['event_id'],
      event_name: json['event_name'],
      date: json['date'],
      location: json['location'],
      time: json['time'],
      applyBy: json['apply_by'],
      status: json['status'],
    );
  }
}

class Events {
  final int id;
  final String event_name;
  final String start_date;
  final String location;
  final String end_date;
  final String applyBy;
  final String status;

  Events({
    required this.id,
    required this.event_name,
    required this.start_date,
    required this.location,
    required this.end_date,
    required this.applyBy,
    required this.status,
  });

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      id: json['event_id'],
      event_name: json['event_name'],
      location: json['location'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      applyBy: json['apply_by'],
      status: json['status'],
    );
  }
}

class EventResponse {
  final String status;
  final String message;
  final List<Event> eventList;

  EventResponse({
    required this.status,
    required this.message,
    required this.eventList,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      status: json['status'],
      message: json['message'],
      eventList: List<Event>.from(json['data'].map((x) => Event.fromJson(x))),
    );
  }
}

class EventsResponse {
  final String status;
  final String message;
  final List<Events> eventList;

  EventsResponse({
    required this.status,
    required this.message,
    required this.eventList,
  });

  factory EventsResponse.fromJson(Map<String, dynamic> json) {
    return EventsResponse(
      status: json['status'],
      message: json['message'],
      eventList: List<Events>.from(json['data'].map((x) => Events.fromJson(x))),
    );
  }
}
//
