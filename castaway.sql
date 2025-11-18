-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 18/11/2025 às 01:49
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `castaway`
--

CREATE DATABASE castaway;

USE castaway;

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarvendedorPorID` (IN `vendedor_id` INT)   BEGIN
    SELECT * FROM vendedor WHERE vendedor.PK_Id_vendedor = vendedor_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarArmaduras` ()   BEGIN
SELECT * FROM item, tipo_item WHERE item.FK_Id_tipo_item=tipo_item.PK_Id_tipo_item AND tipo_item.PK_Id_tipo_item=3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarArmas` ()   BEGIN
SELECT * FROM item, tipo_item WHERE item.FK_Id_tipo_item=tipo_item.PK_Id_tipo_item AND tipo_item.PK_Id_tipo_item=2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarDialogosdeVendedor` (IN `Id_procurado` INT)   BEGIN
SELECT vendedor.Vendedor_nome, dialogos.Dialogo_1, dialogos.Dialogo_2, dialogos.Dialogo_3 FROM dialogos, vendedor WHERE vendedor.PK_Id_vendedor=Id_procurado AND vendedor.FK_Id_dialogos=dialogos.PK_Id_dialogos;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarInfoInimigos` ()   BEGIN
    SELECT * FROM inimigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarItemsInfos` ()   BEGIN
    SELECT * FROM item;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarItensAPartirdeCertoValor` (IN `preco_min` INT)   BEGIN
    SELECT * FROM item WHERE item.PrecoC_item > preco_min;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarItensConsumíveis` ()   BEGIN
SELECT * FROM item, tipo_item WHERE item.FK_Id_tipo_item=tipo_item.PK_Id_tipo_item AND tipo_item.PK_Id_tipo_item=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarItensLucrativos` ()   BEGIN
    SELECT * FROM item WHERE item.PrecoV_item > item.PrecoC_item;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarPontosdeSave` ()   BEGIN
SELECT * FROM tela WHERE tela.Pode_salvar=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarStatusInimigo` (IN `pkey_Id_inimigo` INT)   BEGIN
SELECT Inimigo_nome, HP_inimigo, ATQ_inimigo, DEF_inimigo
FROM inimigo
WHERE PK_Id_inimigo = pkey_Id_inimigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarStatusPlayer` (IN `pkey_Id_player` INT)   BEGIN
SELECT Nome_player, HP_player, ATQ_player, DEF_player, Level_player, Gold_player, Tempo_player
FROM player
WHERE PK_Id_player = pkey_Id_player;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTelas` ()   BEGIN
SELECT * FROM tela;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTelasQueNãoPodeSalvar` ()   BEGIN
    SELECT * FROM tela WHERE tela.Pode_salvar = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarVendedores` ()   BEGIN
SELECT vendedor.Vendedor_nome, vendedor.Pode_comprar, dialogos.Dialogo_1, dialogos.Dialogo_2, dialogos.Dialogo_3 FROM vendedor, dialogos WHERE vendedor.FK_Id_dialogos=dialogos.PK_Id_dialogos;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `dialogos`
--

CREATE TABLE `dialogos` (
  `PK_Id_dialogos` int(2) NOT NULL,
  `Dialogo_1` varchar(30) DEFAULT NULL,
  `Dialogo_2` varchar(30) DEFAULT NULL,
  `Dialogo_3` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `dialogos`
--

INSERT INTO `dialogos` (`PK_Id_dialogos`, `Dialogo_1`, `Dialogo_2`, `Dialogo_3`) VALUES
(1, 'Bem-vindo!', 'Quer comprar algo?', 'Volte sempre!'),
(2, 'Olá aventureiro', 'Tenho itens raros', 'Até logo!'),
(3, 'Oi!', 'Precisa de ajuda?', 'Tchau!'),
(4, 'Cuidado na estrada', 'Aqui é perigoso', 'Boa sorte!'),
(5, 'Novidades na loja', 'Aproveite as ofertas', 'Até mais!'),
(6, 'Precisa de poções?', 'Tenho de todos os tipos', 'Não se perca!'),
(7, 'Treine seus poderes', 'Não subestime inimigos', 'Volte aqui depois'),
(8, 'Espadas à venda', 'Defesas também', 'Boas compras!'),
(9, 'Olá estranho', 'Posso te vender algo?', 'Adeus!'),
(10, 'Venha se equipar', 'Itens raros disponíveis', 'Não demore!'),
(11, 'Tudo por ouro', 'Tem itens exclusivos', 'Até a próxima!'),
(12, 'Pronto para batalha?', 'Aqui tem suprimentos', 'Boa sorte!'),
(13, 'Bem-vindo ao bazar', 'Olhe com cuidado', 'Até logo!'),
(14, 'Aventureiro!', 'Compre o melhor equipamento', 'Não volte de mãos vazias!'),
(15, 'Últimas novidades', 'Itens poderosos', 'Volte sempre!');

-- --------------------------------------------------------

--
-- Estrutura para tabela `inimigo`
--

CREATE TABLE `inimigo` (
  `PK_Id_inimigo` int(2) NOT NULL,
  `Inimigo_nome` varchar(20) DEFAULT NULL,
  `HP_inimigo` int(4) DEFAULT NULL,
  `ATQ_inimigo` int(3) DEFAULT NULL,
  `DEF_inimigo` int(3) DEFAULT NULL,
  `FK_Id_tipo_person` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `inimigo`
--

INSERT INTO `inimigo` (`PK_Id_inimigo`, `Inimigo_nome`, `HP_inimigo`, `ATQ_inimigo`, `DEF_inimigo`, `FK_Id_tipo_person`) VALUES
(1, 'Goblin', 50, 10, 5, 2),
(2, 'Orc', 120, 25, 10, 2),
(3, 'Troll', 200, 35, 20, 2),
(4, 'Esqueleto', 40, 15, 5, 2),
(5, 'Zumbi', 60, 12, 8, 2),
(6, 'Lobo', 70, 18, 6, 2),
(7, 'Mago Sombrio', 80, 30, 5, 2),
(8, 'Aranha Gigante', 90, 22, 10, 2),
(9, 'Draconato', 150, 40, 25, 2),
(10, 'Liche', 100, 35, 15, 2),
(11, 'Demônio', 180, 50, 30, 2),
(12, 'Tigre Selvagem', 75, 20, 10, 2),
(13, 'Fantasma', 60, 28, 5, 2),
(14, 'Minotauro', 160, 45, 25, 2),
(15, 'Banshee', 90, 32, 8, 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `inventario`
--

CREATE TABLE `inventario` (
  `PK_Id_inv` int(1) NOT NULL,
  `Qtd_inv` int(1) DEFAULT NULL,
  `FK_Id_item` int(2) DEFAULT NULL,
  `FK_Id_tipo_inv` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `inventario`
--

INSERT INTO `inventario` (`PK_Id_inv`, `Qtd_inv`, `FK_Id_item`, `FK_Id_tipo_inv`) VALUES
(1, 5, 1, 1),
(2, 3, 2, 1),
(3, 2, 3, 1),
(4, 1, 4, 1),
(5, 4, 5, 1),
(6, 2, 6, 1),
(7, 6, 7, 1),
(8, 3, 8, 1),
(9, 5, 9, 1),
(10, 2, 10, 1),
(11, 1, 11, 1),
(12, 3, 12, 1),
(13, 4, 13, 1),
(14, 2, 14, 1),
(15, 1, 15, 1),
(16, 10, 1, 2),
(17, 8, 2, 2),
(18, 5, 3, 2),
(19, 3, 4, 2),
(20, 7, 5, 2),
(21, 4, 6, 2),
(22, 6, 7, 2),
(23, 5, 8, 2),
(24, 9, 9, 2),
(25, 4, 10, 2),
(26, 3, 11, 2),
(27, 6, 12, 2),
(28, 5, 13, 2),
(29, 2, 14, 2),
(30, 1, 15, 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `item`
--

CREATE TABLE `item` (
  `PK_Id_item` int(2) NOT NULL,
  `Nome_item` varchar(20) DEFAULT NULL,
  `Desc_item` varchar(30) DEFAULT NULL,
  `PrecoC_item` int(4) DEFAULT NULL,
  `PrecoV_item` int(4) DEFAULT NULL,
  `Valor_item` int(3) DEFAULT NULL,
  `FK_Id_tipo_item` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `item`
--

INSERT INTO `item` (`PK_Id_item`, `Nome_item`, `Desc_item`, `PrecoC_item`, `PrecoV_item`, `Valor_item`, `FK_Id_tipo_item`) VALUES
(1, 'Poção', 'Restaura HP', 10, 15, 20, 1),
(2, 'Elixir', 'Restaura MP', 20, 30, 15, 1),
(3, 'Poção Superior', 'Restaura muito HP', 50, 70, 50, 1),
(4, 'Espada', 'Ataque médio', 50, 70, 15, 2),
(5, 'Machado', 'Ataque alto', 80, 100, 25, 2),
(6, 'Adaga', 'Ataque rápido', 30, 45, 10, 2),
(7, 'Arco', 'Ataque à distância', 60, 80, 20, 2),
(8, 'Escudo', 'Defesa alta', 40, 60, 25, 3),
(9, 'Capacete', 'Defesa média', 30, 45, 15, 3),
(10, 'Armadura', 'Defesa total', 100, 150, 50, 3),
(11, 'Botas', 'Aumenta agilidade', 25, 35, 10, 3),
(12, 'Luvas', 'Melhora ataque', 20, 30, 5, 3),
(13, 'Capa', 'Reduz dano mágico', 35, 50, 15, 3),
(14, 'Amuleto', 'Proteção extra', 50, 70, 20, 3),
(15, 'Anel', 'Aumenta HP', 40, 55, 10, 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `player`
--

CREATE TABLE `player` (
  `PK_Id_player` int(1) NOT NULL,
  `Nome_player` varchar(10) DEFAULT NULL,
  `HP_player` int(2) DEFAULT NULL,
  `ATQ_player` int(2) DEFAULT NULL,
  `DEF_player` int(2) DEFAULT NULL,
  `Level_player` int(2) DEFAULT NULL,
  `XP_player` int(4) DEFAULT NULL,
  `Gold_player` int(4) DEFAULT NULL,
  `Tempo_player` time DEFAULT NULL,
  `FK_Id_inv` int(1) DEFAULT NULL,
  `FK_Id_tela` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `player`
--

INSERT INTO `player` (`PK_Id_player`, `Nome_player`, `HP_player`, `ATQ_player`, `DEF_player`, `Level_player`, `XP_player`, `Gold_player`, `Tempo_player`, `FK_Id_inv`, `FK_Id_tela`) VALUES
(1, 'Frisk1', 100, 20, 15, 1, 0, 50, '00:10:00', 1, 1),
(2, 'Frisk2', 120, 25, 12, 2, 50, 70, '00:15:00', 2, 2),
(3, 'Frisk3', 90, 18, 10, 1, 0, 30, '00:08:00', 3, 3),
(4, 'Kris1', 110, 22, 13, 1, 0, 40, '00:12:00', 4, 4),
(5, 'Kris2', 130, 27, 14, 2, 0, 60, '00:20:00', 5, 5),
(6, 'Kris3', 95, 19, 11, 1, 0, 35, '00:09:00', 6, 6),
(7, 'Player7', 105, 21, 12, 1, 0, 45, '00:11:00', 7, 7),
(8, 'Player8', 115, 23, 13, 1, 0, 50, '00:13:00', 8, 8),
(9, 'Player9', 125, 26, 15, 2, 0, 70, '00:18:00', 9, 9),
(10, 'Player10', 100, 20, 15, 1, 0, 50, '00:10:00', 10, 10),
(11, 'Player11', 120, 25, 12, 2, 0, 60, '00:15:00', 11, 11),
(12, 'Player12', 90, 18, 10, 1, 0, 35, '00:08:00', 12, 12),
(13, 'Player13', 110, 22, 13, 1, 0, 40, '00:12:00', 13, 13),
(14, 'Player14', 130, 27, 14, 2, 0, 65, '00:20:00', 14, 14),
(15, 'Player15', 95, 19, 11, 1, 0, 35, '00:09:00', 15, 15);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tela`
--

CREATE TABLE `tela` (
  `PK_Id_tela` int(3) NOT NULL,
  `Coord_X` int(4) DEFAULT NULL,
  `Coord_Y` int(4) DEFAULT NULL,
  `Pode_salvar` tinyint(1) DEFAULT NULL,
  `Qtd_kills` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tela`
--

INSERT INTO `tela` (`PK_Id_tela`, `Coord_X`, `Coord_Y`, `Pode_salvar`, `Qtd_kills`) VALUES
(1, 0, 0, 1, 0),
(2, 10, 5, 0, 2),
(3, 20, 10, 1, 5),
(4, 30, 15, 0, 3),
(5, 40, 20, 1, 1),
(6, 50, 25, 0, 0),
(7, 60, 30, 1, 4),
(8, 70, 35, 0, 6),
(9, 80, 40, 1, 2),
(10, 90, 45, 0, 3),
(11, 100, 50, 1, 0),
(12, 110, 55, 0, 7),
(13, 120, 60, 1, 5),
(14, 130, 65, 0, 1),
(15, 140, 70, 1, 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_inventario`
--

CREATE TABLE `tipo_inventario` (
  `PK_Id_tipo_inv` int(1) NOT NULL,
  `Nome_tipo` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tipo_inventario`
--

INSERT INTO `tipo_inventario` (`PK_Id_tipo_inv`, `Nome_tipo`) VALUES
(1, 'Player'),
(2, 'Vendedor');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_item`
--

CREATE TABLE `tipo_item` (
  `PK_Id_tipo_item` int(1) NOT NULL,
  `Nome_tipo` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tipo_item`
--

INSERT INTO `tipo_item` (`PK_Id_tipo_item`, `Nome_tipo`) VALUES
(1, 'Cura'),
(2, 'Arma'),
(3, 'Armadura');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_personagem`
--

CREATE TABLE `tipo_personagem` (
  `PK_Id_tipo_person` int(1) NOT NULL,
  `Nome_tipo` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tipo_personagem`
--

INSERT INTO `tipo_personagem` (`PK_Id_tipo_person`, `Nome_tipo`) VALUES
(1, 'Vendedor'),
(2, 'Inimigo');

-- --------------------------------------------------------

--
-- Estrutura para tabela `vendedor`
--

CREATE TABLE `vendedor` (
  `PK_Id_vendedor` int(2) NOT NULL,
  `Vendedor_nome` varchar(15) NOT NULL,
  `Pode_comprar` tinyint(1) DEFAULT NULL,
  `FK_Id_inv` int(1) DEFAULT NULL,
  `FK_Id_dialogos` int(2) DEFAULT NULL,
  `FK_Id_tipo_person` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `vendedor`
--

INSERT INTO `vendedor` (`PK_Id_vendedor`, `Vendedor_nome`, `Pode_comprar`, `FK_Id_inv`, `FK_Id_dialogos`, `FK_Id_tipo_person`) VALUES
(1, 'Temmie', 1, 16, 1, 1),
(2, 'Shopkeeper', 0, 17, 2, 1),
(3, 'Ralsei', 1, 18, 3, 1),
(4, 'Alphys', 1, 19, 4, 1),
(5, 'Toriel', 0, 20, 5, 1),
(6, 'Asriel', 1, 21, 6, 1),
(7, 'Sans', 0, 22, 7, 1),
(8, 'Papyrus', 0, 23, 8, 1),
(9, 'Noelle', 1, 24, 9, 1),
(10, 'Susie', 1, 25, 10, 1),
(11, 'Lancer', 0, 26, 11, 1),
(12, 'Kris', 1, 27, 12, 1),
(13, 'Berdly', 0, 28, 13, 1),
(14, 'Queen', 1, 29, 14, 1),
(15, 'Rouxls', 0, 30, 15, 1);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `dialogos`
--
ALTER TABLE `dialogos`
  ADD PRIMARY KEY (`PK_Id_dialogos`);

--
-- Índices de tabela `inimigo`
--
ALTER TABLE `inimigo`
  ADD PRIMARY KEY (`PK_Id_inimigo`),
  ADD KEY `FK_Id_tipo_person` (`FK_Id_tipo_person`);

--
-- Índices de tabela `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`PK_Id_inv`),
  ADD KEY `FK_Id_item` (`FK_Id_item`),
  ADD KEY `FK_Id_tipo_inv` (`FK_Id_tipo_inv`);

--
-- Índices de tabela `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`PK_Id_item`),
  ADD KEY `FK_Id_tipo_item` (`FK_Id_tipo_item`);

--
-- Índices de tabela `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`PK_Id_player`),
  ADD KEY `FK_Id_inv` (`FK_Id_inv`),
  ADD KEY `FK_Id_tela` (`FK_Id_tela`);

--
-- Índices de tabela `tela`
--
ALTER TABLE `tela`
  ADD PRIMARY KEY (`PK_Id_tela`);

--
-- Índices de tabela `tipo_inventario`
--
ALTER TABLE `tipo_inventario`
  ADD PRIMARY KEY (`PK_Id_tipo_inv`);

--
-- Índices de tabela `tipo_item`
--
ALTER TABLE `tipo_item`
  ADD PRIMARY KEY (`PK_Id_tipo_item`);

--
-- Índices de tabela `tipo_personagem`
--
ALTER TABLE `tipo_personagem`
  ADD PRIMARY KEY (`PK_Id_tipo_person`);

--
-- Índices de tabela `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`PK_Id_vendedor`),
  ADD KEY `FK_Id_inv` (`FK_Id_inv`),
  ADD KEY `FK_Id_dialogos` (`FK_Id_dialogos`),
  ADD KEY `FK_Id_tipo_person` (`FK_Id_tipo_person`);

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `inimigo`
--
ALTER TABLE `inimigo`
  ADD CONSTRAINT `inimigo_ibfk_1` FOREIGN KEY (`FK_Id_tipo_person`) REFERENCES `tipo_personagem` (`PK_Id_tipo_person`);

--
-- Restrições para tabelas `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`FK_Id_item`) REFERENCES `item` (`PK_Id_item`),
  ADD CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`FK_Id_tipo_inv`) REFERENCES `tipo_inventario` (`PK_Id_tipo_inv`);

--
-- Restrições para tabelas `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `item_ibfk_1` FOREIGN KEY (`FK_Id_tipo_item`) REFERENCES `tipo_item` (`PK_Id_tipo_item`);

--
-- Restrições para tabelas `player`
--
ALTER TABLE `player`
  ADD CONSTRAINT `player_ibfk_1` FOREIGN KEY (`FK_Id_inv`) REFERENCES `inventario` (`PK_Id_inv`),
  ADD CONSTRAINT `player_ibfk_2` FOREIGN KEY (`FK_Id_tela`) REFERENCES `tela` (`PK_Id_tela`);

--
-- Restrições para tabelas `vendedor`
--
ALTER TABLE `vendedor`
  ADD CONSTRAINT `vendedor_ibfk_1` FOREIGN KEY (`FK_Id_inv`) REFERENCES `inventario` (`PK_Id_inv`),
  ADD CONSTRAINT `vendedor_ibfk_2` FOREIGN KEY (`FK_Id_dialogos`) REFERENCES `dialogos` (`PK_Id_dialogos`),
  ADD CONSTRAINT `vendedor_ibfk_3` FOREIGN KEY (`FK_Id_tipo_person`) REFERENCES `tipo_personagem` (`PK_Id_tipo_person`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
