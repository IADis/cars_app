import 'dart:developer';

import 'package:cars_app/bloc/cars_bloc.dart';
import 'package:cars_app/screens/cars_screen/widgets/cars_item.dart';
import 'package:cars_app/screens/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/appbar_cars.dart';

class CarsScreen extends StatelessWidget {
  const CarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateScreen(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: const AppBarCars(),
      body: BlocBuilder<CarsBloc, CarsState>(
        builder: (context, state) {
          log(state.toString());
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SuccessState) {
            return ListView.builder(
              itemCount: state.cars.length,
              itemBuilder: (context, index) {
                return CarsItem(
                  model: state.cars[index],
                );
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
