create database TCC25;
use TCC25;
    
CREATE TABLE instituicao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cep VARCHAR(12) NOT NULL,
    logradouro TEXT NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    cnpj VARCHAR(20) UNIQUE NOT NULL,
    tipo ENUM('publico', 'privado', 'filantropico') NOT NULL,
    telefone VARCHAR(25) NOT NULL,
    email VARCHAR(155) NOT NULL,
    site TEXT,
    atividade ENUM('ativo', 'inativo') DEFAULT 'ativo',
    nome_responsavel VARCHAR(100) NOT NULL,
    telefone_responsavel VARCHAR(20) NOT NULL
);

CREATE TABLE licencas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    token VARCHAR(512) NOT NULL UNIQUE,
    instituicao_id INT,
    tipo_licenca VARCHAR(50),
    status ENUM('ativa','inativa') DEFAULT 'ativa',
    usado BOOLEAN DEFAULT FALSE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expira_em TIMESTAMP NULL,

    FOREIGN KEY (instituicao_id) REFERENCES instituicao(id)
);

CREATE TABLE papeis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL,
    descricao TEXT
);

CREATE TABLE permissoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL,
    descricao TEXT
);

CREATE TABLE papeis_permissoes (
    papel_id INT NOT NULL,
    permissao_id INT NOT NULL,
    PRIMARY KEY (papel_id, permissao_id),

    FOREIGN KEY (papel_id) REFERENCES papeis(id) ON DELETE CASCADE,
    FOREIGN KEY (permissao_id) REFERENCES permissoes(id) ON DELETE CASCADE
);

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    ultimo_login TIMESTAMP NULL,
	tentativas_login INT DEFAULT 0,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

CREATE TABLE usuarios_papeis (
    usuario_id INT NOT NULL,
    papel_id INT NOT NULL,
    PRIMARY KEY (usuario_id, papel_id),
    deleted_at TIMESTAMP NULL,

    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (papel_id) REFERENCES papeis(id) ON DELETE CASCADE
);

CREATE TABLE historico_acessos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    ip VARCHAR(45),
    user_agent TEXT,
    data_acesso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE refresh_tokens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    token VARCHAR(512) NOT NULL UNIQUE,
    expira_em TIMESTAMP NOT NULL,
    revogado BOOLEAN DEFAULT FALSE,
    deleted_at TIMESTAMP NULL,

    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL UNIQUE,
    instituicao_id INT NOT NULL,
    nome VARCHAR(150) NOT NULL,
    deleted_at TIMESTAMP NULL,

    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (instituicao_id) REFERENCES instituicao(id)
);

#
	CREATE TABLE medicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL UNIQUE,
    instituicao_id INT NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    crm VARCHAR(11) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    deleted_at TIMESTAMP NULL,

    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (instituicao_id) REFERENCES instituicao(id)
);

CREATE TABLE pacientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT UNIQUE NULL,
    instituicao_id INT NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    sexo CHAR(1),
    endereco TEXT,
    telefone VARCHAR(50),
    profissao VARCHAR(255),
    estado_civil VARCHAR(50),
    nome_cuidador VARCHAR(100),
    telefone_cuidador VARCHAR(50),
    deleted_at TIMESTAMP NULL,

    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (instituicao_id) REFERENCES instituicao(id)  
);
        
CREATE TABLE auditoria_medica (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    paciente_id INT NOT NULL,
    acao VARCHAR(100),
    descricao TEXT,
    ip VARCHAR(45),
    data_acao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE NO ACTION

);        
        
CREATE TABLE diagnosticos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    data_diagnostico DATE,
    tipo_em VARCHAR(5),
    surtos TEXT,
    deleted_at TIMESTAMP NULL,

    FOREIGN KEY (paciente_id) REFERENCES pacientes(id)
);  

create table sintomas (
		id int primary key auto_increment,
		paciente_id int,
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
		foreign key (paciente_id) references pacientes(id)
	);

	create table historico_medico (
		id int primary key auto_increment,
		paciente_id int,
		medicamento_em_uso text,
		tratamentos_anteriores_em text,
		alergias text,
		historico_outras_doencas text,
		historico_familiar text,
        deleted_at TIMESTAMP NULL,
		foreign key (paciente_id) references pacientes(id)
	);
			
	create table historico_social (
		id int primary key auto_increment,
		paciente_id int,
		tabagismo varchar(50),
		alcool varchar(100),
		atividade_fisica text,
		suporte_social text,
		impacto_profissional_social text,
        deleted_at TIMESTAMP NULL,
		foreign key (paciente_id) references pacientes(id)
	);  

	create table qualidade_vida_em (
		id int primary key auto_increment,
		paciente_id int,
		edss float, 
		questionario_msqol54 text,
		outras_avaliacoes text,
		foreign key (paciente_id) REFERENCES pacientes(id)
	);
	  
	create table exame_fisico (
		id int primary key auto_increment,
		paciente_id int,
		exame_neurologico text,
		forca_muscular text, 
		reflexos text,
		coordenacao text, 
		sensibilidade text,
		equilibrio text,
		funcao_visual text,
		outros_exames_fisicos text,
		foreign key (paciente_id) REFERENCES pacientes(id)
	);

	create table exames_complementares (
		id int primary key auto_increment,
		paciente_id int,
		rm_cerebro_medula text,
		potenciais_evocados_visuais text,
		potenciais_evocados_somatossensoriais text,
		potenciais_evocados_auditivos_de_tronco_encefálico text,
		analise_do_liquido_cefalorraquidiano text,
		outros_exames text,
		foreign key (paciente_id) REFERENCES pacientes(id)
	);
	  
	create table plano_tratamento (
		id int primary key auto_increment,
		paciente_id int,
		medicamentos_modificadores_doenca text,
		tratamento_surtos text,
		tratamento_sintomas text, 
		reabilitacao text,
		acompanhamento_psicologico text,
		outras_terapias text,
		foreign key (paciente_id) REFERENCES pacientes(id)
	);  
	  
	  create table ia_results (
		id int primary key auto_increment,
		paciente_id int,
		nome varchar(150),
		cpf varchar(20),
		imagem longtext, 
		diagnostico text,
		data_diagnostico date,

		foreign key (paciente_id) REFERENCES pacientes(id)
	);
      
CREATE TABLE medico_paciente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    medico_id INT,
    paciente_id INT NOT NULL,
    UNIQUE (medico_id, paciente_id),
    deleted_at TIMESTAMP NULL,

    FOREIGN KEY (medico_id) REFERENCES medicos(id) ON DELETE SET NULL,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE
);
    
CREATE TABLE mensagens_chat (
    id INT AUTO_INCREMENT PRIMARY KEY,
    instituicao_id INT NOT NULL,
    usuario_id INT NOT NULL,
    mensagem TEXT NOT NULL,
    origem_papel_id INT NOT NULL,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    lida BOOLEAN DEFAULT FALSE,
    deleted_at TIMESTAMP NULL,

	FOREIGN KEY (origem_papel_id) REFERENCES papeis(id),
    FOREIGN KEY (instituicao_id) REFERENCES instituicao(id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE INDEX idx_usuarios_email ON usuarios(email);
CREATE INDEX idx_pacientes_cpf ON pacientes(cpf);
CREATE INDEX idx_medicos_crm ON medicos(crm);
CREATE INDEX idx_auditoria_usuario ON auditoria_medica(usuario_id);
CREATE INDEX idx_auditoria_paciente ON auditoria_medica(paciente_id);
CREATE INDEX idx_refresh_usuario ON refresh_tokens(usuario_id);

## TEST

USE TCC25;

-- =========================
-- INSTITUICAO
-- =========================
INSERT INTO instituicao (
    nome, cep, logradouro, cidade, bairro, cnpj, tipo,
    telefone, email, site, nome_responsavel, telefone_responsavel
) VALUES (
    'Hospital Teste', '12200-000', 'Rua A', 'São José', 'Centro',
    '12345678000199', 'privado', '(12)99999-9999',
    'contato@hospital.com', 'https://hospital.com',
    'Diretor Teste', '(12)98888-8888'
);

-- =========================
-- USUARIOS
-- =========================
INSERT INTO usuarios (email, senha_hash)
VALUES
('admin@teste.com', '$2y$10$md.r9c9rnGG9XgMUm3xApO9t94g1TsTdK8IcQ1S3q1g9pbTR5wlzO'),
('medico@teste.com', '123456'),
('paciente@teste.com', '123456');

-- =========================
-- PAPEIS
-- =========================
INSERT INTO papeis (nome, descricao)
VALUES
('ADMIN', 'Administrador do sistema'),
('MEDICO', 'Médico'),
('PACIENTE', 'Paciente');

-- =========================
-- PERMISSOES
-- =========================
INSERT INTO permissoes (nome)
VALUES
('GERENCIAR_USUARIOS'),
('VER_PACIENTE'),
('EDITAR_PACIENTE');

-- =========================
-- VINCULOS PAPEL x PERMISSAO
-- =========================
INSERT INTO papeis_permissoes VALUES (1,1),(2,2),(2,3);

-- =========================
-- USUARIO x PAPEL
-- =========================
INSERT INTO usuarios_papeis VALUES
(1,1,NULL),
(2,2,NULL),
(3,3,NULL);

-- =========================
-- ADMINS
-- =========================
INSERT INTO admins (usuario_id, instituicao_id, nome)
VALUES (1,1,'Administrador Geral');

-- =========================
-- MEDICOS
-- =========================
INSERT INTO medicos (usuario_id, instituicao_id, cpf, crm, nome)
VALUES (2,1,'11111111111','CRM12345','Dr Teste');

-- =========================
-- PACIENTES
-- =========================
INSERT INTO pacientes (
    usuario_id, instituicao_id, cpf, nome, sexo, telefone
) VALUES (
    3,1,'22222222222','Paciente Teste','M','(12)97777-7777'
);

-- =========================
-- MEDICO x PACIENTE
-- =========================
INSERT INTO medico_paciente (medico_id, paciente_id)
VALUES (1,1);

-- =========================
-- DIAGNOSTICO
-- =========================
INSERT INTO diagnosticos (paciente_id, data_diagnostico, tipo_em, surtos)
VALUES (1, '2025-01-01', 'RR', 'Surtos iniciais');

-- =========================
-- SINTOMAS
-- =========================
INSERT INTO sintomas (paciente_id, sintomas_iniciais, fadiga)
VALUES (1, 'Visão turva', TRUE);

-- =========================
-- HISTORICO MEDICO
-- =========================
INSERT INTO historico_medico (paciente_id, alergias)
VALUES (1, 'Nenhuma');

-- =========================
-- HISTORICO SOCIAL
-- =========================
INSERT INTO historico_social (paciente_id, tabagismo)
VALUES (1, 'Nunca');

-- =========================
-- QUALIDADE DE VIDA
-- =========================
INSERT INTO qualidade_vida_em (paciente_id, edss)
VALUES (1, 2.5);

-- =========================
-- EXAME FISICO
-- =========================
INSERT INTO exame_fisico (paciente_id, forca_muscular)
VALUES (1, 'Normal');

-- =========================
-- EXAMES COMPLEMENTARES
-- =========================
INSERT INTO exames_complementares (paciente_id, rm_cerebro_medula)
VALUES (1, 'Sem alterações');

-- =========================
-- PLANO DE TRATAMENTO
-- =========================
INSERT INTO plano_tratamento (paciente_id, tratamento_sintomas)
VALUES (1, 'Fisioterapia');

-- =========================
-- IA RESULTS
-- =========================
INSERT INTO ia_results (
    paciente_id, nome, cpf, diagnostico, data_diagnostico
) VALUES (
    1, 'Paciente Teste', '22222222222', 'Baixa predisposição', '2025-01-01'
);

-- =========================
-- AUDITORIA
-- =========================
INSERT INTO auditoria_medica (
    usuario_id, paciente_id, acao, descricao, ip
) VALUES (
    2,1,'CRIACAO_DIAGNOSTICO','Diagnóstico criado','127.0.0.1'
);

-- =========================
-- CHAT
-- =========================
INSERT INTO mensagens_chat (
    instituicao_id, usuario_id, mensagem, origem_papel_id
) VALUES (
    1,2,'Olá paciente',2
);

-- =========================
-- TESTE UPDATE
-- =========================
UPDATE pacientes SET telefone='(12)90000-0000' WHERE id=1;

-- =========================
-- TESTE SOFT DELETE
-- =========================
UPDATE pacientes SET deleted_at=NOW() WHERE id=1;

-- =========================
-- TESTE SELECT FINAL
-- =========================
SELECT * FROM pacientes WHERE deleted_at IS NULL;
##

#drop database TCC25;