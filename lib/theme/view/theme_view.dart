import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme.dart';

class ThemeView extends StatelessWidget {
  ThemeView({super.key});

  final List themeList = [
    {
      'title': 'Violet clair',
      'color': Colors.purple,
      'brightness': Brightness.light,
    },
    {
      'title': 'Violet sombre',
      'color': Colors.purple,
      'brightness': Brightness.dark,
    },
    {
      'title': 'Rose clair',
      'color': Colors.pink,
      'brightness': Brightness.light,
    },
    {
      'title': 'Rose sombre',
      'color': Colors.pink,
      'brightness': Brightness.dark,
    },
    {
      'title': 'Rouge clair',
      'color': Colors.red,
      'brightness': Brightness.light,
    },
    {
      'title': 'Rouge sombre',
      'color': Colors.red,
      'brightness': Brightness.dark,
    },
    {
      'title': 'Orange clair',
      'color': Colors.orange,
      'brightness': Brightness.light,
    },
    {
      'title': 'Orange sombre',
      'color': Colors.orange,
      'brightness': Brightness.dark,
    },
    {
      'title': 'Jaune clair',
      'color': Colors.amber,
      'brightness': Brightness.light,
    },
    {
      'title': 'Jaune sombre',
      'color': Colors.amber,
      'brightness': Brightness.dark,
    },
    {
      'title': 'Vert clair',
      'color': Colors.green,
      'brightness': Brightness.light,
    },
    {
      'title': 'Vert sombre',
      'color': Colors.green,
      'brightness': Brightness.dark,
    },
    {
      'title': 'Turquoise clair',
      'color': Colors.teal,
      'brightness': Brightness.light,
    },
    {
      'title': 'Turquoise sombre',
      'color': Colors.teal,
      'brightness': Brightness.dark,
    },
    {
      'title': 'Cyan clair',
      'color': Colors.cyan,
      'brightness': Brightness.light,
    },
    {
      'title': 'Cyan sombre',
      'color': Colors.cyan,
      'brightness': Brightness.dark,
    },
    {
      'title': 'Bleu clair',
      'color': Colors.blue,
      'brightness': Brightness.light,
    },
    {
      'title': 'Bleu sombre',
      'color': Colors.blue,
      'brightness': Brightness.dark,
    },
    {
      'title': 'Indigo clair',
      'color': Colors.indigo,
      'brightness': Brightness.light,
    },
    {
      'title': 'Indigo sombre',
      'color': Colors.indigo,
      'brightness': Brightness.dark,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc Theme')),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemCount: themeList.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2,
        ),
        itemBuilder: (context, index) {
          return Card(
            color: themeList[index]['color'],
            child: InkWell(
              onTap: () {
                context.read<ThemeCubit>().changeTheme(
                    themeList[index]['color'], themeList[index]['brightness']);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 7),
                    child: Text(themeList[index]['title']),
                  ),
                  Container(
                    height: 25,
                    color: themeList[index]['brightness'] == Brightness.light
                        ? Colors.white54
                        : Colors.black54,
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DemoPage()));
        },
        child: const Icon(
          Icons.open_in_new,
          color: Colors.white,
        ),
      ),
    );
  }
}
