class Person {
  String? id;
  String? name;
  String? email;
  String? username;
  String? type;
  String? enabled;
  String? timing;
  String? joiningDate;
  String? department;
  String? password;
  String? lastLogin;
  String? teamId;
  String? userSimNumber;
  String? managerId;

  Person(
      {required this.id,
      required this.name,
      required this.email,
      required this.username,
      required this.type,
      required this.enabled,
      this.timing,
      required this.joiningDate,
      this.department,
      required this.password,
      required this.lastLogin,
      this.teamId,
      this.userSimNumber,
      this.managerId});

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    type = json['type'];
    enabled = json['enabled'];
    timing = json['timing'];
    joiningDate = json['joining_date'];
    department = json['department'];
    password = json['password'];
    lastLogin = json['last_login'];
    teamId = json['team_id'];
    userSimNumber = json['user_sim_number'];
    managerId = json['manager_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['type'] = this.type;
    data['enabled'] = this.enabled;
    data['timing'] = this.timing;
    data['joining_date'] = this.joiningDate;
    data['department'] = this.department;
    data['password'] = this.password;
    data['last_login'] = this.lastLogin;
    data['team_id'] = this.teamId;
    data['user_sim_number'] = this.userSimNumber;
    data['manager_id'] = this.managerId;
    return data;
  }
}
