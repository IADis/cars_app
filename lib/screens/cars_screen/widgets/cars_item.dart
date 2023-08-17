import 'package:cars_app/model/cars_model.dart';
import 'package:flutter/material.dart';

class CarsItem extends StatelessWidget {
  const CarsItem({
    super.key,
    required this.model,
  });
  final CarsModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (model.urlImage != null && model.urlImage!.isNotEmpty)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(model.urlImage!),
                ),
              ),
            ),
          if (model.localImage != null)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(model.localImage!),
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${model.model} ${model.brand}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${model.year} год',
                style: const TextStyle(color: Colors.blueGrey, fontSize: 18),
              ),
            ],
          ),
          Text(
            '${model.price} \$',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
