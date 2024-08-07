class TipoMarcacao {
  final String codigo;
  final String descricao;

  const TipoMarcacao._(this.codigo, this.descricao);

  static const TipoMarcacao ENTRADA = TipoMarcacao._('E', 'Entrada');
  static const TipoMarcacao SAIDA = TipoMarcacao._('S', 'Saída');
}