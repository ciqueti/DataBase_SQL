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
