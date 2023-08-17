import 'package:cars_app/model/cars_model.dart';
import 'package:cars_app/repository/cars_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

EventTransformer<Event> debounce<Event>({
  Duration duration = const Duration(milliseconds: 400),
}) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  CarsBloc({required CarsRepo carsRepo})
      : _carsRepo = carsRepo,
        super(InitialState()) {
    on<GetCars>(
      (event, emit) async {
        emit(LoadingState());
        await Future.delayed(const Duration(seconds: 1));
        final cars = _carsRepo.getCars();
        allCars = cars;
        emit(SuccessState(cars: cars));
      },
    );
    on<SearchCars>(
      (event, emit) {
        final newCars = allCars.where((e) {
          final fullName = '${e.model} ${e.brand}';
          return fullName.toLowerCase().contains(event.text.toLowerCase());
        }).toList();
        emit(SuccessState(cars: newCars));
      },
      transformer: debounce(),
    );
    on<AddCars>(
      (event, emit) async {
        emit(LoadingState());
        await Future.delayed(const Duration(seconds: 3));
        allCars.add(event.car);
        emit(SuccessState(cars: allCars));
      },
    );
    on<FiltresCars>(
      (event, emit) {
        switch (event.filtres) {
          case Filtres.byName:
            allCars.sort((a, b) => a.model.compareTo(b.model));
            break;
          case Filtres.byPrice:
            allCars.sort((a, b) => a.price.compareTo(b.price));
            break;
          case Filtres.byYear:
            allCars.sort((a, b) => a.year.compareTo(b.year));
            break;
          default:
        }
        emit(SuccessState(cars: allCars));
      },
    );
  }

  late final CarsRepo _carsRepo;
  List<CarsModel> allCars = [];
}

abstract class CarsEvent {}

class GetCars extends CarsEvent {}

class SearchCars extends CarsEvent {
  SearchCars(this.text);
  final String text;
}

class AddCars extends CarsEvent {
  AddCars(this.car);
  final CarsModel car;
}

class FiltresCars extends CarsEvent {
  FiltresCars(this.filtres);
  final Filtres filtres;
}

enum Filtres {
  byName,
  byPrice,
  byYear,
}

class DeleteCars extends CarsEvent {}

abstract class CarsState {}

class InitialState extends CarsState {}

class LoadingState extends CarsState {}

class SuccessState extends CarsState {
  SuccessState({required this.cars});
  final List<CarsModel> cars;
}

class ErrorState extends CarsState {}
