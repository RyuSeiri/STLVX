/*
Navicat MySQL Data Transfer

Source Server         : DateBase
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : stlv

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2017-10-13 18:11:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tb_answer
-- ----------------------------
DROP TABLE IF EXISTS `tb_answer`;
CREATE TABLE `tb_answer` (
  `ANSWER_ID` varchar(20) NOT NULL,
  `ANSWER_INFO` mediumtext,
  `DEL_FLG` int(11) NOT NULL DEFAULT '0',
  `PRAXIS_INFO` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ANSWER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_article
-- ----------------------------
DROP TABLE IF EXISTS `tb_article`;
CREATE TABLE `tb_article` (
  `SARTICLEID` varchar(20) NOT NULL,
  `STITLE` varchar(50) NOT NULL,
  `IARTICLEKIND` int(11) NOT NULL,
  `SAUTHORID` varchar(20) NOT NULL,
  `DMAKETIME` datetime DEFAULT NULL,
  `SCONTENT` mediumtext NOT NULL,
  `DEL_FLG` int(11) NOT NULL DEFAULT '0',
  `filepath` varchar(255) DEFAULT NULL,
  `FILE_TYPE` int(11) DEFAULT NULL,
  `CHAPTER_INFO` varchar(255) DEFAULT NULL,
  `CHAPTER_ID` varchar(255) DEFAULT NULL,
  `ORDERINFO` int(11) DEFAULT NULL,
  PRIMARY KEY (`SARTICLEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_articleorder
-- ----------------------------
DROP TABLE IF EXISTS `tb_articleorder`;
CREATE TABLE `tb_articleorder` (
  `SARTICLEID` varchar(20) NOT NULL,
  `ORDERINFO` int(11) DEFAULT '0',
  PRIMARY KEY (`SARTICLEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_article_chapter
-- ----------------------------
DROP TABLE IF EXISTS `tb_article_chapter`;
CREATE TABLE `tb_article_chapter` (
  `SARTICLEID` varchar(20) NOT NULL,
  `CHAPTER_ID` varchar(20) NOT NULL,
  PRIMARY KEY (`SARTICLEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_article_file
-- ----------------------------
DROP TABLE IF EXISTS `tb_article_file`;
CREATE TABLE `tb_article_file` (
  `SARTICLEID` varchar(20) NOT NULL,
  `FILE_ID` varchar(20) NOT NULL,
  PRIMARY KEY (`FILE_ID`,`SARTICLEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_chapter
-- ----------------------------
DROP TABLE IF EXISTS `tb_chapter`;
CREATE TABLE `tb_chapter` (
  `CHAPTER_ID` varchar(20) NOT NULL,
  `CHAPTER_INFO` varchar(20) NOT NULL,
  `DEL_FLG` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`CHAPTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_courseoverview
-- ----------------------------
DROP TABLE IF EXISTS `tb_courseoverview`;
CREATE TABLE `tb_courseoverview` (
  `SKEY` varchar(20) NOT NULL,
  `SVALUE` varchar(20) NOT NULL,
  `SMESSAGE` text,
  `DEL_FLG` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`SKEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_file
-- ----------------------------
DROP TABLE IF EXISTS `tb_file`;
CREATE TABLE `tb_file` (
  `FILE_ID` varchar(20) NOT NULL,
  `FILE_NAME` varchar(80) NOT NULL,
  `FILE_PATH` varchar(100) NOT NULL,
  `FILE_TYPE` int(1) NOT NULL,
  `DEL_FLG` int(1) NOT NULL,
  PRIMARY KEY (`FILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_praxis
-- ----------------------------
DROP TABLE IF EXISTS `tb_praxis`;
CREATE TABLE `tb_praxis` (
  `PRAXIS_ID` varchar(20) NOT NULL,
  `PRAXIS_INFO` mediumtext,
  `DEL_FLG` int(11) NOT NULL DEFAULT '0',
  `sArticleId` varchar(255) DEFAULT NULL,
  `sTitle` varchar(255) DEFAULT NULL,
  `iArticleKind` int(11) DEFAULT NULL,
  `sAuthorId` varchar(255) DEFAULT NULL,
  `dMakeTime` date DEFAULT NULL,
  `sContent` varchar(255) DEFAULT NULL,
  `ANSWER_INFO` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`PRAXIS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_question_reply
-- ----------------------------
DROP TABLE IF EXISTS `tb_question_reply`;
CREATE TABLE `tb_question_reply` (
  `CONTENT_ID` varchar(20) CHARACTER SET utf8 COLLATE utf8_sinhala_ci NOT NULL,
  `CONTENT` mediumtext COMMENT '问题信息',
  `TIME` datetime NOT NULL COMMENT '提问时间',
  `CONTENT_TYPE` int(10) NOT NULL COMMENT '内容的类型（0：学生的提问 1：老师的回答）',
  `DEL_FLG` int(10) NOT NULL,
  PRIMARY KEY (`CONTENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_student
-- ----------------------------
DROP TABLE IF EXISTS `tb_student`;
CREATE TABLE `tb_student` (
  `SStudentId` varchar(20) CHARACTER SET latin1 NOT NULL,
  `SUSERNAME` varchar(20) NOT NULL,
  `SPASSWORD` varchar(20) CHARACTER SET latin1 NOT NULL,
  `SEMAIL` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `SREALNAME` varchar(50) NOT NULL,
  `SCLASSID` int(11) NOT NULL,
  `SPERSONID` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `SPHONENUM` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `PHEADPIC` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `DBIRTHDAY` date DEFAULT NULL,
  `SCITY` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `CSEX` char(1) CHARACTER SET latin1 DEFAULT NULL,
  `SQQ` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `SMSN` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `SPERSONNALPAGE` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `SBLOGPAGE` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `SPERSONNALINTRO` varchar(1000) CHARACTER SET latin1 DEFAULT NULL,
  `SADDRESS` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `SPOSTCODE` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `STYPEID` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `SLEVEL` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `SCOMPANYID` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `SSCORE` int(11) DEFAULT NULL,
  `DREGISTERTIME` datetime DEFAULT NULL,
  `DLASTLOGINTIME` datetime DEFAULT NULL,
  `DEL_FLG` int(11) DEFAULT NULL,
  PRIMARY KEY (`SStudentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_system_control
-- ----------------------------
DROP TABLE IF EXISTS `tb_system_control`;
CREATE TABLE `tb_system_control` (
  `SKEY` varchar(20) CHARACTER SET latin1 NOT NULL,
  `SVALUE` varchar(20) CHARACTER SET latin1 NOT NULL,
  `SMESSAGE` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`SKEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
