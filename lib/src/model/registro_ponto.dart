class RegistroPonto {
  final DateTime dataHoraRegistroPonto;
  final String tipoRegistro;

  const RegistroPonto(
      {required this.dataHoraRegistroPonto, required this.tipoRegistro});

  factory RegistroPonto.fromJson(Map<String, dynamic> json) {
    if (json['dataHoraRegistroPonto'] is String) {
      return RegistroPonto(
        dataHoraRegistroPonto: DateTime.parse(json['dataHoraRegistroPonto']),
        tipoRegistro: json['tipoRegistro'].toString(),
      );
    } else {
      throw FormatException('Failed to parse registro ponto');
    }
  }
}
