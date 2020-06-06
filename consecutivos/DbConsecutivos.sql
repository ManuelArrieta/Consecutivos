-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 05-06-2020 a las 19:37:04
-- Versión del servidor: 5.7.23-23
-- Versión de PHP: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hackersj_consecutivos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consecutivos`
--

CREATE TABLE `consecutivos` (
  `indice` bigint(20) NOT NULL,
  `codigo_dependencia` int(5) NOT NULL,
  `codigo_serie` int(11) NOT NULL,
  `codigo_tdocumental` int(11) NOT NULL,
  `consecutivo` bigint(20) NOT NULL,
  `cedula` int(11) NOT NULL,
  `asunto` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `fechaRegistro` date NOT NULL,
  `destinatario` varchar(40) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `consecutivos`
--

INSERT INTO `consecutivos` (`indice`, `codigo_dependencia`, `codigo_serie`, `codigo_tdocumental`, `consecutivo`, `cedula`, `asunto`, `fechaRegistro`, `destinatario`) VALUES
(2, 41, 27, 3, 321, 1112462635, 'Relación entrega de Doc', '2020-05-28', 'Germán Cifuentes '),
(3, 41, 27, 3, 348, 38669670, 'Rad. Documentos contratacion', '2020-05-29', 'Juridica'),
(4, 41, 19, 2, 349, 31536913, 'Tarifas servicio público ', '2020-06-03', 'Fernando Alexis Mosquera'),
(5, 41, 27, 2, 1, 38669670, 'Caja menor de abril ', '2020-06-05', 'Secretaria de Hacienda '),
(7, 41, 1, 2, 1, 1112476082, 'Mod. USP 790', '2020-06-05', 'RUNT');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dependencia`
--

CREATE TABLE `dependencia` (
  `codigo_dependencia` int(11) NOT NULL,
  `nombre` varchar(30) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `dependencia`
--

INSERT INTO `dependencia` (`codigo_dependencia`, `nombre`) VALUES
(41, 'S. TRANSITO Y TRANSPORTE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `series`
--

CREATE TABLE `series` (
  `codigo_dependencia` int(11) NOT NULL,
  `codigo_serie` int(11) NOT NULL,
  `nombre` varchar(25) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `series`
--

INSERT INTO `series` (`codigo_dependencia`, `codigo_serie`, `nombre`) VALUES
(41, 2, 'ACCION DE TUTELA'),
(41, 7, 'CERTIFICADOS'),
(41, 8, 'CIRCULARES'),
(41, 19, 'D. PETICION'),
(41, 27, 'INFORMES'),
(41, 1, 'ACTOS ADMINISTRATIVOS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documental`
--

CREATE TABLE `tipo_documental` (
  `indice` bigint(20) NOT NULL,
  `codigo_dependencia` int(11) NOT NULL,
  `codigo_serie` int(11) NOT NULL,
  `codigo_tdocumental` int(11) NOT NULL,
  `nombre` varchar(30) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_documental`
--

INSERT INTO `tipo_documental` (`indice`, `codigo_dependencia`, `codigo_serie`, `codigo_tdocumental`, `nombre`) VALUES
(1, 41, 2, 2, 'Tutela'),
(2, 41, 2, 1, 'Pruebas'),
(3, 41, 2, 3, 'Respuestas'),
(4, 41, 7, 3, 'Chequeo Centro Diagnostico'),
(5, 41, 7, 4, 'Fotocopia Seguro Obligatorio'),
(6, 41, 7, 5, 'Orden de revision'),
(7, 41, 7, 6, 'Recibo de pago'),
(8, 41, 7, 7, 'Solicitud'),
(9, 41, 7, 8, 'C. Tradicion'),
(14, 41, 27, 1, 'Informe de gestion'),
(10, 41, 8, 1, 'Circular Informativa'),
(11, 41, 8, 2, 'Circular Normativa'),
(12, 41, 19, 1, 'Solicitud Derecho P.'),
(13, 41, 19, 2, 'Respuesta Derecho P'),
(15, 41, 27, 2, 'Informe Mensual'),
(16, 41, 27, 3, 'Informe de Gestion'),
(17, 41, 27, 4, 'Informe al Ministerio de Trans'),
(18, 41, 27, 5, 'Informe Contravencion'),
(19, 41, 27, 6, 'Informe Centro Diagnostico'),
(20, 41, 27, 7, 'Informe Infraestructura'),
(21, 41, 27, 8, 'Informe Actividades'),
(22, 41, 1, 2, 'Resolucion'),
(23, 41, 1, 1, 'Decreto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `CEDULA` bigint(20) NOT NULL,
  `NOMBRE_COMPLETO` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `PASSWORD` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `codigo_dependencia` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`CEDULA`, `NOMBRE_COMPLETO`, `PASSWORD`, `codigo_dependencia`) VALUES
(1112462635, 'Maria Alejandra Castaño', 'Aleja2020*', 41),
(38669670, 'Angie Henao', 'Angie2020*', 41),
(31536913, 'Giselle Gutierrez', 'Giselle2020*', 41),
(1112476082, 'Manuel Arrieta', 'Manuel2020*', 41);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `consecutivos`
--
ALTER TABLE `consecutivos`
  ADD PRIMARY KEY (`indice`);

--
-- Indices de la tabla `dependencia`
--
ALTER TABLE `dependencia`
  ADD PRIMARY KEY (`codigo_dependencia`);

--
-- Indices de la tabla `series`
--
ALTER TABLE `series`
  ADD PRIMARY KEY (`codigo_serie`);

--
-- Indices de la tabla `tipo_documental`
--
ALTER TABLE `tipo_documental`
  ADD PRIMARY KEY (`indice`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`CEDULA`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `consecutivos`
--
ALTER TABLE `consecutivos`
  MODIFY `indice` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
