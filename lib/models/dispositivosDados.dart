class dispDados {
  String codigo = '';

  dispDados({required this.codigo});

  dispDados.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataDisp = new Map<String, dynamic>();
    dataDisp['codigo'] = this.codigo;
    return dataDisp;
  }
}
