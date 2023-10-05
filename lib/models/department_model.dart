class DepartmentModel{

  String? id;
  String? name;
  bool? isUnderGraduate;
  bool? isPostGraduate;
  String? universityId;
  List<String?> sectionImages=[];
  List<String?> sectionDescriptions=[];
  List<String?> arabicSectionDescriptions=[];

  DepartmentModel({
    this.id,
    this.name,
    this.isUnderGraduate,
    this.isPostGraduate,
    this.universityId,
    this.sectionImages=const [],
    this.sectionDescriptions=const[],
    this.arabicSectionDescriptions=const[],
  });

  DepartmentModel.fromJson(Map<String,dynamic>? json){
    name=json!['name'];
    isUnderGraduate=json['isUndergraduate'];
    isPostGraduate=json['isPostgraduate'];
    universityId=json['universityId'];
    json['sectionImages'].forEach((element) {
      sectionImages.add(element);
    });
    json['sectionDescriptions'].forEach((element) {
      sectionDescriptions.add(element);
    });
    json['arabicSectionDescriptions'].forEach((element) {
      arabicSectionDescriptions.add(element);
    });
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'underGraduate':isUnderGraduate,
      'postGraduate':isPostGraduate,
      'universityId':universityId,
      'sectionImages':sectionImages,
      'sectionDescriptions':sectionDescriptions,
      'arabicSectionDescriptions':arabicSectionDescriptions,
    };
  }
}