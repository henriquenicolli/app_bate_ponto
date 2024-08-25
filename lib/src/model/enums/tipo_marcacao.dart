class TipoMarcacao {
  final String codigo;
  final String descricao;

  const TipoMarcacao._(this.codigo, this.descricao);

  static const TipoMarcacao ENTRADA = TipoMarcacao._('E', 'Entrada');
  static const TipoMarcacao SAIDA = TipoMarcacao._('S', 'Saída');

  static TipoMarcacao fromString(String codigo) {
    switch (codigo) {
      case 'E' || 'Entrada':
        return ENTRADA;
      case 'S' || 'Saída':
        return SAIDA;
      default:
        throw ArgumentError('Invalid code for TipoMarcacao: $codigo');
    }
  }
}