-- Pergunta: Quem são nossos mecânicos e em que eles se especializam?
SELECT nome, especialidade 
FROM Mecanico
ORDER BY nome ASC; 

-- Pergunta: Quais peças foram vendidas em maior quantidade e qual o subtotal delas?
SELECT 
    numero_os, 
    id_peca, 
    quantidade, 
    valor_unitario_aplicado,
    (quantidade * valor_unitario_aplicado) AS subtotal_pecas 
FROM OS_Peca
WHERE quantidade >= 1;

-- Pergunta: Qual o cliente e o carro por trás de cada Ordem de Serviço aberta?
SELECT 
    os.numero_os,
    c.nome AS cliente,
    v.modelo AS veiculo,
    v.placa,
    os.status
FROM Ordem_Servico os
INNER JOIN Veiculo v ON os.id_veiculo = v.id_veiculo
INNER JOIN Cliente c ON v.id_cliente = c.id_cliente
WHERE os.status <> 'CONCLUIDA';

-- Pergunta: Quais OS possuem mais de R$ 100,00 apenas em mão de obra?
SELECT 
    numero_os, 
    SUM(quantidade * valor_unitario_aplicado) AS total_servico
FROM OS_Servico
GROUP BY numero_os
HAVING total_servico > 100.00;