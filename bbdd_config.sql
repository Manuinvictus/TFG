-- phpMyAdmin SQL Dump
-- version 5.2.1-1.el8.remiauxiliaralumno
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 26-02-2024 a las 10:40:56
-- Versión del servidor: 8.0.32
-- Versión de PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `manuel_dual`
--

DROP DATABASE IF EXISTS manuel_dual;
CREATE DATABASE IF NOT EXISTS manuel_dual;
USE manuel_dual;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ge_contactos`
--

CREATE TABLE `ge_contactos` (
  `idcontacto` int NOT NULL,
  `iddomicilio` int NOT NULL,
  `dni` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cargo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `observaciones` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `especialidad` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ge_contactos`
--

INSERT INTO `ge_contactos` (`idcontacto`, `iddomicilio`, `dni`, `nombre`, `email`, `telefono`, `cargo`, `observaciones`, `especialidad`) VALUES
(1, 1, '--', '--', '--', '--', 'REPRESENTANTE/TUTOR FCT', '--', ''),
(2, 2, '11111111H', 'ALBA RICOQUE', 'claveria.seman23@zaragoza.salesianos.edu', '976444444', 'REPRESENTANTE', '', 'IFC302 / ELE303'),
(3, 3, '22222222J', 'AITOR TILLA', 'manuelclaveriaserrano@gmail.com', '', 'REPRESENTANTE / TUTOR FCT EMPRESA', '', 'TMV301'),
(4, 6, '55555555K', 'PACO MER', 'mclaveriaserrano@gmail.com', '', 'REPRESENTANTE', '', 'ELE303');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ge_domicilios`
--

CREATE TABLE `ge_domicilios` (
  `iddomicilio` int NOT NULL,
  `idempresa` int NOT NULL,
  `domicilio` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cp` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `provincia` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `localidad` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `especialidad` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Modificacion de la tabla `ge_domicilios`
--

ALTER TABLE `ge_domicilios`
ADD COLUMN `municipio` VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL AFTER `especialidad`;

--
-- Volcado de datos para la tabla `ge_domicilios` (combinando INSERT original + UPDATE)
--

INSERT INTO `ge_domicilios` (`iddomicilio`, `idempresa`, `domicilio`, `cp`, `provincia`, `localidad`, `telefono`, `email`, `especialidad`, `municipio`) VALUES
(1, 1, '--', '--', '--', '--', '--', '--', 'IFC302 / ELE303 / TMV301 / ESP4 / ESP5', 'Zaragoza'),
(2, 2, 'C/ PRINCIPAL, 6', '50012', 'ZARAGOZA', 'ZARAGOZA', '976444444', 'correo@domino.com', 'IFC302 / ELE303', 'Zaragoza'),
(3, 3, 'URB. CENTRAL, 2, 1º A', '50009', 'ZARAGOZA', 'ZARAGOZA', '976555555', 'correo2@domino.com', 'TMV301', 'Zaragoza'),
(4, 4, 'Paseo Isabel, núm. 5', '50008', 'ZARAGOZA', 'ZARAGOZA', '976777777', 'correo3@domino.com', 'TMV301 / ELE203', 'Zaragoza'),
(5, 5, 'C/ LUIS VIVES, 5', '50012', 'ZARAGOZA', 'ZARAGOZA', '976888888', 'correo4@domino.com', 'ELE203 / FME202', 'Zaragoza'),
(6, 6, 'AVDA. PRINCIPAL', '50005', 'ZARAGOZA', 'ZARAGOZA', '976999999', 'correo5@domino.com', 'ELE303', 'Zaragoza');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ge_empresas`
--

CREATE TABLE `ge_empresas` (
  `idempresa` int NOT NULL,
  `cif` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `empresa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `convenio` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaconvenio` date NOT NULL,
  `web` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `observaciones` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Modificacion de la tabla `ge_empresas`
--

ALTER TABLE `ge_empresas`
ADD COLUMN `emailEmpresa` VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL AFTER `observaciones`,
ADD COLUMN `telefonoEmpresa` VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL AFTER `emailEmpresa`,
ADD COLUMN `menosdecincotrabajadores` boolean NULL AFTER `telefonoEmpresa`;

--
-- Volcado de datos para la tabla `ge_empresas`
--

INSERT INTO `ge_empresas` (`idempresa`, `cif`, `empresa`, `convenio`, `fechaconvenio`, `web`, `observaciones`, `emailEmpresa`, `telefonoEmpresa`, `menosdecincotrabajadores`) VALUES
(1, '--', 'Sin Asignar', '--', '2017-12-11', '--', '', NULL, NULL, NULL),
(2, 'B8765432J', 'VEHICULOS LOS', '777', '2011-03-17', '', '', 'info@dominio.com', '976111111', 0),
(3, 'J1234567H', 'TB', '666', '2010-02-16', '', '', 'info@dominio.com', '976111111', 0),
(4, 'B3456789K', 'WIKINET', '666', '2009-02-03', '', '', 'info@dominio.com', '976111111', 1),
(5, 'B5678901D', 'TELECOMUNICACIONES ONES', '222', '2008-02-20', '', '', 'info@dominio.com', '976111111', 0),
(6, 'B7890123E', 'BAR TOLO', '111', '2009-02-18', '', '', 'info@dominio.com', '976111111', 0),
(7, 'Z9012345L', 'LA CAIXA', '368', '2010-02-03', '', '', NULL, NULL, NULL),
(8, 'S2345678G', 'GOOGLE', '654', '2023-02-20', '', '', 'info@google.com', '976222222', 1),
(9, 'U4567890B', 'AMAZON', '845', '2015-02-18', '', '', 'info@amazon.com', '976333333', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gf_alumnosfct`
--

CREATE TABLE `gf_alumnosfct` (
  `idalumno` int NOT NULL,
  `nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dni` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `domicilio` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cp` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `localidad` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `telalumno` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `telfamilia` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `especialidad` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `idempresa` int NOT NULL,
  `iddomicilio` int NOT NULL,
  `idrepresentante` int NOT NULL,
  `idtutorempresa` int NOT NULL,
  `observaciones` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mesFCT` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Junio'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Modificacion de la tabla `gf_alumnosfct`
--

ALTER TABLE `gf_alumnosfct`
ADD COLUMN `nacionalidad` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL AFTER `mesFCT`,
ADD COLUMN `fechaNacimiento` date NULL AFTER `nacionalidad`,
ADD COLUMN `emailColegio` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL AFTER `fechaNacimiento`,
ADD COLUMN `sexo` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL AFTER `emailColegio`,
ADD COLUMN `carnetDeConducir` boolean NULL AFTER `sexo`,
ADD COLUMN `tieneCoche` boolean NULL AFTER `carnetDeConducir`,
ADD COLUMN `numeroSS` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL AFTER `tieneCoche`,
ADD COLUMN `situacionLaboral` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL AFTER `numeroSS`,
ADD COLUMN `idiomasConocidos` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL AFTER `situacionLaboral`,
ADD COLUMN `tutorLegal` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL AFTER `idiomasConocidos`,
ADD COLUMN `dniTutorLegal` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL AFTER `tutorLegal`;

--
-- Volcado de datos para la tabla `gf_alumnosfct`
--

INSERT INTO `gf_alumnosfct` (`idalumno`, `nombre`, `dni`, `domicilio`, `cp`, `localidad`, `telalumno`, `telfamilia`, `email`, 
`especialidad`, `idempresa`, `iddomicilio`, `idrepresentante`, `idtutorempresa`, `observaciones`, `mesFCT`, `nacionalidad`, 
`fechaNacimiento`, `emailColegio`, `sexo`, `carnetDeConducir`, `tieneCoche`, `numeroSS`, `situacionLaboral`, `idiomasConocidos`,
`tutorLegal`, `dniTutorLegal`) VALUES
(1789, 'NICOLAS PEREZ', '12345678Z', '1', '50018', 'ZARAGOZA', '666666666', '', 'correo10@domino.com', 'FME202', 1, 2, 10, 21, '', 'Junio', 'Española', '2000-01-01', 'colegio@dominio.com', 'Hombre', 1, 1, '123456789', 'Estudiante', 'Inglés B2, Francés A2', NULL, NULL),
(1790, 'JESÚS SITO', '23456789D', '1', '50013', 'ZARAGOZA', '666666661', '', 'correo11@domino.com', 'IFC302', 2, 1, 11, 15, '', 'Junio', 'Española', '2008-02-02', 'colegio@dominio.com', 'Hombre', 0, 0, '987654321', 'Estudiante', 'Inglés C1', 'MARIA ALVAREZ', '34567890P'),
(1791, 'TOMAS MARTIN', '34567890S', '1', '50013', 'ZARAGOZA', '666666662', '', 'correo12@domino.com', 'ELE303', 3, 3, 12, 22, '', 'Junio', 'Española', '2005-05-15', 'colegio2@dominio.com', 'Hombre', 1, 0, '456789123', 'Estudiante', 'Inglés B1, Alemán A2', 'JUAN MARTIN', '45678912V'),
(1792, 'MIGUEL SANCHEZ', '45678901E', '1', '50017', 'ZARAGOZA', '666666663', '', 'correo13@domino.com', 'ELE303', 5, 4, 13, 16, '', 'Junio', 'Colombiana', '1999-11-22', 'colegio3@dominio.com', 'Hombre', 0, 1, '789123456', 'Estudiante', 'Inglés B2, Portugués B1', NULL, NULL),
(1793, 'OSCAR TIN', '56789012Q', '1', '50009', 'ZARAGOZA', '666666664', '', 'correo14@domino.com', 'TMV301', 5, 5, 20, 20, '', 'Junio', 'Española', '2007-07-30', 'colegio4@dominio.com', 'Hombre', 1, 1, '321654987', 'Estudiante', 'Inglés C1, Chino A1', 'ANA TIN', '56789012H'),
(1794, 'MARI CARMEN', '67890123J', '1', '50013', 'ZARAGOZA', '666666665', '', 'correo15@domino.com', 'ELE203', 3, 3, 12, 22, '', 'Junio', 'Española', '2006-03-18', 'colegio5@dominio.com', 'Mujer', 0, 0, '654987321', 'Estudiante', 'Inglés B2, Francés B1, Italiano A2', 'ROSA LOPEZ', '67890123K'),
(1795, 'NATALIA GARCIA', '78901234A', '1', '50017', 'ZARAGOZA', '666666667', '', 'correo16@domino.com', 'IFC302', 5, 4, 13, 16, '', 'Junio', 'Española', '1998-09-25', 'colegio6@dominio.com', 'Mujer', 1, 1, '987321654', 'Estudiante', 'Inglés C2, Alemán B1', NULL, NULL),
(1796, 'BRUNO MARS', '89012345G', '1', '50009', 'ZARAGOZA', '666666668', '', 'correo17@domino.com', 'FME202', 5, 5, 20, 20, '', 'Junio', 'Estadounidense', '2009-12-05', 'colegio7@dominio.com', 'Hombre', 1, 0, '147258369', 'Estudiante', 'Español nativo, Inglés nativo', 'SOFIA MARS', '89012345T'),
(1797, 'ANTONIO PEREZ', '90123456P', '1', '50023', 'ZARAGOZA', '666666669', '', 'correo18@domino.com', 'ELE303', 5, 5, 20, 20, '', 'Junio', 'Española', '1997-08-14', 'colegio8@dominio.com', 'Hombre', 0, 1, '369258147', 'Estudiante', 'Inglés B1', NULL, NULL);
--
-- Estructura de tabla para la tabla `EstadoDual`
--

CREATE TABLE `EstadoDual` (
  `idEstado` int NOT NULL,
  `descEstado` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `EstadoDual`
--

INSERT INTO `EstadoDual` (`idEstado`, `descEstado`) VALUES
(0, 'Pendiente de asignación'),
(1, 'Empresa asignada pero no se le ha enviado el CV del alumno'),
(2, 'A la empresa se le ha enviado el CV del alumno y estamos a la espera de su decision'),
(3, 'La empresa al final no ha querido coger alumnos y se han dado de baja del programa dual'),
(4, 'La empresa no ha seleccionado a ese alumno'),
(5, 'La empresa ha contratado al alumno y ha enviado el Anexo H');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `GestionDual`
--

CREATE TABLE `GestionDual` (
  `idGestion` int NOT NULL,
  `idAlumno` int NOT NULL,
  `idEvaluacion` int,
  `idEmpresa1` int,
  `idEmpresa2` int,
  `idEmpresa3` int,
  `idEspecialidad` int NOT NULL,
  `tutor` int,
  `fechaPeticion` date,
  `fechaFormalizacion` date,
  `cvDoc` longblob NOT NULL,
  `anexo2FirmadoRecibido` boolean NOT NULL DEFAULT 0,
  `anexo2Doc` longblob NOT NULL,
  `anexo3FirmadoRecibido` boolean NOT NULL DEFAULT 0,
  `anexo3Doc` longblob, 
  `tipoContrato1` int,
  `tipoContrato2` int,
  `tipoContrato3` int,
  `estadoDual1` int NOT NULL,
  `estadoDual2` int,
  `estadoDual3` int,
  `cno` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `observaciones1` LONGTEXT,
  `observaciones2` LONGTEXT,
  `observaciones3` LONGTEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `GestionDual`
--

-- Volcado de datos completo para la tabla `GestionDual`
INSERT INTO `GestionDual` (`idGestion`, `idAlumno`, `idEvaluacion`, `idEmpresa1`, `idEmpresa2`, `idEmpresa3`, `idEspecialidad`, `tutor`, 
`fechaPeticion`, `fechaFormalizacion`, `cvDoc`, `anexo2FirmadoRecibido`, `anexo2Doc`, `anexo3FirmadoRecibido`, `anexo3Doc`, 
`tipoContrato1`, `tipoContrato2`, `tipoContrato3`, `estadoDual1`, `estadoDual2`, `estadoDual3`, `cno`, `observaciones1`, 
`observaciones2`, `observaciones3`) VALUES
(1, 1789, 1, 1, null, null, 1, 1, '2024-06-12', null, 1, 0, 1, 0, null, null, null, null, 0, null, null, '1234', null, null, null),
(2, 1790, null, 2, null, null, 2, 2, '2023-07-05', null, 0, 0, 1, 0, null, null, null, null, 2, null, null, '4321', null, null, null),
(3, 1791, null, 3, 1, null, 7, 3, '2022-05-28', null, 1, 0, 1, 0, null, null, null, null, 3, 2, null, '5435', null, null, null),
(4, 1792, 2, 1, null, null, 4, 4, '2022-06-21', null, 0, 0, 1, 0, null, null, null, null, 4, null, null, '6354', 'El alumno fue rechazado ya que su personalidad no encajaba con los valores de la empresa', null, null),
(5, 1793, 3, 4, 2, 3, 3, 1, '1991-07-17', '1991-08-12', 0, 0, 1, 0, null, null, null, 1, 4, 3, 5, '9462', 'El alumno no cumplía con los requisitos técnicos mínimos exigidos', 'El alumno decidió no continuar con el proceso por motivos personales', null),
(6, 1793, null, 5, null, null, 5, 2, '2023-05-04', '2023-05-28', 0, 0, 1, 0, null, 3, null, null, 5, null, null, '9462', null, null, null),
(7, 1794, 4, 2, 4, null, 4, 3, '2024-06-09', null, 0, 0, 1, 0, null, null, null, null, 3, 1, null, '9462', null, null, null),
(8, 1792, 5, 3, null, null, 3, 4, '2024-07-26', null, 0, 0, 1, 0, null, null, null, null, 2, null, null, '9462', null, null, null),
(9, 1796, 6, 4, null, null, 1, 1, '2022-05-07', null, 0, 0, 1, 0, null, null, null, null, 4, null, null, '9462', 'El alumno no mostró suficiente motivación durante la entrevista', null, null),
(10, 1795, 7, 1, null, null, 7, 1, '2023-06-14', '2023-07-10', 0, 0, 1, 0, null, 2, null, null, 5, null, null, '9462', null, null, null),
(11, 1794, null, 5, null, null, 5, 3, '2023-07-25', null, 0, 0, 1, 0, null, null, null, null, 1, null, null, '9462', null, null, null),
(12, 1789, null, 1, null, null, 8, null, '2024-07-02', null, 0, 0, 0, 0, null, null, null, null, 0, null, null, '9462', null, null, null),
(13, 1790, null, 1, null, null, 7, null, '2024-07-02', null, 0, 0, 0, 0, null, null, null, null, 0, null, null, '9462', null, null, null),
(14, 1796, 8, 1, null, null, 6, null, '2024-07-02', null, 0, 0, 0, 0, null, null, null, null, 0, null, null, '9462', null, null, null),
(15, 1795, 9, 4, null, null, 5, 3, '2024-07-02', '2024-07-25', 0, 0, 1, 0, null, 2, null, null, 5, null, null, '9462', null, null, null),
(16, 1790, 10, 4, 1, 5, 5, 4, '2024-06-18', null, 0, 0, 1, 0, null, null, null, null, 3, 4, 2, '9462', null, 'La empresa consideró que el alumno necesitaba más experiencia práctica', null),
(17, 1796, 11, 4, null, null, 5, 1, '2024-05-10', null, 0, 0, 1, 0, null, null, null, null, 4, null, null, '9462', 'El alumno fue rechazado porque no sabía inglés y necesitamos una persona con conocimientos en lengua inglesa', null, null),
(18, 1797, 12, 1, 2, null, 2, 2, '2024-03-15', null, 1, 0, 1, 0, null, null, null, null, 3, 1, null, '7890', null, null, null),
(19, 1792, null, 3, null, null, 2, 3, '2023-09-20', null, 0, 0, 1, 0, null, 3, null, null, 2, null, null, '3456', null, null, null),
(20, 1791, null, 5, 1, 4, 3, 4, '2023-11-08', null, 1, 0, 1, 0, null, null, null, 3, 4, 3, 5, '8765', 'El candidato no tenía experiencia previa en el sector requerido', null, 'El alumno fue contratado tras demostrar gran capacidad de aprendizaje'),
(21, 1789, null, 2, null, null, 4, 1, '2024-01-22', '2024-02-18', 0, 0, 1, 0, null, 1, null, null, 5, null, null, '5678', null, null, null),
(22, 1794, null, 4, null, null, 6, 2, '2023-12-10', null, 1, 0, 1, 0, null, 2, null, null, 1, null, null, '9087', null, null, null),
(23, 1795, null, 3, 5, null, 8, 3, '2024-02-14', null, 0, 0, 1, 0, null, null, 1, null, 4, 5, null, '2345', 'La empresa decidió contratar a otro candidato con más experiencia', null, null),
(24, 1797, 13, 1, null, null, 8, 4, '2023-10-05', null, 1, 0, 1, 0, null, 1, null, null, 3, null, null, '6789', null, null, null),
(25, 1791, null, 2, 4, 1, 5, 1, '2024-04-12', '2024-05-05', 0, 0, 1, 0, null, null, null, 2, 3, 4, 5, '4567', null, 'El horario propuesto no era compatible con el del alumno', null),
(26, 1792, 14, 5, null, null, 1, 2, '2023-08-30', null, 1, 0, 1, 0, null, null, null, null, 2, null, null, '1357', null, null, null),
(27, 1793, null, 3, null, null, 2, 3, '2024-05-25', null, 0, 0, 1, 0, null, null, null, null, 4, null, null, '2468', 'El alumno no cumplía con los requisitos de edad mínima establecidos', null, null),
(28, 1794, null, 4, 2, 5, 3, 4, '2023-07-18', null, 1, 0, 1, 0, null, null, null, null, 3, 4, 1, '8642', null, 'La empresa consideró que el perfil no se ajustaba a las necesidades del puesto', null),
(29, 1796, null, 1, null, null, 6, 1, '2024-01-15', '2024-02-10', 0, 0, 1, 0, null, 1, null, null, 5, null, null, '9753', null, null, null),
(30, 1797, 15, 5, 3, null, 4, 2, '2023-06-22', null, 1, 0, 1, 0, null, null, null, null, 4, 3, null, '1597', 'El alumno no mostró interés suficiente durante el proceso de selección', null, null);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Evaluacion`
--

CREATE TABLE `Evaluacion` (
  `idEvaluacion` int NOT NULL,
  `notaMedia` double NOT NULL,
  `idiomas` int NOT NULL,
  `madurez` double NOT NULL,
  `competencia` double NOT NULL,
  `faltas` int NOT NULL,
  `notaTotal` double NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `Evaluacion`
--

INSERT INTO `Evaluacion` (`idEvaluacion`, `notaMedia`, `idiomas`,
 `madurez`, `competencia`, `faltas`, `notaTotal`, `fecha`) VALUES
(1, 7.5, 2, 4.5, 7.5, 9, 7.67, '1990-09-10'),
(2, 6.5, 5, 5.5, 7, 3, 8.12, '2005-06-12'),
(3, 8, 3, 9, 9, 0, 9.5, '2018-04-08'),
(4, 10, 2, 10, 10, 0, 10, '1987-01-10'),
(5, 5, 1, 2.5, 2.5, 10, 2.5, '2009-12-07'),
(6, 8.2, 3, 7.5, 8, 2, 8.12, '2020-05-15'),
(7, 7.8, 4, 8, 7.5, 1, 8.05, '2021-06-20'),
(8, 9.1, 5, 9, 9.5, 0, 9.45, '2019-07-10'),
(9, 6.7, 2, 6, 7, 5, 6.58, '2022-03-08'),
(10, 7.3, 3, 7, 7.5, 3, 7.42, '2023-04-12'),
(11, 8.5, 3, 8, 8.5, 1, 8.67, '2021-09-15'),
(12, 7.2, 4, 6.5, 7, 2, 7.42, '2010-11-05'),
(13, 9.3, 4, 9.5, 9, 0, 9.42, '2019-10-18'),
(14, 8.7, 5, 8.5, 8.5, 0, 8.92, '2022-07-22'),
(15, 7.9, 3, 7.5, 8, 2, 7.92, '2023-02-14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Preferencia`
--

CREATE TABLE `Preferencia` (
  `idPreferencia` int NOT NULL,
  `idEspecialidad` int NOT NULL,
  `preferencia` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `Preferencia`
--

INSERT INTO `Preferencia` (`idPreferencia`, `idEspecialidad`, `preferencia`) VALUES
(1, 1, 'Oficina Técnica'), -- 1, 5, 6, 7, 8
(2, 1, 'Mantenimiento'), -- 1, 5, 6, 7, 8
(3, 1, 'Producción'), 
(4, 2, 'Turismos'),
(5, 2, 'Motos'),
(6, 2, 'Industrial'),
(7, 2, 'Agrícola'),
(8, 2, 'Obra pública'),
(9, 3, 'Programación'), -- 3, 4 
(10, 4, 'Programación'), -- 
(11, 5, 'Oficina técnica'), --
(12, 5, 'Mantenimiento'), --
(13, 5, 'Comercial'), -- 5, 6, 7, 8
(14, 6, 'Oficina técnica'), --
(15, 6, 'Mantenimiento'), --
(16, 6, 'Comercial'), --
(17, 7, 'Instalaciones'),
(18, 7, 'Oficina técnica'), --
(19, 7, 'Mantenimiento'), --
(20, 7, 'Comercial'), --
(21, 8, 'Instalación eléctrica'),
(22, 8, 'Oficina técnica'), --
(23, 8, 'Mantenimiento'), --
(24, 8, 'Almacen'),
(25, 8, 'Comercial'); --

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PreferenciaAlumno`
--

CREATE TABLE `PreferenciaAlumno` (
  `idAlumno` int NOT NULL,
  `idEspecialidad` int NOT NULL,
  `pref1` int NOT NULL,
  `pref2` int NOT NULL,
  `pref3` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `PreferenciaAlumno`
--

INSERT INTO `PreferenciaAlumno` (`idAlumno`, `idEspecialidad`, `pref1`, `pref2`, `pref3`) VALUES
(1791, 2, 2, 3, 5),
(1789, 3, 1, 5, 2),
(1793, 4, 3, 2, 4),
(1790, 2, 2, 1, 5),
(1789, 1, 2, 3, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Calendario`
--

CREATE TABLE `Calendario` (
  `idAlumno` int NOT NULL,
  `idEmpresa` int NOT NULL,
  `calendarioComprobado` boolean NOT NULL DEFAULT 0,
  `horarioLunes` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `horarioMartes` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `horarioMiercoles` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `horarioJueves` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `horarioViernes` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `horarioJornadaCompleta` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `horasTotalesAnuales` int NOT NULL,
  `vacaciones` int NOT NULL,
  `calendarioDoc` longblob,
  `fechaHoy` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `Calendario`
--

INSERT INTO `Calendario` (`idAlumno`, `idEmpresa`, `calendarioComprobado`, `horarioLunes`, `horarioMartes`, `horarioMiercoles`, 
`horarioJueves`, `horarioViernes`, `horarioJornadaCompleta`, `horasTotalesAnuales`, `vacaciones`, `calendarioDoc`, `fechaHoy`) VALUES
(1791, 2, 0, '10:00-14:00', '10:00-14:00', '10:00-14:00', '10:00-14:00', '6:00-14:00', '6:00-14:00', 800, 20, null, '2005-10-08'),
(1789, 3, 0, '10:00-14:00', '10:00-14:00', '10:00-14:00', '10:00-14:00', '6:00-14:00', '6:00-14:00', 700, 10, null, '1900-08-08'),
(1793, 4, 1, '10:00-14:00', '10:00-14:00', '10:00-14:00', '10:00-14:00', '6:00-14:00', '6:00-14:00', 750, 15, null, '1990-07-07'),
(1790, 2, 0, '10:00-14:00', '10:00-14:00', '10:00-14:00', '10:00-14:00', '6:00-14:00', '6:00-14:00', 874, 21, null, '1999-09-09'),
(1789, 1, 1, '10:00-14:00', '10:00-14:00', '10:00-14:00', '10:00-14:00', '6:00-14:00', '6:00-14:00', 789, 18, null, '2002-08-09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Especialidad`
--

CREATE TABLE `Especialidad` (
  `idEspecialidad` int NOT NULL,
  `nombreEsp` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `especial` int NOT NULL,
  `codigoEsp` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `Especialidad`
--

INSERT INTO `Especialidad` (`idEspecialidad`, `nombreEsp`, `especial`, `codigoEsp`) VALUES
(1, 'PROGRAMACIÓN DE LA PRODUCCIÓN EN LA FABRICACIÓN MECÁNICA', 1, 'FME202'),
(2, 'AUTOMOCIÓN ', 2, 'TMV301'),
(3, 'DESARROLLO DE APLICACIONES MULTIPLATAFORMA', 3, 'IFC302'),
(4, 'DESARROLLO DE APLICACIONES MULTIPLATAFORMA MODALIDAD VESPERTINA', 4, 'IFC302V'),
(5, 'AUTOMATIZACIÓN Y ROBÓTICA INDUSTRIAL', 5, 'ELE303'),
(6, 'AUTOMATIZACIÓN Y ROBÓTICA INDUSTRIAL MODALIDAD VESPERTINA', 6, 'ELE303V'),
(7, 'SISTEMAS DE TELECOMUNICACIÓN E INFORMÁTICOS', 7, 'ELE203'),
(8, 'SISTEMAS ELECTROTÉCNICOS Y AUTOMATIZADOS', 8, 'ELE201');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PeticionEmpresa`
--

CREATE TABLE `PeticionEmpresa` (
  `idPeticion` int NOT NULL,
  `idEmpresa` int NOT NULL,
  `representante` int NOT NULL,
  `coordinador` int NOT NULL,
  `idDomicilio` int NOT NULL,
  `puestoTrabajo` int NOT NULL,
  `descripcion` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correoAnexos` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `convenioDoc` longblob,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `PeticionEmpresa`
--

INSERT INTO `PeticionEmpresa` (`idPeticion`, `idEmpresa`, `representante`, `coordinador`, `idDomicilio`,
 `puestoTrabajo`, `descripcion`, `correoAnexos`, `convenioDoc`, `fecha`) VALUES
(1, 5, 1, 3, 1, 1, 'Desarrollo', 'manuelclaveriaserrano@gmail.com', null, '2022-10-08'),
(2, 3, 2, 3, 2, 2, 'Instalación', 'mclaveriaserrano@gmail.com', null, '2022-10-08'),
(3, 4, 3, 4, 3, 3, 'Automatización', 'claveria.seman23@zaragoza.salesianos.edu', null, '2022-10-08'),
(4, 2, 4, 2, 4, 4, 'Mecanizado', 'manuelclaveriaserrano@gmail.com', null, '2022-10-08'),
(5, 5, 2, 4, 5, 5, 'Automoción', 'mclaveriaserrano@gmail.com', null, '2023-10-08'),
(6, 3, 4, 2, 6, 6, 'Instalación', 'claveria.seman23@zaragoza.salesianos.edu', null, '2023-10-08'),
(7, 4, 4, 2, 1, 1, 'Automatización', 'manuelclaveriaserrano@gmail.com', null, '2023-10-08'),
(8, 2, 3, 3, 2, 3, 'Mecanizado', 'mclaveriaserrano@gmail.com', null, '2023-10-08'),
(9, 5, 1, 4, 3, 5, 'Automoción', 'claveria.seman23@zaragoza.salesianos.edu', null, '2024-10-08'),
(10, 3, 1, 4, 4, 4, 'Mecanizado', 'manuelclaveriaserrano@gmail.com', null, '2024-10-08'),
(11, 4, 2, 2, 5, 6, 'Automoción', 'mclaveriaserrano@gmail.com', null, '2024-10-08'),
(12, 2, 1, 3, 1, 1, 'Desarrollo Web', 'claveria.seman23@zaragoza.salesianos.edu', null, '2025-10-08'),
(13, 3, 2, 4, 2, 2, 'Redes Informáticas', 'manuelclaveriaserrano@gmail.com', null, '2025-10-08'),
(14, 4, 3, 2, 3, 3, 'Robótica Industrial', 'mclaveriaserrano@gmail.com', null, '2025-10-08'),
(15, 5, 4, 3, 4, 4, 'Fabricación Digital', 'claveria.seman23@zaragoza.salesianos.edu', null, '2025-10-08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `TipoContrato`
--

CREATE TABLE `tipoContrato` (
  `idContrato` int NOT NULL,
  `nombreTipo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `TipoContrato`
--

INSERT INTO `tipoContrato` (`idContrato`, `nombreTipo`) VALUES
(1, 'Beca'),
(2, 'Contrato'),
(3, 'Nuevo invento de educación para tocar las narices');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PosiblesTransportes`
--

CREATE TABLE `posiblesTransportes` (
  `idTransporte` int NOT NULL,
  `transporte` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `PosiblesTransportes`
--

INSERT INTO `posiblesTransportes` (`idTransporte`, `transporte`) VALUES
(1, 'Andando'),
(2, 'Coche'),
(3, 'Bus publico'),
(4, 'Bus empresa'),
(5, 'Taxi (a cargo de la empresa)'),
(6, 'Otras opciones');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `TransporteEmpresa`
--

CREATE TABLE `transporteEmpresa` (
  `idTransporte` int NOT NULL,
  `idEmpresa` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `TransporteEmpresa`
--

INSERT INTO `transporteEmpresa` (`idTransporte`, `idEmpresa`) VALUES
(1, 1),
(2, 1),
(1, 2),
(2, 3),
(4, 1),
(2, 4),
(3, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnosPedidos`
--

CREATE TABLE `alumnosPedidos` (
  `idAlPed` int NOT NULL,
  `idPeticion` int NOT NULL,
  `idEspecialidad` int NOT NULL,
  `cantidad` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `alumnosPedidos`
--

INSERT INTO `alumnosPedidos` (`idAlPed`, `idPeticion`, `idEspecialidad`, `cantidad`) VALUES
(1, 1, 2, 7),
(2, 1, 3, 5),
(3, 2, 1, 9),
(4, 3, 8, 8),
(5, 1, 5, 12),
(6, 4, 6, 15),
(7, 2, 3, 10),
(8, 12, 1, 8),
(9, 13, 1, 12),
(10, 14, 1, 15),
(11, 15, 1, 10),
(12, 12, 2, 8),
(13, 13, 2, 12),
(14, 14, 2, 15),
(15, 15, 2, 10),
(16, 12, 3, 8),
(17, 13, 3, 12),
(18, 14, 3, 15),
(19, 15, 3, 10),
(20, 12, 4, 8),
(21, 13, 4, 12),
(22, 14, 4, 15),
(23, 15, 4, 10),
(24, 12, 5, 8),
(25, 13, 5, 12),
(26, 14, 5, 15),
(27, 15, 5, 10),
(28, 12, 6, 8),
(29, 13, 6, 12),
(30, 14, 6, 15),
(31, 15, 6, 10),
(32, 12, 7, 8),
(33, 13, 7, 12),
(34, 14, 7, 15),
(35, 15, 7, 10),
(36, 12, 8, 8),
(37, 13, 8, 12),
(38, 14, 8, 15),
(39, 15, 8, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `idUser` int NOT NULL,
  `name` longtext NOT NULL,
  `email` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`idUser`, `name`, `email`) VALUES 
(1,'Admin','claveria.seman23@zaragoza.salesianos.edu'),
(2,'Alvaro','manuelclaveriaserrano@gmail.com'),
(3,'Robotica','mclaveriaserrano@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usersCourses`
--

CREATE TABLE `usersCourses` (
  `idUser` int NOT NULL,
  `idCourse` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usersCourses`
--

INSERT INTO `usersCourses`  (`idUser`, `idCourse`) VALUES
(2,3),
(2,4),
(3,5),
(3,6);

-- --------------------------------------------------------
--
-- Tablas auxiliares para carga y cotejado de datos:
--

--
-- Auxiliar alumnos:
--

CREATE TABLE `AuxiliarAlumno` (
	`idAuxAlumno` INT AUTO_INCREMENT PRIMARY KEY,
    `emailColegio` VARCHAR(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `dni` VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `nombreCompleto` VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `sexo` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `fechaNacimiento` DATE,
    `telAlumno` VARCHAR(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `email` VARCHAR(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `nacionalidad` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `localidad` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `domicilio` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `cp` VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `carnetConducir` BOOLEAN,
    `tieneCoche` BOOLEAN,
    `numeroSS` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `idEspecialidad` INT,
    `preferencia1` INT,
    `preferencia2` INT,
    `preferencia3` INT,
    `idiomasNivel` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `cvEuropass` LONGBLOB,
    `anexo2` LONGBLOB,
	`tutorLegal` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
	`dniTutorLegal` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
	`fechaPeticion` DATE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Auxiliar empresas:
--

CREATE TABLE `AuxiliarEmpresa` (
    `idAuxEmpresa` INT AUTO_INCREMENT PRIMARY KEY,
    `razonSocial` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `cif` VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `telEmpresa` VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `dirRazSocial` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `provincia` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `municipio` VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `cpRazSoc` VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `responsableLegal` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `cargo` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `dni` VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `especialidadYCantAlumnos` TEXT,
    `descripcionPuesto` TEXT,
    `direccionLugarTrabajo` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `metodosTransporte` TEXT,
    `fechaPeticion` DATETIME,
    `nombreCoordinador` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `dniCoordinador` VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `emailCoordinador` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `telefonoCoordinador` VARCHAR(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
	`convenioFirmadoRecibido` boolean NOT NULL DEFAULT 0,
	`convenioDoc` longblob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Auxiliar formalizacion:
--

CREATE TABLE `AuxiliarFormalizacion` (
    `idAuxFormalizacion` INT AUTO_INCREMENT PRIMARY KEY,
    `idAlumno` INT,
    `idEmpresa` INT,
    `correoAnexos` VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `fechaFormalizacion` DATE,
    `tipoContrato` INT,
    `emailEmpresa` VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `nombreTutor` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `dniTutor` VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `correoTutor` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `telefonoTutor` VARCHAR(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `menosDe5Trabajadores` BOOLEAN,
    `provinciaTrabajo` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `cno` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `horarioLunes` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `horarioMartes` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `horarioMiercoles` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `horarioJueves` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `horarioViernes` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `horarioJornadaCompleta` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `horasTotalesAnuales` INT,
    `vacaciones` INT,
    `observaciones` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ge_contactos`
--
ALTER TABLE `ge_contactos`
  ADD PRIMARY KEY (`idcontacto`) USING BTREE,
  ADD KEY `Secundario` (`nombre`) USING BTREE;

--
-- Indices de la tabla `ge_domicilios`
--
ALTER TABLE `ge_domicilios`
  ADD PRIMARY KEY (`iddomicilio`);

--
-- Indices de la tabla `ge_empresas`
--
ALTER TABLE `ge_empresas`
  ADD PRIMARY KEY (`idempresa`),
  ADD KEY `empresa` (`empresa`);
  
--
-- Indices de la tabla `gf_alumnosfct`
--
ALTER TABLE `gf_alumnosfct`
  ADD PRIMARY KEY (`idalumno`);
  
--
-- Indices de la tabla `calendario`
--
ALTER TABLE `calendario`
  ADD PRIMARY KEY (`idAlumno`, `idEmpresa`);

--
-- Indices de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  ADD PRIMARY KEY (`idEspecialidad`);

--
-- Indices de la tabla `estadoDual`
--
ALTER TABLE `estadoDual`
  ADD PRIMARY KEY (`idEstado`);
  
--
-- Indices de la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  ADD PRIMARY KEY (`idEvaluacion`);
  
--
-- Indices de la tabla `gestionDual`
--
ALTER TABLE `gestionDual`
  ADD PRIMARY KEY (`idGestion`);

--
-- Indices de la tabla `peticionEmpresa`
--
ALTER TABLE `peticionEmpresa`
  ADD PRIMARY KEY (`idPeticion`);

--
-- Indices de la tabla `preferencia`
--
ALTER TABLE `preferencia`
  ADD PRIMARY KEY (`idPreferencia`);

--
-- Indices de la tabla `preferenciaAlumno`
--
ALTER TABLE `preferenciaAlumno`
  ADD PRIMARY KEY (`idAlumno`, `idEspecialidad`);
  
--
-- Indices de la tabla `tipoContrato`
--
ALTER TABLE `tipoContrato`
  ADD PRIMARY KEY (`idContrato`);
  
--
-- Indices de la tabla `posiblesTransportes`
--
ALTER TABLE `posiblesTransportes`
  ADD PRIMARY KEY (`idTransporte`);
  
--
-- Indices de la tabla `transporteEmpresa`
--
ALTER TABLE `transporteEmpresa`
  ADD PRIMARY KEY (`idTransporte`, `idEmpresa`);
  
--
-- Indices de la tabla `alumnosPedidos`
--
ALTER TABLE `alumnosPedidos`
  ADD PRIMARY KEY (`idAlPed`);
  
--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`idUser`);
  
--
-- Indices de la tabla `usersCourses`
--
ALTER TABLE `usersCourses`
  ADD PRIMARY KEY (`idUser`, `idCourse`);
  
-- --------------------------------------------------------

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ge_contactos`
--
ALTER TABLE `ge_contactos`
  MODIFY `idcontacto` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7924;

--
-- AUTO_INCREMENT de la tabla `ge_domicilios`
--
ALTER TABLE `ge_domicilios`
  MODIFY `iddomicilio` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2662;

--
-- AUTO_INCREMENT de la tabla `ge_empresas`
--
ALTER TABLE `ge_empresas`
  MODIFY `idempresa` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3969;

--
-- AUTO_INCREMENT de la tabla `ge_empresas`
--
ALTER TABLE `gestiondual`
  MODIFY `idGestion` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gf_alumnosfct`
--
ALTER TABLE `gf_alumnosfct`
  MODIFY `idalumno` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2078;
  
--
-- AUTO_INCREMENT de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  MODIFY `idEspecialidad` int NOT NULL AUTO_INCREMENT;
    
--
-- AUTO_INCREMENT de la tabla `estadoDual`
--
ALTER TABLE `estadoDual`
  MODIFY `idEstado` int NOT NULL AUTO_INCREMENT;
      
--
-- AUTO_INCREMENT de la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  MODIFY `idEvaluacion` int NOT NULL AUTO_INCREMENT;
        
--
-- AUTO_INCREMENT de la tabla `peticionempresa`
--
ALTER TABLE `peticionempresa`
  MODIFY `idPeticion` int NOT NULL AUTO_INCREMENT;
  
--
-- AUTO_INCREMENT de la tabla `preferencia`
--
ALTER TABLE `preferencia`
  MODIFY `idPreferencia` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipoContrato`
--
ALTER TABLE `tipoContrato`
  MODIFY `idContrato` int NOT NULL AUTO_INCREMENT;
  
--
-- AUTO_INCREMENT de la tabla `posiblesTransportes`
--
ALTER TABLE `posiblesTransportes`
  MODIFY `idTransporte` int NOT NULL AUTO_INCREMENT;
  
--
-- Indices de la tabla `alumnosPedidos`
--
ALTER TABLE `alumnosPedidos`
  MODIFY `idAlPed` int NOT NULL AUTO_INCREMENT;
  
--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `idUser` int NOT NULL AUTO_INCREMENT;

-- --------------------------------------------------------

--
-- FK de las tablas volcadas
--

--
-- FK de la tabla `ge_contactos`
--
ALTER TABLE `ge_contactos`
ADD CONSTRAINT FK_domicilio
FOREIGN KEY (`iddomicilio`)
REFERENCES `ge_domicilios`(`iddomicilio`);

--
-- FK de la tabla `ge_domicilios`
--
ALTER TABLE `ge_domicilios`
ADD CONSTRAINT FK_empresa
FOREIGN KEY (`idempresa`)
REFERENCES `ge_empresas`(`idempresa`);

--
-- FK de la tabla `gf_alumnosfct`
--
ALTER TABLE `gf_alumnosfct`
ADD CONSTRAINT FK_empresa2
FOREIGN KEY (`idempresa`)
REFERENCES `ge_empresas`(`idempresa`),
ADD CONSTRAINT FK_domicilio2
FOREIGN KEY (`iddomicilio`)
REFERENCES `ge_domicilios`(`iddomicilio`);

--
-- FK de la tabla `calendario`
--
ALTER TABLE `calendario`
ADD CONSTRAINT FK_alumno
FOREIGN KEY (`idAlumno`)
REFERENCES `gf_alumnosfct`(`idAlumno`),
ADD CONSTRAINT FK_empresa3
FOREIGN KEY (`idEmpresa`)
REFERENCES `ge_empresas`(`idEmpresa`);
  
--
-- FK de la tabla `gestionDual`
--
ALTER TABLE `gestionDual`
ADD CONSTRAINT FK_alumno2
FOREIGN KEY (`idAlumno`)
REFERENCES `gf_alumnosfct`(`idAlumno`),
ADD CONSTRAINT FK_evaluacion
FOREIGN KEY (`idEvaluacion`)
REFERENCES `evaluacion`(`idEvaluacion`),
ADD CONSTRAINT FK_empresa4
FOREIGN KEY (`idEmpresa1`)
REFERENCES `ge_empresas`(`idEmpresa`),
ADD CONSTRAINT FK_empresa5
FOREIGN KEY (`idEmpresa2`)
REFERENCES `ge_empresas`(`idEmpresa`),
ADD CONSTRAINT FK_empresa6
FOREIGN KEY (`idEmpresa3`)
REFERENCES `ge_empresas`(`idEmpresa`),
ADD CONSTRAINT FK_especialidad
FOREIGN KEY (`idEspecialidad`)
REFERENCES `especialidad`(`idEspecialidad`),
ADD CONSTRAINT FK_contacto
FOREIGN KEY (`tutor`)
REFERENCES `ge_contactos`(`idcontacto`),
ADD CONSTRAINT FK_tipoContrato
FOREIGN KEY (`tipoContrato1`)
REFERENCES `tipoContrato`(`idContrato`),
ADD CONSTRAINT FK_tipoContrato2
FOREIGN KEY (`tipoContrato2`)
REFERENCES `tipoContrato`(`idContrato`),
ADD CONSTRAINT FK_tipoContrato3
FOREIGN KEY (`tipoContrato3`)
REFERENCES `tipoContrato`(`idContrato`),
ADD CONSTRAINT FK_estadoDual
FOREIGN KEY (`estadoDual1`)
REFERENCES `estadoDual`(`idEstado`),
ADD CONSTRAINT FK_estadoDual2
FOREIGN KEY (`estadoDual2`)
REFERENCES `estadoDual`(`idEstado`),
ADD CONSTRAINT FK_estadoDual3
FOREIGN KEY (`estadoDual3`)
REFERENCES `estadoDual`(`idEstado`);

--
-- FK de la tabla `peticionEmpresa`
--
ALTER TABLE `peticionEmpresa`
ADD CONSTRAINT FK_empresa7
FOREIGN KEY (`idEmpresa`)
REFERENCES `ge_empresas`(`idEmpresa`),
ADD CONSTRAINT FK_contacto2
FOREIGN KEY (`representante`)
REFERENCES `ge_contactos`(`idcontacto`),
ADD CONSTRAINT FK_contacto3
FOREIGN KEY (`coordinador`)
REFERENCES `ge_contactos`(`idcontacto`),
ADD CONSTRAINT FK_domicilio3
FOREIGN KEY (`idDomicilio`)
REFERENCES `ge_domicilios`(`iddomicilio`),
ADD CONSTRAINT FK_domicilio4
FOREIGN KEY (`puestoTrabajo`)
REFERENCES `ge_domicilios`(`iddomicilio`);

--
-- FK de la tabla `preferencia`
--
ALTER TABLE `preferencia`
ADD CONSTRAINT FK_especialidad2
FOREIGN KEY (`idEspecialidad`)
REFERENCES `especialidad`(`idEspecialidad`);

--
-- FK de la tabla `preferenciaAlumno`
--
ALTER TABLE `preferenciaAlumno`
ADD CONSTRAINT FK_alumno3
FOREIGN KEY (`idAlumno`)
REFERENCES `gf_alumnosfct`(`idAlumno`),
ADD CONSTRAINT FK_especialidad3
FOREIGN KEY (`idEspecialidad`)
REFERENCES `especialidad`(`idEspecialidad`);

--
-- FK de la tabla `transporteEmpresa`
--
ALTER TABLE `transporteEmpresa`
ADD CONSTRAINT FK_transporte
FOREIGN KEY (`idTransporte`)
REFERENCES `posiblesTransportes`(`idTransporte`),
ADD CONSTRAINT FK_empresa8
FOREIGN KEY (`idEmpresa`)
REFERENCES `ge_empresas`(`idEmpresa`);

--
-- FK de la tabla `alumnosPedidos`
--
ALTER TABLE `alumnosPedidos`
ADD CONSTRAINT FK_peticion
FOREIGN KEY (`idPeticion`)
REFERENCES `peticionEmpresa`(`idPeticion`),
ADD CONSTRAINT FK_especialidad4
FOREIGN KEY (`idEspecialidad`)
REFERENCES `especialidad`(`idEspecialidad`);

--
-- Indices de la tabla `usersCourses`
--
ALTER TABLE `usersCourses`
ADD CONSTRAINT FK_user
FOREIGN KEY (`idUser`)
REFERENCES `users`(`idUser`),
ADD CONSTRAINT FK_especialidad5
FOREIGN KEY (`idCourse`)
REFERENCES `especialidad`(`idEspecialidad`);

COMMIT;

-- --------------------------------------------------------
--
-- Generación de usuarios:
--

--
-- Usuario admin con todos los poderes
--

DROP USER IF EXISTS 'admin';
CREATE USER IF NOT EXISTS 'admin'
IDENTIFIED BY 'admin';
GRANT 		all privileges
ON 			manuel_dual.*
TO 			'admin';

--
-- Usuario profe que solo lee las tablas que necesitan ver los tutores
--

DROP USER IF EXISTS 'profe';
CREATE USER IF NOT EXISTS 'profe'
IDENTIFIED BY 'profe';
GRANT 		select
ON 			manuel_dual.evaluacion
TO 			'profe';
GRANT 		select
ON 			manuel_dual.ge_contactos
TO 			'profe';
GRANT 		select
ON 			manuel_dual.ge_domicilios
TO 			'profe';
GRANT 		select
ON 			manuel_dual.ge_empresas
TO 			'profe';
GRANT 		select
ON 			manuel_dual.gf_alumnosfct
TO 			'profe';
GRANT 		select
ON 			manuel_dual.preferencia
TO 			'profe';
GRANT 		select
ON 			manuel_dual.preferenciaalumno
TO 			'profe';

--
-- Usuario secretaría que solo lee las tablas que necesita secretaría
--

DROP USER IF EXISTS 'secretaria';
CREATE USER IF NOT EXISTS 'secretaria'
IDENTIFIED BY 'secretaria';
GRANT 		select
ON 			manuel_dual.gestiondual
TO			'secretaria';

-- --------------------------------------------------------

--
-- Objetos
--

-- Una función que dado un grado nos diga cuantos alumnos quedan por colocar. 
-- He decidido que se pueda elegir de qué año buscas los alumnos poniendo este parámetro.

DROP FUNCTION IF EXISTS alumnosSinEmpresa;
DELIMITER $$
CREATE FUNCTION alumnosSinEmpresa(codigoEsp varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, fecha int)
	RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE		total int;
    
	SELECT		count(*)
	INTO		total
	FROM		gestiondual g, especialidad e
	WHERE		g.idEspecialidad = e.idEspecialidad
    AND			e.codigoEsp = codigoEsp
    AND			year(g.fechaFormalizacion) = fecha
	AND			(idEmpresa1 = null
	OR			idEmpresa1 = 1)
	AND			(idEmpresa2 = null
	OR			idEmpresa2 = 1)
	AND			(idEmpresa3 = null
	OR			idEmpresa3 = 1);
    
    RETURN total;
END

$$
DELIMITER ;

SELECT	alumnosSinEmpresa('IFC302', 2024);

-- Un procedimiento que contenga un update/insert/delete pensado por vosotros
-- El procedimiento pondrá en observaciones 'Trabaja de tardes' para todos los alumnos que no 
-- sean ni de Robotica ni de Informática ya que estos solo pueden ir a turno de mañanas.

DROP PROCEDURE IF EXISTS cuandoTrabaja;
DELIMITER $$
CREATE PROCEDURE cuandoTrabaja(IN fecha INT)
BEGIN
	UPDATE		gf_alumnosfct
    SET			observaciones = 'Trabaja de tardes'
    WHERE		idalumno in (
		SELECT		idAlumno
        FROM		gestiondual
        WHERE		idEspecialidad != 1
        AND			idEspecialidad != 3
        AND			year(fechaFormalizacion) = fecha
    );
END

$$
DELIMITER ;

CALL cuandoTrabaja(2024);

-- Una función que encripte y desencripte una contraseña. 

DROP FUNCTION IF EXISTS gestionPassword;
DELIMITER $$
CREATE FUNCTION gestionPassword(pswd varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, 
								llave varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, encriptar tinyint)
	RETURNS varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
    DETERMINISTIC
BEGIN
	DECLARE		output varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    
    IF			encriptar = 1 THEN
    -- Para encriptar invertimos la contraseña y añadimos al final la llave
    SET			output = concat(reverse(pswd), llave);
    ELSE
    -- Para desencriptar eliminamos la llave pillando solo los caracteres que resultan en la diferencia de la contraseña
    -- y la llave desde la izquierda y luego invertimos el String resultante
    SET			output = reverse(left(pswd, length(pswd) - length(llave)));
    END IF;
    
    RETURN		output;
END

$$
DELIMITER ;

SELECT	gestionPassword('IFC302', 'IFC302', 1);

-- Un procedimiento que borre una empresa estando seguros de que no tiene alumnos adjudicados.

DROP PROCEDURE IF EXISTS eliminarEmpresa;
DELIMITER $$
CREATE PROCEDURE eliminarEmpresa(eliminar varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci)
BEGIN
	DELETE
    FROM		ge_empresas
    WHERE		empresa = eliminar
    AND			idempresa not in(
		SELECT		idEmpresa
        FROM		gestiondual
        WHERE		idAlumno is not null
        AND			idEmpresa is not null
        );
END

$$
DELIMITER ;

CALL eliminarEmpresa('AMAZON');

-- --------------------------------------------------------

--
-- Objetos2
--

-- Una vista inventada
-- He decidido crear una vista que me muestre los alumnos que todavía no tienen empresa asignada

DROP VIEW IF EXISTS alumnosSinAsignar;
CREATE VIEW alumnosSinAsignar AS (
	SELECT		nombre
    FROM		gf_alumnosfct a
    WHERE		a.idalumno not in (
		SELECT		g.idAlumno
        FROM		gestiondual g
        WHERE		g.idEmpresa1 is not null -- Si en la primera no tiene nada nunca tendrá en las siguientes
        OR			g.idEmpresa1 = 1
        )
);

-- Una vista con el estado de la solicitud de los alumnos del curso actual.
-- Debido a que la fecha que se guarda es la de inicio, se pillarán tanto 
-- los alumnos cuya fecha de Inicio cuadre con la del año actual como con 
-- la del año anterior, ya que si lo checkqueas en noviembre del 23 te 
-- interesarán los de ese año pero en enero del 24 te seguirán interesando 
-- los mismos.

DROP VIEW IF EXISTS estadoSolicitudAlumnos;
CREATE VIEW estadoSolicitudAlumnos AS (
	SELECT		a.nombre, em.empresa, e.descEstado, g.fechaFormalizacion
    FROM		gf_alumnosfct a, gestiondual g, estadodual e, ge_empresas em
    WHERE		a.idalumno = g.idAlumno
    AND			(g.idEmpresa1 = em.idempresa
    OR			g.idEmpresa2 = em.idempresa
    OR			g.idEmpresa3 = em.idempresa)
    AND			(g.estadoDual1 = e.idEstado
    OR			g.estadoDual2 = e.idEstado
    OR			g.estadoDual3 = e.idEstado)
    AND			(year(g.fechaFormalizacion) = year(curdate())
    OR			year(g.fechaFormalizacion) = year(curdate()) - 1)
);

-- Un trigger que al borrar un alumno no deje si tiene empresa asignada
-- Si tiene calendarios, evaluaciones, idiomas registrados o preferencias estas se borrarán también ya que son propias del alumno.

DELIMITER $$
DROP TRIGGER IF EXISTS eliminarAlumno $$
CREATE TRIGGER eliminarAlumno
BEFORE DELETE
ON gf_alumnosfct FOR EACH ROW
BEGIN
	DECLARE empresaAsignada int;
    DECLARE empresaAsignada1 int;
    
	SELECT		count(*)
    INTO		empresaAsignada
    FROM		gf_alumnosfct a
    WHERE		old.idalumno in (
		SELECT		g.idAlumno
        FROM		gestiondual g
        WHERE		(g.idEmpresa1 is not null -- Si en la primera no tiene nada nunca tendrá en las siguientes
        or			g.idEmpresa1 = 1)
    );
    
    IF empresaAsignada > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El alumno tiene empresa asignada en la tabla GestionDual';
    END IF;
    
    DELETE
    FROM		calendario c
    WHERE		old.idalumno = c.idAlumno;
    
    DELETE
    FROM		preferenciaalumno p
    WHERE		old.idalumno = p.idAlumno;
END;

DELETE FROM `manuel_dual`.`gf_alumnosfct` WHERE (`idalumno` = '1797');
DELETE FROM `manuel_dual`.`gf_alumnosfct` WHERE (`idalumno` = '1796');

-- --------------------------------------------------------

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;