import 'package:abonet/services/api_service.dart';
import 'package:abonet/services/auth_service.dart';
import 'package:abonet/views/Categorias.dart';
import 'package:abonet/views/chat.dart';
import 'package:abonet/widgets/buildMenuItem.dart';
import 'package:abonet/widgets/expansionFAQ.dart';
import 'package:abonet/views/ciudades.dart';
import 'package:abonet/widgets/abog_info.dart';
import 'package:abonet/widgets/circleTabIndicator.dart';
import 'package:flutter/material.dart';
import 'package:abonet/routes/routes.dart' as route;
import 'package:flutter_svg/svg.dart';
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
  List<ExpansionItem> _faq = [
    ExpansionItem("¿Qué es Abonet?",
        "Abonet es una app que permite al usuario encontrar rápidamente un asesor legal especializado que brinde soluciones a sus consultas legales. Agenda tu cita con el abogado de preferencia"),
    ExpansionItem("¿Cómo funciona?", "Contacta a tu abogado de preferencia"),
    ExpansionItem("¿Cómo seleccionar un asesor jurídico?",
        "Selecciona un asesor de acuerdo a su experiencia y disponibilidad"),
  ];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

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
          drawer: Drawer(
              child: Material(
            color: Theme.of(context).colorScheme.primary,
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 48,
                ),
                buildMenuItem(
                    text: "Home",
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, "Home")),
                const SizedBox(
                  height: 16,
                ),
                buildMenuItem(
                    text: "Chat",
                    icon: Icons.chat_bubble_outline,
                    onClicked: () => selectedItem(context, "Chat")),
                const SizedBox(
                  height: 16,
                ),
                buildMenuItem(
                    text: "Ranking",
                    icon: Icons.leaderboard_outlined,
                    onClicked: () => selectedItem(context, "Ranking")),
                const SizedBox(
                  height: 16,
                ),
                Divider(
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 12,
                ),
                buildMenuItem(
                  text: "Logout",
                  icon: Icons.exit_to_app_outlined,
                  onClicked: () async {
                    var authService =
                        Provider.of<AuthService>(context, listen: false);
                    await authService.logout();
                    while (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    Navigator.of(context).pushNamed(route.loginView);
                  },
                ),
              ],
            ),
          )),
          appBar: AppBar(
            iconTheme:
                IconThemeData(color: Theme.of(context).colorScheme.primary),
            elevation: 0,
            backgroundColor: Colors.white,
            titleSpacing: 0,
            title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Image.asset(
                'lib/images/logo/logo.png',
                fit: BoxFit.fitWidth,
                height: 30,
                width: 30,
              ),
            ]),
            bottom: TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey,
              indicator: CircleTabIndicator(
                color: Theme.of(context).colorScheme.secondary,
                radius: 4,
              ),
              tabs: [
                Tab(text: "Inicio"),
                Tab(text: "Ciudades"),
                Tab(text: "Categorias"),
              ],
            ),
          ),
          body: Container(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bienvenido",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
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
                                    primary:
                                        Theme.of(context).colorScheme.primary,
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

                        Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            width: 6)),
                                  ),
                                  child: Text(
                                    "FAQ",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ))),

                        //Expansion FAQ
                        Expanded(
                          child: ListView(
                            children: [
                              ExpansionPanelList(
                                expandedHeaderPadding: EdgeInsets.all(10),
                                elevation: 0,
                                animationDuration: Duration(milliseconds: 1000),
                                dividerColor:
                                    Theme.of(context).colorScheme.secondary,
                                expansionCallback:
                                    (int index, bool isExpanded) {
                                  setState(() {
                                    _faq[index].isExpanded =
                                        !_faq[index].isExpanded;
                                  });
                                },
                                children: _faq.map((ExpansionItem item) {
                                  return ExpansionPanel(
                                    headerBuilder: (BuildContext context,
                                        bool isExpanded) {
                                      return ListTile(
                                        title: Text(item.header,
                                            style: optionStyle),
                                      );
                                    },
                                    body: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(item.body),
                                    ),
                                    isExpanded: item.isExpanded,
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        ),
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
          ),
        ));
  }
}
