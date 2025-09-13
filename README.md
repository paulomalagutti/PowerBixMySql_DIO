Relatório de Análise de RH e Projetos com Power BI
1. Visão Geral do Projeto
Este projeto, desenvolvido como parte da formação Power BI Analyst da DIO, teve como objetivo principal realizar a coleta, o processamento e a visualização de dados de uma base de dados empresarial fictícia chamada company. O fluxo completo envolveu a configuração de um banco de dados, a transformação dos dados (ETL), a modelagem, a criação de métricas (DAX) e, por fim, a construção de um dashboard interativo no Power BI para extrair insights sobre a estrutura da empresa, alocação de recursos e hierarquias.

2. Ferramentas Utilizadas
Banco de Dados: MySQL Server (instalação local)

Gerenciador de BD: MySQL Workbench

Business Intelligence: Microsoft Power BI Desktop

3. Etapas do Projeto
O desenvolvimento foi dividido em 5 etapas principais, desde a configuração do ambiente até a criação do relatório final.

3.1. Configuração do Ambiente e Carga de Dados
Inicialmente, o projeto previa o uso do Azure para hospedar o banco de Dados MySQL. Após desafios técnicos na implantação, o projeto foi adaptado para um ambiente local, garantindo a continuidade e o foco nos objetivos de análise de dados.

Instalação: Foi instalado o MySQL Server e o MySQL Workbench na máquina local.

Criação e Carga: O banco de dados company foi criado e populado utilizando o script SQL fornecido no material do desafio.

3.2. Extração e Modelagem de Dados no Power BI
Com o ambiente local pronto, os dados foram conectados e modelados no Power BI.

Conexão: Foi estabelecida a conexão entre o Power BI e o servidor MySQL local (localhost).

Importação: Todas as tabelas do banco company (employee, department, project, works_on, etc.) foram importadas.

Modelagem: Na "Exibição de Modelo" do Power BI, foram criados os relacionamentos entre as tabelas para formar um esquema estrela, utilizando a tabela works_on como uma tabela fato para conectar funcionários e projetos. Esta etapa foi crucial para o funcionamento correto dos visuais.

3.3. Transformação de Dados (ETL com Power Query)
Seguindo as diretrizes do desafio, diversas transformações foram aplicadas no Power Query para limpar e enriquecer os dados.

Criação de Colunas: Foi criada a coluna Nome_Completo na tabela employee a partir da mescla das colunas Fname e Lname.

Verificação de Tipos: Os tipos de dados de todas as colunas foram verificados e corrigidos, com especial atenção para valores monetários (Salary) e numéricos.

Análise de Nulos: Foi realizada uma análise para identificar valores nulos em colunas chave, como Super_ssn (para identificar funcionários sem gerente).

3.4. Criação de Métricas (DAX)
Para potencializar as análises, foram criadas diversas medidas utilizando a linguagem DAX.

KPIs Principais:

Total de Colaboradores = COUNTROWS('employee')

Média Salarial = AVERAGE('employee'[Salary])

Total de Horas Registradas = SUM('works_on'[Hours])

Cálculos Específicos:

Número de Projetos por Funcionário = DISTINCTCOUNT('company works_on'[Pno])

Colunas Calculadas para Hierarquia:

Foi criada a coluna Nome do Gerente na tabela employee com a função LOOKUPVALUE para estabelecer a relação de hierarquia nominal.

3.5. Visualização de Dados e Criação do Dashboard
Com os dados modelados e as métricas criadas, o dashboard foi construído para apresentar os insights de forma clara. O relatório final inclui:

Cartões de KPI: Apresentam os números mais importantes da empresa de forma direta.

Gráficos de Barras: Utilizados para comparar a quantidade de funcionários por gerente e a média salarial por departamento.

Gráfico de Pizza: Mostra a distribuição percentual das horas de trabalho entre os diferentes departamentos.

Matriz (Mapa de Calor): Um visual detalhado que exibe as horas que cada funcionário dedicou a cada projeto.

Tabela Detalhada: Apresenta informações relacionais, como a lista de dependentes de cada funcionário.

4. Principais Insights Gerados
O dashboard final permite que a gestão da empresa possa:

Ter uma visão geral e imediata da quantidade de funcionários, projetos, custos salariais e esforço total em horas.

Analisar a estrutura das equipes, identificando quais gerentes possuem mais liderados.

Comparar a distribuição de salários entre os departamentos.

Identificar quais projetos estão consumindo a maior parte do tempo dos colaboradores e quais funcionários estão mais sobrecarregados.
