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
            icon: Icon(Icons.search),
          )
        ],
        centerTitle: false,
        title: Text('Próprios PMSCS'),
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

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
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
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: (){
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}