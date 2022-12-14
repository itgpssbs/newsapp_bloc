import 'package:flutter/material.dart';

import '../../../data/model/monsterTruck.dart';

class DetailPage extends StatelessWidget {
  final MonsterTruck monsterTruck;
  // const DetailPage({Key? key}): super(key:key);
  const DetailPage({Key? key, required this.monsterTruck}): super(key:key);

  @override
  Widget build(BuildContext context){
    // TODO : implemend build
    return Scaffold(
      // SafeArea - mencegah app kehalang poni
      body: SafeArea (
        child: SingleChildScrollView(
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('images/1.jpg'),
              Stack(
                  children: [
                    // Image.asset(monsterTruck.poster),
                    SafeArea(
                        child: Padding (
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor:Colors.grey,
                                child: IconButton(
                                  icon: const Icon(
                                      Icons.arrow_back,
                                      color:Colors.white                                    
                                  ),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              const FavoriteButton(),
                            ],
                          ),
                        ),
                    ),
                  ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: Text(
                  monsterTruck.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const Icon(Icons.calendar_today),
                        const SizedBox(height: 8.0),
                        Text(monsterTruck.schedule),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const Icon(Icons.timeline),
                        const SizedBox(height: 8.0),
                        Text(monsterTruck.schedule),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const Icon(Icons.favorite),
                        const SizedBox(height: 8.0),
                        Text(monsterTruck.numEpisodes.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: const Text(
                  "Kisah berawal dari perusahaan minyak dan gas Terravex yang tengah melakukan proyek pengeboran di wilayah Amerika Serikat. Proyek pengeboran ini sayangnya membuat kehidupan bawah tanah terancam. Ini termasuk ancaman terhadap makhluk monster bawah tanah, dan menyebabkan tiga monster bawah tanah keluar dari habitatnya.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(
                height:150,
                child:ListView(
                  scrollDirection: Axis.horizontal,
                  children: monsterTruck.imageUrls.map((url){
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:Image.network(url),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget{
  const FavoriteButton({Key? key}): super(key:key);

  @override
  // FavoriteButtonState createState()=> _FavoriteButtonState();
  _FavoriteButtonState createState()=> _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>{
  bool isFave=false;
  @override
  Widget build (BuildContext context){
    //TODO : implement build
    return IconButton(
      icon: Icon(
        isFave ? Icons.favorite:Icons.favorite_border,
        color: Colors.red
      ),
      onPressed: (){
        setState((){
          isFave = !isFave;
        });
      },
    );
  }
}