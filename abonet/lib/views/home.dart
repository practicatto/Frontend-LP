import 'package:flutter/material.dart';
import 'package:abonet/routes/routes.dart' as route;
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Inicio",
                  icon: Icon(Icons.home),
                ),
                Tab(
                  text: "Ciudades",
                  icon: Icon(Icons.location_city),
                ),
                Tab(
                  text: "Categorias",
                  icon: Icon(Icons.category),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bienvenido, Elmo Quito",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //Card for saying look for a place
                      Card(
                          child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text("Busca a los mejores abogados aquí"),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {},
                                child: Text("Buscar")),
                          ],
                        ),
                      )),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "FAQ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Divider(),
                      Text(
                        "¿Qué es Abonet?",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  )),
              Center(
                child: Text(
                  'Ciudades',
                ),
              ),
              Center(
                child: Text(
                  'Categorias',
                ),
              ),
            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              iconSize: 35,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.leaderboard),
                  label: 'Ranking',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Perfil',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
              selectedItemColor: Colors.amber[
                  800]), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
