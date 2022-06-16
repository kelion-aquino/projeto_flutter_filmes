import 'package:flutter/material.dart';
import 'package:projeto_final_filmes/database/filme_dao.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'cadastrar_filme.dart';
import '../model/filme.dart';

class ListarFilmes extends StatefulWidget {
  const ListarFilmes({Key? key}) : super(key: key);

  @override
  State<ListarFilmes> createState() => _ListarFilmesState();
}

class _ListarFilmesState extends State<ListarFilmes> {
  List<Filme> filmes = [];
  final FilmeDao _filmeDao = FilmeDao();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: buildAppBar(),
        body: buildBody(context),
        floatingActionButton: buildFloatActionButton(),
      ),
    );
  }

  buildAppBar() {
    return AppBar(
      title: const Text('Listar'),
      actions: [
        IconButton(
          onPressed: () {
            showMyDialog(context);
          },
          icon: const Icon(Icons.info),
        ),
      ],
    );
  }

  void showMyDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Equipe:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Kelion Fernandes'),
              Text('Larissa Dantas'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  buildBody(context) {
    return Container(
      child: FutureBuilder(
          future: Future.delayed(
              const Duration(seconds: 5), () => _filmeDao.findAll()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              filmes = snapshot.data as List<Filme>;
              return ListView.builder(
                itemCount: filmes.length,
                itemBuilder: (context, index) {
                  return buildItemListView(index);
                },
              );
            } else if (!snapshot.hasData) {
              return Text("Banco vazio");
            } else {
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      Text("Loading...")
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  buildItemListView(index) {
    return Dismissible(
      key: Key(filmes[index].id.toString()),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          _filmeDao.delete(index).then((value) => print("deletando: $value"));
          filmes.removeAt(index);
        });
      },
      direction: DismissDirection.endToStart,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    width: 100,
                    height: 150,
                    child: Image.network(filmes[index].imagem),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${filmes[index].titulo}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.normal),
                        ),
                        Text("${filmes[index].genero}"),
                        Text("${filmes[index].duracao} min"),
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: SmoothStarRating(
                            isReadOnly: true,
                            borderColor: Colors.yellow,
                            color: Colors.yellow,
                            // rating: double.parse(filmes[index].pontuacao),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildFloatActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        Filme filme =
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CadastrarFilme();
        }));

        setState(() {
          filmes.add(filme);
        });
      },
      child: const Icon(Icons.add),
    );
  }
}
