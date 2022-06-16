import 'package:sqflite/sqflite.dart';

import '../model/filme.dart';
import 'database.dart';

class FilmeDao {
  static const String tabelaFilmes = "filmes";
  static const String colunaId = "id";
  static const String colunaImagem = "imagem";
  static const String colunaTitulo = "titulo";
  static const String colunaGenero = "genero";
  static const String colunaFaixaEtaria = "faixa_etaria";
  static const String colunaDuracao = "duracao";
  static const String colunaPontuacao = "pontuacao";
  static const String colunaDescricao = "descricao";
  static const String colunaAno = "ano";

  Future<int> insert(Filme filme) async {
    Database db = await getDatabase();
    return db.insert(tabelaFilmes, filme.toMap());
  }

  Future<List<Filme>> findAll() async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> listMap = await db.query(tabelaFilmes);
    print("caravana do find All: ${listMap.first[colunaPontuacao].toString()}");
    return _toList(listMap);
  }

  Future<int> update(Filme filme) async {
    Database db = await getDatabase();
    return await db.update(
      tabelaFilmes,
      filme.toMap(),
      where: "$colunaId = ?",
      whereArgs: [filme.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await getDatabase();
    return await db.delete(
      tabelaFilmes,
      where: "$colunaId = ?",
      whereArgs: [id],
    );
  }

  Future<Filme?> findById(int id) async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> listMap =
        await db.query(tabelaFilmes, where: '$colunaId = ?', whereArgs: [id]);
    if (listMap.isEmpty) {
      return null;
    }
    Filme contato = Filme(
      listMap.first[colunaImagem].toString(),
      listMap.first[colunaTitulo].toString(),
      listMap.first[colunaGenero].toString(),
      listMap.first[colunaFaixaEtaria].toString(),
      listMap.first[colunaDuracao].toString(),
      listMap.first[colunaPontuacao].toString(),
      listMap.first[colunaDescricao].toString(),
      listMap.first[colunaAno].toString(),
      id: listMap.first[colunaId] as int,
    );
    return contato;
  }

  List<Filme> _toList(List<Map<String, dynamic>> listMap) {
    List<Filme> filmes = [];
    for (Map<String, dynamic> map in listMap) {
      Filme novoFilme = Filme(
        map[colunaImagem],
        map[colunaTitulo],
        map[colunaGenero],
        map[colunaFaixaEtaria],
        map[colunaDuracao],
        map[colunaPontuacao],
        map[colunaDescricao],
        map[colunaAno],
        id: map[colunaId],
      );
      filmes.add(novoFilme);
    }
    return filmes;
  }
}
