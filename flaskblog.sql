-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2020 at 11:49 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flaskblog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_no` varchar(50) NOT NULL,
  `msg` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_no`, `msg`) VALUES
(1, 'robin', 'rabin@gmail', '1231231', 'robin hood '),
(2, 'Kartikay Raheja', 'asdas@asdas', '324121312', 'testing'),
(3, 'kartikay raheja', 'rahejakartikay99@gmail.com', '09582400910', 'testing\r\n'),
(4, 'kartikay raheja', 'rahejakartikay99@gmail.com', '09582400910', 'testing'),
(5, 'kartikay raheja', 'rahejakartikay99@gmail.com', '09582400910', 'testing\r\n'),
(6, 'kartikay raheja', 'rahejakartikay99@gmail.com', '09582400910', 'testing\r\n'),
(7, 'kartikay raheja', 'rahejakartikay99@gmail.com', '09582400910', 'testing\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` varchar(11) NOT NULL,
  `content` longtext NOT NULL,
  `date` date NOT NULL,
  `slug` varchar(25) NOT NULL,
  `img_file` varchar(12) NOT NULL,
  `tagline` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `content`, `date`, `slug`, `img_file`, `tagline`) VALUES
(2, 'Testing 1', 'he term document template used in the context of file format refers to a common feature of many software applications that define a unique non-executable file format intended specifically for that particular application.\r\n\r\nTemplate file formats are those whose file extension indicates that the file type is intended as a high starting point from which to create other files.\r\n\r\n\r\nSave As ... file dialog box\r\nThese types of files are usually indicated on the Save As ... file dialog box of the application.\r\n\r\nFor example, the word processing application Microsoft Word uses different file extensions for documents and templates: In Word 2003 the file extension .dot is used to indicate a template, in contrast to .doc for a standard document. In Word 2007, it\'s .dotx, instead of .docx for documents.\r\n\r\nThe OpenDocument Format also has templates in its specification, with .ott as the filename extension for OpenDocument Text template.\r\n\r\nIn Adobe Dreamweaver the .dwt extension is used to indicate a template.', '2020-10-28', 'second-post', 'about-bg.jpg', 'Insert Tagline'),
(3, 'Template 2', 'he term document template used in the context of file format refers to a common feature of many software applications that define a unique non-executable file format intended specifically for that particular application.\r\n\r\nTemplate file formats are those whose file extension indicates that the file type is intended as a high starting point from which to create other files.\r\n\r\n\r\nSave As ... file dialog box\r\nThese types of files are usually indicated on the Save As ... file dialog box of the application.\r\n\r\nFor example, the word processing application Microsoft Word uses different file extensions for documents and templates: In Word 2003 the file extension .dot is used to indicate a template, in contrast to .doc for a standard document. In Word 2007, it\'s .dotx, instead of .docx for documents.\r\n\r\nThe OpenDocument Format also has templates in its specification, with .ott as the filename extension for OpenDocument Text template.\r\n\r\nIn Adobe Dreamweaver the .dwt extension is used to indicate a template.', '0000-00-00', 'third-post', 'home-ng.jpg', 'Insert Tagline'),
(4, 'Text classi', 'ASDASDASD', '2020-10-28', 'backend', 'IIA.png', 'Backend'),
(5, 'Text classi', 'asasdadas', '2020-10-28', 'backend', 'asd.png', 'Backend'),
(6, 'Text classi', 'asdasdsadsdsa', '2020-10-28', 'backend', 'dsd.png', 'Backend');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
