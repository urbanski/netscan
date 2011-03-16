--
-- Table structure for table `history`
--

CREATE TABLE IF NOT EXISTS `history` (
  `HistoryDate` date NOT NULL,
  `HistoryPort` varchar(10) NOT NULL,
  `HistoryCount` int(11) NOT NULL,
  KEY `HistoryDate` (`HistoryDate`,`HistoryPort`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hosts`
--

CREATE TABLE IF NOT EXISTS `hosts` (
  `HostIP` varchar(255) NOT NULL,
  `HostPort` varchar(10) NOT NULL,
  `HostDateIdentified` date NOT NULL,
  KEY `HostIP` (`HostIP`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

