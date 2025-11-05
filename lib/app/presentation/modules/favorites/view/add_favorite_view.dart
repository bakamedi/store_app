import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/app/domain/responses/category/category_response.dart';
import 'package:store_app/app/domain/responses/product/product_response.dart';
import 'package:store_app/app/presentation/global/extensions/string_ext.dart';
import 'package:store_app/app/presentation/global/extensions/widgets_ext.dart';
import 'package:store_app/app/presentation/global/widgets/inputs/input_text_gw.dart';
import 'package:store_app/app/presentation/modules/favorites/cubit/favorites_cubit.dart';

class AddFavoriteView extends StatefulWidget {
  const AddFavoriteView({super.key});

  @override
  State<AddFavoriteView> createState() => _AddFavoriteViewState();
}

class _AddFavoriteViewState extends State<AddFavoriteView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _customTitleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Favorite Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              InputTextGW(
                controller: _titleController,
                hintText: 'Title',
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter a title'
                    : null,
              ),
              InputTextGW(
                controller: _customTitleController,
                hintText: 'Custom Title',
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter a custom title'
                    : null,
              ),
              InputTextGW(
                controller: _priceController,
                hintText: 'Price',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              InputTextGW(
                controller: _descriptionController,
                hintText: 'Description',
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter a description'
                    : null,
              ),
              InputTextGW(
                controller: _categoryController,
                hintText: 'Category',
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter a category'
                    : null,
              ),
              InputTextGW(
                controller: _imageController,
                hintText: 'Image URL',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  if (!value.isValidImageUrl) {
                    return 'Please enter a valid image URL';
                  }
                  return null;
                },
              ),
              20.h,
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final product = ProductResponse(
                      id: DateTime.now().millisecondsSinceEpoch,
                      title: _titleController.text,
                      price: double.parse(_priceController.text),
                      description: _descriptionController.text,
                      category: _categoryController.text,
                      image: _imageController.text,
                      rating: const RatingResponse(rate: 0, count: 0),
                    );
                    context.read<FavoritesCubit>().addFavorite(
                      product,
                      _customTitleController.text,
                    );
                    GoRouter.of(context).pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
