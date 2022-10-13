# 1_11 Explorando o SELECT - https://dev.mysql.com/doc/refman/8.0/en/select.html

SELECT * FROM tabela_de_produtos;

SELECT SEXO, NOME, ENDERECO_1 AS ENDERECO, IDADE, VOLUME_DE_COMPRA AS GASTOS_TOTALIZADOS, CIDADE FROM tabela_de_clientes
	WHERE (SEXO ='M' OR CIDADE ='São Paulo');
    
SELECT * FROM tabela_de_produtos 
	WHERE SABOR = 'Laranja';
    
SELECT * FROM tabela_de_produtos
	WHERE (PRECO_DE_LISTA <= 16.009 AND PRECO_DE_LISTA >= 16.007); #Selecionando um ponto flutuante
    
# 1_12 Aplicando Consultas condicionais

SELECT * FROM tabela_de_produtos
	WHERE NOT SABOR = 'Uva';
    
SELECT * FROM tabela_de_produtos
	WHERE SABOR IN ('Maça', 'Açai', 'Manga') AND PRECO_DE_LISTA <= 10;

SELECT * FROM tabela_de_produtos
	WHERE (EMBALAGEM = 'PET' AND SABOR IN ('Manga', 'Maça', 'Uva', 'Laranja')) OR EMBALAGEM ='Garrafa'; 
    
SELECT * FROM tabela_de_clientes
	WHERE CIDADE IN ('Rio de Janeiro', 'São Paulo') AND (IDADE >=19 AND IDADE <=23);
    

# 1_21 Selecione todos os itens de notas fiscais cuja quantidade seja maior que 60 e preço menor ou igual a 3?

SELECT * FROM itens_notas_fiscais
	WHERE QUANTIDADE > 60 AND PRECO <= 3;
    
# 1_13 Usando o LIKE

SELECT * FROM tabela_de_produtos
	WHERE SABOR LIKE '%Maça%';

SELECT * FROM tabela_de_produtos
	WHERE EMBALAGEM = 'PET' and SABOR LIKE '%Maça%';
    
# 1_22 Quantos clientes possuem o último sobrenome Mattos?

SELECT * FROM tabela_de_clientes
	WHERE NOME LIKE '%Mattos';


# 1_14 Usando o DISTINCT https://dev.mysql.com/doc/refman/8.0/en/select.html

SELECT EMBALAGEM, TAMANHO FROM tabela_de_produtos;

SELECT DISTINCT EMBALAGEM, TAMANHO FROM tabela_de_produtos; 

SELECT DISTINCT EMBALAGEM, TAMANHO FROM tabela_de_produtos #Selecionando as Embalagens e Produtos
	WHERE SABOR LIKE '%Laranja%';							# distintos com Laranja
    
    
# 1_23 Quais são os bairros da cidade do Rio de Janeiro que possuem clientes?

SELECT DISTINCT BAIRRO FROM tabela_de_clientes
	WHERE CIDADE = 'Rio de Janeiro';
    

# 1_15 Limitando a saída com o comando LIMIT

SELECT * FROM tabela_de_clientes;

SELECT * FROM tabela_de_clientes
	LIMIT 2, 3;
    
SELECT * FROM tabela_de_clientes
	LIMIT 3 OFFSET 2;
    
SELECT * FROM tabela_de_clientes
	LIMIT 5;
    

# 1_24 Queremos obter as 10 primeiras vendas do dia 01/01/2017. 
# Qual seria o comando SQL para obter este resultado?

SELECT * FROM notas_fiscais
	WHERE DATA_VENDA = '2017/01/01'
    LIMIT 10;
    
# 1_16 Ordenando a saída de consulta com ORDER BY

SELECT * FROM tabela_de_produtos;

SELECT * FROM tabela_de_produtos
	ORDER BY PRECO_DE_LISTA;
    
SELECT * FROM tabela_de_produtos
	ORDER BY PRECO_DE_LISTA DESC;
    
SELECT * FROM tabela_de_produtos
	ORDER BY EMBALAGEM DESC , NOME_DO_PRODUTO ASC;
    

# 1_25 Qual (ou quais) foi (foram) a(s) maior(es) venda(s) do produto “Linha Refrescante - 1 Litro - 
# Morango/Limão”, em quantidade? (Obtenha este resultado usando 2 SQLs).

SELECT * FROM tabela_de_produtos
	WHERE NOME_DO_PRODUTO = 'Linha Refrescante - 1 Litro - Morango/Limão';

SELECT * FROM itens_notas_fiscais
	WHERE CODIGO_DO_PRODUTO = '1101035'
    ORDER BY QUANTIDADE DESC;

# 1.17 Agrupando com GROUP BY

SELECT BAIRRO, SUM(LIMITE_DE_CREDITO) AS CREDITO FROM tabela_de_clientes
	GROUP BY BAIRRO;
    
SELECT EMBALAGEM, COUNT(SABOR) AS CONTADOR FROM tabela_de_produtos
	GROUP BY EMBALAGEM;
    
SELECT SABOR, MAX(PRECO_DE_LISTA) AS MAIOR_VALOR FROM tabela_de_produtos
	GROUP BY SABOR;
    
SELECT ESTADO, BAIRRO, SUM(LIMITE_DE_CREDITO) AS CREDITO_TOTALIZADO FROM tabela_de_clientes
	WHERE CIDADE = 'Rio de Janeiro'
    GROUP BY ESTADO, BAIRRO;
    
# 1_26 quantos itens de venda existem com a maior quantidade do produto '1101035'?

SELECT MAX(QUANTIDADE) AS MAXIMA_QUANTIDADE FROM itens_notas_fiscais
	WHERE CODIGO_DO_PRODUTO = '1101035';
    
SELECT COUNT(*) AS CONTADOR FROM itens_notas_fiscais 
	WHERE CODIGO_DO_PRODUTO = '1101035' AND QUANTIDADE = 99;
    
# 1_18 Usando a condição HAVING

SELECT BAIRRO, SUM(LIMITE_DE_CREDITO) AS CREDITO_BAIRRO FROM tabela_de_clientes
	WHERE CIDADE = 'São Paulo'
	GROUP BY BAIRRO
    HAVING SUM(LIMITE_DE_CREDITO) > 100000; #Bairros com maiores créditos em São Paulo
    
SELECT SABOR, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO, MIN(PRECO_DE_LISTA) AS MENOR_PRECO FROM tabela_de_produtos
	GROUP BY SABOR
    HAVING MAX(PRECO_DE_LISTA) >= 10 AND SUM(PRECO_DE_LISTA) >=40;
    
# 1_27 Quais foram os clientes que fizeram mais de 2000 compras em 2016?
    
SELECT CPF, COUNT(MATRICULA) AS CONTADOR FROM notas_fiscais
	WHERE YEAR(DATA_VENDA) = 2016
	GROUP BY CPF
    HAVING COUNT(MATRICULA) > 2000;
    
SELECT * FROM tabela_de_clientes
	WHERE CPF IN ('3623344710','492472718','50534475787');
    

# 1_19 Usando CASE -Flow Control Statement- https://dev.mysql.com/doc/refman/8.0/en/case.html

SELECT NOME_DO_PRODUTO, PRECO_DE_LISTA,
CASE
	WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
    WHEN PRECO_DE_LISTA < 12 AND PRECO_DE_LISTA >= 7 THEN 'PRODUTO EM CONTA'
    ELSE 'PRODUTO BARATO'
END AS CLASSIFICAO
FROM tabela_de_produtos;

# Agrupar produtos por embalagem e classifica-los

SELECT EMBALAGEM, 
CASE
	WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
    WHEN PRECO_DE_LISTA < 12 AND PRECO_DE_LISTA >= 7 THEN 'PRODUTO EM CONTA'
    ELSE 'PRODUTO BARATO'
END AS CLASSIFICACAO, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO FROM tabela_de_produtos
GROUP BY EMBALAGEM, CLASSIFICACAO
ORDER BY EMBALAGEM;

# Agrupar produtos Manga por embalagem e classifica-los

SELECT EMBALAGEM, 
CASE
	WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
    WHEN PRECO_DE_LISTA < 12 AND PRECO_DE_LISTA >= 7 THEN 'PRODUTO EM CONTA'
    ELSE 'PRODUTO BARATO'
END AS CLASSIFICACAO, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO FROM tabela_de_produtos
WHERE SABOR = 'Manga'
GROUP BY EMBALAGEM, CLASSIFICACAO
ORDER BY EMBALAGEM;


# 1_28 Veja o ano de nascimento dos clientes e classifique-os como: Nascidos antes de 1990 são velhos
# nascidos entre 1990 e 1995 são jovens e nascidos depois de 1995 são crianças. 
# Liste o nome do cliente e esta classificação.

SELECT NOME, DATA_DE_NASCIMENTO, 
CASE
	WHEN YEAR(DATA_DE_NASCIMENTO) < 1990 THEN 'Velhos'
	WHEN YEAR(DATA_DE_NASCIMENTO) >= 1990 AND YEAR(DATA_DE_NASCIMENTO) <= 1995 THEN 'Jovens'
    ELSE 'Crianças'
END AS CLASSIFICACAO FROM tabela_de_clientes;

# 2_11 Usando JOIN - https://dev.mysql.com/doc/refman/8.0/en/join.html

SELECT * FROM tabela_de_vendedores;
SELECT * FROM notas_fiscais;

SELECT * FROM tabela_de_vendedores A INNER JOIN notas_fiscais B
ON A.MATRICULA = B.MATRICULA;

SELECT A.MATRICULA, A.NOME, COUNT(*) FROM tabela_de_vendedores A INNER JOIN notas_fiscais B
ON A.MATRICULA = B.MATRICULA
GROUP BY MATRICULA;

# 1_29 Obtenha o faturamento anual da empresa. Leve em consideração que o valor financeiro das vendas
# consiste em multiplicar a quantidade pelo preço.

SELECT * FROM notas_fiscais;
SELECT * FROM itens_notas_fiscais;

SELECT A.NUMERO, A.QUANTIDADE, A.PRECO, B.IMPOSTO FROM itens_notas_fiscais A INNER JOIN notas_fiscais B
ON A.NUMERO = B.NUMERO;

SELECT YEAR(DATA_VENDA), SUM(QUANTIDADE * PRECO) FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF
ON NF.NUMERO = INF.NUMERO
GROUP BY YEAR(DATA_VENDA);

# 2_12 Usando LEFT JOIN

SELECT CPF, COUNT(*) FROM notas_fiscais
GROUP BY CPF; # 14 Registros

SELECT COUNT(*) FROM tabela_de_clientes; # 15 Clientes

SELECT DISTINCT A.CPF, A.NOME, B.CPF FROM tabela_de_clientes A INNER JOIN notas_fiscais B
ON A.CPF = B.CPF;

SELECT DISTINCT A.CPF, A.NOME, B.CPF FROM tabela_de_clientes A LEFT JOIN notas_fiscais B
ON A.CPF = B.CPF
WHERE B.CPF IS NULL;

SELECT DISTINCT A.CPF, B.NOME, B.CPF FROM notas_fiscais A RIGHT JOIN tabela_de_clientes B
ON A.CPF = B.CPF;

# 2_13 FULL e CROSS JOIN

SELECT * FROM tabela_de_vendedores; # 4 registros
SELECT * FROM tabela_de_clientes; # 15 registros

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, DE_FERIAS, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME
FROM tabela_de_vendedores INNER JOIN tabela_de_clientes
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO;
# Repara que o vendedor que possui mais que um cliente do mesmo bairro terá seu registro duplicado para fazer o pareamento necessário
# Pega somente registros que tenham bairros em comum

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, DE_FERIAS, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME
FROM tabela_de_vendedores LEFT JOIN tabela_de_clientes
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO;
# Pega todos os registros da esquerda - dos vendedores no caso

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, DE_FERIAS, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME
FROM tabela_de_vendedores RIGHT JOIN tabela_de_clientes
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO;

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, DE_FERIAS, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME
FROM tabela_de_vendedores CROSS JOIN tabela_de_clientes
# Cruzando todos os registros AxB (produto cartesiano)

# 2_14 Union https://dev.mysql.com/doc/refman/8.0/en/union.html

SELECT DISTINCT BAIRRO FROM tabela_de_clientes;
SELECT DISTINCT BAIRRO FROM tabela_de_vendedores;

SELECT DISTINCT BAIRRO FROM tabela_de_clientes
UNION
SELECT DISTINCT BAIRRO FROM tabela_de_vendedores;
# União sem duplicação de registros

SELECT DISTINCT BAIRRO FROM tabela_de_clientes
UNION ALL
SELECT DISTINCT BAIRRO FROM tabela_de_vendedores;
# União dos registros incluindo duplicas

# Unindo bairro, nomes e identificação de clientes e vendedores

SELECT DISTINCT BAIRRO, NOME, 'Cliente' as TIPO_CLIENTE FROM tabela_de_clientes
UNION
SELECT DISTINCT BAIRRO, NOME, 'Vendedor' as TIPO_VENDEDOR FROM tabela_de_vendedores;

# Adicionando o CPF do cliente e a Matricula do vendedor na coluna

SELECT DISTINCT BAIRRO, NOME, CPF, 'CLIENTE' AS TIPO_CLIENTE FROM tabela_de_clientes
UNION
SELECT DISTINCT BAIRRO, NOME, MATRICULA, 'VENDEDOR' AS TIPO_VENDEDOR FROM tabela_de_vendedores;


# Unindo left join com right join
#bairro, nome, de_ferias(vendedores), bairro nome (clientes)
SELECT A.BAIRRO, A.NOME, DE_FERIAS, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME FROM 
tabela_de_vendedores A LEFT JOIN tabela_de_clientes
ON A.BAIRRO = tabela_de_clientes.BAIRRO
UNION
SELECT A.BAIRRO, A.NOME, DE_FERIAS, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME FROM 
tabela_de_vendedores A RIGHT JOIN tabela_de_clientes
ON A.BAIRRO = tabela_de_clientes.BAIRRO;

# 2_15 Subconsultas

# Selecione os clientes cujo bairro tb estão em vendedores

SELECT DISTINCT BAIRRO FROM tabela_de_vendedores;

SELECT * FROM tabela_de_clientes
	WHERE BAIRRO IN ('Tijuca', 'Jardins', 'Copacabana', 'Santo Amaro');

# Outra maneira
SELECT * FROM tabela_de_clientes
	WHERE BAIRRO IN (SELECT DISTINCT BAIRRO FROM tabela_de_vendedores);
    
# Embalagens, max(preco)

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS PRECO_MAXIMO FROM tabela_de_produtos
GROUP BY EMBALAGEM;

SELECT X.EMBALAGEM, X.PRECO_MAXIMO FROM 
	(SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS PRECO_MAXIMO FROM tabela_de_produtos
	GROUP BY EMBALAGEM) X
    WHERE X.PRECO_MAXIMO > 10;
    
# 1_28 Qual seria a consulta usando subconsulta que seria equivalente a:
  SELECT CPF, COUNT(*) FROM notas_fiscais
  WHERE YEAR(DATA_VENDA) = 2016
  GROUP BY CPF
  HAVING COUNT(*) > 2000;
  
SELECT A.CPF, A.CONTADOR FROM
	(SELECT CPF, COUNT(*) AS CONTADOR FROM notas_fiscais
	WHERE YEAR(DATA_VENDA) = 2016
    GROUP BY CPF) A
    WHERE A.CONTADOR > 2000;
    
# 2_16 Visão

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO FROM tabela_de_produtos
GROUP BY EMBALAGEM;

SELECT X.EMBALAGEM, X.MAIOR_PRECO FROM
	(SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO FROM tabela_de_produtos
    GROUP BY EMBALAGEM) X
    WHERE MAIOR_PRECO > 10;
    
SELECT EMBALAGEM, MAIOR_PRECO FROM vw_maiores_embalagens
	WHERE MAIOR_PRECO > 10;
    
# nome, embalagem, preco e seu maior preco de embalagem

SELECT A.NOME_DO_PRODUTO, A.EMBALAGEM, A.PRECO_DE_LISTA, B.MAIOR_PRECO, (PRECO_DE_LISTA / MAIOR_PRECO) * 100 AS PERCENTUAL 
FROM tabela_de_produtos A INNER JOIN vw_maiores_embalagens B
ON A.EMBALAGEM = B.EMBALAGEM;

# 2_17 Funções de STRING - https://dev.mysql.com/doc/refman/8.0/en/string-functions.html

SELECT CONCAT('OLÁ ', 'GOOD', ' ','FELLOWS') AS RESULTADO;

SELECT LOWER('FUNÇÕES DE STRING') AS RESULTADO;

SELECT REPLACE('OLA A TODOS', 'O', 'X') AS RESULTADO;

SELECT TRIM(BOTH 'x' FROM 'xbatxxx') AS RESULTADO;

SELECT SUBSTRING('Bom Dia a Todos', 5, 3) AS RESULTADO;

SELECT CONCAT(NOME, '(', CPF, ')') AS NOME_CPF FROM tabela_de_clientes;

# 1_29 Faça uma consulta listando o nome do cliente e o endereço completo 
#(Com rua, bairro, cidade e estado).

SELECT NOME, CONCAT(ENDERECO_1, '-', BAIRRO, '-', CIDADE, '-', ESTADO) AS ENDERECO_COMPLETO FROM tabela_de_clientes;