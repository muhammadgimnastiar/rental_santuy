import 'package:flutter/material.dart';

class OrderService extends ChangeNotifier {
  int? selectedIndex;

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
      'status': "progress",
      'vehicle': {'type': 'sepeda', 'harga': 5000, 'total': 1},
      'wash': {'type': 'full', 'harga': 10000},
      'add': [
        {'': 0}
      ],
    },
    {
      'id': 3,
      'status': "progress",
      'vehicle': {'type': 'motor', 'harga': 10000, 'total': 1},
      'wash': {'type': 'full', 'harga': 10000},
      'add': [
        {'': 0}
      ],
    },
  ];

  Map<String, dynamic> aTransaksi = {
    'id': 0,
    'status': "progress",
    'vehicle': {'type': '', 'harga': 0, 'total': 0},
    'wash': {'type': 'full wash', 'harga': 0},
    'add': [
      {'': 0}
    ],
  };

  void createTransaksi() {
    aTransaksi['id'] = transaksi.length + 1;
    transaksi.add(aTransaksi);
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
      'status': "progress",
      'vehicle': {'type': '', 'harga': 0, 'total': 0},
      'wash': {'type': 'full wash', 'harga': 0},
      'add': [
        {'': 0}
      ],
    };
    notifyListeners();
  }

  int getHarga() {
    return (aTransaksi['vehicle']['total'] * aTransaksi['vehicle']['harga'] +
        aTransaksi['wash']['harga']);
  }

  String? selectedVehicle = 'mobil';
}


// {
//       'id': 2,
//       'status': "selesai",
//       'vehicle': {'type': 'motor', 'harga': 10000, 'total': 1},
//       'wash': {'type': 'full', 'harga': 10000},
//       'add': [
//         {'': 0}
//       ],
//     },
//     {
//       'id': 3,
//       'status': "progress",
//       'vehicle': {'type': 'mobil', 'harga': 20000, 'total': 1},
//       'wash': {'type': 'full', 'harga': 10000},
//       'add': [
//         {'': 0}
//       ],
//     },
//     {
//       'id': 4,
//       'status': "progress",
//       'vehicle': {'type': 'sepeda', 'harga': 5000, 'total': 1},
//       'wash': {'type': 'full', 'harga': 10000},
//       'add': [
//         {'': 0}
//       ],
//     }