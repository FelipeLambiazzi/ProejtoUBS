DROP DATABASE IF EXISTS sistema_ubs;
CREATE DATABASE sistema_ubs;
use sistema_ubs;

DROP TABLE IF EXISTS MEDICACAO;
CREATE TABLE MEDICACAO (
  medicacao_id int primary key auto_increment,
  nome varchar(20),
  quantidade float(3,2),
  qtd_comprimidos int
)engine=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

DROP TABLE IF EXISTS PRODUTO;
CREATE TABLE PRODUTO (
  produto_id int primary key auto_increment,
  data_validade date,
  quantidade int,
  dimensao int,
  peso float,
  valor float,
  lote varchar(20)
)engine=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

DROP TABLE IF EXISTS PERMISSAO;
CREATE TABLE PERMISSAO (
  permissao_id int primary key auto_increment,
  permissao varchar(20)
)engine=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

DROP TABLE IF EXISTS FUNCIONARIO;
CREATE TABLE FUNCIONARIO (
  funcionario_id int primary key auto_increment,
  login varchar(20),
  senha varchar(20),
  acesso varchar(20),
  permissao_fk int,
  Foreign key (permissao_fk) references PERMISSAO(permissao_id)
)engine=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

DROP TABLE IF EXISTS VACINAS;
CREATE TABLE VACINAS (
  vacinas_id int primary key auto_increment,
  nome varchar(20),
  funcionario_fk int,
  lote varchar(10),
  data date,
  nivel_dose varchar(20),
  validade date,
  Foreign key (funcionario_fk) references FUNCIONARIO(funcionario_id)
)engine=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

DROP TABLE IF EXISTS PRONTUARIO;
CREATE TABLE PRONTUARIO (
  prontuario_id int primary key auto_increment,
  cod_ficha varchar(20),
  vacinas_fk int,
  medicacao_fk int,
  Foreign key (vacinas_fk) references VACINAS(vacinas_id),
  Foreign key (medicacao_fk) references MEDICACAO(medicacao_id)
)engine=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

DROP TABLE IF EXISTS TES;
CREATE TABLE TES (
  tes_id int primary key auto_increment,
  data_envio date,
  data_entrega date,
  empresa varchar(20),
  produto_fk int,
  ubs_fk int,
  Foreign key (produto_fk) references PRODUTO(produto_id)
)engine=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

DROP TABLE IF EXISTS UBS;
CREATE TABLE UBS (
  ubs_id int primary key auto_increment,
  nome varchar(20),
  endereco varchar(20),
  lotacao int,
  funcionario_fk int,
  tes_fk int,
  Foreign key (funcionario_fk) references FUNCIONARIO(funcionario_id),
  Foreign key (tes_fk) references TES(tes_id)
)engine=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

DROP TABLE IF EXISTS PACIENTE;
CREATE TABLE PACIENTE (
  paciente_id int primary key auto_increment,
  nome varchar(20),
  data_nasc date,
  cpf varchar(20),
  sus varchar(20),
  rg varchar(20)
)engine=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

DROP TABLE IF EXISTS MEDICO;
CREATE TABLE MEDICO (
  medico_id int primary key auto_increment,
  login_crm varchar(20),
  senha varchar(20),
  especialidade varchar(20)
)engine=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

DROP TABLE IF EXISTS CONSULTAS;
CREATE TABLE CONSULTAS (
  consultas_id int primary key auto_increment,
  data_agendamento datetime,
  paciente_fk int,
  medico_fk int,
  funcionario_fk int,
  ubs_fk int,
  Foreign key (paciente_fk) references PACIENTE(paciente_id),
  Foreign key (medico_fk) references MEDICO(medico_id),
  Foreign key (funcionario_fk) references FUNCIONARIO(funcionario_id),
  Foreign key (ubs_fk) references UBS(ubs_id)
)engine=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;