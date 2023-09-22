class DepartmentModel{

  String? id;
  String? name;
  String? departmentImage;
  bool? underGraduate;
  bool? postGraduate;
  String? universityId;

  DepartmentModel({
    this.id,
    this.name,
    this.departmentImage,
    this.underGraduate,
    this.postGraduate,
    this.universityId,
  });

  DepartmentModel.fromJson(Map<String,dynamic>? json){
    name=json!['name'];
    departmentImage=json['departmentImage'];
    underGraduate=json['underGraduate'];
    postGraduate=json['postGraduate'];
    universityId=json['universityId'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'departmentImage':departmentImage,
      'underGraduate':underGraduate,
      'postGraduate':postGraduate,
      'universityId':universityId,
    };
  }
}