class SettingsModel{

  bool? reviewPosts;

  SettingsModel({
    this.reviewPosts,
  });

  SettingsModel.fromJson(Map<String, dynamic>? json) {
    reviewPosts = json!['reviewPosts'];
  }

  Map<String, dynamic> toMap() {
    return {
      'reviewPosts': reviewPosts,
    };
  }
}