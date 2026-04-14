-- =============================================
-- Criação do Banco de Dados Faculdade
-- =============================================
CREATE DATABASE IF NOT EXISTS Faculdade
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE Faculdade;

-- =============================================
-- Tabela: professor
-- =============================================
CREATE TABLE professor (
    id_professor     INT AUTO_INCREMENT PRIMARY KEY,
    nome             VARCHAR(100) NOT NULL,
    email            VARCHAR(100) UNIQUE,
    titulacao        ENUM('Graduação', 'Especialização', 'Mestrado', 'Doutorado') NOT NULL DEFAULT 'Mestrado',
    data_contratacao DATE DEFAULT (CURRENT_DATE),
    salario          DECIMAL(10,2) DEFAULT 0.00,
    ativo            BOOLEAN DEFAULT TRUE,
    
    INDEX idx_nome_prof (nome)
);

-- =============================================
-- Tabela: aluno
-- =============================================
CREATE TABLE aluno (
    id_aluno         INT AUTO_INCREMENT PRIMARY KEY,
    nome             VARCHAR(100) NOT NULL,
    email            VARCHAR(100) UNIQUE,
    data_nascimento  DATE NOT NULL,
    cpf              CHAR(11) UNIQUE,
    matricula        VARCHAR(20) UNIQUE NOT NULL,
    semestre         INT DEFAULT 1,
    ativo            BOOLEAN DEFAULT TRUE,
    
    INDEX idx_nome_aluno (nome),
    INDEX idx_matricula (matricula)
);

-- =============================================
-- Tabela: disciplina
-- =============================================
CREATE TABLE disciplina (
    id_disciplina    INT AUTO_INCREMENT PRIMARY KEY,
    codigo           VARCHAR(10) UNIQUE NOT NULL,
    nome             VARCHAR(100) NOT NULL,
    carga_horaria    INT NOT NULL DEFAULT 60,
    semestre         INT NOT NULL DEFAULT 1,
    id_professor     INT NULL,
    
    CONSTRAINT fk_disciplina_professor 
        FOREIGN KEY (id_professor) 
        REFERENCES professor(id_professor)
        ON DELETE SET NULL 
        ON UPDATE CASCADE,
    
    INDEX idx_nome_disciplina (nome),
    INDEX idx_codigo (codigo)
);

-- =============================================
-- Inserção de Dados
-- =============================================

-- Professores
INSERT INTO professor (nome, email, titulacao, data_contratacao, salario) VALUES
('Ana Silva',          'ana.silva@faculdade.edu.br', 'Doutorado',    '2022-03-15', 8500.00),
('Carlos Oliveira',    'carlos.oliveira@faculdade.edu.br', 'Mestrado', '2021-08-01', 7200.00),
('Mariana Santos',     'mariana.santos@faculdade.edu.br', 'Mestrado', '2023-01-10', 6800.00),
('Roberto Mendes',     'roberto.mendes@faculdade.edu.br', 'Especialização', '2020-05-20', 5900.00);

-- Alunos
INSERT INTO aluno (nome, email, data_nascimento, cpf, matricula, semestre) VALUES
('João Pedro Costa',    'joao.costa@email.com',     '2005-04-12', '12345678901', '202310001', 3),
('Maria Clara Lima',    'maria.lima@email.com',     '2006-11-23', '98765432100', '202310002', 2),
('Lucas Ferreira',      'lucas.ferreira@email.com', '2004-08-05', '45678912345', '202410003', 1),
('Beatriz Souza',       'beatriz.souza@email.com',  '2005-02-18', '32165498700', '202310004', 3),
('Pedro Henrique Alves','pedro.alves@email.com',    '2006-07-30', '78912345678', '202410005', 1);

-- Disciplinas
INSERT INTO disciplina (codigo, nome, carga_horaria, semestre, id_professor) VALUES
('MAT101', 'Cálculo I',                    80, 1, 1),
('MAT102', 'Cálculo II',                   80, 2, 1),
('POO01',  'Programação Orientada a Objetos', 60, 3, 2),
('BD01',   'Banco de Dados I',             60, 3, 3),
('RED01',  'Redes de Computadores',        60, 2, 4),
('ENG01',  'Engenharia de Software',       60, 4, 2);