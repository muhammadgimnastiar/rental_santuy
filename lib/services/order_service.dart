import 'package:flutter/material.dart';

class OrderService extends ChangeNotifier {
  Map<String, Map<String, dynamic>> vehicle = {
    'mobil': {'mobil': 20000},
    'motor': {'motor': 10000},
    'sepeda': {'sepeda': 5000},
  };

  Map<String, Map<String, dynamic>> add = {
    'helm': {'helm': 2000},
    'full': {'full': 10000},
    'washndry': {'washndry': 5000},
    'washonly': {'washonly': 2000},
  };

  List<Map<String, dynamic>> transaksi = [
    {
      'id': 1,
      'status': "progress",
      'vehicle': {'mobil': 20000, 'total': 0},
      'wash': {'full': 10000},
      'add': [
        {'': 0}
      ],
    }
  ];

  Map<String, dynamic> aTransaksi = {};

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
