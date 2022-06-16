import 'package:flutter/material.dart';
import 'package:projeto_final_filmes/database/filme_dao.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../model/filme.dart';

class CadastrarFilme extends StatefulWidget {
  const CadastrarFilme({Key? key}) : super(key: key);

  @override
  State<CadastrarFilme> createState() => _CadastrarFilmeState();
}

class _CadastrarFilmeState extends State<CadastrarFilme> {
  TextEditingController edtImagem = TextEditingController();
  TextEditingController edtTitulo = TextEditingController();
  TextEditingController edtGenero = TextEditingController();
  TextEditingController edtFaixaEtaria = TextEditingController();
  TextEditingController edtDuracao = TextEditingController();
  double rating = 0.0;
  TextEditingController edtDescricao = TextEditingController();
  TextEditingController edtAno = TextEditingController();

  final _key = GlobalKey<FormState>();
  String dropdownValue = 'Livre';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: buildFloatActionButton(context),
    );
  }

  buildAppBar() {
    return AppBar(
      title: const Text('Cadastrar Filme'),
    );
  }

  buildBody() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: edtImagem,
                decoration: const InputDecoration(
                  labelText: "Url Imagem",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: edtTitulo,
                  decoration: const InputDecoration(
                    labelText: "Título",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: edtGenero,
                  decoration: const InputDecoration(
                    labelText: "Gênero",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text("Faixa Etária: ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        )),
                    DropdownClassificacao(),
                  ],
                ),
              ),
              TextFormField(
                controller: edtDuracao,
                decoration: const InputDecoration(
                  labelText: "Duração",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Nota: ",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16)),
                    SmoothStarRating(
                        rating: rating,
                        starCount: 5,
                        onRated: (value) {
                          setState(() {
                            rating = value;
                          });
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: edtAno,
                  decoration: const InputDecoration(
                    labelText: "Ano",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: edtDescricao,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: "Descrição",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildFloatActionButton(context) {
    return FloatingActionButton(
      onPressed: () {
        cadastrarFilme(context);
      },
      child: const Icon(Icons.save),
    );
  }

  void cadastrarFilme(context) {
    Filme filme = Filme(
      edtImagem.text,
      edtTitulo.text,
      edtGenero.text,
      "Livre",
      edtDuracao.text,
      rating.toString(),
      edtDescricao.text,
      edtAno.text,
    );

    if (edtImagem.text.isEmpty) {
      alertDialogValidation("Informe a url da imagem", context);
      return;
    }
    if (edtTitulo.text.isEmpty) {
      alertDialogValidation("Informe o título do filme", context);
      return;
    }
    if (edtGenero.text.isEmpty) {
      alertDialogValidation("Informe o gênero do filme", context);
      return;
    }
    // if (edtFaixaEtaria.text.isEmpty) {
    //   alertDialogValidation("Informe a faixa etária do filme", context);
    //   return;
    // }
    if (edtDuracao.text.isEmpty) {
      alertDialogValidation("Informe a duração do filme", context);
      return;
    }
    if (edtDescricao.text.isEmpty) {
      alertDialogValidation("Informe a descrição do filme", context);
      return;
    }
    if (edtAno.text.isEmpty) {
      alertDialogValidation("Informe o ano do filme", context);
      return;
    }

    FilmeDao _filmeDao = FilmeDao();
    _filmeDao.insert(filme).then((value) => print("Inserindo: $value"));

    Navigator.pop(context, filme);
  }

  void alertDialogValidation(String s, context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Verificação"),
            content: Text(s),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok")),
            ],
          );
        });
  }
}

class DropdownClassificacao extends StatefulWidget {
  const DropdownClassificacao({Key? key}) : super(key: key);

  @override
  State<DropdownClassificacao> createState() => _DropdownClassificacaoState();
}

class _DropdownClassificacaoState extends State<DropdownClassificacao> {
  String dropdownValue = 'Livre';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 1,
        underline: Container(
          height: 0,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['Livre', '10', '12', '14', '16', '18']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
