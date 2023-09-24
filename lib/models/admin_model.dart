class AdminModel{

  String? id;
  String? name;
  String? email;
  String? phone;
  String? departmentId;
  String? universityId;
  bool? isAvailable;
  bool? postGraduate;
  bool? underGraduate;
  bool? showInDepartment;

  AdminModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.departmentId,
    this.universityId,
    this.isAvailable,
    this.postGraduate,
    this.underGraduate,
    this.showInDepartment,
  });

  AdminModel.fromJson(Map<String, dynamic>? json){
    id = json!['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    departmentId = json['departmentId'];
    universityId = json['universityId'];
    isAvailable = json['isAvailable'];
    postGraduate = json['postGraduate'];
    underGraduate = json['underGraduate'];
    showInDepartment = json['showInDepartment'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'departmentId': departmentId,
      'universityId': universityId,
      'isAvailable': isAvailable,
      'postGraduate': postGraduate,
      'underGraduate': underGraduate,
      'showInDepartment': showInDepartment,
    };
  }
}