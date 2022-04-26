import "package:flutter/material.dart";
import "package:proprios/model/dados.dart";
import 'ui/dado.ui.dart';

class PropriosListView extends StatefulWidget {
  const PropriosListView({Key? key}) : super(key: key);

  @override
  _PropriosListViewState createState() => _PropriosListViewState();
}

class _PropriosListViewState extends State<PropriosListView> {
  final List<Dado> dadoList = Dado.getDados();
  final List<String> lista = Dado.getDescricao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search(lista));
            },
            icon: const Icon(Icons.search),
          )
        ],
        centerTitle: false,
        title: const Text('Próprios PMSCS'),
      ),
      body: ListView.builder(
          itemCount: dadoList.length,
          itemBuilder: (context, int index) {
            return Stack(children: <Widget>[
              dadoCard(dadoList[index], context),
              Positioned(
                top: 20,
                left: 15,
                child: dadoCircle(dadoList[index].unidade.toString()),
              ),
            ]);
          }),
    );
  }

  Widget dadoCard(Dado dado, BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(left: 5.0, right: 5.0),
        width: MediaQuery.of(context).size.width,
        height: 90.0,
        child: Card(
            color: Colors.greenAccent,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, left: 74.0, right: 5.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(dado.descricao,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.black87,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProprioListDetails(
                      dadoNome: dado.unidade,
                      dado: dado,
                    )))
      },
    );
  }

  TextStyle mainTextStyle() {
    return const TextStyle(fontSize: 15.0, color: Colors.teal);
  }

  Widget dadoCircle(String unidade) {
    return InkWell(
        child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.teal,
            ),
            child: Center(
              child: Text(
                unidade,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700),
              ),
            )));
  }
}

class Search extends SearchDelegate implements Dado {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  String get searchFieldLabel => 'Pesquisar...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
        ),
        textTheme: const TextTheme(
            headline6: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        )));
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    List<Dado> result = dadoList1;
    int index = getDadoFromIndex(selectedResult)!;
    if (index != 999) {
      return ListView(children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: <Widget>[
              const HorizontalLine(),
              ProprioField(
                  field: "Código da Unidade: ", value: result[index].unidade),
              const HorizontalLine(),
              ProprioField(field: "Próprio: ", value: result[index].descricao),
              const HorizontalLine(),
              ProprioField(
                  field: "Rede de Dados: ", value: result[index].redeDados),
              const HorizontalLine(),
              ProprioField(
                  field: "Vlan de Dados:", value: result[index].vlanDados),
              const HorizontalLine(),
              ProprioField(
                  field: "Rede de Voz: ", value: result[index].redeVoz),
              const HorizontalLine(),
              ProprioField(
                  field: "Vlan de Voz: ", value: result[index].vlanVoz),
              const HorizontalLine(),
              ProprioField(
                  field: "Rede WifiAdm: ", value: result[index].redeWifiadm),
              const HorizontalLine(),
              ProprioField(
                  field: "Vlan WifiAdm: ", value: result[index].vlanWifiadm),
              const HorizontalLine(),
              ProprioField(
                  field: "Rede Pedagógica: ",
                  value: result[index].redePedagogica),
              const HorizontalLine(),
              ProprioField(
                  field: "Vlan Pedagógica: ",
                  value: result[index].vlanPedagogica),
              const HorizontalLine(),
              ProprioField(
                  field: "IP Gerência Switch: ",
                  value: result[index].ipGerenciaSwitch),
              const HorizontalLine(),
              ProprioField(
                  field: "IP Gerência ONU: ",
                  value: result[index].ipGerenciaOnu),
              const HorizontalLine(),
              ProprioField(field: "OLT: ", value: result[index].olt),
              const HorizontalLine(),
              ProprioField(
                  field: "Observação: ", value: result[index].observacao),
              const HorizontalLine(),
            ]))
      ]);
    } else {
      return const Center(child: Text("Não encontrado..."));
    }
  }

  final List<String> listExample;

  Search(this.listExample);

  List<String> recentList = [" "];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
            // In the false case
            (element) => element.contains(query.toUpperCase()),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? const SizedBox() : const SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }

  @override
  String dataAtivacao = "";
  @override
  String descricao = "";
  @override
  String dominio = "";
  @override
  String fileserver = "";
  @override
  String hostname = "";
  @override
  String ipGerenciaOnu = "";
  @override
  String ipGerenciaSwitch = "";
  @override
  String observacao = "";
  @override
  String olt = "";
  @override
  String redeDados = "";
  @override
  String redePedagogica = "";
  @override
  String redeVoz = "";
  @override
  String redeWifiadm = "";
  @override
  String statusAtivacao = "";
  @override
  String unidade = "";
  @override
  String vlanDados = "";
  @override
  String vlanPedagogica = "";
  @override
  String vlanVoz = "";
  @override
  String vlanWifiadm = "";

  final List<Dado> dadoList1 = Dado.getDados();

  int? getDadoFromIndex(String selectedResult) {
    var selectedResult1 = " ";
    if (selectedResult.length > 3) {
      int s = selectedResult.indexOf(':');
      selectedResult1 = selectedResult.substring(0, s);
    } else {
      selectedResult1 = "umapinoia";
    }
    int retorno = 999;
    for (int i = 0; i < dadoList1.length; i++) {
      if (dadoList1[i].descricao.toUpperCase() ==
          selectedResult1.toUpperCase()) {
        retorno = i;
      }
    }
    return retorno;
  }
}
