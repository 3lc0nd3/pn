-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 16-01-2013 a las 20:06:38
-- Versión del servidor: 5.5.28
-- Versión de PHP: 5.4.6-1ubuntu1.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `pn`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo_empleado`
--

CREATE TABLE IF NOT EXISTS `cargo_empleado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_cargo` int(11) NOT NULL COMMENT 'Tabla Tipo Cargo Empleado',
  `cargo` varchar(400) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_tipo_cargo` (`id_tipo_cargo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Cargo del empleado segun convocatoria' AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `cargo_empleado`
--

INSERT INTO `cargo_empleado` (`id`, `id_tipo_cargo`, `cargo`) VALUES
(1, 1, 'Líder Evaluador'),
(2, 1, 'Evaluador'),
(3, 2, 'Gerente General'),
(4, 2, 'Director'),
(5, 2, 'Presidente'),
(6, 2, 'Supervisor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE IF NOT EXISTS `empleado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_participante` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `id_cargo` int(11) NOT NULL,
  `id_perfil` int(11) NOT NULL,
  `fecha_ingreso` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_convocatoria` (`id_participante`),
  KEY `id_persona` (`id_persona`),
  KEY `id_cargo` (`id_cargo`),
  KEY `id_perfil` (`id_perfil`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='imagen de como era la empresa en esa convocatoria' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE IF NOT EXISTS `empresa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_empresa` int(11) NOT NULL,
  `id_categoria_empresa` int(11) NOT NULL,
  `id_categoria_tamano_empresa` int(11) NOT NULL,
  `nit` varchar(100) NOT NULL,
  `id_ciudad` int(10) unsigned NOT NULL,
  `direccion` varchar(300) NOT NULL,
  `nombre` varchar(600) NOT NULL,
  `tel_fijo` varchar(100) DEFAULT NULL,
  `tel_movil` varchar(20) DEFAULT NULL,
  `web` varchar(200) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `actividad_principal` text,
  `productos` text,
  `marcas` text,
  `alcance_mercado` varchar(20) DEFAULT NULL,
  `empleados` int(11) DEFAULT NULL,
  `valor_activos` varchar(30) DEFAULT NULL,
  `publica` int(11) DEFAULT NULL,
  `file_certificado_constitucion` varchar(600) DEFAULT NULL,
  `file_estado_financiero` varchar(600) DEFAULT NULL,
  `file_consignacion` varchar(600) DEFAULT NULL,
  `estado` int(11) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nit` (`nit`),
  KEY `id_tipo_empresa` (`id_tipo_empresa`),
  KEY `id_ciudad` (`id_ciudad`),
  KEY `id_categoria_empresa` (`id_categoria_empresa`),
  KEY `id_categoria_tamano_empresa` (`id_categoria_tamano_empresa`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`id`, `id_tipo_empresa`, `id_categoria_empresa`, `id_categoria_tamano_empresa`, `nit`, `id_ciudad`, `direccion`, `nombre`, `tel_fijo`, `tel_movil`, `web`, `email`, `actividad_principal`, `productos`, `marcas`, `alcance_mercado`, `empleados`, `valor_activos`, `publica`, `file_certificado_constitucion`, `file_estado_financiero`, `file_consignacion`, `estado`, `fecha_creacion`) VALUES
(1, 2, 1, 5, '777', 151, 'dire local', 'Sonido Local', '999-111-777', '300-300+300', 'http://hola.com', 'elcorreo@dominio.com', 'mi actividad', 'vainas', 'no hay marcas', '1', 324, '9223372036854775807', 2, '7593A32FD1B48\n', '/home/usuariox/tmp/estado.pdf', 'bogota \n\n076-026400\n\n\n', 0, '2013-01-10 07:51:08'),
(2, 2, 1, 5, '778', 127, 'dire local', 'Sonido Local', '999-111-777', '300-300+300', 'http://hola.com', 'elcorreo@dominio.com', 'mi actividad', 'vainas', 'no hay marcas', '1', 324, '789456', 2, '/home/usuariox/IdeaProjects/pn/target/pn/pdfs/cc-778', '/home/usuariox/IdeaProjects/pn/target/pn/pdfs/ef-778', '/home/usuariox/IdeaProjects/pn/target/pn/pdfs/co-778', 0, '2013-01-10 08:20:05'),
(3, 2, 1, 1, '345', 127, 'cll ', 'Una empresa', '555', '9090', '', 'algo@gg.com', 'ac', 'pr', 'mar', '1', 44, '56', 1, '/usr/local/tomcat6/webapps/pn/pdfs/cc-345', '/usr/local/tomcat6/webapps/pn/pdfs/ef-345', '/usr/local/tomcat6/webapps/pn/pdfs/co-345', 0, '2013-01-10 08:51:37'),
(4, 2, 2, 4, '8908052674', 320, 'km 10 via la calera', 'dulces la felicidad', '5678909', '3107689854', '', 'dulceslafelicidad@dulceslafelicidad.com', 'producción de confiteria', 'caramelos masticables, chiles y agregados', 'Americana', '1', 123, '123034', 2, '/usr/local/tomcat6/webapps/pn/pdfs/cc-8908052674', '/usr/local/tomcat6/webapps/pn/pdfs/ef-8908052674', '/usr/local/tomcat6/webapps/pn/pdfs/co-8908052674', 0, '2013-01-10 10:26:10'),
(5, 2, 1, 4, '123', 834, 'acca', 'aaaa', '3525215', '2452543542', '', '34324@sdfs.s', 'a', 'b', 'c', '1', 43, '$2,343,534.00', 1, '/home/usuariox/prj/pn/target/pn/pdfs/cc-123', '/home/usuariox/prj/pn/target/pn/pdfs/ef-123', '/home/usuariox/prj/pn/target/pn/pdfs/co-123', 0, '2013-01-14 23:11:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa_categoria`
--

CREATE TABLE IF NOT EXISTS `empresa_categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(300) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `empresa_categoria`
--

INSERT INTO `empresa_categoria` (`id`, `categoria`) VALUES
(1, 'Organización de Servicios'),
(2, 'Organización de Manufactura');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa_categoria_tamano`
--

CREATE TABLE IF NOT EXISTS `empresa_categoria_tamano` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tamano` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `empresa_categoria_tamano`
--

INSERT INTO `empresa_categoria_tamano` (`id`, `tamano`) VALUES
(1, 'Muy grande'),
(2, 'Grande'),
(3, 'Mediana'),
(4, 'Pequeña'),
(5, 'Microempresa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `loc_ciudad`
--

CREATE TABLE IF NOT EXISTS `loc_ciudad` (
  `id_ciudad` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo_ciudad` varchar(100) DEFAULT NULL,
  `nombre_ciudad` varchar(600) NOT NULL,
  `id_estado` int(11) unsigned DEFAULT NULL,
  `nombre_estado` varchar(600) DEFAULT NULL,
  `latitud_ciudad` int(11) DEFAULT NULL,
  `longitud_ciudad` int(11) DEFAULT NULL,
  `activo_ciudad` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_ciudad`),
  KEY `id_state` (`id_estado`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1104 ;

--
-- Volcado de datos para la tabla `loc_ciudad`
--

INSERT INTO `loc_ciudad` (`id_ciudad`, `codigo_ciudad`, `nombre_ciudad`, `id_estado`, `nombre_estado`, `latitud_ciudad`, `longitud_ciudad`, `activo_ciudad`) VALUES
(0, '1', 'Sin Origen', 1, 'Ninguno', 1, 1, 1),
(2, '5001', 'Medellín', 5, 'Antioquia', 6, -76, 1),
(3, '5002', 'Abejorral', 5, 'Antioquia', 6, -75, 1),
(4, '5004', 'Abriaquí', 5, 'Antioquia', 7, -76, 1),
(5, '5021', 'Alejandria', 5, 'Antioquia', 6, -75, 1),
(6, '5030', 'Amagá', 5, 'Antioquia', 6, -76, 1),
(7, '5031', 'Amalfi', 5, 'Antioquia', 7, -75, 1),
(8, '5034', 'Andes', 5, 'Antioquia', 6, -76, 1),
(9, '5036', 'Angelópolis', 5, 'Antioquia', 6, -76, 1),
(10, '5038', 'Angostura', 5, 'Antioquia', 7, -75, 1),
(11, '5040', 'Anorí', 5, 'Antioquia', 7, -75, 1),
(12, '5042', 'Santa Fé de Antioquia', 5, 'Antioquia', 7, -76, 1),
(13, '5044', 'Anzá', 5, 'Antioquia', 6, -76, 1),
(14, '5045', 'Apartadó', 5, 'Antioquia', 8, -77, 1),
(15, '5051', 'Arboletes', 5, 'Antioquia', 9, -76, 1),
(16, '5055', 'Argelia', 5, 'Antioquia', 6, -75, 1),
(17, '5059', 'Armenia', 5, 'Antioquia', 6, -76, 1),
(18, '5079', 'Barbosa', 5, 'Antioquia', 6, -75, 1),
(19, '5086', 'Belmira', 5, 'Antioquia', 7, -76, 1),
(20, '5088', 'Bello', 5, 'Antioquia', 6, -76, 1),
(21, '5091', 'Betania', 5, 'Antioquia', 6, -76, 1),
(22, '5093', 'Betulia', 5, 'Antioquia', 6, -76, 1),
(23, '5101', 'Bolívar', 5, 'Antioquia', 6, -76, 1),
(24, '5107', 'Briceño', 5, 'Antioquia', 7, -76, 1),
(25, '5113', 'Burítica', 5, 'Antioquia', 7, -76, 1),
(26, '5120', 'Cáceres', 5, 'Antioquia', 8, -75, 1),
(27, '5125', 'Caicedo', 5, 'Antioquia', 6, -76, 1),
(28, '5129', 'Caldas', 5, 'Antioquia', 6, -76, 1),
(29, '5134', 'Campamento', 5, 'Antioquia', 7, -75, 1),
(30, '5138', 'Cañasgordas', 5, 'Antioquia', 7, -76, 1),
(31, '5142', 'Caracolí', 5, 'Antioquia', 6, -75, 1),
(32, '5145', 'Caramanta', 5, 'Antioquia', 6, -76, 1),
(33, '5147', 'Carepa', 5, 'Antioquia', 8, -77, 1),
(34, '5148', 'Carmen de Viboral', 5, 'Antioquia', 6, -75, 1),
(35, '5150', 'Carolina', 5, 'Antioquia', 7, -75, 1),
(36, '5154', 'Caucasia', 5, 'Antioquia', 8, -75, 1),
(37, '5172', 'Chigorodó', 5, 'Antioquia', 8, -77, 1),
(38, '5190', 'Cisneros', 5, 'Antioquia', 7, -75, 1),
(39, '5197', 'Cocorná', 5, 'Antioquia', 6, -75, 1),
(40, '5206', 'Concepción', 5, 'Antioquia', 6, -75, 1),
(41, '5209', 'Concordia', 5, 'Antioquia', 6, -76, 1),
(42, '5212', 'Copacabana', 5, 'Antioquia', 6, -76, 1),
(43, '5234', 'Dabeiba', 5, 'Antioquia', 7, -76, 1),
(44, '5237', 'Don Matías', 5, 'Antioquia', 7, -75, 1),
(45, '5240', 'Ebéjico', 5, 'Antioquia', 6, -76, 1),
(46, '5250', 'El Bagre', 5, 'Antioquia', 8, -75, 1),
(47, '5264', 'Entrerríos', 5, 'Antioquia', 7, -76, 1),
(48, '5266', 'Envigado', 5, 'Antioquia', 6, -76, 1),
(49, '5282', 'Fredonia', 5, 'Antioquia', 6, -76, 1),
(50, '5284', 'Frontino', 5, 'Antioquia', 7, -76, 1),
(51, '5306', 'Giraldo', 5, 'Antioquia', 7, -76, 1),
(52, '5308', 'Girardota', 5, 'Antioquia', 6, -75, 1),
(53, '5310', 'Gómez Plata', 5, 'Antioquia', 7, -76, 1),
(54, '5313', 'Granada', 5, 'Antioquia', 6, -75, 1),
(55, '5315', 'Guadalupe', 5, 'Antioquia', 7, -75, 1),
(56, '5318', 'Guarne', 5, 'Antioquia', 6, -75, 1),
(57, '5321', 'Guatapé', 5, 'Antioquia', 6, -75, 1),
(58, '5347', 'Heliconia', 5, 'Antioquia', 6, -76, 1),
(59, '5353', 'Hispania', 5, 'Antioquia', 6, -76, 1),
(60, '5360', 'Itagüí', 5, 'Antioquia', 6, -76, 1),
(61, '5361', 'Ituango', 5, 'Antioquia', 7, -76, 1),
(62, '5364', 'Jardín', 5, 'Antioquia', 6, -76, 1),
(63, '5368', 'Jericó', 5, 'Antioquia', 6, -76, 1),
(64, '5376', 'La Ceja', 5, 'Antioquia', 6, -75, 1),
(65, '5380', 'La Estrella', 5, 'Antioquia', 6, -76, 1),
(66, '5390', 'La Pintada', 5, 'Antioquia', 6, -76, 1),
(67, '5400', 'La Unión', 5, 'Antioquia', 6, -75, 1),
(68, '5411', 'Liborina', 5, 'Antioquia', 7, -76, 1),
(69, '5425', 'Maceo', 5, 'Antioquia', 7, -75, 1),
(70, '5440', 'Marinilla', 5, 'Antioquia', 6, -75, 1),
(71, '5467', 'Montebello', 5, 'Antioquia', 6, -76, 1),
(72, '5475', 'Murindó', 5, 'Antioquia', 7, -77, 1),
(73, '5480', 'Mutatá', 5, 'Antioquia', 7, -77, 1),
(74, '5483', 'Nariño', 5, 'Antioquia', 6, -75, 1),
(75, '5490', 'Necoclí', 5, 'Antioquia', 8, -77, 1),
(76, '5495', 'Nechí', 5, 'Antioquia', 8, -75, 1),
(77, '5501', 'Olaya', 5, 'Antioquia', 7, -76, 1),
(78, '5541', 'Peñol', 5, 'Antioquia', 6, -75, 1),
(79, '5543', 'Peque', 5, 'Antioquia', 7, -76, 1),
(80, '5576', 'Pueblorrico', 5, 'Antioquia', 6, -76, 1),
(81, '5579', 'Puerto Berrío', 5, 'Antioquia', 6, -75, 1),
(82, '5585', 'Puerto Nare', 5, 'Antioquia', 6, -75, 1),
(83, '5591', 'Puerto Triunfo', 5, 'Antioquia', 6, -75, 1),
(84, '5604', 'Remedios', 5, 'Antioquia', 7, -74, 1),
(85, '5607', 'Retiro', 5, 'Antioquia', 6, -76, 1),
(86, '5615', 'Ríonegro', 5, 'Antioquia', 6, -75, 1),
(87, '5628', 'Sabanalarga', 5, 'Antioquia', 7, -76, 1),
(88, '5631', 'Sabaneta', 5, 'Antioquia', 6, -76, 1),
(89, '5642', 'Salgar', 5, 'Antioquia', 6, -76, 1),
(90, '5647', 'San Andrés de Cuerquía', 5, 'Antioquia', 7, -76, 1),
(91, '5649', 'San Carlos', 5, 'Antioquia', 6, -75, 1),
(92, '5652', 'San Francisco', 5, 'Antioquia', 6, -76, 1),
(93, '5656', 'San Jerónimo', 5, 'Antioquia', 6, -76, 1),
(94, '5658', 'San José de Montaña', 5, 'Antioquia', 7, -76, 1),
(95, '5659', 'San Juan de Urabá', 5, 'Antioquia', 9, -77, 1),
(96, '5660', 'San Luís', 5, 'Antioquia', 6, -75, 1),
(97, '5664', 'San Pedro', 5, 'Antioquia', 6, -76, 1),
(98, '5665', 'San Pedro de Urabá', 5, 'Antioquia', 8, -76, 1),
(99, '5667', 'San Rafael', 5, 'Antioquia', 6, -75, 1),
(100, '5670', 'San Roque', 5, 'Antioquia', 6, -75, 1),
(101, '5674', 'San Vicente', 5, 'Antioquia', 6, -75, 1),
(102, '5679', 'Santa Bárbara', 5, 'Antioquia', 6, -76, 1),
(103, '5686', 'Santa Rosa de Osos', 5, 'Antioquia', 7, -75, 1),
(104, '5690', 'Santo Domingo', 5, 'Antioquia', 6, -75, 1),
(105, '5697', 'Santuario', 5, 'Antioquia', 6, -75, 1),
(106, '5736', 'Segovia', 5, 'Antioquia', 7, -75, 1),
(107, '5756', 'Sonsón', 5, 'Antioquia', 6, -75, 1),
(108, '5761', 'Sopetrán', 5, 'Antioquia', 7, -76, 1),
(109, '5789', 'Támesis', 5, 'Antioquia', 6, -76, 1),
(110, '5790', 'Tarazá', 5, 'Antioquia', 8, -75, 1),
(111, '5792', 'Tarso', 5, 'Antioquia', 6, -76, 1),
(112, '5809', 'Titiribí', 5, 'Antioquia', 6, -76, 1),
(113, '5819', 'Toledo', 5, 'Antioquia', 7, -76, 1),
(114, '5837', 'Turbo', 5, 'Antioquia', 8, -77, 1),
(115, '5842', 'Uramita', 5, 'Antioquia', 7, -76, 1),
(116, '5847', 'Urrao', 5, 'Antioquia', 6, -76, 1),
(117, '5854', 'Valdivia', 5, 'Antioquia', 7, -75, 1),
(118, '5856', 'Valparaiso', 5, 'Antioquia', 6, -76, 1),
(119, '5858', 'Vegachí', 5, 'Antioquia', 7, -75, 1),
(120, '5861', 'Venecia', 5, 'Antioquia', 6, -76, 1),
(121, '5873', 'Vigía del Fuerte', 5, 'Antioquia', 7, -77, 1),
(122, '5885', 'Yalí', 5, 'Antioquia', 7, -75, 1),
(123, '5887', 'Yarumal', 5, 'Antioquia', 7, -76, 1),
(124, '5890', 'Yolombó', 5, 'Antioquia', 7, -75, 1),
(125, '5893', 'Yondó (Casabe)', 5, 'Antioquia', 7, -74, 1),
(126, '5895', 'Zaragoza', 5, 'Antioquia', 8, -75, 1),
(127, '8001', 'Barranquilla', 8, 'Atlántico', 11, -75, 1),
(128, '8078', 'Baranoa', 8, 'Atlántico', 11, -75, 1),
(129, '8132', 'Juan de Acosta', 8, 'Atlántico', 11, -75, 1),
(130, '8137', 'Campo de la Cruz', 8, 'Atlántico', 10, -75, 1),
(131, '8141', 'Candelaria', 8, 'Atlántico', 11, -75, 1),
(132, '8296', 'Galapa', 8, 'Atlántico', 11, -75, 1),
(133, '8421', 'Luruaco', 8, 'Atlántico', 11, -75, 1),
(134, '8433', 'Malambo', 8, 'Atlántico', 11, -75, 1),
(135, '8436', 'Manatí', 8, 'Atlántico', 11, -75, 1),
(136, '8520', 'Palmar de Varela', 8, 'Atlántico', 11, -75, 1),
(137, '8549', 'Piojo', 8, 'Atlántico', 11, -75, 1),
(138, '8558', 'Polonuevo', 8, 'Atlántico', 11, -75, 1),
(139, '8560', 'Ponedera', 8, 'Atlántico', 11, -75, 1),
(140, '8573', 'Puerto Colombia', 8, 'Atlántico', 11, -75, 1),
(141, '8606', 'Repelón', 8, 'Atlántico', 11, -75, 1),
(142, '8634', 'Sabanagrande', 8, 'Atlántico', 11, -75, 1),
(143, '8638', 'Sabanalarga', 8, 'Atlántico', 11, -75, 1),
(144, '8675', 'Santa Lucía', 8, 'Atlántico', 10, -75, 1),
(145, '8685', 'Santo Tomás', 8, 'Atlántico', 11, -75, 1),
(146, '8758', 'Soledad', 8, 'Atlántico', 11, -75, 1),
(147, '8770', 'Suan', 8, 'Atlántico', 10, -75, 1),
(148, '8832', 'Tubará', 8, 'Atlántico', 11, -75, 1),
(149, '8849', 'Usiacuri', 8, 'Atlántico', 11, -75, 1),
(150, '11001', 'Bogotá D.C.', 25, 'Cundinamarca', 5, -74, 1),
(151, '13001', 'Cartagena', 13, 'Bolívar', 10, -76, 1),
(152, '13006', 'Achí', 13, 'Bolívar', 8, -75, 1),
(153, '13030', 'Altos del Rosario', 13, 'Bolívar', 9, -74, 1),
(154, '13042', 'Arenal', 13, 'Bolívar', 8, -74, 1),
(155, '13052', 'Arjona', 13, 'Bolívar', 10, -75, 1),
(156, '13062', 'Arroyohondo', 13, 'Bolívar', 10, -75, 1),
(157, '13074', 'Barranco de Loba', 13, 'Bolívar', 9, -74, 1),
(158, '13140', 'Calamar', 13, 'Bolívar', 10, -75, 1),
(159, '13160', 'Cantagallo', 13, 'Bolívar', 7, -74, 1),
(160, '13188', 'Cicuco', 13, 'Bolívar', 9, -75, 1),
(161, '13212', 'Córdoba', 13, 'Bolívar', 10, -75, 1),
(162, '13222', 'Clemencia', 13, 'Bolívar', 11, -75, 1),
(163, '13244', 'El Carmen de Bolívar', 13, 'Bolívar', 10, -75, 1),
(164, '13248', 'El Guamo', 13, 'Bolívar', 10, -75, 1),
(165, '13268', 'El Peñon', 13, 'Bolívar', 9, -74, 1),
(166, '13300', 'Hatillo de Loba', 13, 'Bolívar', 9, -74, 1),
(167, '13430', 'Magangué', 13, 'Bolívar', 9, -75, 1),
(168, '13433', 'Mahates', 13, 'Bolívar', 10, -75, 1),
(169, '13440', 'Margarita', 13, 'Bolívar', 9, -74, 1),
(170, '13442', 'María la Baja', 13, 'Bolívar', 10, -75, 1),
(171, '13458', 'Montecristo', 13, 'Bolívar', 8, -74, 1),
(172, '13468', 'Mompós', 13, 'Bolívar', 9, -75, 1),
(173, '13473', 'Morales', 13, 'Bolívar', 8, -74, 1),
(174, '13490', 'Norosí', 13, 'Bolívar', 9, -74, 1),
(175, '13549', 'Pinillos', 13, 'Bolívar', 9, -74, 1),
(176, '13580', 'Regidor', 13, 'Bolívar', 9, -74, 1),
(177, '13600', 'Río Viejo', 13, 'Bolívar', 9, -74, 1),
(178, '13620', 'San Cristobal', 13, 'Bolívar', 10, -75, 1),
(179, '13647', 'San Estanislao', 13, 'Bolívar', 10, -75, 1),
(180, '13650', 'San Fernando', 13, 'Bolívar', 9, -74, 1),
(181, '13654', 'San Jacinto', 13, 'Bolívar', 10, -75, 1),
(182, '13655', 'San Jacinto del Cauca', 13, 'Bolívar', 10, -75, 1),
(183, '13657', 'San Juan de Nepomuceno', 13, 'Bolívar', 10, -75, 1),
(184, '13667', 'San Martín de Loba', 13, 'Bolívar', 9, -74, 1),
(185, '13670', 'San Pablo', 13, 'Bolívar', 10, -75, 1),
(186, '13673', 'Santa Catalina', 13, 'Bolívar', 11, -75, 1),
(187, '13683', 'Santa Rosa', 13, 'Bolívar', 10, -75, 1),
(188, '13688', 'Santa Rosa del Sur', 13, 'Bolívar', 8, -74, 1),
(189, '13744', 'Simití', 13, 'Bolívar', 8, -74, 1),
(190, '13760', 'Soplaviento', 13, 'Bolívar', 10, -75, 1),
(191, '13780', 'Talaigua Nuevo', 13, 'Bolívar', 9, -75, 1),
(192, '13810', 'Tiquisio (Puerto Rico)', 13, 'Bolívar', 9, -74, 1),
(193, '13836', 'Turbaco', 13, 'Bolívar', 10, -75, 1),
(194, '13838', 'Turbaná', 13, 'Bolívar', 10, -75, 1),
(195, '13873', 'Villanueva', 13, 'Bolívar', 10, -75, 1),
(196, '13894', 'Zambrano', 13, 'Bolívar', 10, -75, 1),
(197, '15001', 'Tunja', 15, 'Boyacá', 6, -73, 1),
(198, '15022', 'Almeida', 15, 'Boyacá', 5, -73, 1),
(199, '15047', 'Aquitania', 15, 'Boyacá', 6, -73, 1),
(200, '15051', 'Arcabuco', 15, 'Boyacá', 6, -73, 1),
(201, '15087', 'Belén', 15, 'Boyacá', 6, -73, 1),
(202, '15090', 'Berbeo', 15, 'Boyacá', 5, -73, 1),
(203, '15092', 'Beteitiva', 15, 'Boyacá', 6, -73, 1),
(204, '15097', 'Boavita', 15, 'Boyacá', 6, -73, 1),
(205, '15104', 'Boyacá', 15, 'Boyacá', 6, -73, 1),
(206, '15106', 'Briceño', 15, 'Boyacá', 6, -74, 1),
(207, '15109', 'Buenavista', 15, 'Boyacá', 6, -74, 1),
(208, '15114', 'Busbanza', 15, 'Boyacá', 6, -73, 1),
(209, '15131', 'Caldas', 15, 'Boyacá', 6, -74, 1),
(210, '15135', 'Campohermoso', 15, 'Boyacá', 5, -73, 1),
(211, '15162', 'Cerinza', 15, 'Boyacá', 6, -73, 1),
(212, '15172', 'Chinavita', 15, 'Boyacá', 5, -73, 1),
(213, '15176', 'Chiquinquirá', 15, 'Boyacá', 6, -74, 1),
(214, '15180', 'Chiscas', 15, 'Boyacá', 7, -72, 1),
(215, '15183', 'Chita', 15, 'Boyacá', 6, -72, 1),
(216, '15185', 'Chitaraque', 15, 'Boyacá', 6, -73, 1),
(217, '15187', 'Chivatá', 15, 'Boyacá', 6, -73, 1),
(218, '15189', 'Ciénaga', 15, 'Boyacá', 5, -73, 1),
(219, '15204', 'Cómbita', 15, 'Boyacá', 6, -73, 1),
(220, '15212', 'Coper', 15, 'Boyacá', 5, -74, 1),
(221, '15215', 'Corrales', 15, 'Boyacá', 6, -73, 1),
(222, '15218', 'Covarachía', 15, 'Boyacá', 7, -73, 1),
(223, '15223', 'Cubará', 15, 'Boyacá', 7, -72, 1),
(224, '15224', 'Cucaita', 15, 'Boyacá', 6, -73, 1),
(225, '15226', 'Cuitiva', 15, 'Boyacá', 6, -73, 1),
(226, '15232', 'Chíquiza', 15, 'Boyacá', 6, -73, 1),
(227, '15236', 'Chívor', 15, 'Boyacá', 5, -73, 1),
(228, '15238', 'Duitama', 15, 'Boyacá', 6, -73, 1),
(229, '15244', 'El Cocuy', 15, 'Boyacá', 6, -72, 1),
(230, '15248', 'El Espino', 15, 'Boyacá', 7, -72, 1),
(231, '15272', 'Firavitoba', 15, 'Boyacá', 6, -73, 1),
(232, '15276', 'Floresta', 15, 'Boyacá', 6, -73, 1),
(233, '15293', 'Gachantivá', 15, 'Boyacá', 6, -74, 1),
(234, '15296', 'Gámeza', 15, 'Boyacá', 6, -73, 1),
(235, '15299', 'Garagoa', 15, 'Boyacá', 5, -73, 1),
(236, '15317', 'Guacamayas', 15, 'Boyacá', 7, -73, 1),
(237, '15322', 'Guateque', 15, 'Boyacá', 5, -74, 1),
(238, '15325', 'Guayatá', 15, 'Boyacá', 5, -74, 1),
(239, '15332', 'Guicán', 15, 'Boyacá', 7, -72, 1),
(240, '15362', 'Izá', 15, 'Boyacá', 6, -73, 1),
(241, '15367', 'Jenesano', 15, 'Boyacá', 5, -73, 1),
(242, '15368', 'Jericó', 15, 'Boyacá', 6, -73, 1),
(243, '15377', 'Labranzagrande', 15, 'Boyacá', 6, -73, 1),
(244, '15380', 'La Capilla', 15, 'Boyacá', 5, -73, 1),
(245, '15401', 'La Victoria', 15, 'Boyacá', 6, -74, 1),
(246, '15403', 'La Uvita', 15, 'Boyacá', 6, -73, 1),
(247, '15407', 'Villa de Leiva', 15, 'Boyacá', 6, -74, 1),
(248, '15425', 'Macanal', 15, 'Boyacá', 5, -73, 1),
(249, '15442', 'Maripí', 15, 'Boyacá', 6, -74, 1),
(250, '15455', 'Miraflores', 15, 'Boyacá', 5, -73, 1),
(251, '15464', 'Mongua', 15, 'Boyacá', 6, -73, 1),
(252, '15466', 'Monguí', 15, 'Boyacá', 6, -73, 1),
(253, '15469', 'Moniquirá', 15, 'Boyacá', 6, -74, 1),
(254, '15476', 'Motavita', 15, 'Boyacá', 6, -73, 1),
(255, '15480', 'Muzo', 15, 'Boyacá', 6, -74, 1),
(256, '15491', 'Nobsa', 15, 'Boyacá', 6, -73, 1),
(257, '15494', 'Nuevo Colón', 15, 'Boyacá', 5, -73, 1),
(258, '15500', 'Oicatá', 15, 'Boyacá', 6, -73, 1),
(259, '15507', 'Otanche', 15, 'Boyacá', 6, -74, 1),
(260, '15511', 'Pachavita', 15, 'Boyacá', 5, -73, 1),
(261, '15514', 'Páez', 15, 'Boyacá', 5, -73, 1),
(262, '15516', 'Paipa', 15, 'Boyacá', 6, -73, 1),
(263, '15518', 'Pajarito', 15, 'Boyacá', 5, -73, 1),
(264, '15522', 'Panqueba', 15, 'Boyacá', 7, -72, 1),
(265, '15531', 'Pauna', 15, 'Boyacá', 6, -74, 1),
(266, '15532', 'Paya', 15, 'Boyacá', 6, -72, 1),
(267, '15537', 'Paz de Río', 15, 'Boyacá', 6, -73, 1),
(268, '15542', 'Pesca', 15, 'Boyacá', 6, -73, 1),
(269, '15550', 'Pisva', 15, 'Boyacá', 6, -72, 1),
(270, '15572', 'Puerto Boyacá', 15, 'Boyacá', 6, -75, 1),
(271, '15580', 'Quipama', 15, 'Boyacá', 6, -74, 1),
(272, '15599', 'Ramiriquí', 15, 'Boyacá', 5, -73, 1),
(273, '15600', 'Ráquira', 15, 'Boyacá', 6, -74, 1),
(274, '15621', 'Rondón', 15, 'Boyacá', 5, -73, 1),
(275, '15632', 'Saboyá', 15, 'Boyacá', 6, -74, 1),
(276, '15638', 'Sáchica', 15, 'Boyacá', 6, -74, 1),
(277, '15646', 'Samacá', 15, 'Boyacá', 6, -74, 1),
(278, '15660', 'San Eduardo', 15, 'Boyacá', 5, -73, 1),
(279, '15664', 'San José de Pare', 15, 'Boyacá', 6, -73, 1),
(280, '15667', 'San Luís de Gaceno', 15, 'Boyacá', 5, -73, 1),
(281, '15673', 'San Mateo', 15, 'Boyacá', 7, -73, 1),
(282, '15676', 'San Miguel de Sema', 15, 'Boyacá', 6, -74, 1),
(283, '15681', 'San Pablo de Borbur', 15, 'Boyacá', 6, -74, 1),
(284, '15686', 'Santana', 15, 'Boyacá', 6, -73, 1),
(285, '15690', 'Santa María', 15, 'Boyacá', 5, -73, 1),
(286, '15693', 'Santa Rosa de Viterbo', 15, 'Boyacá', 6, -73, 1),
(287, '15696', 'Santa Sofía', 15, 'Boyacá', 6, -74, 1),
(288, '15720', 'Sativanorte', 15, 'Boyacá', 6, -73, 1),
(289, '15723', 'Sativasur', 15, 'Boyacá', 6, -73, 1),
(290, '15740', 'Siachoque', 15, 'Boyacá', 6, -73, 1),
(291, '15753', 'Soatá', 15, 'Boyacá', 6, -73, 1),
(292, '15755', 'Socotá', 15, 'Boyacá', 6, -73, 1),
(293, '15757', 'Socha', 15, 'Boyacá', 6, -73, 1),
(294, '15759', 'Sogamoso', 15, 'Boyacá', 6, -73, 1),
(295, '15761', 'Somondoco', 15, 'Boyacá', 5, -73, 1),
(296, '15762', 'Sora', 15, 'Boyacá', 6, -73, 1),
(297, '15763', 'Sotaquirá', 15, 'Boyacá', 6, -73, 1),
(298, '15764', 'Soracá', 15, 'Boyacá', 6, -73, 1),
(299, '15774', 'Susacón', 15, 'Boyacá', 6, -73, 1),
(300, '15776', 'Sutamarchán', 15, 'Boyacá', 6, -74, 1),
(301, '15778', 'Sutatenza', 15, 'Boyacá', 5, -73, 1),
(302, '15790', 'Tasco', 15, 'Boyacá', 6, -73, 1),
(303, '15798', 'Tenza', 15, 'Boyacá', 5, -73, 1),
(304, '15804', 'Tibaná', 15, 'Boyacá', 5, -73, 1),
(305, '15806', 'Tibasosa', 15, 'Boyacá', 6, -73, 1),
(306, '15808', 'Tinjacá', 15, 'Boyacá', 6, -74, 1),
(307, '15810', 'Tipacoque', 15, 'Boyacá', 6, -73, 1),
(308, '15814', 'Toca', 15, 'Boyacá', 6, -73, 1),
(309, '15816', 'Toguí', 15, 'Boyacá', 6, -73, 1),
(310, '15820', 'Topagá', 15, 'Boyacá', 6, -73, 1),
(311, '15822', 'Tota', 15, 'Boyacá', 6, -73, 1),
(312, '15832', 'Tunungua', 15, 'Boyacá', 6, -74, 1),
(313, '15835', 'Turmequé', 15, 'Boyacá', 5, -74, 1),
(314, '15837', 'Tuta', 15, 'Boyacá', 6, -73, 1),
(315, '15839', 'Tutasá', 15, 'Boyacá', 6, -73, 1),
(316, '15842', 'Úmbita', 15, 'Boyacá', 5, -73, 1),
(317, '15861', 'Ventaquemada', 15, 'Boyacá', 5, -74, 1),
(318, '15879', 'Viracachá', 15, 'Boyacá', 6, -73, 1),
(319, '15897', 'Zetaquirá', 15, 'Boyacá', 5, -73, 1),
(320, '17001', 'Manizales', 17, 'Caldas', 5, -76, 1),
(321, '17013', 'Aguadas', 17, 'Caldas', 6, -75, 1),
(322, '17042', 'Anserma', 17, 'Caldas', 5, -76, 1),
(323, '17050', 'Aranzazu', 17, 'Caldas', 5, -75, 1),
(324, '17088', 'Belalcázar', 17, 'Caldas', 5, -76, 1),
(325, '17174', 'Chinchiná', 17, 'Caldas', 5, -76, 1),
(326, '17272', 'Filadelfia', 17, 'Caldas', 5, -76, 1),
(327, '17380', 'La Dorada', 17, 'Caldas', 6, -75, 1),
(328, '17388', 'La Merced', 17, 'Caldas', 5, -76, 1),
(329, '17433', 'Manzanares', 17, 'Caldas', 5, -75, 1),
(330, '17442', 'Marmato', 17, 'Caldas', 6, -76, 1),
(331, '17444', 'Marquetalia', 17, 'Caldas', 5, -75, 1),
(332, '17446', 'Marulanda', 17, 'Caldas', 5, -75, 1),
(333, '17486', 'Neira', 17, 'Caldas', 5, -76, 1),
(334, '17495', 'Norcasia', 17, 'Caldas', 6, -75, 1),
(335, '17513', 'Pácora', 17, 'Caldas', 6, -76, 1),
(336, '17524', 'Palestina', 17, 'Caldas', 5, -76, 1),
(337, '17541', 'Pensilvania', 17, 'Caldas', 6, -75, 1),
(338, '17614', 'Río Sucio', 17, 'Caldas', 5, -76, 1),
(339, '17616', 'Risaralda', 17, 'Caldas', 5, -76, 1),
(340, '17653', 'Salamina', 17, 'Caldas', 5, -75, 1),
(341, '17662', 'Samaná', 17, 'Caldas', 6, -75, 1),
(342, '17665', 'San José', 17, 'Caldas', 5, -76, 1),
(343, '17777', 'Supía', 17, 'Caldas', 6, -76, 1),
(344, '17867', 'La Victoria', 17, 'Caldas', 5, -76, 1),
(345, '17873', 'Villamaría', 17, 'Caldas', 5, -76, 1),
(346, '17877', 'Viterbo', 17, 'Caldas', 5, -76, 1),
(347, '18001', 'Florencia', 18, 'Caquetá', 2, -76, 1),
(348, '18029', 'Albania', 18, 'Caquetá', 1, -76, 1),
(349, '18094', 'Belén de los Andaquíes', 18, 'Caquetá', 1, -76, 1),
(350, '18150', 'Cartagena del Chairá', 18, 'Caquetá', 1, -75, 1),
(351, '18205', 'Curillo', 18, 'Caquetá', 1, -76, 1),
(352, '18247', 'El Doncello', 18, 'Caquetá', 2, -75, 1),
(353, '18256', 'El Paujil', 18, 'Caquetá', 2, -75, 1),
(354, '18410', 'La Montañita', 18, 'Caquetá', 2, -75, 1),
(355, '18460', 'Milán', 18, 'Caquetá', 1, -76, 1),
(356, '18479', 'Morelia', 18, 'Caquetá', 1, -76, 1),
(357, '18592', 'Puerto Rico', 18, 'Caquetá', 2, -75, 1),
(358, '18610', 'San José del Fragua', 18, 'Caquetá', 1, -76, 1),
(359, '18753', 'San Vicente del Caguán', 18, 'Caquetá', 2, -75, 1),
(360, '18765', 'Solano', 18, 'Caquetá', 1, -75, 1),
(361, '18785', 'Solita', 18, 'Caquetá', 1, -76, 1),
(362, '18860', 'Valparaiso', 18, 'Caquetá', 1, -76, 1),
(363, '19001', 'Popayán', 19, 'Cauca', 3, -76, 1),
(364, '19022', 'Almaguer', 19, 'Cauca', 2, -77, 1),
(365, '19050', 'Argelia', 19, 'Cauca', 2, -77, 1),
(366, '19075', 'Balboa', 19, 'Cauca', 2, -77, 1),
(367, '19100', 'Bolívar', 19, 'Cauca', 2, -77, 1),
(368, '19110', 'Buenos Aires', 19, 'Cauca', 3, -77, 1),
(369, '19130', 'Cajibío', 19, 'Cauca', 3, -77, 1),
(370, '19137', 'Caldono', 19, 'Cauca', 3, -76, 1),
(371, '19142', 'Caloto', 19, 'Cauca', 3, -76, 1),
(372, '19212', 'Corinto', 19, 'Cauca', 3, -76, 1),
(373, '19256', 'El Tambo', 19, 'Cauca', 3, -77, 1),
(374, '19290', 'Florencia', 19, 'Cauca', 2, -77, 1),
(375, '19300', 'Guachené', 19, 'Cauca', 3, -76, 1),
(376, '19318', 'Guapí', 19, 'Cauca', 2, -78, 1),
(377, '19355', 'Inzá', 19, 'Cauca', 3, -76, 1),
(378, '19364', 'Jambaló', 19, 'Cauca', 3, -76, 1),
(379, '19392', 'La Sierra', 19, 'Cauca', 2, -77, 1),
(380, '19397', 'La Vega', 19, 'Cauca', 2, -77, 1),
(381, '19418', 'López (Micay)', 19, 'Cauca', 2, -77, 1),
(382, '19450', 'Mercaderes', 19, 'Cauca', 2, -77, 1),
(383, '19455', 'Miranda', 19, 'Cauca', 3, -76, 1),
(384, '19473', 'Morales', 19, 'Cauca', 3, -77, 1),
(385, '19513', 'Padilla', 19, 'Cauca', 3, -76, 1),
(386, '19517', 'Páez (Belalcazar)', 19, 'Cauca', 5, -73, 1),
(387, '19532', 'Patía (El Bordo)', 19, 'Cauca', 2, -77, 1),
(388, '19533', 'Piamonte', 19, 'Cauca', 8, -75, 1),
(389, '19548', 'Piendamó', 19, 'Cauca', 3, -77, 1),
(390, '19573', 'Puerto Tejada', 19, 'Cauca', 3, -76, 1),
(391, '19585', 'Puracé (Coconuco)', 19, 'Cauca', 2, -77, 1),
(392, '19622', 'Rosas', 19, 'Cauca', 2, -77, 1),
(393, '19693', 'San Sebastián', 19, 'Cauca', 2, -77, 1),
(394, '19698', 'Santander de Quilichao', 19, 'Cauca', 3, -76, 1),
(395, '19701', 'Santa Rosa', 19, 'Cauca', 2, -77, 1),
(396, '19743', 'Silvia', 19, 'Cauca', 3, -76, 1),
(397, '19760', 'Sotara (Paispamba)', 19, 'Cauca', 2, -77, 1),
(398, '19780', 'Suárez', 19, 'Cauca', 3, -77, 1),
(399, '19785', 'Sucre', 19, 'Cauca', 2, -77, 1),
(400, '19807', 'Timbío', 19, 'Cauca', 2, -77, 1),
(401, '19809', 'Timbiquí', 19, 'Cauca', 3, -78, 1),
(402, '19821', 'Toribío', 19, 'Cauca', 3, -76, 1),
(403, '19824', 'Totoró', 19, 'Cauca', 3, -76, 1),
(404, '19845', 'Villa Rica', 19, 'Cauca', 3, -77, 1),
(405, '20001', 'Valledupar', 20, 'Cesar', 10, -73, 1),
(406, '20011', 'Aguachica', 20, 'Cesar', 8, -74, 1),
(407, '20013', 'Agustín Codazzi', 20, 'Cesar', 10, -73, 1),
(408, '20032', 'Astrea', 20, 'Cesar', 10, -74, 1),
(409, '20045', 'Becerríl', 20, 'Cesar', 10, -73, 1),
(410, '20060', 'Bosconia', 20, 'Cesar', 10, -74, 1),
(411, '20175', 'Chimichagua', 20, 'Cesar', 9, -74, 1),
(412, '20178', 'Chiriguaná', 20, 'Cesar', 10, -73, 1),
(413, '20228', 'Curumaní', 20, 'Cesar', 9, -74, 1),
(414, '20238', 'El Copey', 20, 'Cesar', 10, -74, 1),
(415, '20250', 'El Paso', 20, 'Cesar', 10, -74, 1),
(416, '20295', 'Gamarra', 20, 'Cesar', 8, -74, 1),
(417, '20310', 'Gonzalez', 20, 'Cesar', 8, -73, 1),
(418, '20383', 'La Gloria', 20, 'Cesar', 9, -74, 1),
(419, '20400', 'La Jagua de Ibirico', 20, 'Cesar', 10, -73, 1),
(420, '20443', 'Manaure Balcón del Cesar', 20, 'Cesar', 10, -73, 1),
(421, '20517', 'Pailitas', 20, 'Cesar', 9, -74, 1),
(422, '20550', 'Pelaya', 20, 'Cesar', 9, -74, 1),
(423, '20570', 'Pueblo Bello', 20, 'Cesar', 10, -74, 1),
(424, '20614', 'Río de oro', 20, 'Cesar', 8, -74, 1),
(425, '20621', 'La Paz (Robles)', 20, 'Cesar', 10, -73, 1),
(426, '20710', 'San Alberto', 20, 'Cesar', 8, -73, 1),
(427, '20750', 'San Diego', 20, 'Cesar', 10, -73, 1),
(428, '20770', 'San Martín', 20, 'Cesar', 8, -74, 1),
(429, '20787', 'Tamalameque', 20, 'Cesar', 9, -74, 1),
(430, '23001', 'Monteria', 23, 'Córdoba', 9, -76, 1),
(431, '23068', 'Ayapel', 23, 'Córdoba', 8, -75, 1),
(432, '23079', 'Buenavista', 23, 'Córdoba', 9, -76, 1),
(433, '23090', 'Canalete', 23, 'Córdoba', 9, -76, 1),
(434, '23162', 'Cereté', 23, 'Córdoba', 9, -76, 1),
(435, '23168', 'Chimá', 23, 'Córdoba', 9, -76, 1),
(436, '23182', 'Chinú', 23, 'Córdoba', 9, -75, 1),
(437, '23189', 'Ciénaga de Oro', 23, 'Córdoba', 9, -76, 1),
(438, '23300', 'Cotorra', 23, 'Córdoba', 9, -76, 1),
(439, '23350', 'La Apartada y La Frontera', 23, 'Córdoba', 0, 0, 1),
(440, '23417', 'Lorica', 23, 'Córdoba', 9, -76, 1),
(441, '23419', 'Los Córdobas', 23, 'Córdoba', 9, -76, 1),
(442, '23464', 'Momil', 23, 'Córdoba', 9, -76, 1),
(443, '23466', 'Montelíbano', 23, 'Córdoba', 8, -76, 1),
(444, '23500', 'Moñitos', 23, 'Córdoba', 8, -76, 1),
(445, '23555', 'Planeta Rica', 23, 'Córdoba', 8, -76, 1),
(446, '23570', 'Pueblo Nuevo', 23, 'Córdoba', 8, -75, 1),
(447, '23574', 'Puerto Escondido', 23, 'Córdoba', 9, -76, 1),
(448, '23580', 'Puerto Libertador', 23, 'Córdoba', 5, -74, 1),
(449, '23586', 'Purísima', 23, 'Córdoba', 9, -76, 1),
(450, '23660', 'Sahagún', 23, 'Córdoba', 9, -75, 1),
(451, '23670', 'San Andrés Sotavento', 23, 'Córdoba', 9, -76, 1),
(452, '23672', 'San Antero', 23, 'Córdoba', 9, -76, 1),
(453, '23675', 'San Bernardo del Viento', 23, 'Córdoba', 9, -76, 1),
(454, '23678', 'San Carlos', 23, 'Córdoba', 9, -76, 1),
(455, '23682', 'San José de Uré', 23, 'Córdoba', 8, -76, 1),
(456, '23686', 'San Pelayo', 23, 'Córdoba', 9, -76, 1),
(457, '23807', 'Tierralta', 23, 'Córdoba', 8, -76, 1),
(458, '23815', 'Tuchín', 23, 'Córdoba', 9, -76, 1),
(459, '23855', 'Valencia', 23, 'Córdoba', 8, -76, 1),
(460, '25001', 'Agua de Dios', 25, 'Cundinamarca', 4, -75, 1),
(461, '25019', 'Albán', 25, 'Cundinamarca', 5, -74, 1),
(462, '25035', 'Anapoima', 25, 'Cundinamarca', 5, -75, 1),
(463, '25040', 'Anolaima', 25, 'Cundinamarca', 5, -75, 1),
(464, '25053', 'Arbeláez', 25, 'Cundinamarca', 4, -75, 1),
(465, '25086', 'Beltrán', 25, 'Cundinamarca', 5, -75, 1),
(466, '25095', 'Bituima', 25, 'Cundinamarca', 5, -75, 1),
(467, '25099', 'Bojacá', 25, 'Cundinamarca', 5, -74, 1),
(468, '25120', 'Cabrera', 25, 'Cundinamarca', 4, -74, 1),
(469, '25123', 'Cachipay', 25, 'Cundinamarca', 5, -75, 1),
(470, '25126', 'Cajicá', 25, 'Cundinamarca', 5, -74, 1),
(471, '25148', 'Caparrapí', 25, 'Cundinamarca', 5, -75, 1),
(472, '25151', 'Cáqueza', 25, 'Cundinamarca', 4, -74, 1),
(473, '25154', 'Carmen de Carupa', 25, 'Cundinamarca', 5, -74, 1),
(474, '25168', 'Chaguaní', 25, 'Cundinamarca', 5, -75, 1),
(475, '25175', 'Chía', 25, 'Cundinamarca', 5, -74, 1),
(476, '25178', 'Chipaque', 25, 'Cundinamarca', 5, -74, 1),
(477, '25181', 'Choachí', 25, 'Cundinamarca', 5, -74, 1),
(478, '25183', 'Chocontá', 25, 'Cundinamarca', 5, -74, 1),
(479, '25200', 'Cogua', 25, 'Cundinamarca', 5, -74, 1),
(480, '25214', 'Cota', 25, 'Cundinamarca', 5, -74, 1),
(481, '25224', 'Cucunubá', 25, 'Cundinamarca', 5, -74, 1),
(482, '25245', 'El Colegio', 25, 'Cundinamarca', 5, -74, 1),
(483, '25258', 'El Peñón', 25, 'Cundinamarca', 5, -74, 1),
(484, '25260', 'El Rosal', 25, 'Cundinamarca', 5, -74, 1),
(485, '25269', 'Facatativá', 25, 'Cundinamarca', 5, -74, 1),
(486, '25279', 'Fómeque', 25, 'Cundinamarca', 5, -74, 1),
(487, '25281', 'Fosca', 25, 'Cundinamarca', 4, -74, 1),
(488, '25286', 'Funza', 25, 'Cundinamarca', 5, -74, 1),
(489, '25288', 'Fúquene', 25, 'Cundinamarca', 5, -74, 1),
(490, '25290', 'Fusagasugá', 25, 'Cundinamarca', 4, -74, 1),
(491, '25293', 'Gachalá', 25, 'Cundinamarca', 5, -74, 1),
(492, '25295', 'Gachancipá', 25, 'Cundinamarca', 5, -74, 1),
(493, '25297', 'Gachetá', 25, 'Cundinamarca', 5, -74, 1),
(494, '25299', 'Gama', 25, 'Cundinamarca', 5, -74, 1),
(495, '25307', 'Girardot', 25, 'Cundinamarca', 4, -75, 1),
(496, '25312', 'Granada', 25, 'Cundinamarca', 5, -75, 1),
(497, '25317', 'Guachetá', 25, 'Cundinamarca', 5, -74, 1),
(498, '25320', 'Guaduas', 25, 'Cundinamarca', 5, -75, 1),
(499, '25322', 'Guasca', 25, 'Cundinamarca', 5, -74, 1),
(500, '25324', 'Guataquí', 25, 'Cundinamarca', 5, -75, 1),
(501, '25326', 'Guatavita', 25, 'Cundinamarca', 5, -74, 1),
(502, '25328', 'Guayabal de Siquima', 25, 'Cundinamarca', 5, -74, 1),
(503, '25335', 'Guayabetal', 25, 'Cundinamarca', 4, -74, 1),
(504, '25339', 'Gutiérrez', 25, 'Cundinamarca', 4, -74, 1),
(505, '25368', 'Jerusalén', 25, 'Cundinamarca', 5, -75, 1),
(506, '25372', 'Junín', 25, 'Cundinamarca', 5, -74, 1),
(507, '25377', 'La Calera', 25, 'Cundinamarca', 5, -74, 1),
(508, '25386', 'La Mesa', 25, 'Cundinamarca', 5, -75, 1),
(509, '25394', 'La Palma', 25, 'Cundinamarca', 5, -74, 1),
(510, '25398', 'La Peña', 25, 'Cundinamarca', 5, -74, 1),
(511, '25402', 'La Vega', 25, 'Cundinamarca', 5, -74, 1),
(512, '25407', 'Lenguazaque', 25, 'Cundinamarca', 5, -74, 1),
(513, '25426', 'Machetá', 25, 'Cundinamarca', 5, -74, 1),
(514, '25430', 'Madrid', 25, 'Cundinamarca', 5, -74, 1),
(515, '25436', 'Manta', 25, 'Cundinamarca', 5, -74, 1),
(516, '25438', 'Medina', 25, 'Cundinamarca', 5, -73, 1),
(517, '25473', 'Mosquera', 25, 'Cundinamarca', 5, -74, 1),
(518, '25483', 'Nariño', 25, 'Cundinamarca', 4, -75, 1),
(519, '25486', 'Nemocón', 25, 'Cundinamarca', 5, -74, 1),
(520, '25488', 'Nilo', 25, 'Cundinamarca', 4, -75, 1),
(521, '25489', 'Nimaima', 25, 'Cundinamarca', 5, -74, 1),
(522, '25491', 'Nocaima', 25, 'Cundinamarca', 5, -74, 1),
(523, '25506', 'Venecia (Ospina Pérez)', 25, 'Cundinamarca', 4, -75, 1),
(524, '25513', 'Pacho', 25, 'Cundinamarca', 5, -74, 1),
(525, '25518', 'Paime', 25, 'Cundinamarca', 5, -74, 1),
(526, '25524', 'Pandi', 25, 'Cundinamarca', 4, -75, 1),
(527, '25530', 'Paratebueno', 25, 'Cundinamarca', 4, -73, 1),
(528, '25535', 'Pasca', 25, 'Cundinamarca', 4, -74, 1),
(529, '25572', 'Puerto Salgar', 25, 'Cundinamarca', 6, -75, 1),
(530, '25580', 'Pulí', 25, 'Cundinamarca', 5, -75, 1),
(531, '25592', 'Quebradanegra', 25, 'Cundinamarca', 5, -75, 1),
(532, '25594', 'Quetame', 25, 'Cundinamarca', 4, -74, 1),
(533, '25596', 'Quipile', 25, 'Cundinamarca', 5, -75, 1),
(534, '25599', 'Apulo', 25, 'Cundinamarca', 5, -75, 1),
(535, '25612', 'Ricaurte', 25, 'Cundinamarca', 4, -75, 1),
(536, '25645', 'San Antonio de Tequendama', 25, 'Cundinamarca', 4, -75, 1),
(537, '25649', 'San Bernardo', 25, 'Cundinamarca', 4, -74, 1),
(538, '25653', 'San Cayetano', 25, 'Cundinamarca', 5, -74, 1),
(539, '25658', 'San Francisco', 25, 'Cundinamarca', 5, -74, 1),
(540, '25662', 'San Juan de Río Seco', 25, 'Cundinamarca', 5, -75, 1),
(541, '25718', 'Sasaima', 25, 'Cundinamarca', 5, -74, 1),
(542, '25736', 'Sesquilé', 25, 'Cundinamarca', 5, -74, 1),
(543, '25740', 'Sibaté', 25, 'Cundinamarca', 4, -74, 1),
(544, '25743', 'Silvania', 25, 'Cundinamarca', 5, -74, 1),
(545, '25745', 'Simijaca', 25, 'Cundinamarca', 6, -74, 1),
(546, '25754', 'Soacha', 25, 'Cundinamarca', 5, -74, 1),
(547, '25758', 'Sopó', 25, 'Cundinamarca', 5, -74, 1),
(548, '25769', 'Subachoque', 25, 'Cundinamarca', 5, -74, 1),
(549, '25772', 'Suesca', 25, 'Cundinamarca', 5, -74, 1),
(550, '25777', 'Supatá', 25, 'Cundinamarca', 5, -74, 1),
(551, '25779', 'Susa', 25, 'Cundinamarca', 6, -74, 1),
(552, '25781', 'Sutatausa', 25, 'Cundinamarca', 5, -74, 1),
(553, '25785', 'Tabio', 25, 'Cundinamarca', 5, -74, 1),
(554, '25793', 'Tausa', 25, 'Cundinamarca', 5, -74, 1),
(555, '25797', 'Tena', 25, 'Cundinamarca', 5, -74, 1),
(556, '25799', 'Tenjo', 25, 'Cundinamarca', 5, -74, 1),
(557, '25805', 'Tibacuy', 25, 'Cundinamarca', 4, -75, 1),
(558, '25807', 'Tibirita', 25, 'Cundinamarca', 5, -74, 1),
(559, '25815', 'Tocaima', 25, 'Cundinamarca', 5, -75, 1),
(560, '25817', 'Tocancipá', 25, 'Cundinamarca', 5, -74, 1),
(561, '25823', 'Topaipí', 25, 'Cundinamarca', 5, -74, 1),
(562, '25839', 'Ubalá', 25, 'Cundinamarca', 5, -74, 1),
(563, '25841', 'Ubaque', 25, 'Cundinamarca', 5, -74, 1),
(564, '25843', 'Ubaté', 25, 'Cundinamarca', 5, -74, 1),
(565, '25845', 'Une', 25, 'Cundinamarca', 4, -74, 1),
(566, '25851', 'Útica', 25, 'Cundinamarca', 5, -75, 1),
(567, '25862', 'Vergara', 25, 'Cundinamarca', 5, -74, 1),
(568, '25867', 'Viani', 25, 'Cundinamarca', 5, -75, 1),
(569, '25871', 'Villagómez', 25, 'Cundinamarca', 5, -74, 1),
(570, '25873', 'Villapinzón', 25, 'Cundinamarca', 5, -74, 1),
(571, '25875', 'Villeta', 25, 'Cundinamarca', 5, -75, 1),
(572, '25878', 'Viotá', 25, 'Cundinamarca', 5, -75, 1),
(573, '25885', 'Yacopí', 25, 'Cundinamarca', 6, -74, 1),
(574, '25888', 'Zipacón', 25, 'Cundinamarca', 5, -74, 1),
(575, '25899', 'Zipaquirá', 25, 'Cundinamarca', 5, -74, 1),
(576, '27001', 'Quibdó', 27, 'Chocó', 6, -77, 1),
(577, '27006', 'Acandí', 27, 'Chocó', 8, -77, 1),
(578, '27025', 'Alto Baudó (Pie de Pato)', 27, 'Chocó', 6, -77, 1),
(579, '27050', 'Atrato (Yuto)', 27, 'Chocó', 6, -77, 1),
(580, '27073', 'Bagadó', 27, 'Chocó', 6, -76, 1),
(581, '27075', 'Bahía Solano (Mútis)', 27, 'Chocó', 6, -77, 1),
(582, '27077', 'Bajo Baudó (Pizarro)', 27, 'Chocó', 5, -77, 1),
(583, '27086', 'Belén de Bajirá', 27, 'Chocó', 7, -77, 1),
(584, '27099', 'Bojayá (Bellavista)', 27, 'Chocó', 7, -77, 1),
(585, '27135', 'Cantón de San Pablo', 27, 'Chocó', 5, -77, 1),
(586, '27150', 'Carmen del Darién (CURBARADÓ)', 27, 'Chocó', 7, -77, 1),
(587, '27160', 'Cértegui', 27, 'Chocó', 5, -77, 1),
(588, '27205', 'Condoto', 27, 'Chocó', 5, -77, 1),
(589, '27245', 'El Carmen de Atrato', 27, 'Chocó', 0, 0, 1),
(590, '27250', 'Santa Genoveva de Docorodó', 27, 'Chocó', 4, -77, 1),
(591, '27361', 'Istmina', 27, 'Chocó', 5, -77, 1),
(592, '27372', 'Juradó', 27, 'Chocó', 7, -78, 1),
(593, '27413', 'Lloró', 27, 'Chocó', 6, -76, 1),
(594, '27425', 'Medio Atrato', 27, 'Chocó', 0, 0, 1),
(595, '27430', 'Medio Baudó', 27, 'Chocó', 0, 0, 1),
(596, '27450', 'Medio San Juan (ANDAGOYA)', 27, 'Chocó', 5, -77, 1),
(597, '27491', 'Novita', 27, 'Chocó', 5, -77, 1),
(598, '27495', 'Nuquí', 27, 'Chocó', 6, -77, 1),
(599, '27580', 'Río Iró', 27, 'Chocó', 5, -77, 1),
(600, '27600', 'Río Quito', 27, 'Chocó', 6, -77, 1),
(601, '27615', 'Ríosucio', 27, 'Chocó', 7, -77, 1),
(602, '27660', 'San José del Palmar', 27, 'Chocó', 5, -76, 1),
(603, '27745', 'Sipí', 27, 'Chocó', 5, -77, 1),
(604, '27787', 'Tadó', 27, 'Chocó', 5, -76, 1),
(605, '27800', 'Unguía', 27, 'Chocó', 8, -77, 1),
(606, '27810', 'Unión Panamericana (ÁNIMAS)', 27, 'Chocó', 5, -77, 1),
(607, '41001', 'Neiva', 41, 'Huila', 3, -75, 1),
(608, '41006', 'Acevedo', 41, 'Huila', 2, -76, 1),
(609, '41013', 'Agrado', 41, 'Huila', 2, -76, 1),
(610, '41016', 'Aipe', 41, 'Huila', 3, -75, 1),
(611, '41020', 'Algeciras', 41, 'Huila', 3, -75, 1),
(612, '41026', 'Altamira', 41, 'Huila', 2, -76, 1),
(613, '41078', 'Baraya', 41, 'Huila', 3, -75, 1),
(614, '41132', 'Campoalegre', 41, 'Huila', 3, -75, 1),
(615, '41206', 'Colombia', 41, 'Huila', 3, -76, 1),
(616, '41244', 'Elías', 41, 'Huila', 2, -76, 1),
(617, '41298', 'Garzón', 41, 'Huila', 2, -76, 1),
(618, '41306', 'Gigante', 41, 'Huila', 3, -76, 1),
(619, '41319', 'Guadalupe', 41, 'Huila', 2, -76, 1),
(620, '41349', 'Hobo', 41, 'Huila', 3, -76, 1),
(621, '41357', 'Íquira', 41, 'Huila', 3, -76, 1),
(622, '41359', 'Isnos', 41, 'Huila', 2, -76, 1),
(623, '41378', 'La Argentina', 41, 'Huila', 2, -76, 1),
(624, '41396', 'La Plata', 41, 'Huila', 2, -76, 1),
(625, '41483', 'Nátaga', 41, 'Huila', 3, -76, 1),
(626, '41503', 'Oporapa', 41, 'Huila', 2, -76, 1),
(627, '41518', 'Paicol', 41, 'Huila', 2, -76, 1),
(628, '41524', 'Palermo', 41, 'Huila', 3, -76, 1),
(629, '41530', 'Palestina', 41, 'Huila', 2, -76, 1),
(630, '41548', 'Pital', 41, 'Huila', 2, -76, 1),
(631, '41551', 'Pitalito', 41, 'Huila', 2, -76, 1),
(632, '41615', 'Rivera', 41, 'Huila', 3, -75, 1),
(633, '41660', 'Saladoblanco', 41, 'Huila', 2, -76, 1),
(634, '41668', 'San Agustín', 41, 'Huila', 2, -76, 1),
(635, '41676', 'Santa María', 41, 'Huila', 3, -76, 1),
(636, '41770', 'Suaza', 41, 'Huila', 2, -76, 1),
(637, '41791', 'Tarqui', 41, 'Huila', 2, -76, 1),
(638, '41797', 'Tesalia', 41, 'Huila', 3, -76, 1),
(639, '41799', 'Tello', 41, 'Huila', 3, -75, 1),
(640, '41801', 'Teruel', 41, 'Huila', 3, -76, 1),
(641, '41807', 'Timaná', 41, 'Huila', 2, -76, 1),
(642, '41872', 'Villavieja', 41, 'Huila', 3, -75, 1),
(643, '41885', 'Yaguará', 41, 'Huila', 3, -76, 1),
(644, '44001', 'Riohacha', 44, 'La Guajira', 12, -73, 1),
(645, '44035', 'Albania', 44, 'La Guajira', 11, -73, 1),
(646, '44078', 'Barrancas', 44, 'La Guajira', 11, -73, 1),
(647, '44090', 'Dibulla', 44, 'La Guajira', 11, -73, 1),
(648, '44098', 'Distracción', 44, 'La Guajira', 11, -73, 1),
(649, '44110', 'El Molino', 44, 'La Guajira', 11, -73, 1),
(650, '44279', 'Fonseca', 44, 'La Guajira', 11, -73, 1),
(651, '44378', 'Hatonuevo', 44, 'La Guajira', 11, -73, 1),
(652, '44420', 'La Jagua del Pilar', 44, 'La Guajira', 11, -73, 1),
(653, '44430', 'Maicao', 44, 'La Guajira', 11, -72, 1),
(654, '44560', 'Manaure', 44, 'La Guajira', 12, -72, 1),
(655, '44650', 'San Juan del Cesar', 44, 'La Guajira', 11, -73, 1),
(656, '44847', 'Uribia', 44, 'La Guajira', 12, -72, 1),
(657, '44855', 'Urumita', 44, 'La Guajira', 11, -73, 1),
(658, '44874', 'Villanueva', 44, 'La Guajira', 11, -73, 1),
(659, '47001', 'Santa Marta', 47, 'Magdalena', 11, -74, 1),
(660, '47030', 'Algarrobo', 47, 'Magdalena', 10, -75, 1),
(661, '47053', 'Aracataca', 47, 'Magdalena', 11, -74, 1),
(662, '47058', 'Ariguaní (El Difícil)', 47, 'Magdalena', 10, -74, 1),
(663, '47161', 'Cerro San Antonio', 47, 'Magdalena', 10, -75, 1),
(664, '47170', 'Chivolo', 47, 'Magdalena', 10, -75, 1),
(665, '47189', 'Ciénaga', 47, 'Magdalena', 11, -74, 1),
(666, '47205', 'Concordia', 47, 'Magdalena', 10, -74, 1),
(667, '47245', 'El Banco', 47, 'Magdalena', 9, -74, 1),
(668, '47258', 'El Piñon', 47, 'Magdalena', 10, -75, 1),
(669, '47268', 'El Retén', 47, 'Magdalena', 11, -74, 1),
(670, '47288', 'Fundación', 47, 'Magdalena', 10, -74, 1),
(671, '47318', 'Guamal', 47, 'Magdalena', 9, -74, 1),
(672, '47441', 'Pedraza', 47, 'Magdalena', 10, -75, 1),
(673, '47460', 'Nueva Granada', 47, 'Magdalena', 10, -74, 1),
(674, '47545', 'Pijiño', 47, 'Magdalena', 0, -74, 1),
(675, '47551', 'Pivijay', 47, 'Magdalena', 10, -74, 1),
(676, '47555', 'Plato', 47, 'Magdalena', 10, -74, 1),
(677, '47570', 'Puebloviejo', 47, 'Magdalena', 11, -74, 1),
(678, '47605', 'Remolino', 47, 'Magdalena', 11, -75, 1),
(679, '47660', 'Sabanas de San Angel (SAN ANGEL)', 47, 'Magdalena', 10, -74, 1),
(680, '47675', 'Salamina', 47, 'Magdalena', 11, -75, 1),
(681, '47692', 'San Sebastián de Buenavista', 47, 'Magdalena', 9, -74, 1),
(682, '47703', 'San Zenón', 47, 'Magdalena', 9, -74, 1),
(683, '47707', 'Santa Ana', 47, 'Magdalena', 9, -75, 1),
(684, '47720', 'Santa Bárbara de Pinto', 47, 'Magdalena', 11, -74, 1),
(685, '47745', 'Sitionuevo', 47, 'Magdalena', 11, -75, 1),
(686, '47798', 'Tenerife', 47, 'Magdalena', 10, -75, 1),
(687, '47960', 'Zapayán (PUNTA DE PIEDRAS)', 47, 'Magdalena', 10, -75, 1),
(688, '47980', 'Zona Bananera (PRADO - SEVILLA)', 47, 'Magdalena', 0, 0, 1),
(689, '50001', 'Villavicencio', 50, 'Meta', 4, -74, 1),
(690, '50006', 'Acacías', 50, 'Meta', 4, -74, 1),
(691, '50110', 'Barranca de Upía', 50, 'Meta', 5, -73, 1),
(692, '50124', 'Cabuyaro', 50, 'Meta', 4, -73, 1),
(693, '50150', 'Castilla la Nueva', 50, 'Meta', 4, -74, 1),
(694, '50223', 'Cubarral', 50, 'Meta', 4, -74, 1),
(695, '50226', 'Cumaral', 50, 'Meta', 4, -73, 1),
(696, '50245', 'El Calvario', 50, 'Meta', 4, -74, 1),
(697, '50251', 'El Castillo', 50, 'Meta', 4, -74, 1),
(698, '50270', 'El Dorado', 50, 'Meta', 3, -73, 1),
(699, '50287', 'Fuente de Oro', 50, 'Meta', 3, -74, 1),
(700, '50313', 'Granada', 50, 'Meta', 4, -74, 1),
(701, '50318', 'Guamal', 50, 'Meta', 4, -74, 1),
(702, '50325', 'Mapiripan', 50, 'Meta', 3, -72, 1),
(703, '50330', 'Mesetas', 50, 'Meta', 3, -74, 1),
(704, '50350', 'La Macarena', 50, 'Meta', 3, -74, 1),
(705, '50370', 'Uribe', 50, 'Meta', 3, -74, 1),
(706, '50400', 'Lejanías', 50, 'Meta', 4, -74, 1),
(707, '50450', 'Puerto Concordia', 50, 'Meta', 3, -73, 1),
(708, '50568', 'Puerto Gaitán', 50, 'Meta', 4, -72, 1),
(709, '50573', 'Puerto López', 50, 'Meta', 4, -73, 1),
(710, '50577', 'Puerto Lleras', 50, 'Meta', 3, -73, 1),
(711, '50590', 'Puerto Rico', 50, 'Meta', 3, -73, 1),
(712, '50606', 'Restrepo', 50, 'Meta', 4, -73, 1),
(713, '50680', 'San Carlos de Guaroa', 50, 'Meta', 4, -73, 1),
(714, '50683', 'San Juan de Arama', 50, 'Meta', 3, -74, 1),
(715, '50686', 'San Juanito', 50, 'Meta', 4, -74, 1),
(716, '50689', 'San Martín', 50, 'Meta', 4, -74, 1),
(717, '50711', 'Vista Hermosa', 50, 'Meta', 3, -74, 1),
(718, '52001', 'San Juan de Pasto', 52, 'Nariño', 1, -77, 1),
(719, '52019', 'Albán (San José)', 52, 'Nariño', 1, -77, 1),
(720, '52022', 'Aldana', 52, 'Nariño', 1, -78, 1),
(721, '52036', 'Ancuya', 52, 'Nariño', 1, -78, 1),
(722, '52051', 'Arboleda (Berruecos)', 52, 'Nariño', 2, -77, 1),
(723, '52079', 'Barbacoas', 52, 'Nariño', 2, -78, 1),
(724, '52083', 'Belén', 52, 'Nariño', 2, -77, 1),
(725, '52110', 'Buesaco', 52, 'Nariño', 1, -77, 1),
(726, '52203', 'Colón (Génova)', 52, 'Nariño', 2, -77, 1),
(727, '52207', 'Consaca', 52, 'Nariño', 1, -77, 1),
(728, '52210', 'Contadero', 52, 'Nariño', 1, -78, 1),
(729, '52215', 'Córdoba', 52, 'Nariño', 1, -77, 1),
(730, '52224', 'Cuaspud (Carlosama)', 52, 'Nariño', 1, -78, 1),
(731, '52227', 'Cumbal', 52, 'Nariño', 1, -78, 1),
(732, '52233', 'Cumbitara', 52, 'Nariño', 2, -78, 1),
(733, '52240', 'Chachaguí', 52, 'Nariño', 1, -77, 1),
(734, '52250', 'El Charco', 52, 'Nariño', 2, -78, 1),
(735, '52254', 'El Peñol', 52, 'Nariño', 1, -77, 1),
(736, '52256', 'El Rosario', 52, 'Nariño', 2, -77, 1),
(737, '52258', 'El Tablón de Gómez', 52, 'Nariño', 0, 0, 1),
(738, '52260', 'El Tambo', 52, 'Nariño', 1, -77, 1),
(739, '52287', 'Funes', 52, 'Nariño', 1, -77, 1),
(740, '52317', 'Guachucal', 52, 'Nariño', 1, -78, 1),
(741, '52320', 'Guaitarilla', 52, 'Nariño', 1, -78, 1),
(742, '52323', 'Gualmatán', 52, 'Nariño', 1, -78, 1),
(743, '52352', 'Iles', 52, 'Nariño', 1, -78, 1),
(744, '52354', 'Imúes', 52, 'Nariño', 1, -78, 1),
(745, '52356', 'Ipiales', 52, 'Nariño', 1, -78, 1),
(746, '52378', 'La Cruz', 52, 'Nariño', 2, -77, 1),
(747, '52381', 'La Florida', 52, 'Nariño', 1, -77, 1),
(748, '52385', 'La Llanada', 52, 'Nariño', 1, -78, 1),
(749, '52390', 'La Tola', 52, 'Nariño', 2, -78, 1),
(750, '52399', 'La Unión', 52, 'Nariño', 2, -77, 1),
(751, '52405', 'Leiva', 52, 'Nariño', 2, -77, 1),
(752, '52411', 'Linares', 52, 'Nariño', 1, -77, 1),
(753, '52418', 'Sotomayor (Los Andes)', 52, 'Nariño', 2, -77, 1),
(754, '52427', 'Magüi (Payán)', 52, 'Nariño', 2, -78, 1),
(755, '52435', 'Mallama (Piedrancha)', 52, 'Nariño', 1, -78, 1),
(756, '52473', 'Mosquera', 52, 'Nariño', 2, -78, 1),
(757, '52480', 'Nariño', 52, 'Nariño', 2, -78, 1),
(758, '52490', 'Olaya Herrera', 52, 'Nariño', 1, -77, 1),
(759, '52506', 'Ospina', 52, 'Nariño', 1, -78, 1),
(760, '52520', 'Francisco Pizarro', 52, 'Nariño', 2, -79, 1),
(761, '52540', 'Policarpa', 52, 'Nariño', 2, -77, 1),
(762, '52560', 'Potosí', 52, 'Nariño', 1, -77, 1),
(763, '52565', 'Providencia', 52, 'Nariño', 2, -77, 1),
(764, '52573', 'Puerres', 52, 'Nariño', 1, -77, 1),
(765, '52585', 'Pupiales', 52, 'Nariño', 1, -78, 1),
(766, '52612', 'Ricaurte', 52, 'Nariño', 1, -78, 1),
(767, '52621', 'Roberto Payán (San José)', 52, 'Nariño', 2, -78, 1),
(768, '52678', 'Samaniego', 52, 'Nariño', 1, -78, 1),
(769, '52683', 'Sandoná', 52, 'Nariño', 1, -77, 1),
(770, '52685', 'San Bernardo', 52, 'Nariño', 2, -77, 1),
(771, '52687', 'San Lorenzo', 52, 'Nariño', 2, -77, 1),
(772, '52693', 'San Pablo', 52, 'Nariño', 2, -77, 1),
(773, '52694', 'San Pedro de Cartago', 52, 'Nariño', 2, -77, 1),
(774, '52695', 'Santa Bárbara (Iscuandé)', 52, 'Nariño', 2, -78, 1),
(775, '52699', 'Guachavés', 52, 'Nariño', 1, -78, 1),
(776, '52720', 'Sapuyes', 52, 'Nariño', 1, -78, 1),
(777, '52786', 'Taminango', 52, 'Nariño', 2, -77, 1),
(778, '52788', 'Tangua', 52, 'Nariño', 1, -77, 1),
(779, '52835', 'Tumaco', 52, 'Nariño', 2, -79, 1),
(780, '52838', 'Túquerres', 52, 'Nariño', 1, -78, 1),
(781, '52885', 'Yacuanquer', 52, 'Nariño', 1, -77, 1),
(782, '54001', 'Cúcuta', 54, 'Norte de Santander', 8, -73, 1),
(783, '54003', 'Ábrego', 54, 'Norte de Santander', 8, -73, 1),
(784, '54051', 'Arboledas', 54, 'Norte de Santander', 8, -73, 1),
(785, '54099', 'Bochalema', 54, 'Norte de Santander', 8, -73, 1),
(786, '54109', 'Bucarasica', 54, 'Norte de Santander', 8, -73, 1),
(787, '54125', 'Cácota', 54, 'Norte de Santander', 7, -73, 1),
(788, '54128', 'Cáchira', 54, 'Norte de Santander', 8, -73, 1),
(789, '54172', 'Chinácota', 54, 'Norte de Santander', 8, -73, 1),
(790, '54174', 'Chitagá', 54, 'Norte de Santander', 7, -73, 1),
(791, '54206', 'Convención', 54, 'Norte de Santander', 9, -73, 1),
(792, '54223', 'Cucutilla', 54, 'Norte de Santander', 8, -73, 1),
(793, '54239', 'Durania', 54, 'Norte de Santander', 8, -73, 1),
(794, '54245', 'El Carmen', 54, 'Norte de Santander', 9, -73, 1),
(795, '54250', 'El Tarra', 54, 'Norte de Santander', 9, -73, 1),
(796, '54261', 'El Zulia', 54, 'Norte de Santander', 8, -73, 1),
(797, '54313', 'Gramalote', 54, 'Norte de Santander', 8, -73, 1),
(798, '54344', 'Hacarí', 54, 'Norte de Santander', 9, -73, 1),
(799, '54347', 'Herrán', 54, 'Norte de Santander', 8, -72, 1),
(800, '54377', 'Labateca', 54, 'Norte de Santander', 7, -73, 1),
(801, '54385', 'La Esperanza', 54, 'Norte de Santander', 8, -72, 1),
(802, '54398', 'La Playa', 54, 'Norte de Santander', 8, -73, 1),
(803, '54405', 'Los Patios', 54, 'Norte de Santander', 8, -73, 1),
(804, '54418', 'Lourdes', 54, 'Norte de Santander', 8, -73, 1),
(805, '54480', 'Mutiscua', 54, 'Norte de Santander', 7, -73, 1),
(806, '54498', 'Ocaña', 54, 'Norte de Santander', 8, -73, 1),
(807, '54518', 'Pamplona', 54, 'Norte de Santander', 7, -73, 1),
(808, '54520', 'Pamplonita', 54, 'Norte de Santander', 8, -73, 1),
(809, '54553', 'Puerto Santander', 54, 'Norte de Santander', 8, -72, 1),
(810, '54599', 'Ragonvalia', 54, 'Norte de Santander', 8, -73, 1),
(811, '54660', 'Salazar', 54, 'Norte de Santander', 8, -73, 1),
(812, '54670', 'San Calixto', 54, 'Norte de Santander', 9, -73, 1),
(813, '54673', 'San Cayetano', 54, 'Norte de Santander', 8, -73, 1),
(814, '54680', 'Santiago', 54, 'Norte de Santander', 8, -73, 1),
(815, '54720', 'Sardinata', 54, 'Norte de Santander', 8, -73, 1),
(816, '54743', 'Silos', 54, 'Norte de Santander', 7, -73, 1),
(817, '54800', 'Teorama', 54, 'Norte de Santander', 9, -73, 1),
(818, '54810', 'Tibú', 54, 'Norte de Santander', 9, -73, 1),
(819, '54820', 'Toledo', 54, 'Norte de Santander', 7, -72, 1),
(820, '54871', 'Villa Caro', 54, 'Norte de Santander', 8, -73, 1),
(821, '54874', 'Villa del Rosario', 54, 'Norte de Santander', 8, -72, 1),
(822, '63001', 'Armenia', 63, 'Quindío', 5, -76, 1),
(823, '63111', 'Buenavista', 63, 'Quindío', 4, -76, 1),
(824, '63130', 'Calarcá', 63, 'Quindío', 5, -76, 1),
(825, '63190', 'Circasia', 63, 'Quindío', 5, -76, 1),
(826, '63212', 'Cordobá', 63, 'Quindío', 4, -76, 1),
(827, '63272', 'Filandia', 63, 'Quindío', 5, -76, 1),
(828, '63302', 'Génova', 63, 'Quindío', 4, -76, 1),
(829, '63401', 'La Tebaida', 63, 'Quindío', 4, -76, 1),
(830, '63470', 'Montenegro', 63, 'Quindío', 5, -76, 1),
(831, '63548', 'Pijao', 63, 'Quindío', 4, -76, 1),
(832, '63594', 'Quimbaya', 63, 'Quindío', 5, -76, 1),
(833, '63690', 'Salento', 63, 'Quindío', 5, -76, 1),
(834, '66001', 'Pereira', 66, 'Risaralda', 5, -76, 1),
(835, '66045', 'Apía', 66, 'Risaralda', 5, -76, 1),
(836, '66075', 'Balboa', 66, 'Risaralda', 5, -76, 1),
(837, '66088', 'Belén de Umbría', 66, 'Risaralda', 5, -76, 1),
(838, '66170', 'Dos Quebradas', 66, 'Risaralda', 5, -76, 1),
(839, '66318', 'Guática', 66, 'Risaralda', 5, -76, 1),
(840, '66383', 'La Celia', 66, 'Risaralda', 5, -76, 1),
(841, '66400', 'La Virginia', 66, 'Risaralda', 5, -76, 1),
(842, '66440', 'Marsella', 66, 'Risaralda', 5, -76, 1),
(843, '66456', 'Mistrató', 66, 'Risaralda', 5, -76, 1),
(844, '66572', 'Pueblo Rico', 66, 'Risaralda', 5, -76, 1),
(845, '66594', 'Quinchía', 66, 'Risaralda', 5, -76, 1),
(846, '66682', 'Santa Rosa de Cabal', 66, 'Risaralda', 5, -76, 1),
(847, '66687', 'Santuario', 66, 'Risaralda', 5, -76, 1),
(848, '68001', 'Bucaramanga', 68, 'Santander', 7, -73, 1),
(849, '68013', 'Aguada', 68, 'Santander', 6, -73, 1),
(850, '68020', 'Albania', 68, 'Santander', 6, -74, 1),
(851, '68051', 'Aratoca', 68, 'Santander', 7, -73, 1),
(852, '68077', 'Barbosa', 68, 'Santander', 6, -74, 1),
(853, '68079', 'Barichara', 68, 'Santander', 7, -73, 1),
(854, '68081', 'Barrancabermeja', 68, 'Santander', 7, -74, 1),
(855, '68092', 'Betulia', 68, 'Santander', 7, -73, 1),
(856, '68101', 'Bolívar', 68, 'Santander', 6, -74, 1),
(857, '68121', 'Cabrera', 68, 'Santander', 7, -73, 1),
(858, '68132', 'California', 68, 'Santander', 7, -73, 1),
(859, '68147', 'Capitanejo', 68, 'Santander', 7, -73, 1),
(860, '68152', 'Carcasí', 68, 'Santander', 7, -73, 1),
(861, '68160', 'Cepita', 68, 'Santander', 7, -73, 1),
(862, '68162', 'Cerrito', 68, 'Santander', 7, -73, 1),
(863, '68167', 'Charalá', 68, 'Santander', 6, -73, 1),
(864, '68169', 'Charta', 68, 'Santander', 7, -73, 1),
(865, '68176', 'Chima', 68, 'Santander', 6, -73, 1),
(866, '68179', 'Chipatá', 68, 'Santander', 6, -74, 1),
(867, '68190', 'Cimitarra', 68, 'Santander', 6, -74, 1),
(868, '68207', 'Concepción', 68, 'Santander', 7, -73, 1),
(869, '68209', 'Confines', 68, 'Santander', 6, -73, 1),
(870, '68211', 'Contratación', 68, 'Santander', 6, -73, 1),
(871, '68217', 'Coromoro', 68, 'Santander', 6, -73, 1),
(872, '68229', 'Curití', 68, 'Santander', 7, -73, 1),
(873, '68235', 'El Carmen', 68, 'Santander', 6, -74, 1),
(874, '68245', 'El Guacamayo', 68, 'Santander', 6, -73, 1),
(875, '68250', 'El Peñon', 68, 'Santander', 7, -73, 1),
(876, '68255', 'El Playón', 68, 'Santander', 7, -73, 1),
(877, '68264', 'Encino', 68, 'Santander', 6, -73, 1),
(878, '68266', 'Enciso', 68, 'Santander', 7, -73, 1),
(879, '68271', 'Florián', 68, 'Santander', 6, -74, 1),
(880, '68276', 'Floridablanca', 68, 'Santander', 7, -73, 1),
(881, '68296', 'Galán', 68, 'Santander', 7, -73, 1),
(882, '68298', 'Gámbita', 68, 'Santander', 6, -73, 1),
(883, '68306', 'Girón', 68, 'Santander', 7, -73, 1),
(884, '68318', 'Guaca', 68, 'Santander', 7, -73, 1),
(885, '68320', 'Guadalupe', 68, 'Santander', 6, -73, 1),
(886, '68322', 'Guapota', 68, 'Santander', 6, -73, 1),
(887, '68324', 'Guavatá', 68, 'Santander', 6, -74, 1),
(888, '68327', 'Guepsa', 68, 'Santander', 6, -74, 1),
(889, '68344', 'Hato', 68, 'Santander', 7, -73, 1),
(890, '68368', 'Jesús María', 68, 'Santander', 6, -74, 1),
(891, '68370', 'Jordán', 68, 'Santander', 7, -73, 1),
(892, '68377', 'La Belleza', 68, 'Santander', 6, -74, 1),
(893, '68385', 'Landázuri', 68, 'Santander', 6, -74, 1),
(894, '68397', 'La Paz', 68, 'Santander', 6, -73, 1),
(895, '68406', 'Lebrija', 68, 'Santander', 7, -73, 1),
(896, '68418', 'Los Santos', 68, 'Santander', 7, -73, 1),
(897, '68425', 'Macaravita', 68, 'Santander', 7, -73, 1),
(898, '68432', 'Málaga', 68, 'Santander', 7, -73, 1),
(899, '68444', 'Matanza', 68, 'Santander', 7, -73, 1),
(900, '68464', 'Mogotes', 68, 'Santander', 7, -73, 1),
(901, '68468', 'Molagavita', 68, 'Santander', 7, -73, 1),
(902, '68498', 'Ocamonte', 68, 'Santander', 6, -73, 1),
(903, '68500', 'Oiba', 68, 'Santander', 6, -73, 1),
(904, '68502', 'Onzaga', 68, 'Santander', 6, -73, 1),
(905, '68522', 'Palmar', 68, 'Santander', 7, -73, 1),
(906, '68524', 'Palmas del Socorro', 68, 'Santander', 6, -73, 1),
(907, '68533', 'Páramo', 68, 'Santander', 7, -73, 1),
(908, '68547', 'Pie de Cuesta', 68, 'Santander', 6, -74, 1),
(909, '68549', 'Pinchote', 68, 'Santander', 7, -73, 1),
(910, '68572', 'Puente Nacional', 68, 'Santander', 6, -74, 1),
(911, '68573', 'Puerto Parra', 68, 'Santander', 7, -74, 1),
(912, '68575', 'Puerto Wilches', 68, 'Santander', 8, -74, 1);
INSERT INTO `loc_ciudad` (`id_ciudad`, `codigo_ciudad`, `nombre_ciudad`, `id_estado`, `nombre_estado`, `latitud_ciudad`, `longitud_ciudad`, `activo_ciudad`) VALUES
(913, '68615', 'Rio Negro', 68, 'Santander', 7, -73, 1),
(914, '68655', 'Sabana de Torres', 68, 'Santander', 7, -73, 1),
(915, '68669', 'San Andrés', 68, 'Santander', 7, -73, 1),
(916, '68673', 'San Benito', 68, 'Santander', 6, -73, 1),
(917, '68679', 'San Gíl', 68, 'Santander', 7, -73, 1),
(918, '68682', 'San Joaquín', 68, 'Santander', 6, -73, 1),
(919, '68684', 'San Miguel', 68, 'Santander', 7, -73, 1),
(920, '68686', 'San José de Miranda', 68, 'Santander', 7, -73, 1),
(921, '68689', 'San Vicente del Chucurí', 68, 'Santander', 7, -73, 1),
(922, '68705', 'Santa Bárbara', 68, 'Santander', 7, -73, 1),
(923, '68720', 'Santa Helena del Opón', 68, 'Santander', 6, -74, 1),
(924, '68745', 'Simacota', 68, 'Santander', 6, -73, 1),
(925, '68755', 'Socorro', 68, 'Santander', 7, -73, 1),
(926, '68770', 'Suaita', 68, 'Santander', 6, -73, 1),
(927, '68773', 'Sucre', 68, 'Santander', 6, -74, 1),
(928, '68780', 'Suratá', 68, 'Santander', 8, -73, 1),
(929, '68820', 'Tona', 68, 'Santander', 7, -73, 1),
(930, '68855', 'Valle de San José', 68, 'Santander', 7, -73, 1),
(931, '68861', 'Vélez', 68, 'Santander', 6, -74, 1),
(932, '68867', 'Vetas', 68, 'Santander', 7, -73, 1),
(933, '68872', 'Villanueva', 68, 'Santander', 7, -73, 1),
(934, '68895', 'Zapatoca', 68, 'Santander', 7, -73, 1),
(935, '70001', 'Sincelejo', 70, 'Sucre', 9, -75, 1),
(936, '70110', 'Buenavista', 70, 'Sucre', 9, -75, 1),
(937, '70124', 'Caimito', 70, 'Sucre', 9, -75, 1),
(938, '70204', 'Colosó (Ricaurte)', 70, 'Sucre', 9, -75, 1),
(939, '70215', 'Corozal', 70, 'Sucre', 9, -75, 1),
(940, '70221', 'Coveñas', 70, 'Sucre', 9, -76, 1),
(941, '70230', 'Chalán', 70, 'Sucre', 10, -75, 1),
(942, '70233', 'El Roble', 70, 'Sucre', 9, -75, 1),
(943, '70235', 'Galeras (Nueva Granada)', 70, 'Sucre', 9, -75, 1),
(944, '70265', 'Guaranda', 70, 'Sucre', 8, -76, 1),
(945, '70400', 'La Unión', 70, 'Sucre', 9, -75, 1),
(946, '70418', 'Los Palmitos', 70, 'Sucre', 9, -75, 1),
(947, '70429', 'Majagual', 70, 'Sucre', 9, -75, 1),
(948, '70473', 'Morroa', 70, 'Sucre', 9, -75, 1),
(949, '70508', 'Ovejas', 70, 'Sucre', 10, -75, 1),
(950, '70523', 'Palmito', 70, 'Sucre', 9, -76, 1),
(951, '70670', 'Sampués', 70, 'Sucre', 9, -75, 1),
(952, '70678', 'San Benito Abad', 70, 'Sucre', 9, -75, 1),
(953, '70702', 'San Juan de Betulia', 70, 'Sucre', 9, -75, 1),
(954, '70708', 'San Marcos', 70, 'Sucre', 9, -75, 1),
(955, '70713', 'San Onofre', 70, 'Sucre', 10, -76, 1),
(956, '70717', 'San Pedro', 70, 'Sucre', 9, -75, 1),
(957, '70742', 'Sincé', 70, 'Sucre', 9, -75, 1),
(958, '70771', 'Sucre', 70, 'Sucre', 9, -75, 1),
(959, '70820', 'Tolú', 70, 'Sucre', 10, -76, 1),
(960, '70823', 'Tolú Viejo', 70, 'Sucre', 0, 0, 1),
(961, '73001', 'Ibagué', 73, 'Tolima', 4, -75, 1),
(962, '73024', 'Alpujarra', 73, 'Tolima', 3, -75, 1),
(963, '73026', 'Alvarado', 73, 'Tolima', 5, -75, 1),
(964, '73030', 'Ambalema', 73, 'Tolima', 5, -75, 1),
(965, '73043', 'Anzoátegui', 73, 'Tolima', 5, -75, 1),
(966, '73055', 'Armero (Guayabal)', 73, 'Tolima', 5, -75, 1),
(967, '73067', 'Ataco', 73, 'Tolima', 3, -76, 1),
(968, '73124', 'Cajamarca', 73, 'Tolima', 4, -76, 1),
(969, '73148', 'Carmen de Apicalá', 73, 'Tolima', 4, -75, 1),
(970, '73152', 'Casabianca', 73, 'Tolima', 5, -75, 1),
(971, '73168', 'Chaparral', 73, 'Tolima', 4, -76, 1),
(972, '73200', 'Coello', 73, 'Tolima', 4, -75, 1),
(973, '73217', 'Coyaima', 73, 'Tolima', 4, -75, 1),
(974, '73226', 'Cunday', 73, 'Tolima', 4, -75, 1),
(975, '73236', 'Dolores', 73, 'Tolima', 4, -75, 1),
(976, '73268', 'Espinal', 73, 'Tolima', 4, -75, 1),
(977, '73270', 'Falan', 73, 'Tolima', 5, -75, 1),
(978, '73275', 'Flandes', 73, 'Tolima', 4, -75, 1),
(979, '73283', 'Fresno', 73, 'Tolima', 5, -75, 1),
(980, '73319', 'Guamo', 73, 'Tolima', 4, -75, 1),
(981, '73347', 'Herveo', 73, 'Tolima', 5, -75, 1),
(982, '73349', 'Honda', 73, 'Tolima', 5, -75, 1),
(983, '73352', 'Icononzo', 73, 'Tolima', 4, -75, 1),
(984, '73408', 'Lérida', 73, 'Tolima', 5, -75, 1),
(985, '73411', 'Líbano', 73, 'Tolima', 5, -75, 1),
(986, '73443', 'Mariquita', 73, 'Tolima', 5, -75, 1),
(987, '73449', 'Melgar', 73, 'Tolima', 4, -75, 1),
(988, '73461', 'Murillo', 73, 'Tolima', 5, -75, 1),
(989, '73483', 'Natagaima', 73, 'Tolima', 4, -75, 1),
(990, '73504', 'Ortega', 73, 'Tolima', 4, -75, 1),
(991, '73520', 'Palocabildo', 73, 'Tolima', 5, -75, 1),
(992, '73547', 'Piedras', 73, 'Tolima', 5, -75, 1),
(993, '73555', 'Planadas', 73, 'Tolima', 3, -76, 1),
(994, '73563', 'Prado', 73, 'Tolima', 4, -75, 1),
(995, '73585', 'Purificación', 73, 'Tolima', 4, -75, 1),
(996, '73616', 'Rioblanco', 73, 'Tolima', 4, -76, 1),
(997, '73622', 'Roncesvalles', 73, 'Tolima', 4, -76, 1),
(998, '73624', 'Rovira', 73, 'Tolima', 4, -75, 1),
(999, '73671', 'Saldaña', 73, 'Tolima', 4, -75, 1),
(1000, '73675', 'San Antonio', 73, 'Tolima', 4, -76, 1),
(1001, '73678', 'San Luis', 73, 'Tolima', 4, -75, 1),
(1002, '73686', 'Santa Isabel', 73, 'Tolima', 5, -75, 1),
(1003, '73770', 'Suárez', 73, 'Tolima', 4, -75, 1),
(1004, '73854', 'Valle de San Juan', 73, 'Tolima', 4, -75, 1),
(1005, '73861', 'Venadillo', 73, 'Tolima', 5, -75, 1),
(1006, '73870', 'Villahermosa', 73, 'Tolima', 5, -75, 1),
(1007, '73873', 'Villarrica', 73, 'Tolima', 4, -75, 1),
(1008, '76001', 'Calí', 76, 'Valle del Cauca', 3, -77, 1),
(1009, '76020', 'Alcalá', 76, 'Valle del Cauca', 5, -76, 1),
(1010, '76036', 'Andalucía', 76, 'Valle del Cauca', 4, -76, 1),
(1011, '76041', 'Ansermanuevo', 76, 'Valle del Cauca', 5, -76, 1),
(1012, '76054', 'Argelia', 76, 'Valle del Cauca', 5, -76, 1),
(1013, '76100', 'Bolívar', 76, 'Valle del Cauca', 4, -76, 1),
(1014, '76109', 'Buenaventura', 76, 'Valle del Cauca', 4, -77, 1),
(1015, '76111', 'Buga', 76, 'Valle del Cauca', 4, -76, 1),
(1016, '76113', 'Bugalagrande', 76, 'Valle del Cauca', 4, -76, 1),
(1017, '76122', 'Caicedonia', 76, 'Valle del Cauca', 4, -76, 1),
(1018, '76126', 'Calima (Darién)', 76, 'Valle del Cauca', 4, -77, 1),
(1019, '76130', 'Candelaria', 76, 'Valle del Cauca', 3, -76, 1),
(1020, '76147', 'Cartago', 76, 'Valle del Cauca', 5, -76, 1),
(1021, '76233', 'Dagua', 76, 'Valle del Cauca', 4, -77, 1),
(1022, '76243', 'El Águila', 76, 'Valle del Cauca', 5, -76, 1),
(1023, '76246', 'El Cairo', 76, 'Valle del Cauca', 5, -76, 1),
(1024, '76248', 'El Cerrito', 76, 'Valle del Cauca', 4, -76, 1),
(1025, '76250', 'El Dovio', 76, 'Valle del Cauca', 5, -76, 1),
(1026, '76275', 'Florida', 76, 'Valle del Cauca', 3, -76, 1),
(1027, '76306', 'Ginebra', 76, 'Valle del Cauca', 4, -76, 1),
(1028, '76318', 'Guacarí', 76, 'Valle del Cauca', 4, -76, 1),
(1029, '76364', 'Jamundí', 76, 'Valle del Cauca', 3, -77, 1),
(1030, '76400', 'La Unión', 76, 'Valle del Cauca', 5, -76, 1),
(1031, '76403', 'La Victoria', 76, 'Valle del Cauca', 5, -76, 1),
(1032, '76497', 'Obando', 76, 'Valle del Cauca', 5, -76, 1),
(1033, '76520', 'Palmira', 76, 'Valle del Cauca', 4, -76, 1),
(1034, '76563', 'Pradera', 76, 'Valle del Cauca', 3, -76, 1),
(1035, '76606', 'Restrepo', 76, 'Valle del Cauca', 4, -77, 1),
(1036, '76616', 'Riofrío', 76, 'Valle del Cauca', 4, -76, 1),
(1037, '76622', 'Roldanillo', 76, 'Valle del Cauca', 4, -76, 1),
(1038, '76670', 'San Pedro', 76, 'Valle del Cauca', 4, -76, 1),
(1039, '76677', 'La Cumbre', 76, 'Valle del Cauca', 4, -77, 1),
(1040, '76736', 'Sevilla', 76, 'Valle del Cauca', 4, -76, 1),
(1041, '76823', 'Toro', 76, 'Valle del Cauca', 5, -76, 1),
(1042, '76828', 'Trujillo', 76, 'Valle del Cauca', 4, -76, 1),
(1043, '76834', 'Tulúa', 76, 'Valle del Cauca', 4, -76, 1),
(1044, '76845', 'Ulloa', 76, 'Valle del Cauca', 5, -76, 1),
(1045, '76863', 'Versalles', 76, 'Valle del Cauca', 5, -76, 1),
(1046, '76869', 'Vijes', 76, 'Valle del Cauca', 4, -76, 1),
(1047, '76890', 'Yotoco', 76, 'Valle del Cauca', 4, -76, 1),
(1048, '76892', 'Yumbo', 76, 'Valle del Cauca', 4, -76, 1),
(1049, '76895', 'Zarzal', 76, 'Valle del Cauca', 4, -76, 1),
(1050, '81001', 'Arauca', 81, 'Arauca', 7, -71, 1),
(1051, '81065', 'Arauquita', 81, 'Arauca', 7, -71, 1),
(1052, '81220', 'Cravo Norte', 81, 'Arauca', 6, -70, 1),
(1053, '81300', 'Fortúl', 81, 'Arauca', 7, -72, 1),
(1054, '81591', 'Puerto Rondón', 81, 'Arauca', 6, -71, 1),
(1055, '81736', 'Saravena', 81, 'Arauca', 7, -72, 1),
(1056, '81794', 'Tame', 81, 'Arauca', 6, -72, 1),
(1057, '85001', 'Yopal', 85, 'Casanare', 5, -72, 1),
(1058, '85010', 'Aguazul', 85, 'Casanare', 5, -73, 1),
(1059, '85015', 'Chámeza', 85, 'Casanare', 5, -73, 1),
(1060, '85125', 'Hato Corozal', 85, 'Casanare', 6, -72, 1),
(1061, '85136', 'La Salina', 85, 'Casanare', 6, -72, 1),
(1062, '85139', 'Maní', 85, 'Casanare', 5, -72, 1),
(1063, '85162', 'Monterrey', 85, 'Casanare', 5, -73, 1),
(1064, '85225', 'Nunchía', 85, 'Casanare', 6, -72, 1),
(1065, '85230', 'Orocué', 85, 'Casanare', 5, -71, 1),
(1066, '85250', 'Paz de Ariporo', 85, 'Casanare', 6, -72, 1),
(1067, '85263', 'Pore', 85, 'Casanare', 6, -72, 1),
(1068, '85279', 'Recetor', 85, 'Casanare', 5, -73, 1),
(1069, '85300', 'Sabanalarga', 85, 'Casanare', 5, -73, 1),
(1070, '85315', 'Sácama', 85, 'Casanare', 6, -72, 1),
(1071, '85325', 'San Luís de Palenque', 85, 'Casanare', 5, -72, 1),
(1072, '85400', 'Támara', 85, 'Casanare', 6, -72, 1),
(1073, '85410', 'Tauramena', 85, 'Casanare', 5, -73, 1),
(1074, '85430', 'Trinidad', 85, 'Casanare', 5, -72, 1),
(1075, '85440', 'Villanueva', 85, 'Casanare', 5, -72, 1),
(1076, '86001', 'Mocoa', 86, 'Putumayo', 1, -77, 1),
(1077, '86219', 'Colón', 86, 'Putumayo', 1, -77, 1),
(1078, '86320', 'Orito', 86, 'Putumayo', 1, -77, 1),
(1079, '86568', 'Puerto Asís', 86, 'Putumayo', 1, -76, 1),
(1080, '86569', 'Puerto Caicedo', 86, 'Putumayo', 1, -77, 1),
(1081, '86571', 'Puerto Guzmán', 86, 'Putumayo', 1, -77, 1),
(1082, '86573', 'Puerto Leguízamo', 86, 'Putumayo', 0, -75, 1),
(1083, '86749', 'Sibundoy', 86, 'Putumayo', 1, -77, 1),
(1084, '86755', 'San Francisco', 86, 'Putumayo', 1, -77, 1),
(1085, '86757', 'San Miguel', 86, 'Putumayo', 0, -77, 1),
(1086, '86760', 'Santiago', 86, 'Putumayo', 1, -77, 1),
(1087, '86865', 'Valle del Guamuez', 86, 'Putumayo', 0, -77, 1),
(1088, '86885', 'Villagarzón', 86, 'Putumayo', 1, -77, 1),
(1089, '88564', 'Providencia', 88, 'San Andrés', 13, -82, 1),
(1090, '91001', 'Leticia', 91, 'Amazonas', -4, -70, 1),
(1091, '91540', 'Puerto Nariño', 91, 'Amazonas', -4, -70, 1),
(1092, '94001', 'Inírida', 94, 'Guainía', 4, -68, 1),
(1093, '95001', 'San José del Guaviare', 95, 'Guaviare', 3, -73, 1),
(1094, '95015', 'Calamar', 95, 'Guaviare', 2, -73, 1),
(1095, '95025', 'El Retorno', 95, 'Guaviare', 2, -73, 1),
(1096, '95200', 'Miraflores', 95, 'Guaviare', 1, -72, 1),
(1097, '97001', 'Mitú', 97, 'Vaupés', 1, -70, 1),
(1098, '97161', 'Carurú', 97, 'Vaupés', 1, -71, 1),
(1099, '97666', 'Taraira', 97, 'Vaupés', 0, -70, 1),
(1100, '99001', 'Puerto Carreño', 99, 'Vichada', 6, -67, 1),
(1101, '99524', 'La Primavera', 99, 'Vichada', 5, -70, 1),
(1102, '99624', 'Santa Rosalía', 99, 'Vichada', 5, -71, 1),
(1103, '99773', 'Cumaribo', 99, 'Vichada', 4, -70, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `loc_estado`
--

CREATE TABLE IF NOT EXISTS `loc_estado` (
  `id_estado` int(11) unsigned NOT NULL,
  `id_pais` int(10) unsigned NOT NULL,
  `nombre_estado` varchar(600) NOT NULL,
  `latitud_estado` double NOT NULL,
  `longitud_estado` double NOT NULL,
  `activo_estado` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_estado`),
  KEY `id_pais` (`id_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `loc_estado`
--

INSERT INTO `loc_estado` (`id_estado`, `id_pais`, `nombre_estado`, `latitud_estado`, `longitud_estado`, `activo_estado`) VALUES
(1, 1, 'Seleccione...', 0, 0, 1),
(5, 57, 'Antioquia', 7, -75.5, 1),
(8, 57, 'Atlántico', 10.75, -75, 1),
(13, 57, 'Bolívar', 9, -74.3333333, 1),
(15, 57, 'Boyacá', 5.5, -72.5, 1),
(17, 57, 'Caldas', 5.25, -75.5, 1),
(18, 57, 'Caquetá', 1, -74, 1),
(19, 57, 'Cauca', 2.5, -76.8333333, 1),
(20, 57, 'Cesar', 9.3333333, -73.5, 1),
(23, 57, 'Córdoba', 8.3333333, -75.6666667, 1),
(25, 57, 'Cundinamarca', 5, -74.1666667, 1),
(27, 57, 'Chocó', 6, -77, 1),
(41, 57, 'Huila', 2.5, -75.75, 1),
(44, 57, 'La Guajira', 11.5, -72.5, 1),
(47, 57, 'Magdalena', 10, -74.5, 1),
(50, 57, 'Meta', 3.5, -73, 1),
(52, 57, 'Nariño', 1.5, -78, 1),
(54, 57, 'Norte de Santander', 8, -73, 1),
(63, 57, 'Quindío', 4.5, -75.6666667, 1),
(66, 57, 'Risaralda', 5, -76, 1),
(68, 57, 'Santander', 7, -73.25, 1),
(70, 57, 'Sucre', 9, -75, 1),
(73, 57, 'Tolima', 3.75, -75.25, 1),
(76, 57, 'Valle del Cauca', 3.75, -76.5, 1),
(81, 57, 'Arauca', 7.0902778, -70.7616667, 1),
(85, 57, 'Casanare', 5.5, -71.5, 1),
(86, 57, 'Putumayo', 0.5, -76, 1),
(88, 57, 'San Andrés', 12.5847222, -81.7005556, 1),
(91, 57, 'Amazonas', -1.0197222, -71.9383333, 1),
(94, 57, 'Guainía', 2.5, -69, 1),
(95, 57, 'Guaviare', 1.6894444, -72.8202778, 1),
(97, 57, 'Vaupés', 0.25, -70.75, 1),
(99, 57, 'Vichada', 5, -69.5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `loc_pais`
--

CREATE TABLE IF NOT EXISTS `loc_pais` (
  `id_pais` int(10) unsigned NOT NULL,
  `nombre_pais` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `loc_pais`
--

INSERT INTO `loc_pais` (`id_pais`, `nombre_pais`) VALUES
(1, 'No'),
(7, 'Rusia'),
(11, 'Estados Unidos'),
(20, 'Egipto'),
(27, 'Sudafrica'),
(30, 'Grecia'),
(31, 'Holanda'),
(32, 'Belgica'),
(33, 'Francia'),
(34, 'Espana'),
(36, 'Hungria'),
(39, 'Italia'),
(40, 'Rumania'),
(41, 'Suiza'),
(43, 'Austria'),
(44, 'Reino Unido'),
(45, 'Dinamarca'),
(46, 'Suecia'),
(47, 'Noruega'),
(48, 'Polonia'),
(49, 'Alemania'),
(51, 'Peru'),
(52, 'Mexico'),
(53, 'Cuba'),
(54, 'Argentina'),
(55, 'Brasil'),
(56, 'Chile'),
(57, 'Colombia'),
(58, 'Venezuela'),
(60, 'Malasia'),
(61, 'Australia'),
(62, 'Indonesia'),
(63, 'Filipinas'),
(64, 'Nueva Zelanda'),
(65, 'Singapur'),
(66, 'Tailandia'),
(81, 'Japon'),
(82, 'Corea del Sur'),
(84, 'Vietnam'),
(86, 'China'),
(90, 'Turquia'),
(91, 'India'),
(92, 'Pakistan'),
(93, 'Afganistan'),
(94, 'Sri Lanka'),
(95, 'Myanmar'),
(98, 'Iran'),
(213, 'Argelia'),
(216, 'Tunez'),
(218, 'Libia'),
(220, 'Gambia'),
(221, 'Senegal'),
(222, 'Mauritania'),
(223, 'Mali'),
(224, 'Rep. de Guinea'),
(225, 'Costa de Marfil'),
(226, 'Burkina Faso'),
(227, 'Niger'),
(228, 'Togo'),
(229, 'Benin'),
(230, 'Islas Mauricio'),
(231, 'Liberia'),
(232, 'Sierra Leona'),
(233, 'Ghana'),
(234, 'Nigeria'),
(235, 'Chad'),
(236, 'Rep. Centroafricana'),
(237, 'Camerun'),
(238, 'Cabo Verde'),
(239, 'Santo Tome y Principe'),
(240, 'Guinea Ecuatorial'),
(241, 'Gabon'),
(242, 'Rep. del Congo'),
(243, 'Zaire'),
(244, 'Angola'),
(245, 'Guinea Bissau'),
(246, 'Diego Garcia'),
(247, 'Ascension'),
(248, 'Seychelles'),
(249, 'Sudan'),
(250, 'Ruanda'),
(251, 'Etiopia'),
(252, 'Somalia'),
(253, 'Yibuti'),
(254, 'Kenia'),
(255, 'Tanzania'),
(256, 'Uganda'),
(257, 'Burundi'),
(258, 'Mozambique'),
(260, 'Zambia'),
(261, 'Madagascar'),
(262, 'Islas Reunion'),
(263, 'Zimbabwe'),
(264, 'Namibia'),
(265, 'Malawi'),
(266, 'Lesotho'),
(267, 'Botswana'),
(268, 'Suazilandia'),
(269, 'Comores'),
(290, 'Santa Elena'),
(291, 'Eritrea'),
(297, 'Aruba'),
(298, 'Islas Feroe'),
(299, 'Groenlandia'),
(338, 'Francia Premium'),
(350, 'Gibraltar'),
(351, 'Portugal'),
(352, 'Luxemburgo'),
(353, 'Irlanda'),
(354, 'Islandia'),
(355, 'Albania'),
(356, 'Malta'),
(357, 'Chipre'),
(358, 'Finlandia'),
(359, 'Bulgaria'),
(370, 'Lituania'),
(371, 'Letonia'),
(372, 'Estonia'),
(373, 'Moldavia'),
(374, 'Armenia'),
(375, 'Bielorrusia'),
(376, 'Andorra'),
(377, 'Monaco'),
(378, 'San Marino'),
(379, 'Vaticano'),
(380, 'Ucrania'),
(381, 'Serbia'),
(382, 'Montenegro'),
(385, 'Croacia'),
(386, 'Eslovenia'),
(387, 'Bosnia Herzegovina'),
(389, 'Macedonia'),
(403, 'Rumania Redes Alternativas'),
(420, 'Rep. Checa'),
(421, 'Rep. Eslovaca'),
(423, 'Liechtenstein'),
(500, 'Islas Malvinas'),
(501, 'Belize'),
(502, 'Guatemala'),
(503, 'El Salvador'),
(504, 'Honduras'),
(505, 'Nicaragua'),
(506, 'Costa Rica'),
(507, 'Panama'),
(508, 'San Pedro y Miquelon'),
(509, 'Haiti'),
(531, 'Cuba Guantanamo'),
(590, 'Guadalupe'),
(591, 'Bolivia'),
(592, 'Guyana'),
(593, 'Ecuador'),
(594, 'Guayana Francesa'),
(595, 'Paraguay'),
(596, 'Martinica'),
(597, 'Surinam'),
(598, 'Uruguay'),
(599, 'Antillas Holandesas'),
(670, 'Timor Oriental'),
(672, 'Territorio Ext. de Australia'),
(673, 'Brunei'),
(674, 'Nauru'),
(675, 'Papua Nueva Guinea'),
(676, 'Tonga'),
(677, 'Islas Salomon'),
(678, 'Vanuatu'),
(679, 'Fiji'),
(680, 'Palau'),
(681, 'Islas Wallis y Futuna'),
(682, 'Islas Cook'),
(683, 'Niue'),
(684, 'Samoa Americana'),
(685, 'Samoa Occidental'),
(686, 'Kiribati'),
(687, 'Nueva Caledonia'),
(688, 'Tuvalu'),
(689, 'Polinesia Francesa'),
(690, 'Tokelau'),
(691, 'Micronesia'),
(692, 'Islas Marshall'),
(850, 'Corea del Norte'),
(852, 'Hong Kong'),
(853, 'Macao'),
(855, 'Camboya'),
(856, 'Laos'),
(880, 'Bangladesh'),
(886, 'Taiwan'),
(960, 'Maldivas'),
(961, 'Libano'),
(962, 'Jordania'),
(963, 'Siria'),
(964, 'Irak'),
(965, 'Kuwait'),
(966, 'Arabia Saudita'),
(967, 'Yemen'),
(968, 'Oman'),
(970, 'Palestina'),
(971, 'Emiratos arabes Unidos'),
(972, 'Israel'),
(973, 'Bahrein'),
(974, 'Qatar'),
(975, 'Bhutan'),
(976, 'Mongolia'),
(977, 'Nepal'),
(992, 'Tadjikistan'),
(993, 'Turkmenistan'),
(994, 'Azerbaiyan'),
(995, 'Georgia'),
(996, 'Kirguizistan'),
(998, 'Uzbekistan'),
(1204, 'Canada'),
(1242, 'Bahamas'),
(1246, 'Barbados'),
(1264, 'Anguilla'),
(1268, 'Antigua y Barbuda'),
(1284, 'Isl. Virgenes Britanicas'),
(1340, 'Islas Virgenes Americanas'),
(1345, 'Islas Caiman'),
(1441, 'Bermudas'),
(1473, 'Granada'),
(1649, 'Turcos y Caicos'),
(1664, 'Montserrat'),
(1670, 'Islas Marianas'),
(1671, 'Guam'),
(1758, 'Santa Lucia'),
(1767, 'Dominica'),
(1784, 'S. Vicente y Granadinas'),
(1787, 'Puerto Rico'),
(1800, 'Estados Unidos Freephone'),
(1808, 'Hawai'),
(1809, 'Rep. Dominicana'),
(1868, 'Trinidad y Tobago'),
(1869, 'San Cristobal y Nevis'),
(1876, 'Jamaica'),
(1907, 'Alaska'),
(2234, 'Mali Orange'),
(3774, 'Monaco Otros Servicios'),
(4470, 'Reino Unido Personal'),
(4702, 'Noruega Otros Servicios'),
(5118, 'Peru Rural'),
(6723, 'Islas Norfolk'),
(7573, 'Kazakstan'),
(8703, 'Inmarsat B'),
(8706, 'Inmarsat M'),
(8707, 'Inmarsat Mini M'),
(8711, 'Inmarsat A'),
(8715, 'Inmarsat Aero'),
(8816, 'Iridium'),
(8818, 'Satelite Globalstar'),
(44345, 'Reino Unido Local Rate'),
(44870, 'Reino Unido National Rate'),
(49180, 'Alemania Premium'),
(87039, 'Inmarsat B RDSI'),
(87060, 'Inmarsat M4 Datos'),
(88213, 'Emsat'),
(88216, 'Satelite Thuraya'),
(212525, 'Marruecos'),
(262269, 'Mayotte'),
(351291, 'Madeira'),
(351292, 'Azores'),
(441481, 'Islas Guernesey'),
(441534, 'Islas Jersey'),
(6189162, 'Islas Christmas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `participante`
--

CREATE TABLE IF NOT EXISTS `participante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_empresa` int(11) NOT NULL,
  `id_convocatoria` int(11) NOT NULL,
  `fecha_ingreso` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado` int(11) NOT NULL,
  `observaciones` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_empresa` (`id_empresa`),
  KEY `id_convocatoria` (`id_convocatoria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Convocatoria Empresa' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil`
--

CREATE TABLE IF NOT EXISTS `perfil` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `perfil` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `perfil`
--

INSERT INTO `perfil` (`id`, `perfil`) VALUES
(1, 'Administrador'),
(2, 'Evaluador'),
(3, 'Encargado de Proceso'),
(4, 'Jurado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_ciudad` int(10) unsigned NOT NULL,
  `nombre` varchar(400) DEFAULT NULL,
  `apellido` varchar(400) DEFAULT NULL,
  `documento_identidad` varchar(100) NOT NULL,
  `email_personal` varchar(200) DEFAULT NULL,
  `email_corporativo` varchar(200) DEFAULT NULL,
  `twitter` varchar(200) DEFAULT NULL,
  `skype` varchar(200) DEFAULT NULL,
  `telefono_fijo` varchar(200) DEFAULT NULL,
  `celular` varchar(200) DEFAULT NULL,
  `login` varchar(30) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT '1' COMMENT 'activo 1, inactivo 0',
  `fecha_creacion` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `documento_identidad` (`documento_identidad`),
  KEY `id_ciudad` (`id_ciudad`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='persona' AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id`, `id_ciudad`, `nombre`, `apellido`, `documento_identidad`, `email_personal`, `email_corporativo`, `twitter`, `skype`, `telefono_fijo`, `celular`, `login`, `password`, `estado`, `fecha_creacion`) VALUES
(2, 0, 'Pedro', 'Perez', '123', NULL, 'pedro.perez@yopmail.com', NULL, NULL, '555-555-5501', NULL, NULL, NULL, 0, '2013-01-10 06:58:12'),
(3, 0, 'Juan', 'Alvarez', '234', 'juan.alvarez.persona@yopmail.com', 'juan.alvarez@yopmail.com', NULL, NULL, '555-555-5566', NULL, NULL, NULL, 0, '2013-01-10 06:58:12'),
(4, 127, 'oscar', 'perez', '12', NULL, 'asd@os.com', NULL, NULL, '999', NULL, NULL, NULL, 0, '2013-01-10 08:51:37'),
(5, 127, 'pedro', 'caceres', '23', 'adad@sasdpersonal.com', 'adad@sasd.com', NULL, NULL, '9898', NULL, NULL, NULL, 0, '2013-01-10 08:51:37'),
(6, 320, 'luz nancy ', 'lanza angulo', '52158883', NULL, 'pccg@ccalidad.com.co', NULL, NULL, '2861444', NULL, NULL, NULL, 0, '2013-01-10 10:26:10'),
(7, 320, 'Edward', 'Ramirez', '78.908.657', 'eramirez@ccalidad.com.co', 'eramirez@ccalidad.com.co', NULL, NULL, '4567890', NULL, NULL, NULL, 0, '2013-01-10 10:26:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pn_agenda`
--

CREATE TABLE IF NOT EXISTS `pn_agenda` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_participante` int(11) NOT NULL,
  `id_empleado_creador` int(11) NOT NULL,
  `fecha_agenda` datetime NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_participante` (`id_participante`),
  KEY `id_empleado_creador` (`id_empleado_creador`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pn_agenda_invitado`
--

CREATE TABLE IF NOT EXISTS `pn_agenda_invitado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_agenda` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `id_pn_subcapitulo` int(11) NOT NULL,
  `documentos` text NOT NULL,
  `preguntas` text NOT NULL,
  `resultados` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_agenda` (`id_agenda`),
  KEY `id_empleado` (`id_empleado`),
  KEY `id_pn_capitulo` (`id_pn_subcapitulo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pn_capitulo`
--

CREATE TABLE IF NOT EXISTS `pn_capitulo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `criterio` varchar(400) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Capitulos para el PNEIG' AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `pn_capitulo`
--

INSERT INTO `pn_capitulo` (`id`, `criterio`) VALUES
(1, 'Estrategia'),
(2, 'Liderazgo'),
(3, 'Personas'),
(4, 'Procesos'),
(5, 'Conocimiento e información'),
(6, 'Capacidad de Innovación'),
(7, 'Clientes y mercados'),
(8, 'Resultados');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pn_categoria_criterio`
--

CREATE TABLE IF NOT EXISTS `pn_categoria_criterio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoria_criterio` varchar(400) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Agrupa Criterios Por Categoria' AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `pn_categoria_criterio`
--

INSERT INTO `pn_categoria_criterio` (`id`, `categoria_criterio`) VALUES
(1, 'Enfoque'),
(2, 'Implementación'),
(3, 'Resultados'),
(4, 'Visión');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pn_conclusion`
--

CREATE TABLE IF NOT EXISTS `pn_conclusion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_participante` int(11) NOT NULL,
  `id_capitulo` int(11) NOT NULL,
  `recomendacion` text NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_participante` (`id_participante`),
  KEY `id_capitulo` (`id_capitulo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pn_criterio`
--

CREATE TABLE IF NOT EXISTS `pn_criterio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_categoria_criterio` int(11) NOT NULL,
  `criterio` varchar(400) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_categoria_criterio` (`id_categoria_criterio`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Creterios PNEIG' AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `pn_criterio`
--

INSERT INTO `pn_criterio` (`id`, `id_categoria_criterio`, `criterio`) VALUES
(1, 1, 'Sistematicidad'),
(2, 1, 'Amplitud'),
(3, 1, 'Proactividad'),
(4, 1, 'Impacto'),
(5, 1, 'Ciclo de evaluación y mejoramiento'),
(6, 2, 'Despliegue'),
(7, 2, 'Sistematicidad '),
(8, 2, 'Prioridad'),
(9, 2, 'Ciclo de evaluación y mejoramiento'),
(10, 3, 'Pertinencia'),
(11, 3, 'Consistencia'),
(12, 3, 'Avance de la medición'),
(13, 3, 'Tendencia'),
(14, 3, 'Comparación'),
(15, 4, 'Visión Global o de Capítulo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pn_cualitativa`
--

CREATE TABLE IF NOT EXISTS `pn_cualitativa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_formato` int(11) NOT NULL,
  `id_participante` int(11) NOT NULL,
  `id_empleado` int(11) DEFAULT NULL COMMENT 'En Global es NULO',
  `id_capitulo` int(11) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fortalezas` text NOT NULL,
  `oportunidades` text NOT NULL,
  `pendientes_visita` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_tipo_formato` (`id_tipo_formato`),
  KEY `id_participante` (`id_participante`),
  KEY `id_empleado` (`id_empleado`),
  KEY `id_capitulo` (`id_capitulo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pn_cuantitativa`
--

CREATE TABLE IF NOT EXISTS `pn_cuantitativa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_formato` int(11) NOT NULL,
  `id_participante` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `id_sub_capitulo` int(11) NOT NULL,
  `valor` int(11) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_tipo_formato` (`id_tipo_formato`),
  KEY `id_participante` (`id_participante`),
  KEY `id_empleado` (`id_empleado`),
  KEY `id_sub_capitulo` (`id_sub_capitulo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Total de 0 a 1000, Cada Valor se Multiplica por el Ponderado del SubCapilo' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pn_premio`
--

CREATE TABLE IF NOT EXISTS `pn_premio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(400) NOT NULL,
  `fecha_desde` datetime NOT NULL,
  `fecha_hasta` datetime NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `pn_premio`
--

INSERT INTO `pn_premio` (`id`, `nombre`, `fecha_desde`, `fecha_hasta`, `fecha_creacion`) VALUES
(1, 'PNEIG 2013-13', '2013-01-01 00:00:00', '2013-01-15 00:00:00', '2013-01-15 03:57:47'),
(2, 'dos', '2013-01-15 00:00:00', '2013-01-18 00:00:00', '2013-01-15 03:48:41'),
(3, 'algo', '2013-01-09 00:00:00', '2013-01-10 00:00:00', '2013-01-15 03:58:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pn_sub_capitulo`
--

CREATE TABLE IF NOT EXISTS `pn_sub_capitulo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_capitulo` int(11) NOT NULL,
  `ponderacion` int(11) NOT NULL COMMENT 'ponderado maximo',
  `sub_capitulo` varchar(400) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_capitulo` (`id_capitulo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=31 ;

--
-- Volcado de datos para la tabla `pn_sub_capitulo`
--

INSERT INTO `pn_sub_capitulo` (`id`, `id_capitulo`, `ponderacion`, `sub_capitulo`) VALUES
(1, 1, 30, '1.1 Pensamiento organizacional, formulación y planteamiento estratégico'),
(2, 1, 30, '1.2 Definición de iniciativas y acciones estratégicas'),
(3, 1, 30, '1.3 Despliegue y seguimiento estratégico'),
(4, 1, 30, '1.4 Alineación de estrategia, estructura y cultura'),
(5, 2, 40, '2.1 Estilo de liderazgo'),
(6, 2, 30, '2.2 Cultura organizacional'),
(7, 2, 30, '2.3 Ética y gobierno corporativo'),
(8, 3, 20, '3.1 Gestión del talento humano'),
(9, 3, 20, '3.2 Desarrollo integral de las personas'),
(10, 3, 20, '3.3 Competencias y disciplinas'),
(11, 3, 20, '3.4 Calidad de vida en el trabajo'),
(12, 4, 25, '4.1 Estructura y gestión de procesos'),
(13, 4, 25, '4.2 Gestión de la rutina'),
(14, 4, 25, '4.3 Gestión de mejoramiento e innovación'),
(15, 4, 25, '4.4 Gestión de relaciones con los proveedores'),
(16, 5, 30, '5.1 Gestión de la información'),
(17, 5, 30, '5.2 Gestión del conocimiento'),
(18, 5, 20, '5.3 Redes'),
(19, 6, 30, '6.1 Estrategia de innovación'),
(20, 6, 20, '6.2 Despliegue de la estrategia de innovación'),
(21, 6, 20, '6.3 Cultura de la innovación'),
(22, 6, 20, '6.4 Innovación en la cadena de valor'),
(23, 6, 30, '6.5 Resultados de la innovación'),
(24, 7, 25, '7.1 Conocimiento de clientes y mercados'),
(25, 7, 30, '7.2 Desarrollo de productos y servicios'),
(26, 7, 25, '7.3 Relaciones con los clientes'),
(27, 7, 20, '7.4 Asociatividad'),
(28, 8, 100, '8.1 Creación de valor para los grupos sociales objetivo'),
(29, 8, 100, '8.2 Competitividad'),
(30, 8, 100, '8.3 Sostenibilidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pn_valoracion`
--

CREATE TABLE IF NOT EXISTS `pn_valoracion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_formato` int(11) NOT NULL,
  `id_participante` int(11) NOT NULL,
  `id_empleado` int(11) DEFAULT NULL COMMENT 'En Global es NULO',
  `id_capitulo` int(11) DEFAULT NULL COMMENT 'Para los de capitulos',
  `id_pn_criterio` int(11) NOT NULL,
  `valor` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_tipo_formato` (`id_tipo_formato`),
  KEY `id_participante` (`id_participante`),
  KEY `id_pn_criterio` (`id_pn_criterio`),
  KEY `id_empleado` (`id_empleado`),
  KEY `id_capitulo` (`id_capitulo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio`
--

CREATE TABLE IF NOT EXISTS `servicio` (
  `id_servicio` int(11) NOT NULL AUTO_INCREMENT,
  `servicio` varchar(300) DEFAULT NULL,
  `texto_servicio` varchar(500) NOT NULL,
  `publico` int(11) DEFAULT NULL,
  `visible` int(11) DEFAULT NULL,
  `tipo` char(1) NOT NULL,
  `orden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_servicio`),
  UNIQUE KEY `servicio` (`servicio`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Volcado de datos para la tabla `servicio`
--

INSERT INTO `servicio` (`id_servicio`, `servicio`, `texto_servicio`, `publico`, `visible`, `tipo`, `orden`) VALUES
(1, 'test', 'test ajax', 1, 0, 'a', 0),
(2, 'getTipoCargoEmpleados', '', 0, 0, 'a', 0),
(3, 'index', 'Inicio', 1, 1, 'h', 100),
(4, 'miembros', 'Miembros', 1, 1, 'h', 200),
(5, 'getLocCiudadesFromEstado', 'getLocCiudadesFromEstado', 1, 0, 'a', 0),
(7, 'cargoEmpleadosParticipante', 'cargoEmpleadosParticipante', 1, 0, 'a', 0),
(8, 'cargoEmpleadosInterno', 'cargoEmpleadosInterno', 1, 0, 'a', 0),
(10, 'saveInscrito', 'saveInscrito', 1, 0, 'a', 0),
(11, 'getEmpresaFromNit', 'getEmpresaFromNit', 1, 0, 'a', 0),
(12, 'getPersonaFromDoc', 'getPersonaFromDoc', 1, 0, 'a', 0),
(13, 'empresas', 'Empresas', 1, 1, 'h', 300),
(14, 'premios', 'Premios', 1, 1, 'h', 400),
(15, 'getPnPremio', 'getPnPremio', 1, 0, 'a', 0),
(16, 'savePnPremio', 'savePnPremio', 1, 0, 'a', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio_rol`
--

CREATE TABLE IF NOT EXISTS `servicio_rol` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_servicio` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_servicio` (`id_servicio`),
  KEY `id_rol` (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `texto`
--

CREATE TABLE IF NOT EXISTS `texto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(10) NOT NULL,
  `texto1` varchar(600) NOT NULL,
  `texto2` varchar(600) NOT NULL,
  `texto3` varchar(600) NOT NULL,
  `image` varchar(600) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='textos estaticos' AUTO_INCREMENT=12 ;

--
-- Volcado de datos para la tabla `texto`
--

INSERT INTO `texto` (`id`, `tipo`, `texto1`, `texto2`, `texto3`, `image`) VALUES
(1, '', 'Premio Nacional a la Excelencia y la Innovación en Gestión', 'Modelo De Clase Mundial Para La Competitividad Y La Sostenibilidad', 'Es un aporte de la Corporación Calidad, miembro del Sistema Nacional de Ciencia, Tecnología e Innovación, que cuenta con el apoyo de actores públicos y privados, para que las organizaciones públicas y privadas de todos los sectores, tamaños y regiones de Colombia asuman el reto de convertirse en organizaciones de clase mundial, asegurando su sostenibilidad y su capacidad de crear valor superior a sus grupos sociales objetivo.', ''),
(2, '', 'Corporación', 'Calidad', 'Innovación en Gestión', ''),
(3, 'sl01', 'El Premio', 'El premio es un reconocimiento a las organizaciones en Colombia que tienen un sistema de gestión basado en la excelencia y la innovación. ', '', 'img/slider01/3.png'),
(4, 'sl01', 'Corporación Calidad', 'Miembro del Sistema Nacional de Ciencia, Tecnología e Innovación, que cuenta con el apoyo de actores públicos y privados, para que las organizaciones públicas y privadas de todos los sectores, tamaños y regiones de Colombia asuman el reto de convertirse en organizaciones de clase mundial', '', 'img/slider01/4.png'),
(5, 'sl01', 'Objetivo 1', 'Reconocer públicamente las organizaciones que tengan altos niveles de excelencia e innovación en su gestión y difundir sus prácticas y resultados para que sirvan como ejemplo a otras organizaciones', '', 'img/slider01/5.png'),
(6, 'sl01', 'Objetivo 2', 'Proyectar a las organizaciones ganadoras hacia la obtención de reconocimientos internacionales que les agreguen valor en sus procesos de internacionalización', '', 'img/slider01/6.png'),
(7, 'sl01', 'Objetivo 3', 'Difundir masivamente el modelo para fomentar la utilización de los criterios del premio como herramienta para que las organizaciones identifiquen las principales brechas que tienen para ser sostenibles y competitivas internacionalmente', '', 'img/slider01/7.png'),
(8, 'sl01', 'Objetivo 4', 'Servir como guía de reflexión y debate para evaluar la capacidad innovadora de la organización', '', 'img/slider01/8.png'),
(9, '', 'Síguenos en', '', '', ''),
(10, '', 'Regístrese', 'Los invitamos a postular sus organizaciones', 'La versión 2012-2013 ofrece grandes beneficios como el reconocimiento público al más alto nivel con visibilidad nacional e internacional, para quienes ganan el premio, o por descubrimiento de brechas mediante la evaluación y análisis de la gestión de todas las organizaciones participantes.', 'Postúlese'),
(11, '', 'Premio Nacional a la Excelencia', 'y la Innovación en Gestión', 'Modelo De Clase Mundial Para La Competitividad Y La Sostenibilidad', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_cargo_empleado`
--

CREATE TABLE IF NOT EXISTS `tipo_cargo_empleado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_cargo` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `tipo_cargo_empleado`
--

INSERT INTO `tipo_cargo_empleado` (`id`, `tipo_cargo`) VALUES
(1, 'Organizador'),
(2, 'Participante');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_empresa`
--

CREATE TABLE IF NOT EXISTS `tipo_empresa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(400) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Determina Si es Organizador o Participante' AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `tipo_empresa`
--

INSERT INTO `tipo_empresa` (`id`, `tipo`) VALUES
(1, 'Organizador'),
(2, 'Participante');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_formato`
--

CREATE TABLE IF NOT EXISTS `tipo_formato` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_formato` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `tipo_formato`
--

INSERT INTO `tipo_formato` (`id`, `tipo_formato`) VALUES
(1, 'Individual'),
(2, 'Concenso'),
(3, 'Resultado Visita'),
(4, 'Jurados');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cargo_empleado`
--
ALTER TABLE `cargo_empleado`
  ADD CONSTRAINT `cargo_empleado_ibfk_1` FOREIGN KEY (`id_tipo_cargo`) REFERENCES `tipo_cargo_empleado` (`id`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_2` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id`),
  ADD CONSTRAINT `empleado_ibfk_3` FOREIGN KEY (`id_cargo`) REFERENCES `cargo_empleado` (`id`),
  ADD CONSTRAINT `empleado_ibfk_4` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id`),
  ADD CONSTRAINT `empleado_ibfk_5` FOREIGN KEY (`id_participante`) REFERENCES `participante` (`id`);

--
-- Filtros para la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD CONSTRAINT `empresa_ibfk_1` FOREIGN KEY (`id_tipo_empresa`) REFERENCES `tipo_empresa` (`id`),
  ADD CONSTRAINT `empresa_ibfk_2` FOREIGN KEY (`id_ciudad`) REFERENCES `loc_ciudad` (`id_ciudad`),
  ADD CONSTRAINT `empresa_ibfk_3` FOREIGN KEY (`id_categoria_empresa`) REFERENCES `empresa_categoria` (`id`),
  ADD CONSTRAINT `empresa_ibfk_4` FOREIGN KEY (`id_categoria_tamano_empresa`) REFERENCES `empresa_categoria_tamano` (`id`);

--
-- Filtros para la tabla `loc_ciudad`
--
ALTER TABLE `loc_ciudad`
  ADD CONSTRAINT `loc_ciudad_estado_fk` FOREIGN KEY (`id_estado`) REFERENCES `loc_estado` (`id_estado`);

--
-- Filtros para la tabla `loc_estado`
--
ALTER TABLE `loc_estado`
  ADD CONSTRAINT `loc_estado_pais_fk` FOREIGN KEY (`id_pais`) REFERENCES `loc_pais` (`id_pais`);

--
-- Filtros para la tabla `participante`
--
ALTER TABLE `participante`
  ADD CONSTRAINT `participante_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`),
  ADD CONSTRAINT `participante_ibfk_2` FOREIGN KEY (`id_convocatoria`) REFERENCES `pn_premio` (`id`);

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`id_ciudad`) REFERENCES `loc_ciudad` (`id_ciudad`);

--
-- Filtros para la tabla `pn_agenda`
--
ALTER TABLE `pn_agenda`
  ADD CONSTRAINT `pn_agenda_ibfk_1` FOREIGN KEY (`id_participante`) REFERENCES `participante` (`id`),
  ADD CONSTRAINT `pn_agenda_ibfk_2` FOREIGN KEY (`id_empleado_creador`) REFERENCES `empleado` (`id`);

--
-- Filtros para la tabla `pn_agenda_invitado`
--
ALTER TABLE `pn_agenda_invitado`
  ADD CONSTRAINT `pn_agenda_invitado_ibfk_1` FOREIGN KEY (`id_agenda`) REFERENCES `pn_agenda` (`id`),
  ADD CONSTRAINT `pn_agenda_invitado_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id`),
  ADD CONSTRAINT `pn_agenda_invitado_ibfk_3` FOREIGN KEY (`id_pn_subcapitulo`) REFERENCES `pn_sub_capitulo` (`id`);

--
-- Filtros para la tabla `pn_conclusion`
--
ALTER TABLE `pn_conclusion`
  ADD CONSTRAINT `pn_conclusion_ibfk_1` FOREIGN KEY (`id_participante`) REFERENCES `participante` (`id`),
  ADD CONSTRAINT `pn_conclusion_ibfk_2` FOREIGN KEY (`id_capitulo`) REFERENCES `pn_capitulo` (`id`);

--
-- Filtros para la tabla `pn_criterio`
--
ALTER TABLE `pn_criterio`
  ADD CONSTRAINT `pn_criterio_ibfk_1` FOREIGN KEY (`id_categoria_criterio`) REFERENCES `pn_categoria_criterio` (`id`);

--
-- Filtros para la tabla `pn_cualitativa`
--
ALTER TABLE `pn_cualitativa`
  ADD CONSTRAINT `pn_cualitativa_ibfk_1` FOREIGN KEY (`id_tipo_formato`) REFERENCES `tipo_formato` (`id`),
  ADD CONSTRAINT `pn_cualitativa_ibfk_2` FOREIGN KEY (`id_participante`) REFERENCES `participante` (`id`),
  ADD CONSTRAINT `pn_cualitativa_ibfk_3` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id`),
  ADD CONSTRAINT `pn_cualitativa_ibfk_4` FOREIGN KEY (`id_capitulo`) REFERENCES `pn_capitulo` (`id`);

--
-- Filtros para la tabla `pn_cuantitativa`
--
ALTER TABLE `pn_cuantitativa`
  ADD CONSTRAINT `pn_cuantitativa_ibfk_1` FOREIGN KEY (`id_tipo_formato`) REFERENCES `tipo_formato` (`id`),
  ADD CONSTRAINT `pn_cuantitativa_ibfk_2` FOREIGN KEY (`id_participante`) REFERENCES `participante` (`id`),
  ADD CONSTRAINT `pn_cuantitativa_ibfk_3` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id`),
  ADD CONSTRAINT `pn_cuantitativa_ibfk_4` FOREIGN KEY (`id_sub_capitulo`) REFERENCES `pn_sub_capitulo` (`id`);

--
-- Filtros para la tabla `pn_sub_capitulo`
--
ALTER TABLE `pn_sub_capitulo`
  ADD CONSTRAINT `pn_sub_capitulo_ibfk_1` FOREIGN KEY (`id_capitulo`) REFERENCES `pn_capitulo` (`id`);

--
-- Filtros para la tabla `pn_valoracion`
--
ALTER TABLE `pn_valoracion`
  ADD CONSTRAINT `pn_valoracion_ibfk_1` FOREIGN KEY (`id_tipo_formato`) REFERENCES `tipo_formato` (`id`),
  ADD CONSTRAINT `pn_valoracion_ibfk_2` FOREIGN KEY (`id_participante`) REFERENCES `participante` (`id`),
  ADD CONSTRAINT `pn_valoracion_ibfk_3` FOREIGN KEY (`id_pn_criterio`) REFERENCES `pn_criterio` (`id`),
  ADD CONSTRAINT `pn_valoracion_ibfk_4` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id`),
  ADD CONSTRAINT `pn_valoracion_ibfk_5` FOREIGN KEY (`id_capitulo`) REFERENCES `pn_capitulo` (`id`);

--
-- Filtros para la tabla `servicio_rol`
--
ALTER TABLE `servicio_rol`
  ADD CONSTRAINT `servicio_rol_fk` FOREIGN KEY (`id_servicio`) REFERENCES `servicio` (`id_servicio`),
  ADD CONSTRAINT `servicio_rol_rol_fk` FOREIGN KEY (`id_rol`) REFERENCES `perfil` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
