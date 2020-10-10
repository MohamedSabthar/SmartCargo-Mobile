class ScheduleResponse {
  Schedule schedule;

  ScheduleResponse({this.schedule});

  ScheduleResponse.fromJson(Map<String, dynamic> json) {
    schedule = json['schedule'] != null
        ? new Schedule.fromJson(json['schedule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.schedule != null) {
      data['schedule'] = this.schedule.toJson();
    }
    return data;
  }
}

class Schedule {
  List<String> orders;
  List<Route> route;
  String sId;
  Vehicle vehicle;
  String date;
  String storekeeper;
  String driver;
  int iV;

  Schedule(
      {this.orders,
      this.route,
      this.sId,
      this.vehicle,
      this.date,
      this.storekeeper,
      this.driver,
      this.iV});

  Schedule.fromJson(Map<String, dynamic> json) {
    orders = json['orders'].cast<String>();
    if (json['route'] != null) {
      route = new List<Route>();
      json['route'].forEach((v) {
        route.add(new Route.fromJson(v));
      });
    }
    sId = json['_id'];
    vehicle =
        json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
    date = json['date'];
    storekeeper = json['storekeeper'];
    driver = json['driver'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orders'] = this.orders;
    if (this.route != null) {
      data['route'] = this.route.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle.toJson();
    }
    data['date'] = this.date;
    data['storekeeper'] = this.storekeeper;
    data['driver'] = this.driver;
    data['__v'] = this.iV;
    return data;
  }
}

class Route {
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

  Route(
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

  Route.fromJson(Map<String, dynamic> json) {
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

class Vehicle {
  bool isAvailable;
  bool onRepair;
  bool deleted;
  String sId;
  VehicleType vehicleType;
  String licensePlate;
  int iV;

  Vehicle(
      {this.isAvailable,
      this.onRepair,
      this.deleted,
      this.sId,
      this.vehicleType,
      this.licensePlate,
      this.iV});

  Vehicle.fromJson(Map<String, dynamic> json) {
    isAvailable = json['is_available'];
    onRepair = json['on_repair'];
    deleted = json['deleted'];
    sId = json['_id'];
    vehicleType = json['vehicle_type'] != null
        ? new VehicleType.fromJson(json['vehicle_type'])
        : null;
    licensePlate = json['license_plate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_available'] = this.isAvailable;
    data['on_repair'] = this.onRepair;
    data['deleted'] = this.deleted;
    data['_id'] = this.sId;
    if (this.vehicleType != null) {
      data['vehicle_type'] = this.vehicleType.toJson();
    }
    data['license_plate'] = this.licensePlate;
    data['__v'] = this.iV;
    return data;
  }
}

class VehicleType {
  Capacity capacity;
  bool deleted;
  String sId;
  String type;
  int fuelEconomy;
  int iV;

  VehicleType(
      {this.capacity,
      this.deleted,
      this.sId,
      this.type,
      this.fuelEconomy,
      this.iV});

  VehicleType.fromJson(Map<String, dynamic> json) {
    capacity = json['capacity'] != null
        ? new Capacity.fromJson(json['capacity'])
        : null;
    deleted = json['deleted'];
    sId = json['_id'];
    type = json['type'];
    fuelEconomy = json['fuel_economy'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.capacity != null) {
      data['capacity'] = this.capacity.toJson();
    }
    data['deleted'] = this.deleted;
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['fuel_economy'] = this.fuelEconomy;
    data['__v'] = this.iV;
    return data;
  }
}

class Capacity {
  int volume;
  int maxLoad;

  Capacity({this.volume, this.maxLoad});

  Capacity.fromJson(Map<String, dynamic> json) {
    volume = json['volume'];
    maxLoad = json['max_load'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['volume'] = this.volume;
    data['max_load'] = this.maxLoad;
    return data;
  }
}
