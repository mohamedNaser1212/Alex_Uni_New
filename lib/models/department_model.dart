class DepartmentModel{

  String? id;
  String? name;

  String? mainImage;
  String? description;
  bool? isUnderGraduate;
  bool? isPostGraduate;
  String? universityId;
  List<String?> sectionImages=[];
  List<String?> sectionTitles=[];
  List<String?> sectionDescriptions=[];


  DepartmentModel({
    this.id,
    this.name,

    this.description,
    this.mainImage,
    this.isUnderGraduate,
    this.isPostGraduate,
    this.universityId,
    this.sectionImages=const [],
    this.sectionTitles=const[],
    this.sectionDescriptions=const[],
  });

  DepartmentModel.fromJson(Map<String,dynamic>? json){
    name=json!['name'];
    description=json['description'];


    mainImage=json['mainImage'];
    isUnderGraduate=json['isUndergraduate'];
    isPostGraduate=json['isPostgraduate'];
    universityId=json['universityId'];
    json['sectionImages'].forEach((element) {
      sectionImages!.add(element);
    });
    json['sectionTitles'].forEach((element) {
      sectionTitles!.add(element);
    });
    json['sectionDescriptions'].forEach((element) {
      sectionDescriptions!.add(element);
    });
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'mainImage':mainImage,
      'description':description,
      'underGraduate':isUnderGraduate,
      'postGraduate':isPostGraduate,
      'universityId':universityId,
      'sectionImages':sectionImages,
      'sectionTitles':sectionTitles,
      'sectionDescriptions':sectionDescriptions,
    };
  }
}