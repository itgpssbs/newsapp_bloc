import 'package:flutter/material.dart';

import '../data/model/monsterTruck.dart';
import 'detail_page.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key ? key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    // TODO : implemend build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Truck List'),
      ),
      body: ListView.builder(
          itemBuilder: (context, index){
            final MonsterTruck monsterTruck = monsterTruckList[index];
            return InkWell(
              onTap: (){
                // apps tumpuk2 / stack
                // MaterialPageRoute: routing ke halaman lain
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return DetailPage(monsterTruck:monsterTruck);
                }));
              },
              child:Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex:1,
                        // child:Image.asset('images/1.jpg'),
                        child:Image.asset(monsterTruck.poster),
                    ),
                    Expanded(
                      flex:2,
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(monsterTruck.name,style: const TextStyle(fontSize: 16.0),),
                            const SizedBox(height: 10,),
                            Text(monsterTruck.broadcaster),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        itemCount: monsterTruckList.length,
      ),
    );
  }
}