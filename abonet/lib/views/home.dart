import 'package:abonet/services/api_service.dart';
import 'package:abonet/services/auth_service.dart';
import 'package:abonet/views/Categorias.dart';
import 'package:abonet/views/ciudades.dart';
import 'package:abonet/widgets/abog_info.dart';
import 'package:flutter/material.dart';
import 'package:abonet/routes/routes.dart' as route;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<AuthService>(context);
    var apiService = Provider.of<ApiService>(context);
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
                                onPressed: () async {
                                  var id = await service.readId();
                                  var data = await apiService
                                      .getAbogadoById(int.parse(id));
                                  print(data["categoria"]);
                                  var categoriasNombres = data["categoria"]
                                      .map((cat) => cat["nombre"])
                                      .toList()
                                      .join(", ");
                                  print(categoriasNombres);
                                },
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
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              primary: Colors.white),
                          onPressed: () async {
                            var authService = Provider.of<AuthService>(context,
                                listen: false);
                            await authService.logout();
                            while (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                            Navigator.of(context).pushNamed(route.loginView);
                          },
                          child: Text("Logout"))
                    ],
                  )),
              Center(
                child: Ciudades(),
              ),
              Center(
                child: Categorias(),
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
