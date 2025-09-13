-- Apaga o schema antigo para garantir um começo limpo (opcional, mas recomendado)
DROP SCHEMA IF EXISTS company;

-- Cria o banco de dados se ele não existir
CREATE SCHEMA IF NOT EXISTS company;

-- Seleciona o banco de dados para os comandos seguintes
USE company;

-- 1. Cria a tabela de funcionários
CREATE TABLE employee (
    fname VARCHAR(15) NOT NULL,
    Minit CHAR,
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Bdate DATE,
    Address VARCHAR(30),
    sex CHAR,
    Salary DECIMAL(10, 2),
    Super_ssn CHAR(9),
    Dno INT,
    CONSTRAINT chk_salary_employee CHECK (Salary > 2000.0),
    CONSTRAINT pk_employee PRIMARY KEY (Ssn)
);

-- Adiciona a chave de auto-referência para o supervisor
-- (Feito com ALTER TABLE porque a tabela precisa existir antes de referenciar a si mesma)
ALTER TABLE employee 
ADD CONSTRAINT fk_employee_supervisor
FOREIGN KEY (Super_ssn) REFERENCES employee(Ssn)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- 2. Cria a tabela de departamentos
CREATE TABLE department (
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9),
    Mgr_start_date DATE,
    Dept_create_date DATE,
    CONSTRAINT chk_date_dept CHECK (Dept_create_date < Mgr_start_date),
    CONSTRAINT pk_department PRIMARY KEY (Dnumber),
    CONSTRAINT unique_name_dept UNIQUE (Dname),
    CONSTRAINT fk_department_employee FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
    ON UPDATE CASCADE
);

-- Adiciona a chave estrangeira de employee para department
-- (Feito com ALTER TABLE para evitar um problema de dependência circular na criação)
ALTER TABLE employee
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (Dno) REFERENCES department(Dnumber)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- 3. Cria a tabela de localizações do departamento
CREATE TABLE dept_location (
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,
    CONSTRAINT pk_dept_locations PRIMARY KEY (Dnumber, Dlocation),
    CONSTRAINT fk_dept_locations_department FOREIGN KEY (Dnumber) REFERENCES department (Dnumber)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- 4. Cria a tabela de projetos
CREATE TABLE project (
    Pname VARCHAR(15) NOT NULL,
    Pnumber INT NOT NULL,
    Plocation VARCHAR(15),
    Dnum INT NOT NULL,
    CONSTRAINT pk_project PRIMARY KEY (Pnumber),
    CONSTRAINT unique_project UNIQUE (Pname),
    CONSTRAINT fk_project_department FOREIGN KEY (Dnum) REFERENCES department (Dnumber)
    ON UPDATE CASCADE
);

-- 5. Cria a tabela de alocação de trabalho (tabela de ligação)
CREATE TABLE works_on (
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3, 1) NOT NULL,
    CONSTRAINT pk_works_on PRIMARY KEY (Essn, Pno),
    CONSTRAINT fk_works_on_project FOREIGN KEY (Pno) REFERENCES project (Pnumber)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_works_on_employee FOREIGN KEY (Essn) REFERENCES employee (Ssn)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- 6. Cria a tabela de dependentes
CREATE TABLE dependent (
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR(15) NOT NULL,
    Sex CHAR,
    Bdate DATE,
    Relationship VARCHAR(9),
    CONSTRAINT pk_dependent PRIMARY KEY (Essn, Dependent_name),
    CONSTRAINT fk_dependent_employee FOREIGN KEY (Essn) REFERENCES employee (Ssn)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);