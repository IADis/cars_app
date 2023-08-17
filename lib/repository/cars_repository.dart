import 'package:cars_app/model/cars_model.dart';

class CarsRepo {
  List<CarsModel> getCars() {
    return _cars;
  }

  final _cars = [
    CarsModel(
      urlImage:
          'https://www.topgear.com/sites/default/files/2021/08/1995-Nissan-Skyline-GT-R-_0.jpg',
      model: 'Nissan',
      brand: 'Skyline gtr r33',
      price: 12000.0,
      year: 2003,
    ),
    CarsModel(
      urlImage:
          'https://s1.auto.drom.ru/photo/zJHAXIugFF6Zx5ac9riY4ku8FrDlejuazpXa_li6u0vsvlTRwiHtqYxfw4UgwVxwPu_odTlS12h9NEhyoLv4u8u9IwQN.jpg',
      model: 'Subaru',
      brand: 'Legacy',
      price: 6000.0,
      year: 2007,
    ),
    CarsModel(
      urlImage: 'https://a.d-cd.net/27012a6s-960.jpg',
      model: 'Mercedes',
      brand: 'w211 E63 AMG',
      price: 32000.0,
      year: 2008,
    ),
    CarsModel(
      urlImage:
          'https://hips.hearstapps.com/hmg-prod/images/02-ss300p-3i4-front-1567937037.jpg?crop=0.671xw:1.00xh;0.161xw,0&resize=640:*',
      model: 'Bugatti',
      brand: 'Chiron',
      price: 1200000.0,
      year: 2023,
    ),
  ];
}
