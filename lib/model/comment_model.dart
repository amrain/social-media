class CommentModel {
  List<DataComment>? data;
  int? total;
  int? page;
  int? limit;

  CommentModel({this.data, this.total, this.page, this.limit});

  CommentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataComment>[];
      json['data'].forEach((v) {
        data!.add(new DataComment.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    return data;
  }
}

class DataComment {
  String? id;
  String? message;
  OwnerComment? owner;
  String? post;
  String? publishDate;

  DataComment({this.id, this.message, this.owner, this.post, this.publishDate});

  DataComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    owner = json['owner'] != null ? new OwnerComment.fromJson(json['owner']) : null;
    post = json['post'];
    publishDate = json['publishDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['post'] = this.post;
    data['publishDate'] = this.publishDate;
    return data;
  }
}

class OwnerComment {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;

  OwnerComment({this.id, this.title, this.firstName, this.lastName, this.picture});

  OwnerComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['picture'] = this.picture;
    return data;
  }
}
