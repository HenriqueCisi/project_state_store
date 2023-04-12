import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_state_store/components/app_drawer.dart';
import 'package:project_state_store/models/product_list.model.dart';
import 'package:project_state_store/models/products.model.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();


  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies(){
     super.didChangeDependencies();

     if(_formData.isEmpty){
      final arg = ModalRoute.of(context)?.settings.arguments;

      if(arg != null){
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
     }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  void submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    Provider.of<ProductList>(context, listen: false)
        .saveProduct(_formData);

    Navigator.of(context).pop();
  }

  bool isValidUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool isValidExtension = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return (isValidUrl && isValidExtension);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Produto'),
        actions: [
          IconButton(
              onPressed: () {
                submitForm();
              },
              icon: const Icon(Icons.send))
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _formData['name'] as String,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  onSaved: (name) => _formData['name'] = name ?? '',
                  validator: (_name) {
                    final name = _name ?? '';

                    if (name.trim().isEmpty) {
                      return 'Nome obrigatório';
                    }

                    if (name.trim().length < 3) {
                      return 'Tamanho mínimo de 3 letras';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['price']?.toString(),
                  decoration: const InputDecoration(labelText: 'Preço'),
                  textInputAction: TextInputAction.next,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  focusNode: _priceFocus,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                  onSaved: (price) =>
                      _formData['price'] = double.parse(price ?? '0'),
                  validator: (_price) {
                    final priceString = _price ?? '';
                    final price = double.tryParse(priceString) ?? -1;

                    if (price <= 0) {
                      return 'Preço inválido';
                    }

                    return null;
                  },
                ),
                TextFormField(
                   initialValue: _formData['description'] as String,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  textInputAction: TextInputAction.next,
                  focusNode: _descriptionFocus,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_imageUrlFocus);
                  },
                  onSaved: (description) =>
                      _formData['description'] = description ?? '',
                  validator: (_description) {
                    final description = _description ?? '';

                    if (description.trim().isEmpty) {
                      return 'Descrição obrigatória';
                    }

                    if (description.trim().length < 10) {
                      return 'Tamanho mínimo de 10 letras';
                    }

                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'URL da Imagem'),
                        textInputAction: TextInputAction.done,
                        focusNode: _imageUrlFocus,
                        keyboardType: TextInputType.url,
                        controller: _imageUrlController,
                        onFieldSubmitted: (_) {
                          submitForm();
                        },
                        onSaved: (url) => _formData['imgUrl'] = url ?? '',
                        validator: (_url) {
                          final imgUrl = _url ?? '';
                          if (!isValidUrl(imgUrl)) {
                            return 'url inválida';
                          }

                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.only(top: 10, left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1)),
                      alignment: Alignment.center,
                      child: _imageUrlController.text.isEmpty
                          ? const Text('Informe a url')
                          : FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(_imageUrlController.text),
                            ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
