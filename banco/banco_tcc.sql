create database tests_tcc;
use tests_tcc;

	CREATE TABLE licencas (
		id INT AUTO_INCREMENT PRIMARY KEY,
		token VARCHAR(512) NOT NULL,
		email VARCHAR(255),
		instituicao INT DEFAULT NULL,
		tipo_licenca VARCHAR(50),
		status ENUM('ativa','inativa') DEFAULT 'ativa',
		usado TINYINT(1) DEFAULT 0,
		criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		expira_em TIMESTAMP NULL
	);
    
    select * from licencas;
    
	create table instituicao (
		id int primary key auto_increment,
        nome varchar(100) not null,
        CEP VARCHAR(12) not null,
        logradouro text not null,
        cidade VARCHAR(60) not null,
        bairro varchar(50) not null,
        cnpj varchar(20) UNIQUE NOT NULL,
        tipo ENUM('publico', 'privado', 'filantropico') not null,
        telefone varchar(25) not null,
        email varchar(155) not null,
        site text not null,
        atividade ENUM('ativo', 'inativo') default 'ativo',
        nome_responsavel varchar(100) not null,
        telefone_responsavel varchar(20) not null
    );
    
    select * from instituicao;

	create table adm (
		id int primary key auto_increment,
        id_instituicao int not null,
        foreign key (id_instituicao) references instituicao(id) ON DELETE CASCADE,
		nome varchar(150) not null,
		email varchar(150) not null UNIQUE,
		senha varchar(255) not null
	);

	select * from adm;

	CREATE TABLE medico (
		id int PRIMARY KEY auto_increment, 
		id_instituicao int not null,
        foreign key (id_instituicao) references instituicao(id) ON DELETE CASCADE,
		cpf VARCHAR(11) not null UNIQUE,
		crm VARCHAR(11) not null,
		email VARCHAR(100) not null,
		senha VARCHAR(50) not null,
		nome VARCHAR(100) NOT NULL
	);
    
    select * from medico;

	CREATE TABLE paciente (
		id INT PRIMARY KEY auto_increment,
        id_instituicao int not null,
        foreign key (id_instituicao) references instituicao(id) ON DELETE CASCADE,
		cpf varchar(11) not null,
		nome varchar(100) not null,
		sexo varchar(1),
		endereco text,
		telefone varchar(50) not null,
		email varchar(255) not null,
		profissao varchar(255),
		estado_civil varchar(50),
		nome_cuidador varchar(100),
		telefone_cuidador varchar(50)    
	);
		
        
        
	CREATE TABLE diagnostico (
		id_table int primary key auto_increment,
		id_paciente int,
		data_diagnostico date,
		tipo_em varchar(5),
		surtos text,
		foreign key (id_paciente) references paciente(id) ON DELETE CASCADE
	);    

select * from diagnostico;

	create table sintomas (
		id_table int primary key auto_increment,
		id_paciente int,
		sintomas_iniciais text,
		sintomas_atuais text,
		fadiga bool,
		problema_visao varchar(100),
		problema_equilibrio bool,
		problema_coordenacao bool,
		espaticidade bool,
		fraqueza_muscular bool,
		problema_sensibilidade varchar(100),
		problema_bexiga bool,
		problema_intestino bool,
		problema_cognitivo varchar(255),
		problema_emocional VARCHAR(255),
		foreign key (id_paciente) references paciente(id) ON DELETE CASCADE
	);

select * from sintomas;

	create table historico_medico (
		id_table int primary key auto_increment,
		id_paciente int,
		medicamento_em_uso text,
		tratamentos_anteriores_em text,
		alergias text,
		historico_outras_doencas text,
		historico_familiar text,
		foreign key (id_paciente) references paciente(id) ON DELETE CASCADE
	);
			
	create table historico_social (
		id_table int primary key auto_increment,
		id_paciente int,
		tabagismo varchar(50),
		alcool varchar(100),
		atividade_fisica text,
		suporte_social text,
		impacto_profissional_social text,
		foreign key (id_paciente) references paciente(id) ON DELETE CASCADE
	);  

	create table qualidade_vida_em (
		id_table int primary key auto_increment,
		id_paciente int,
		edss float, 
		questionario_msqol54 text,
		outras_avaliacoes text,
		foreign key (id_paciente) references paciente(id) ON DELETE CASCADE
	);
	  
	create table exame_fisico (
		id_table int primary key auto_increment,
		id_paciente int,
		exame_neurologico text,
		forca_muscular text, 
		reflexos text,
		coordenacao text, 
		sensibilidade text,
		equilibrio text,
		funcao_visual text,
		outros_exames_fisicos text,
		foreign key (id_paciente) references paciente(id) ON DELETE CASCADE
	);

	create table exames_complementares (
		id_table int primary key auto_increment,
		id_paciente int,
		rm_cerebro_medula text,
		potenciais_evocados_visuais text,
		potenciais_evocados_somatossensoriais text,
		potenciais_evocados_auditivos_de_tronco_encefálico text,
		análise_do_líquido_cefalorraquidiano text,
		outros_exames text,
		foreign key (id_paciente) references paciente(id) ON DELETE CASCADE
	);
	  
	create table plano_tratamento (
		id_table int primary key auto_increment,
		id_paciente int,
		medicamentos_modificadores__doença text,
		tratamnto_surtos text,
		tratamento_sintomas text, 
		reabilitacao text,
		acompanhamento_psicologico text,
		outras_terapias text,
		foreign key (id_paciente) references paciente(id) ON DELETE CASCADE
	);  
	  
	  create table ia_results (
		id_table int primary key auto_increment,
		id_paciente int,
		nome varchar(150),
		cpf varchar(20),
		imagem longtext, 
		diagnostico text,
		data_diagnostico date,

		foreign key (id_paciente) references paciente(id) ON DELETE CASCADE
	);  
	  
      select * from ia_results;
      
	CREATE TABLE relacao_medico_paciente (
    id_table INT PRIMARY KEY AUTO_INCREMENT,
    id_medico INT NULL,
    id_paciente INT NOT NULL,
    UNIQUE (id_medico, id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medico(id) ON DELETE SET NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id) ON DELETE CASCADE
);

select * from relacao_medico_paciente;
    
CREATE TABLE mensagens_chat (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_instituicao int not null,
  cpf_medico VARCHAR(11) not null,
  mensagem TEXT NOT NULL,
  origem ENUM('medico', 'adm') NOT NULL,
  data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lida BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (cpf_medico) REFERENCES medico(cpf) ON DELETE CASCADE
);

INSERT INTO instituicao (
    nome, CEP, logradouro, cidade, bairro, cnpj, tipo, telefone, email, site, nome_responsavel, telefone_responsavel
) VALUES
('Hospital São Lucas', '12245-000', 'Av. São José, 123', 'São José dos Campos', 'Centro', '12.345.678/0001-99', 'privado', '(12) 3921-2233', 'contato@saolucas.com', 'www.saolucas.com', 'Dra. Maria Costa',
	'(12) 99123-4567');


INSERT INTO licencas (
    token, email, instituicao, tipo_licenca, status, usado, expira_em
) VALUES
('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdCIsInN1YiI6ImFjZXNzb19zaXN0ZW1hIiwiaWF0IjoxNzYwMzU5MTQ2LCJleHAiOjE3OTE0NjMxNDYsIm5iZiI6MTc2MDM1OTE0NiwianRpIjoiM2QyZjQ3ZmRhYTU0YTdjODc4YjlhY2JiYmVkMzM0YWUiLCJlbWFpbCI6IlN0YW5sZWVAZ21haWwuY29tIiwidGlwb19saWNlbmNhIjoiYW51YWwiLCJzdGF0dXMiOiJhdGl2YSIsImNoYXZlX3VuaWNhIjoibGljXzY4ZWNmMmVhYmI3ZjY0Ljg2ODUzNzM4IiwidXNhZG8iOmZhbHNlLCJpZF9pbnN0aXR1aWNhbyI6bnVsbH0.1rMZBuFot8lYHBMrwb3erSVLrrqm4R9v3ZlA-kWCbBQ'
	, 'admin@saolucas.com', 1, 'profissional', 'ativa', 1, '2026-10-13 00:00:00');

# INSERT #
    
-- INSERTS ADM -- 

INSERT INTO instituicao (nome, CEP, logradouro, cidade, bairro, cnpj, tipo, telefone, email, site, atividade, nome_responsavel, telefone_responsavel)
VALUES
('Hospital Santa Luzia', '01311000', 'Av. Paulista, 1000', 'São Paulo', 'Bela Vista', '12345678000101', 'privado', '(11) 3234-1000', 'contato@santaluzia.com.br', 'www.santaluzia.com.br', 'ativo', 
'Dr. Marcos Almeida', '(55) 12 996789101');


INSERT INTO adm (id_instituicao, nome, email, senha) VALUES 
(1, 'adm1', 'adm1@gmail.com', MD5('adm01')),
(1, 'adm2', 'adm2@gmail.com', MD5('adm02')),
(1, 'adm3', 'adm3@gmail.com', MD5('adm03')),
(1, 'adm4', 'adm4@gmail.com', MD5('adm04')),
(1, 'adm5', 'adm5@gmail.com', MD5('adm05')),
(1, 'adm6', 'adm6@gmail.com', MD5('adm06')),
(1, 'adm7', 'adm7@gmail.com', MD5('adm07')),
(1, 'adm8', 'adm8@gmail.com', MD5('adm08')),
(1, 'adm9', 'adm9@gmail.com', MD5('adm09')),
(1, 'adm10', 'adm10@gmail.com', MD5('adm10')),
(1, 'adm11', 'adm11@gmail.com', MD5('adm11')),
(1, 'adm12', 'adm12@gmail.com', MD5('adm12')),
(1, 'adm13', 'adm13@gmail.com', MD5('adm13')),
(1, 'adm14', 'adm14@gmail.com', MD5('adm14')),
(1, 'adm15', 'adm15@gmail.com', MD5('adm15')),
(1, 'adm16', 'adm16@gmail.com', MD5('adm16')),
(1, 'adm17', 'adm17@gmail.com', MD5('adm17')),
(1, 'adm18', 'adm18@gmail.com', MD5('adm18')),
(1, 'adm19', 'adm19@gmail.com', MD5('adm19')),
(1, 'adm20', 'adm20@gmail.com', MD5('adm20')),
(1, 'adm21', 'adm21@gmail.com', MD5('adm21')),
(1, 'adm22', 'adm22@gmail.com', MD5('adm22')),
(1, 'adm23', 'adm23@gmail.com', MD5('adm23')),
(1, 'adm24', 'adm24@gmail.com', MD5('adm24')),
(1, 'adm25', 'adm25@gmail.com', MD5('adm25')),
(1, 'adm26', 'adm26@gmail.com', MD5('adm26')),
(1, 'adm27', 'adm27@gmail.com', MD5('adm27')),
(1, 'adm28', 'adm28@gmail.com', MD5('adm28')),
(1, 'adm29', 'adm29@gmail.com', MD5('adm29')),
(1, 'adm30', 'adm30@gmail.com', MD5('adm30')),
(1, 'adm31', 'adm31@gmail.com', MD5('adm31')),
(1, 'adm32', 'adm32@gmail.com', MD5('adm32')),
(1, 'adm33', 'adm33@gmail.com', MD5('adm33')),
(1, 'adm34', 'adm34@gmail.com', MD5('adm34')),
(1, 'adm35', 'adm35@gmail.com', MD5('adm35')),
(1, 'adm36', 'adm36@gmail.com', MD5('adm36')),
(1, 'adm37', 'adm37@gmail.com', MD5('adm37')),
(1, 'adm38', 'adm38@gmail.com', MD5('adm38')),
(1, 'adm39', 'adm39@gmail.com', MD5('adm39')),
(1, 'adm40', 'adm40@gmail.com', MD5('adm40')),
(1, 'adm41', 'adm41@gmail.com', MD5('adm41')),
(1, 'adm42', 'adm42@gmail.com', MD5('adm42')),
(1, 'adm43', 'adm43@gmail.com', MD5('adm43')),
(1, 'adm44', 'adm44@gmail.com', MD5('adm44')),
(1, 'adm45', 'adm45@gmail.com', MD5('adm45')),
(1, 'adm46', 'adm46@gmail.com', MD5('adm46')),
(1, 'adm47', 'adm47@gmail.com', MD5('adm47')),
(1, 'adm48', 'adm48@gmail.com', MD5('adm48')),
(1, 'adm49', 'adm49@gmail.com', MD5('adm49')),
(1, 'adm50', 'adm50@gmail.com', MD5('adm50'));

Select * from adm;
-- INSERT MÉDICOS --

INSERT INTO medico (id_instituicao, cpf, crm, email, senha, nome) VALUES
(1, '11111111111', 'CRM000001', 'medico1@gmail.com', MD5('med01'), 'Dr. Médico 1'),
(1, '11111111112', 'CRM000002', 'medico2@gmail.com', MD5('med02'), 'Dr. Médico 2'),
(1, '11111111113', 'CRM000003', 'medico3@gmail.com', MD5('med03'), 'Dr. Médico 3'),
(1, '11111111114', 'CRM000004', 'medico4@gmail.com', MD5('med04'), 'Dr. Médico 4'),
(1, '11111111115', 'CRM000005', 'medico5@gmail.com', MD5('med05'), 'Dr. Médico 5'),
(1, '11111111116', 'CRM000006', 'medico6@gmail.com', MD5('med06'), 'Dr. Médico 6'),
(1, '11111111117', 'CRM000007', 'medico7@gmail.com', MD5('med07'), 'Dr. Médico 7'),
(1, '11111111118', 'CRM000008', 'medico8@gmail.com', MD5('med08'), 'Dr. Médico 8'),
(1, '11111111119', 'CRM000009', 'medico9@gmail.com', MD5('med09'), 'Dr. Médico 9'),
(1, '11111111120', 'CRM000010', 'medico10@gmail.com', MD5('med10'), 'Dr. Médico 10'),
(1, '11111111121', 'CRM000011', 'medico11@gmail.com', MD5('med11'), 'Dr. Médico 11'),
(1, '11111111122', 'CRM000012', 'medico12@gmail.com', MD5('med12'), 'Dr. Médico 12'),
(1, '11111111123', 'CRM000013', 'medico13@gmail.com', MD5('med13'), 'Dr. Médico 13'),
(1, '11111111124', 'CRM000014', 'medico14@gmail.com', MD5('med14'), 'Dr. Médico 14'),
(1, '11111111125', 'CRM000015', 'medico15@gmail.com', MD5('med15'), 'Dr. Médico 15'),
(1, '11111111126', 'CRM000016', 'medico16@gmail.com', MD5('med16'), 'Dr. Médico 16'),
(1, '11111111127', 'CRM000017', 'medico17@gmail.com', MD5('med17'), 'Dr. Médico 17'),
(1, '11111111128', 'CRM000018', 'medico18@gmail.com', MD5('med18'), 'Dr. Médico 18'),
(1, '11111111129', 'CRM000019', 'medico19@gmail.com', MD5('med19'), 'Dr. Médico 19'),
(1, '11111111130', 'CRM000020', 'medico20@gmail.com', MD5('med20'), 'Dr. Médico 20'),
(1, '11111111131', 'CRM000021', 'medico21@gmail.com', MD5('med21'), 'Dr. Médico 21'),
(1, '11111111132', 'CRM000022', 'medico22@gmail.com', MD5('med22'), 'Dr. Médico 22'),
(1, '11111111133', 'CRM000023', 'medico23@gmail.com', MD5('med23'), 'Dr. Médico 23'),
(1, '11111111134', 'CRM000024', 'medico24@gmail.com', MD5('med24'), 'Dr. Médico 24'),
(1, '11111111135', 'CRM000025', 'medico25@gmail.com', MD5('med25'), 'Dr. Médico 25'),
(1, '11111111136', 'CRM000026', 'medico26@gmail.com', MD5('med26'), 'Dr. Médico 26'),
(1, '11111111137', 'CRM000027', 'medico27@gmail.com', MD5('med27'), 'Dr. Médico 27'),
(1, '11111111138', 'CRM000028', 'medico28@gmail.com', MD5('med28'), 'Dr. Médico 28'),
(1, '11111111139', 'CRM000029', 'medico29@gmail.com', MD5('med29'), 'Dr. Médico 29'),
(1, '11111111140', 'CRM000030', 'medico30@gmail.com', MD5('med30'), 'Dr. Médico 30'),
(1, '11111111141', 'CRM000031', 'medico31@gmail.com', MD5('med31'), 'Dr. Médico 31'),
(1, '11111111142', 'CRM000032', 'medico32@gmail.com', MD5('med32'), 'Dr. Médico 32'),
(1, '11111111143', 'CRM000033', 'medico33@gmail.com', MD5('med33'), 'Dr. Médico 33'),
(1, '11111111144', 'CRM000034', 'medico34@gmail.com', MD5('med34'), 'Dr. Médico 34'),
(1, '11111111145', 'CRM000035', 'medico35@gmail.com', MD5('med35'), 'Dr. Médico 35'),
(1, '11111111146', 'CRM000036', 'medico36@gmail.com', MD5('med36'), 'Dr. Médico 36'),
(1, '11111111147', 'CRM000037', 'medico37@gmail.com', MD5('med37'), 'Dr. Médico 37'),
(1, '11111111148', 'CRM000038', 'medico38@gmail.com', MD5('med38'), 'Dr. Médico 38'),
(1, '11111111149', 'CRM000039', 'medico39@gmail.com', MD5('med39'), 'Dr. Médico 39'),
(1, '11111111150', 'CRM000040', 'medico40@gmail.com', MD5('med40'), 'Dr. Médico 40'),
(1, '11111111151', 'CRM000041', 'medico41@gmail.com', MD5('med41'), 'Dr. Médico 41'),
(1, '11111111152', 'CRM000042', 'medico42@gmail.com', MD5('med42'), 'Dr. Médico 42'),
(1, '11111111153', 'CRM000043', 'medico43@gmail.com', MD5('med43'), 'Dr. Médico 43'),
(1, '11111111154', 'CRM000044', 'medico44@gmail.com', MD5('med44'), 'Dr. Médico 44'),
(1, '11111111155', 'CRM000045', 'medico45@gmail.com', MD5('med45'), 'Dr. Médico 45'),
(1, '11111111156', 'CRM000046', 'medico46@gmail.com', MD5('med46'), 'Dr. Médico 46'),
(1, '11111111157', 'CRM000047', 'medico47@gmail.com', MD5('med47'), 'Dr. Médico 47'),
(1, '11111111158', 'CRM000048', 'medico48@gmail.com', MD5('med48'), 'Dr. Médico 48'),
(1, '11111111159', 'CRM000049', 'medico49@gmail.com', MD5('med49'), 'Dr. Médico 49'),
(1, '11111111160', 'CRM000050', 'medico50@gmail.com', MD5('med50'), 'Dr. Médico 50');

Select * from medico;
SELECT COUNT(*) as total FROM medico WHERE id_instituicao = 1;
-- INSERT PACIENTES --

INSERT INTO paciente (id_instituicao, cpf, nome, sexo, endereco, telefone, email, profissao, estado_civil, nome_cuidador, telefone_cuidador) VALUES
(1,'11111111111','Ana Silva','F','Rua das Flores, 10','11990010001','ana.silva1@gmail.com','Professora','Solteira','Maria Silva','11988880001'),
(1,'11111111112','Bruno Santos','M','Av. Paulista, 200','11990010002','bruno.santos2@gmail.com','Engenheiro','Casado','Carlos Santos','11988880002'),
(1,'11111111113','Carla Oliveira','F','Rua Verde, 300','11990010003','carla.oliveira3@gmail.com','Enfermeira','Solteira','João Oliveira','11988880003'),
(1,'11111111114','Diego Souza','M','Rua Azul, 45','11990010004','diego.souza4@gmail.com','Analista','Casado','Marina Souza','11988880004'),
(1,'11111111115','Elisa Costa','F','Av. Central, 55','11990010005','elisa.costa5@gmail.com','Dentista','Solteira','Pedro Costa','11988880005'),
(1,'11111111116','Fernando Lima','M','Rua das Laranjeiras, 12','11990010006','fernando.lima6@gmail.com','Médico','Casado','Paula Lima','11988880006'),
(1,'11111111117','Gabriela Rocha','F','Rua Amarela, 78','11990010007','gabriela.rocha7@gmail.com','Advogada','Divorciada','Roberto Rocha','11988880007'),
(1,'11111111118','Henrique Alves','M','Rua Nova, 15','11990010008','henrique.alves8@gmail.com','Administrador','Casado','Sônia Alves','11988880008'),
(1,'11111111119','Isabela Martins','F','Rua Bela Vista, 40','11990010009','isabela.martins9@gmail.com','Arquiteta','Solteira','Patrícia Martins','11988880009'),
(1,'11111111120','João Pereira','M','Av. Brasil, 500','11990010010','joao.pereira10@gmail.com','Motorista','Casado','Fernanda Pereira','11988880010'),
(1,'11111111121','Karla Fernandes','F','Rua Rio Branco, 60','11990010011','karla.fernandes11@gmail.com','Psicóloga','Solteira','Cláudia Fernandes','11988880011'),
(1,'11111111122','Lucas Oliveira','M','Rua do Sol, 35','11990010012','lucas.oliveira12@gmail.com','Programador','Solteiro','Patrícia Oliveira','11988880012'),
(1,'11111111123','Mariana Silva','F','Rua da Paz, 72','11990010013','mariana.silva13@gmail.com','Estudante','Solteira','Helena Silva','11988880013'),
(1,'11111111124','Nicolas Souza','M','Rua da Serra, 100','11990010014','nicolas.souza14@gmail.com','Mecânico','Casado','Ana Souza','11988880014'),
(1,'11111111125','Olívia Castro','F','Rua das Hortas, 88','11990010015','olivia.castro15@gmail.com','Designer','Solteira','Luciana Castro','11988880015'),
(1,'11111111126','Paulo Mendes','M','Rua das Palmeiras, 9','11990010016','paulo.mendes16@gmail.com','Professor','Casado','Cíntia Mendes','11988880016'),
(1,'11111111127','Queila Barbosa','F','Rua Marrom, 77','11990010017','queila.barbosa17@gmail.com','Veterinária','Solteira','Regina Barbosa','11988880017'),
(1,'11111111128','Rafael Teixeira','M','Rua das Acácias, 55','11990010018','rafael.teixeira18@gmail.com','Engenheiro Civil','Casado','Sara Teixeira','11988880018'),
(1,'11111111129','Sabrina Dias','F','Av. Leste, 12','11990010019','sabrina.dias19@gmail.com','Farmacêutica','Solteira','Paulo Dias','11988880019'),
(1,'11111111130','Tiago Nunes','M','Rua Oeste, 40','11990010020','tiago.nunes20@gmail.com','Consultor','Casado','Denise Nunes','11988880020'),
(1,'11111111131','Ursula Freitas','F','Rua Jardim, 101','11990010021','ursula.freitas21@gmail.com','Bióloga','Casada','Renato Freitas','11988880021'),
(1,'11111111132','Victor Cardoso','M','Av. Norte, 300','11990010022','victor.cardoso22@gmail.com','Eletricista','Casado','Carla Cardoso','11988880022'),
(1,'11111111133','Wesley Andrade','M','Rua Sul, 25','11990010023','wesley.andrade23@gmail.com','Empresário','Casado','Débora Andrade','11988880023'),
(1,'11111111134','Xênia Torres','F','Rua Alegre, 89','11990010024','xenia.torres24@gmail.com','Jornalista','Solteira','Rogério Torres','11988880024'),
(1,'11111111135','Yasmin Ramos','F','Rua Verde Claro, 66','11990010025','yasmin.ramos25@gmail.com','Cozinheira','Casada','Mateus Ramos','11988880025'),
(1,'11111111136','Zeca Martins','M','Rua das Árvores, 14','11990010026','zeca.martins26@gmail.com','Pedreiro','Casado','Beatriz Martins','11988880026'),
(1,'11111111137','Alice Souza','F','Av. Atlântica, 75','11990010027','alice.souza27@gmail.com','Esteticista','Solteira','Renata Souza','11988880027'),
(1,'11111111138','Breno Almeida','M','Rua Central, 22','11990010028','breno.almeida28@gmail.com','Policial','Casado','Cláudia Almeida','11988880028'),
(1,'11111111139','Camila Duarte','F','Rua Bela, 91','11990010029','camila.duarte29@gmail.com','Publicitária','Solteira','Joana Duarte','11988880029'),
(1,'11111111140','Daniel Barros','M','Rua das Palmeiras, 82','11990010030','daniel.barros30@gmail.com','Garçom','Casado','Natália Barros','11988880030'),
(1,'11111111141','Elaine Rocha','F','Rua do Campo, 12','11990010031','elaine.rocha31@gmail.com','Contadora','Solteira','Silvana Rocha','11988880031'),
(1,'11111111142','Felipe Souza','M','Rua Azul, 45','11990010032','felipe.souza32@gmail.com','Motorista','Casado','Sandra Souza','11988880032'),
(1,'11111111143','Giovana Melo','F','Rua Dourada, 8','11990010033','giovana.melo33@gmail.com','Secretária','Solteira','Eduardo Melo','11988880033'),
(1,'11111111144','Hugo Tavares','M','Rua Norte, 63','11990010034','hugo.tavares34@gmail.com','Técnico','Casado','Márcia Tavares','11988880034'),
(1,'11111111145','Ingrid Pereira','F','Rua Nova Esperança, 11','11990010035','ingrid.pereira35@gmail.com','Psicóloga','Solteira','Sérgio Pereira','11988880035'),
(1,'11111111146','Jonas Cruz','M','Rua das Orquídeas, 56','11990010036','jonas.cruz36@gmail.com','Padeiro','Casado','Elaine Cruz','11988880036'),
(1,'11111111147','Kelly Moura','F','Rua Santa Luzia, 14','11990010037','kelly.moura37@gmail.com','Designer','Solteira','Patrícia Moura','11988880037'),
(1,'11111111148','Leonardo Ramos','M','Rua Santa Maria, 99','11990010038','leonardo.ramos38@gmail.com','Fotógrafo','Casado','Tatiane Ramos','11988880038'),
(1,'11111111149','Marina Nogueira','F','Rua das Oliveiras, 3','11990010039','marina.nogueira39@gmail.com','Cabeleireira','Solteira','Silvia Nogueira','11988880039'),
(1,'11111111150','Nathan Ribeiro','M','Rua Pontal, 200','11990010040','nathan.ribeiro40@gmail.com','Pedagogo','Casado','Vera Ribeiro','11988880040'),
(1,'11111111151','Otávia Souza','F','Rua Nova Vida, 22','11990010041','otavia.souza41@gmail.com','Estudante','Solteira','Célia Souza','11988880041'),
(1,'11111111152','Pedro Alves','M','Rua Horizonte, 55','11990010042','pedro.alves42@gmail.com','Mecânico','Casado','Luciana Alves','11988880042'),
(1,'11111111153','Quésia Gomes','F','Rua do Pôr-do-sol, 33','11990010043','quesia.gomes43@gmail.com','Auxiliar','Solteira','Mário Gomes','11988880043'),
(1,'11111111154','Ricardo Campos','M','Av. do Mar, 70','11990010044','ricardo.campos44@gmail.com','Comerciante','Casado','Tânia Campos','11988880044'),
(1,'11111111155','Sofia Almeida','F','Rua São Pedro, 13','11990010045','sofia.almeida45@gmail.com','Nutricionista','Solteira','Eliane Almeida','11988880045'),
(1,'11111111156','Thiago Monteiro','M','Rua Monte Azul, 9','11990010046','thiago.monteiro46@gmail.com','Motorista','Casado','Marta Monteiro','11988880046'),
(1,'11111111157','Úrsula Pires','F','Rua das Violetas, 19','11990010047','ursula.pires47@gmail.com','Professora','Casada','Nelson Pires','11988880047'),
(1,'11111111158','Vitor Lima','M','Rua dos Lírios, 5','11990010048','vitor.lima48@gmail.com','Atendente','Solteiro','Cristina Lima','11988880048'),
(1,'11111111159','Willian Ferreira','M','Rua Bela Rosa, 21','11990010049','willian.ferreira49@gmail.com','Estudante','Solteiro','Rita Ferreira','11988880049'),
(1,'11111111160','Yara Rodrigues','F','Rua Primavera, 16','11990010050','yara.rodrigues50@gmail.com','Bancária','Casada','Renato Rodrigues','11988880050');

select * from paciente WHERE cpf = "11111111137";
SELECT COUNT(*) as total FROM paciente WHERE id_instituicao = 1;

select * from diagnostico;

select * from relacao_medico_paciente;

#drop database tests_tcc;
