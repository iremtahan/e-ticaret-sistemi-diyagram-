CREATE TABLE IF NOT EXISTS `Kullanıcılar` (
	`KullaniciID` int NOT NULL,
	`Ad` varchar(255) NOT NULL DEFAULT '100',
	`Soyad` varchar(255) NOT NULL DEFAULT '100',
	`Email` varchar(255) NOT NULL DEFAULT '150',
	`Sifre` varchar(255) NOT NULL DEFAULT '100',
	PRIMARY KEY (`KullaniciID`)
);

CREATE TABLE IF NOT EXISTS `Ürünler` (
	`UrunID` int NOT NULL,
	`UrunAdi` varchar(255) NOT NULL DEFAULT '150',
	`Fiyat` decimal(10,0) NOT NULL,
	`StokMiktari` int NOT NULL,
	`KategoriID` int NOT NULL,
	PRIMARY KEY (`UrunID`)
);

CREATE TABLE IF NOT EXISTS `Kategoriler` (
	`KategoriID` int NOT NULL,
	`KategoriAdi` varchar(255) NOT NULL DEFAULT '100',
	`Açıklama` text,
	`ÜstKategoriID` int,
	`Aktif` boolean NOT NULL,
	PRIMARY KEY (`KategoriID`)
);

CREATE TABLE IF NOT EXISTS `Siparişler` (
	`SiparisID` int NOT NULL,
	`KullaniciID` int NOT NULL,
	`SiparisTarihi` datetime NOT NULL,
	`ToplamTutar` decimal(10,0) NOT NULL,
	`Durum` varchar(255) NOT NULL DEFAULT '50',
	PRIMARY KEY (`SiparisID`)
);

CREATE TABLE IF NOT EXISTS `SiparişDetayları` (
	`Fiyat` decimal(10,0) NOT NULL,
	`SiparisDetayID` int NOT NULL,
	`SiparisID` int NOT NULL,
	`UrunID` int NOT NULL,
	`Miktar` int NOT NULL,
	PRIMARY KEY (`SiparisDetayID`)
);

CREATE TABLE IF NOT EXISTS `Ödeme` (
	`OdemeID` int NOT NULL,
	`SiparisID` int NOT NULL,
	`OdemeTarihi` datetime NOT NULL,
	`Miktar` decimal(10,0) NOT NULL,
	`OdemeTipi` varchar(255) NOT NULL DEFAULT '50',
	PRIMARY KEY (`OdemeID`)
);

CREATE TABLE IF NOT EXISTS `Kargo` (
	`KargoID` int NOT NULL,
	`SiparisID` int NOT NULL,
	`KargoSirketi` varchar(255) NOT NULL DEFAULT '100',
	`GonderimTarihi` datetime NOT NULL,
	`Durum` varchar(255) NOT NULL DEFAULT '50',
	PRIMARY KEY (`KargoID`)
);


ALTER TABLE `Ürünler` ADD CONSTRAINT `Ürünler_fk4` FOREIGN KEY (`KategoriID`) REFERENCES `Kategoriler`(`KategoriID`);

ALTER TABLE `Siparişler` ADD CONSTRAINT `Siparişler_fk1` FOREIGN KEY (`KullaniciID`) REFERENCES `Kullanıcılar`(`KullaniciID`);
ALTER TABLE `SiparişDetayları` ADD CONSTRAINT `SiparişDetayları_fk2` FOREIGN KEY (`SiparisID`) REFERENCES `Siparişler`(`SiparisID`);

ALTER TABLE `SiparişDetayları` ADD CONSTRAINT `SiparişDetayları_fk3` FOREIGN KEY (`UrunID`) REFERENCES `Ürünler`(`UrunID`);
ALTER TABLE `Ödeme` ADD CONSTRAINT `Ödeme_fk1` FOREIGN KEY (`SiparisID`) REFERENCES `Siparişler`(`SiparisID`);
ALTER TABLE `Kargo` ADD CONSTRAINT `Kargo_fk1` FOREIGN KEY (`SiparisID`) REFERENCES `Siparişler`(`SiparisID`);