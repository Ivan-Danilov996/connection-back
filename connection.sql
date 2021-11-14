-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Ноя 15 2021 г., 00:07
-- Версия сервера: 8.0.19
-- Версия PHP: 7.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `connection`
--

-- --------------------------------------------------------

--
-- Структура таблицы `cause-call`
--

CREATE TABLE `cause-call` (
  `id` int NOT NULL,
  `name` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `cause-call`
--

INSERT INTO `cause-call` (`id`, `name`) VALUES
(1, 'Типичная причина №1'),
(2, 'Типичная причина №2'),
(3, 'Типичная причина №3'),
(4, 'Типичная причина №4');

-- --------------------------------------------------------

--
-- Структура таблицы `cause-close`
--

CREATE TABLE `cause-close` (
  `id` int NOT NULL,
  `name` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `cause-close`
--

INSERT INTO `cause-close` (`id`, `name`) VALUES
(1, 'Причина завершения #1'),
(2, 'Причина завершения #2'),
(3, 'Причина завершения #3'),
(4, 'Причина завершения #4');

-- --------------------------------------------------------

--
-- Структура таблицы `cities`
--

CREATE TABLE `cities` (
  `id` int NOT NULL,
  `name` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `cities`
--

INSERT INTO `cities` (`id`, `name`) VALUES
(4, 'Казань'),
(5, 'Краснодар'),
(1, 'Москва'),
(3, 'Санкт Петербург');

-- --------------------------------------------------------

--
-- Структура таблицы `provider`
--

CREATE TABLE `provider` (
  `id` int NOT NULL,
  `name` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `provider`
--

INSERT INTO `provider` (`id`, `name`) VALUES
(1, 'МТС'),
(3, 'Ростелеком'),
(4, 'Дом.ру');

-- --------------------------------------------------------

--
-- Структура таблицы `request`
--

CREATE TABLE `request` (
  `id` int NOT NULL,
  `city_id` int NOT NULL,
  `fio` varchar(128) NOT NULL,
  `address` varchar(256) NOT NULL,
  `cause_id` int NOT NULL,
  `comment` varchar(256) DEFAULT NULL,
  `tel` varchar(20) NOT NULL,
  `tel-additional` varchar(20) DEFAULT NULL,
  `provider_id` int DEFAULT NULL,
  `tariff_id` int DEFAULT NULL,
  `cause-close_id` int DEFAULT NULL,
  `active` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `request`
--

INSERT INTO `request` (`id`, `city_id`, `fio`, `address`, `cause_id`, `comment`, `tel`, `tel-additional`, `provider_id`, `tariff_id`, `cause-close_id`, `active`) VALUES
(35, 4, 'Иван', 'Ватутина 6', 1, '', '+7(898) 751-11-02', '', 1, 1, NULL, 1),
(36, 4, 'Иван', 'Ватутина 6', 1, '', '+7(898) 751-11-02', '', NULL, NULL, NULL, 1),
(37, 4, 'Иван', 'Ватутина 6', 1, '', '+7(898) 751-11-02', '', NULL, NULL, NULL, 1),
(38, 4, 'Иван', 'Ватутина 6', 1, '', '+7(898) 751-11-02', '', 1, 1, NULL, 1),
(39, 4, 'Иван', 'Ватутина 6', 1, '', '+7(898) 751-11-02', '', NULL, NULL, NULL, 1),
(40, 4, 'Иван', 'Ватутина 6', 1, '', '+7(898) 751-11-02', '', NULL, NULL, NULL, 1),
(41, 4, 'Иван', 'Ватутина 6', 1, '', '+7(898) 751-11-02', '', 3, 5, NULL, 0),
(42, 4, 'Иван', 'Ватутина 6', 1, '', '+7(898) 751-11-02', '', NULL, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `services`
--

CREATE TABLE `services` (
  `id` int NOT NULL,
  `serviceName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `services`
--

INSERT INTO `services` (`id`, `serviceName`) VALUES
(1, 'Мобильная связь'),
(2, 'Домашний интернет'),
(3, 'ТВ');

-- --------------------------------------------------------

--
-- Структура таблицы `tariff`
--

CREATE TABLE `tariff` (
  `id` int NOT NULL,
  `tariffName` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` int NOT NULL,
  `provider_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `tariff`
--

INSERT INTO `tariff` (`id`, `tariffName`, `price`, `provider_id`) VALUES
(1, 'XXL', 1000, 1),
(3, 'XL', 800, 1),
(4, 'L', 600, 1),
(5, 'Ultra', 1000, 3),
(6, 'Mega', 900, 3),
(7, 'Standart', 500, 3),
(8, 'Red', 900, 4),
(9, 'Green', 700, 4),
(10, 'Blue', 500, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `tariff_services`
--

CREATE TABLE `tariff_services` (
  `id` int NOT NULL,
  `tariff_id` int NOT NULL,
  `services_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `tariff_services`
--

INSERT INTO `tariff_services` (`id`, `tariff_id`, `services_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 3, 2),
(5, 3, 3),
(6, 4, 2),
(7, 5, 1),
(8, 5, 2),
(9, 5, 3),
(10, 6, 1),
(11, 6, 2),
(12, 7, 2),
(13, 8, 1),
(14, 8, 2),
(15, 8, 3),
(16, 9, 1),
(17, 9, 2),
(18, 10, 2);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `cause-call`
--
ALTER TABLE `cause-call`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cause-close`
--
ALTER TABLE `cause-close`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `provider`
--
ALTER TABLE `provider`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `cause_id` (`cause_id`),
  ADD KEY `provider_id` (`provider_id`),
  ADD KEY `tariff_id` (`tariff_id`),
  ADD KEY `cause-close_id` (`cause-close_id`);

--
-- Индексы таблицы `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `tariff`
--
ALTER TABLE `tariff`
  ADD PRIMARY KEY (`id`),
  ADD KEY `provider_id` (`provider_id`);

--
-- Индексы таблицы `tariff_services`
--
ALTER TABLE `tariff_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tariff_id` (`tariff_id`),
  ADD KEY `services_id` (`services_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `cause-call`
--
ALTER TABLE `cause-call`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `cause-close`
--
ALTER TABLE `cause-close`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `provider`
--
ALTER TABLE `provider`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `request`
--
ALTER TABLE `request`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT для таблицы `services`
--
ALTER TABLE `services`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `tariff`
--
ALTER TABLE `tariff`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `tariff_services`
--
ALTER TABLE `tariff_services`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `request_ibfk_1` FOREIGN KEY (`cause_id`) REFERENCES `cause-call` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `request_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `tariff`
--
ALTER TABLE `tariff`
  ADD CONSTRAINT `tariff_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `tariff_services`
--
ALTER TABLE `tariff_services`
  ADD CONSTRAINT `tariff_services_ibfk_1` FOREIGN KEY (`services_id`) REFERENCES `services` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `tariff_services_ibfk_2` FOREIGN KEY (`tariff_id`) REFERENCES `tariff` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
