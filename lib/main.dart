// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:proj_list/home_controller.dart';
import 'package:proj_list/models/item_model.dart';
import 'package:provider/provider.dart';

import 'item_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter Slidy',
  //     theme: ThemeData(
  //       primarySwatch: Colors.yellow,
  //     ),
  //     home: const MyHomePage(
  //       title: 'Lista',
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HomeController>(
          create: (context) => HomeController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Slidy',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: const MyHomePage(title: 'Lista'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = HomeController();

  _dialog() {
    var model = ItemModel();
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Adicionar Item'),
          content: TextField(
            onChanged: (value) {
              model.setTitle(value);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Novo Item',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                controller.addItem(model);
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //sfinal controller = Provider.of<HomeController>(context);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: controller.setFilter,
          decoration: InputDecoration(hintText: "Pesquisa"),
        ),
        actions: <Widget>[
          IconButton(
            icon: Observer(
              builder: (_) {
                return Text("${controller.totalCheck}");
              },
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: controller.listFiltered.length,
            itemBuilder: (_, index) {
              var item = controller.listFiltered[index];
              return ItemWidget(
                item: item,
                removeClicked: () {
                  controller.removeItem(item);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _dialog();
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
