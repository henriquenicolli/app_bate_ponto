class RegistroPonto {
  final DateTime dataHoraRegistroPonto;

  const RegistroPonto({
    required this.dataHoraRegistroPonto,
  });

  factory RegistroPonto.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'dataHoraRegistroPonto': String dataHoraRegistroPonto} => RegistroPonto(
          dataHoraRegistroPonto: DateTime.parse(dataHoraRegistroPonto)),
      _ => throw const FormatException('Failed serialize registro ponto'),
    };
  }
}
