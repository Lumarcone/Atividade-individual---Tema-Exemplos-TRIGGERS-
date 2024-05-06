-- Criação da tabela "Pedido"
CREATE TABLE Pedidos(
    IDPedido INT auto_increment PRIMARY KEY,
    DataPedido datetime,
    NomeCliente VARCHAR(100)
);

-- Inserção de dados de exemplo
INSERT INTO Pedidos (DataPedido, NomeCliente) VALUES
(NOW(), 'Cliente 1'),
(NOW(), 'Cliente 2'),
(NOW(), 'Cliente 3');

-- Criação da Trigger
DELIMITER $
CREATE TRIGGER RegistroDataCriacaoPedido
BEFORE INSERT ON pedidos
FOR Each ROW
BEGIN
    SET NEW.DataPedido = NOW();
END;
$
DELIMITER ;

-- Inserção deum noo registro na tabla "Pedidos" sem oferecer a data
INSERT INTO pedidos (NomeCliente) VALUES ('Novo Cliente');

-- Consulta para verificarr os resultados
SELECT* FROM pedidos;