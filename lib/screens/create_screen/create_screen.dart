import 'dart:io';

import 'package:cars_app/bloc/cars_bloc.dart';
import 'package:cars_app/components/text_field.dart';
import 'package:cars_app/model/cars_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final modelController = TextEditingController();
  final brandController = TextEditingController();
  final priceController = TextEditingController();
  final yearController = TextEditingController();
  final photoLinkController = TextEditingController();
  final isFullFilled = ValueNotifier<bool>(false);
  final toogleButton = ValueNotifier<bool>(false);
  final ImagePicker imagePicker = ImagePicker();
  XFile? image;
  File? imageFile;

  @override
  void dispose() {
    isFullFilled.dispose();
    toogleButton.dispose();
    modelController.dispose();
    brandController.dispose();
    priceController.dispose();
    yearController.dispose();
    photoLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Screen'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 15),
          TextFieldWidget(
            onChanged: (v) {
              validation();
            },
            name: 'Brand',
            controller: brandController,
            keyboard: TextInputType.text,
            regex: RegExp(r'[a-aZ-z]'),
          ),
          const SizedBox(height: 15),
          TextFieldWidget(
            onChanged: (v) {
              validation();
            },
            name: 'Model',
            controller: modelController,
            keyboard: TextInputType.text,
            regex: RegExp(r'[a-aZ-z]'),
          ),
          const SizedBox(height: 15),
          TextFieldWidget(
            onChanged: (v) {
              validation();
            },
            name: 'Price',
            controller: priceController,
            keyboard: TextInputType.number,
          ),
          const SizedBox(height: 15),
          TextFieldWidget(
            onChanged: (v) {
              validation();
            },
            name: 'Year',
            controller: yearController,
            keyboard: TextInputType.number,
            regex: RegExp(r'[0-9]'),
          ),
          const SizedBox(height: 15),
          ValueListenableBuilder(
            valueListenable: toogleButton,
            builder: (context, _, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: toogleButton.value,
                    replacement: Row(
                      children: [
                        SizedBox(
                          height: 64,
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 120,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                image =
                                                    await imagePicker.pickImage(
                                                  source: ImageSource.camera,
                                                );
                                                imageFile = File(image!.path);
                                                setState(() {
                                                  validation();
                                                  image;
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.add_a_photo,
                                                size: 40,
                                              ),
                                            ),
                                            const Text('Сделать фото'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                image =
                                                    await imagePicker.pickImage(
                                                  source: ImageSource.gallery,
                                                );
                                                imageFile = File(image!.path);
                                                validation();
                                                setState(() {
                                                  image;
                                                });
                                              },
                                              icon: const Icon(
                                                Icons
                                                    .add_photo_alternate_rounded,
                                                size: 40,
                                              ),
                                            ),
                                            const Text(
                                                'Выбрать фото из галлереи'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Icon(
                              Icons.photo_camera,
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Container(
                          height: 64,
                          width: 64,
                          decoration: BoxDecoration(
                            image: imageFile != null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(imageFile!),
                                  )
                                : const DecorationImage(
                                    image: NetworkImage(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Empty.png/640px-Empty.png'),
                                  ),
                          ),
                        )
                      ],
                    ),
                    child: TextFieldWidget(
                      onChanged: (v) {
                        validation();
                      },
                      name: 'Photo Link',
                      controller: photoLinkController,
                      keyboard: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Switch.adaptive(
                        value: toogleButton.value,
                        onChanged: (value) {
                          toogleButton.value = !toogleButton.value;
                        },
                      ),
                      toogleButton.value
                          ? const Text('Добавить фото из галерии')
                          : const Text('Добавить фото по ссылке'),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 30),
          SizedBox(
              height: 60,
              child: BlocConsumer<CarsBloc, CarsState>(
                listener: (context, state) async {
                  if (state is SuccessState) {
                    await Future.delayed(const Duration(milliseconds: 500));
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return BlocBuilder<CarsBloc, CarsState>(
                    builder: (context, state) {
                      return ValueListenableBuilder(
                          valueListenable: isFullFilled,
                          builder: (context, _, __) {
                            return ElevatedButton(
                              onPressed: state is LoadingState
                                  ? null
                                  : isFullFilled.value
                                      ? () {
                                          final car = CarsModel(
                                            urlImage: photoLinkController.text,
                                            localImage: imageFile,
                                            model: modelController.text,
                                             brand: brandController.text,
                                            price: double.parse(
                                                priceController.text),
                                            year:
                                                int.parse(yearController.text),
                                          );

                                          BlocProvider.of<CarsBloc>(context)
                                              .add(AddCars(car));
                                        }
                                      : null,
                              child: state is LoadingState
                                  ? const CircularProgressIndicator()
                                  : const Text('Add Car'),
                            );
                          });
                    },
                  );
                },
              )),
        ],
      ),
    );
  }

  validation() {
    if ([
      brandController,
      modelController,
      yearController,
      priceController,
    ].every((e) => e.text.length >= 3)) {
      isFullFilled.value = true;
      if (photoLinkController.text.contains('http') || imageFile != null) {
      } else {
        isFullFilled.value = false;
      }
    } else {
      isFullFilled.value = false;
    }
  }
}
