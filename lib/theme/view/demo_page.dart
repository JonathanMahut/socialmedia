import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voyage Thailande"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.bookmark_border,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: const SingleChildScrollView(
          child: Column(
        children: [
          ImageSection(),
          TitleSection(),
          TextSection(),
          IconSection(),
          HotelSection(),
          ButtonSection(),
        ],
      )),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Image.network(
        'https://drissas.com/wp-content/uploads/2021/08/photo_thailande.jpeg');
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bienvenue au paradis',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              ),
              Text(
                'Réservez votre séjour en Thailande',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: const Text(
        "La Thaïlande, en forme longue le Royaume de Thaïlande, est un pays d'Asie du Sud-Est dont le territoire couvre 514 000 km2. Avant 1939, il s'appelait le Royaume de Siam. Il est bordé à l'ouest par la Birmanie, au sud par la Malaisie, ",
        softWrap: true,
      ),
    );
  }
}

class IconSection extends StatelessWidget {
  const IconSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(
                  Icons.hotel,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 5),
                Text(
                  'Hotels'.toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(Icons.airplanemode_active,
                    color: Theme.of(context).primaryColor),
                const SizedBox(height: 5),
                Text(
                  'Vols'.toUpperCase(),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(Icons.drive_eta, color: Theme.of(context).primaryColor),
                const SizedBox(height: 5),
                Text(
                  'Voiture'.toUpperCase(),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HotelSection extends StatelessWidget {
  const HotelSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
                'https://drissas.com/wp-content/uploads/2021/08/photo_thailande_1.jpeg'),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
                'https://drissas.com/wp-content/uploads/2021/08/photo_thailande_2.jpeg'),
          ),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
      child: const Text('Voir plus de logements'),
      onPressed: () {},
    );
  }
}
