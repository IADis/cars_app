import 'dart:io';

class CarsModel {
  CarsModel({
    this.urlImage,
    this.localImage,
    required this.model,
    required this.brand,
    required this.price,
    required this.year,
  });
  final String? urlImage;
  final File? localImage;
  final String model;
  final String brand;
  final double price;
  final int year;

  @override
  String toString() {
    return 'Cars model urlImage: ${urlImage.toString()},Cars model localImage: ${localImage.toString()}, ';
  }
}
