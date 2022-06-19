import 'package:flutter/material.dart';

class OrderService extends ChangeNotifier {
  int? selectedIndex;
  String? selectedVehicle = 'mobil';
  List<Map<String, dynamic>> vehicle = [
    {'type': 'mobil', 'harga': 20000},
    {'type': 'motor', 'harga': 10000},
    {'type': 'sepeda', 'harga': 5000},
  ];

  Map<String, dynamic> vehicleHarga = {
    'mobil': 20000,
    'motor': 10000,
    'sepeda': 5000,
  };

  Map<String, Map<String, dynamic>> add = {
    'helm': {'helm': 2000},
    'full': {'full': 10000},
    'washndry': {'washndry': 5000},
    'washonly': {'washonly': 2000},
  };

  Map<String, String> img = {
    "mobil": "lib/assets/kendaraan/car.png",
    "motor": "lib/assets/kendaraan/motor.png",
    "sepeda": "lib/assets/kendaraan/bicycle.png",
  };

  List<Map<String, dynamic>> transaksi = [
    {
      'id': 1,
      'status': "progress",
      'vehicle': {'type': 'mobil', 'harga': 20000, 'total': 1},
      'wash': {'type': 'full', 'harga': 10000},
      'add': [
        {'': 0}
      ],
    },
    {
      'id': 2,
      'status': "selesai",
      'vehicle': {'type': 'motor', 'harga': 10000, 'total': 1},
      'wash': {'type': 'full', 'harga': 10000},
      'add': [
        {'': 0}
      ],
    },
    {
      'id': 3,
      'status': "progress",
      'vehicle': {'type': 'mobil', 'harga': 20000, 'total': 1},
      'wash': {'type': 'full', 'harga': 10000},
      'add': [
        {'': 0}
      ],
    },
    {
      'id': 4,
      'status': "progress",
      'vehicle': {'type': 'sepeda', 'harga': 5000, 'total': 1},
      'wash': {'type': 'full', 'harga': 10000},
      'add': [
        {'': 0}
      ],
    }
  ];

  Map<String, dynamic> aTransaksi = {
    'id': 0,
    'status': "",
    'vehicle': {'type': '', 'harga': 0, 'total': 1},
    'wash': {'type': 'full wash', 'harga': 10000},
    'add': [
      {'': 0}
    ],
  };

  void createTransaksi(Map<String, dynamic> oneTransaksi) {
    oneTransaksi['id'] = transaksi.length + 1;
    transaksi.add(oneTransaksi);
    notifyListeners();
  }

  void updateStastusTransaksi(int index, String status) {
    transaksi[index]['status'] = status;
    notifyListeners();
  }

  void deleteTransaksi(int index) {
    transaksi.removeAt(index);
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  void saveTransasksiToLocal() {}

  double updateTotalHarga(String vehicle, String wash, List<String> add) {
    double total = 0;

    switch (vehicle) {
      case 'mobil':
    }
    notifyListeners();
    return total;
  }

  void resetATransaksi() {
    aTransaksi = {
      'id': 0,
      'status': "",
      'vehicle': {'': 0, 'total': 0},
      'wash': {'': 0},
      'add': [
        {'': 0}
      ],
    };
    notifyListeners();
  }
}

void main() {
  OrderService order = OrderService();

  order.createTransaksi({
    'id': 1,
    'status': "progress",
    'vehicle': {'mobil': 20000},
    'wash': {'full': 10000},
    'add': [
      {'': 0}
    ],
  });
  order.createTransaksi({
    'id': 1,
    'status': "progress",
    'vehicle': {'mobil': 20000, 'total': 2},
    'wash': {'full': 10000},
    'add': [
      {'': 0}
    ],
  });
  order.createTransaksi({
    'id': 1,
    'status': "progress",
    'vehicle': {'mobil': 20000, 'total': 2},
    'wash': {'full': 10000},
    'add': [
      {'': 0}
    ],
  });

  print("HArga Mobil: ${order.transaksi[2]['vehicle']}");
}
