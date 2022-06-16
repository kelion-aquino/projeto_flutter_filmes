import '../database/filme_dao.dart';

class Filme {
  int id;
  String imagem;
  String titulo;
  String genero;
  String faixaEtaria;
  // double duracao;
  String duracao;
  // double pontuacao;
  String pontuacao;
  String descricao;
  // int ano;
  String ano;

  Filme(this.imagem, this.titulo, this.genero, this.faixaEtaria, this.duracao,
      this.pontuacao, this.descricao, this.ano,
      {this.id = 0});

  Map<String, dynamic> toMap() {
    return {
      FilmeDao.colunaImagem: imagem,
      FilmeDao.colunaTitulo: titulo,
      FilmeDao.colunaGenero: genero,
      FilmeDao.colunaFaixaEtaria: faixaEtaria,
      FilmeDao.colunaDuracao: duracao,
      FilmeDao.colunaPontuacao: pontuacao,
      FilmeDao.colunaDescricao: descricao,
      FilmeDao.colunaAno: ano
    };
  }
}
