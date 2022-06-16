import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'filme_dao.dart';

Future<Database> getDatabase() {
  return getDatabasesPath().then((dataPath) {
    final String path = join(dataPath, "contatos.dart");
    return openDatabase(path, onCreate: (db, version) {
      return db.execute("CREATE TABLE ${FilmeDao.tabelaFilmes} ("
          "${FilmeDao.colunaId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${FilmeDao.colunaImagem} TEXT,"
          "${FilmeDao.colunaTitulo} TEXT,"
          "${FilmeDao.colunaGenero} TEXT,"
          "${FilmeDao.colunaFaixaEtaria} TEXT,"
          "${FilmeDao.colunaDuracao} TEXT,"
          "${FilmeDao.colunaPontuacao} TEXT,"
          "${FilmeDao.colunaDescricao} TEXT,"
          "${FilmeDao.colunaAno} TEXT)");
    }, version: 1);
  });
}
