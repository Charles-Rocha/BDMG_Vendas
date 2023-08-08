SELECT * FROM Clientes
SELECT * FROM Fornecedores ORDER BY NomeFantasia
SELECT * FROM Produtos ORDER BY Descricao
SELECT * FROM Vendas
SELECT * FROM ProdutosVendidos
SELECT MAX(Codigo) AS Codigo FROM ProdutosVendidos

DROP Table ProdutosVendidos

delete from Vendas where NumeroVenda = 9
delete from ProdutosVendidos where CodigoCliente = 11

INSERT INTO Clientes(Nome, CPF, Status, DataNascimento) VALUES ('Alycia', '07239415724', null, '12/07/1985');
INSERT INTO Fornecedores(NomeFantasia, RazaoSocial, CNPJ, Status) VALUES ('Kabum Informática', 'Kabum Informática S.A.', '05570714000159', 1);
INSERT INTO Produtos(Descricao, PrecoUnitario, CodigoFornecedor, Status) VALUES ('Fonte Corsair RMX Series RM850X Full Modular', 929.99, 2, 1);
INSERT INTO Vendas(CodigoCliente, DataHora, CodigoProduto, ValorTotal, Status) VALUES (1, '06/08/2023', 3, 4590.50, 1);
INSERT INTO ProdutosVendidos(Descricao, PrecoUnitario, QuantidadeVendida, ValorTotal, CodigoCliente, CodigoProduto) 
VALUES ('Adaptador DVI Macho x VGA Fêmea', 55.9, 3, 167.70, 3, 10);

SELECT V.NumeroVenda, C.Nome, Convert(varchar(10), V.DataHora, 103) AS DataHora, V.ValorTotal, V.Status 
FROM Vendas V 
INNER JOIN Clientes C on C.Codigo = V.CodigoCliente;

UPDATE Fornecedores SET NomeFantasia = 'Kabum S.A.', RazaoSocial = 'Kabum Comércio Eletrônico S.A.'
WHERE Codigo = 3

UPDATE Produtos SET Descricao = 'Cadeira Gamer Thunder X3' WHERE Codigo = 1;
UPDATE Clientes SET DataNascimento = '28/05/1994' WHERE Codigo = 7;
UPDATE Vendas Set ValorTotal = 4590.5 WHERE CodigoCliente = 1;
UPDATE Vendas Set Status = 0 WHERE CodigoCliente = 3;
UPDATE Vendas Set CodigoCliente = 3 WHERE NumeroVenda = 10;
SELECT * FROM Clientes;

SELECT P.Codigo, P.Descricao, P.PrecoUnitario, P.CodigoFornecedor, F.NomeFantasia, P.Status FROM Produtos P
INNER JOIN Fornecedores F on F.Codigo = P.CodigoFornecedor

SELECT * FROM VENDAS V
INNER JOIN ProdutosVendidos PV on PV.CodigoCliente = V.CodigoCliente 
INNER JOIN Clientes C on C.Codigo = V.CodigoCliente
INNER JOIN Produtos P on P.Codigo = PV.CodigoProduto
WHERE V.CodigoCliente = 3
INNER JOIN Fornecedores F on F.Codigo = P.CodigoFornecedor

SELECT * FROM ProdutosVendidos WHERE 1 = 1
AND CodigoCliente = 3

SELECT * FROM ProdutosVendidos PV
WHERE PV.CodigoCliente = 3

Set Language 'Português'
SET DATEFORMAT 'dd/mm/yyyy'

select Convert(varchar(10), DataNascimento,103) FROM Clientes
SELECT Codigo, Nome, CPF, Status, Convert(varchar(10), DataNascimento, 103) AS Data_Nascimento FROM Clientes WHERE 1 = 1

select * from Clientes
where nome like '%Alicia%' and status = '0'