import 'package:flutter/material.dart';
import 'package:abonet/routes/routes.dart' as route;
import 'package:flutter/services.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "Inicio",
            ),
            Tab(
              text: "Ciudades",
            ),
            Tab(
              text: "Categoria",
            ),
          ],
        ),
      ),
      /*body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, route.loginView),
                child: Text("login")),
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, route.categoriasView),
                child: Text("Categorias")),
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, route.rankingsView),
                child: Text("Rankings")),
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, route.ciudadesView),
                child: Text("Ciudades"))
          ],
        ),
      ),*/
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, route.loginView),
                    child: Text("login")),
                ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, route.categoriasView),
                    child: Text("Categorias")),
                ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, route.rankingsView),
                    child: Text("Rankings")),
                ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, route.ciudadesView),
                    child: Text("Ciudades"))
              ],
            ),
          ),
          Center(
            child: Text("Ciudades"),
          ),
          Center(
            child: Text("Categoria"),
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
          onTap: (index) => setState(() => {_selectedIndex = index}),
          selectedItemColor: Colors.amber[
              800]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
