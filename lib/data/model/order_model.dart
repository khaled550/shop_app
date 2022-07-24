class Order {
  int? id;
  var total;
  String? date;
  String? status;

  Order({id, this.total, this.date, this.status});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total']!;
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total'] = total;
    data['date'] = date;
    data['status'] = status;
    return data;
  }
}
