class Famdados {
  String nome = '';
  bool adm = false;

  Famdados({required this.nome, required this.adm});

  Famdados.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    adm = json['adm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['adm'] = this.adm;
    return data;
  }
}
