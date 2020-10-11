class OrderResponse {
  Order order;

  OrderResponse({this.order});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    return data;
  }
}

class Order {
  Location location;
  String status;
  String sId;
  List<Products> products;
  String email;
  String phone;
  int iV;
  int emergencyLevel;
  int load;
  int volume;

  Order(
      {this.location,
      this.status,
      this.sId,
      this.products,
      this.email,
      this.phone,
      this.iV,
      this.emergencyLevel,
      this.load,
      this.volume});

  Order.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    status = json['status'];
    sId = json['_id'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    email = json['email'];
    phone = json['phone'];
    iV = json['__v'];
    emergencyLevel = json['emergency_level'];
    load = json['load'];
    volume = json['volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['status'] = this.status;
    data['_id'] = this.sId;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['__v'] = this.iV;
    data['emergency_level'] = this.emergencyLevel;
    data['load'] = this.load;
    data['volume'] = this.volume;
    return data;
  }
}

class Location {
  double lat;
  double lang;

  Location({this.lat, this.lang});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    return data;
  }
}

class Products {
  String sId;
  String item;
  int quantity;

  Products({this.sId, this.item, this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    item = json['item'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['item'] = this.item;
    data['quantity'] = this.quantity;
    return data;
  }
}
