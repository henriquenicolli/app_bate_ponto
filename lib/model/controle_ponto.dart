class ControlePonto {
  final DateTime dataHoraRegistroPonto;

  const ControlePonto({
    required this.dataHoraRegistroPonto,
  });

  factory ControlePonto.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'dataHoraRegistroPonto': String dataHoraRegistroPonto} => ControlePonto(
          dataHoraRegistroPonto: DateTime.parse(dataHoraRegistroPonto)),
      _ => throw const FormatException('Failed serialize espelho ponto'),
    };
  }
}
