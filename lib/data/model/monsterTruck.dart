class MonsterTruck{
  String name;
  String broadcaster;
  int numEpisodes;
  String schedule;
  String poster;
  String banner;
  List<String> imageUrls;

  MonsterTruck({
    required this.name,
    required this.broadcaster,
    required this.numEpisodes,
    required this.schedule,
    required this.poster,
    required this.banner,
    required this.imageUrls,});
}

var monsterTruckList = [
  MonsterTruck(
    name:'Monster Truck',
    broadcaster:'Netflix',
    numEpisodes:20,
    schedule:'20.00-21.00',
      poster:'images/1.jpg',
      banner:'images/banner.png',
    imageUrls:[
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKHlksdJWoZVLzpINNNZ8K35qjBnR5I5kKEg&usqp=CAU'
      ,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKHlksdJWoZVLzpINNNZ8K35qjBnR5I5kKEg&usqp=CAU'
      ,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKHlksdJWoZVLzpINNNZ8K35qjBnR5I5kKEg&usqp=CAU'
    ]
  ),
  MonsterTruck(
    name:'Monster Truck',
    broadcaster:'Netflix',
    numEpisodes:20,
    schedule:'20.00-21.00',
    poster:'images/2.jpg',
      banner:'images/banner.png',
    imageUrls:['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKHlksdJWoZVLzpINNNZ8K35qjBnR5I5kKEg&usqp=CAU']
  ),
  MonsterTruck(
    name:'Monster Truck',
    broadcaster:'Netflix',
    numEpisodes:20,
    schedule:'20.00-21.00',
    poster:'images/3.jpg',
      banner:'images/banner.png',
    imageUrls:['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKHlksdJWoZVLzpINNNZ8K35qjBnR5I5kKEg&usqp=CAU']
  )
];
