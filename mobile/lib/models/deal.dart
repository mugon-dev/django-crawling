class Deal {
  String? link;
  String? imageUrl;
  String? title;
  int? replyCount;
  int? upCount;
  String? createAt;

  Deal(
      {this.link,
      this.imageUrl,
      this.title,
      this.replyCount,
      this.upCount,
      this.createAt});

  Deal.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    imageUrl = json['image_url'];
    title = json['title'];
    replyCount = json['reply_count'];
    upCount = json['up_count'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['image_url'] = this.imageUrl;
    data['title'] = this.title;
    data['reply_count'] = this.replyCount;
    data['up_count'] = this.upCount;
    data['create_at'] = this.createAt;
    return data;
  }
}
