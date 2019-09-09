-- Adminer 4.7.2 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP VIEW IF EXISTS `rekap_apbd`;
CREATE TABLE `rekap_apbd` (`tahun` int(1), `id_satker` varchar(65), `kd_skpd` varchar(25), `nama_satker` varchar(255), `btl` varchar(25), `bl` varchar(25), `jml_pagu` double);


DROP VIEW IF EXISTS `rekap_penyedia`;
CREATE TABLE `rekap_penyedia` (`tahun` varchar(4), `id_satker` varchar(10), `nama_satker` varchar(255), `jml_pkt` bigint(21), `jml_pagu` double);


DROP VIEW IF EXISTS `rekap_penyedia_belum`;
CREATE TABLE `rekap_penyedia_belum` (`tahun` varchar(4), `id_satker` varchar(10), `nama_satker` varchar(255), `jml_pkt` bigint(21), `jml_pagu` double);


DROP VIEW IF EXISTS `rekap_penyedia_tepra`;
CREATE TABLE `rekap_penyedia_tepra` (`tahun` varchar(4), `pg_kur_200` double, `pkt_kur_200` bigint(21), `pg_kur_25` double, `pkt_kur_25` bigint(21), `pg_kur_50` double, `pkt_kur_50` bigint(21), `pg_kur_100` double, `pkt_kur_100` bigint(21), `pg_bih_100` double, `pkt_bih_100` bigint(21), `jumlah_paket` bigint(21), `total_pagu` double);


DROP VIEW IF EXISTS `rekap_swakelola`;
CREATE TABLE `rekap_swakelola` (`tahun` varchar(4), `id_satker` varchar(10), `nama_satker` varchar(255), `jml_pkt` bigint(21), `jml_pagu` double);


DROP VIEW IF EXISTS `rekap_swakelola_belum`;
CREATE TABLE `rekap_swakelola_belum` (`tahun` varchar(4), `id_satker` varchar(10), `nama_satker` varchar(255), `jml_pkt` bigint(21), `jml_pagu` double);


DROP VIEW IF EXISTS `rekap_swakelola_tepra`;
CREATE TABLE `rekap_swakelola_tepra` (`tahun` varchar(4), `pg_swa` double, `pkt_swa` bigint(21));


DROP TABLE IF EXISTS `table_apbd`;
CREATE TABLE `table_apbd` (
  `tahun` int(1) NOT NULL DEFAULT '2019',
  `id_satker` varchar(65) NOT NULL DEFAULT '0',
  `kd_skpd` varchar(25) NOT NULL,
  `nama_satker` varchar(255) NOT NULL,
  `pg_btl` varchar(25) NOT NULL,
  `pg_bl` varchar(25) NOT NULL,
  `tanggal_buat` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `table_apbd` (`tahun`, `id_satker`, `kd_skpd`, `nama_satker`, `pg_btl`, `pg_bl`, `tanggal_buat`) VALUES
(2019,	'0',	'1.1.1.1',	'Dinas Pendidikan',	'621506533830',	'118987520675',	'0000-00-00 00:00:00'),
(2019,	'0',	'1.2.1.1',	'Dinas Kesehatan',	'61904439600',	'123132824792',	'0000-00-00 00:00:00'),
(2019,	'0',	'1.2.2.1',	'RSUD Dr. Harjono - SKPD',	'26713062400',	'122781999000',	'0000-00-00 00:00:00'),
(2019,	'0',	'1.3.1.1',	'Dinas Pekerjaan Umum dan Penataan Ruang',	'8652653400',	'262420322120',	'0000-00-00 00:00:00'),
(2019,	'0',	'1.4.1.1',	'Dinas Perumahan dan Kawasan Permukiman',	'2775940400',	'19046835312',	'0000-00-00 00:00:00'),
(2019,	'0',	'1.5.1.1',	'Badan Kesatuan Bangsa dan Politik',	'2117662000',	'1118064800',	'0000-00-00 00:00:00'),
(2019,	'0',	'1.5.2.1',	'Satuan Polisi Pamong Praja',	'5704245000',	'2169297220',	'0000-00-00 00:00:00'),
(2019,	'0',	'1.5.3.1',	'Badan Penanggulangan Bencana Daerah',	'2469649480',	'3003972943',	'0000-00-00 00:00:00'),
(2019,	'0',	'1.6.1.1',	'Dinas Sosial, Pemberdayaan Perempuan dan Perlindungan Anak',	'3070461860',	'2264867816',	'0000-00-00 00:00:00'),
(2019,	'0',	'2.1.1.1',	'Dinas Tenaga Kerja',	'2966818480',	'1588409129',	'0000-00-00 00:00:00'),
(2019,	'0',	'2.3.1.1',	'Dinas Ketahanan Pangan',	'2296167000',	'1205136764',	'0000-00-00 00:00:00'),
(2019,	'0',	'2.5.1.1',	'Dinas Lingkungan Hidup',	'5721476340',	'11951738981',	'0000-00-00 00:00:00'),
(2019,	'0',	'2.6.1.1',	'Dinas Kependudukan dan Pencatatan Sipil',	'6423907000',	'4927554482',	'0000-00-00 00:00:00'),
(2019,	'0',	'2.7.1.1',	'Dinas Pemberdayaan Masyarakat dan Desa',	'2959874000',	'5947626500',	'0000-00-00 00:00:00'),
(2019,	'0',	'2.8.1.1',	'Dinas Pengendalian Penduduk dan Keluarga Berencana',	'3417594000',	'9319768600',	'0000-00-00 00:00:00'),
(2019,	'0',	'2.9.1.1',	'Dinas Perhubungan',	'5522145360',	'4286545552',	'0000-00-00 00:00:00'),
(2019,	'0',	'2.10.1.1',	'Dinas Komunikasi, Informatika dan Statistik',	'2741632920',	'3213142900',	'0000-00-00 00:00:00'),
(2019,	'0',	'2.11.1.1',	'Dinas Perdagangan, Koperasi dan Usaha Mikro',	'7522277480',	'8587907100',	'0000-00-00 00:00:00'),
(2019,	'0',	'2.12.1.1',	'Dinas Penanaman Modal dan Pelayanan Terpadu Satu Pintu (PTSP)',	'2479223000',	'1914730676',	'0000-00-00 00:00:00'),
(2019,	'0',	'2.13.1.1',	'Dinas Pemuda dan Olah Raga',	'2181868480',	'1237545000',	'0000-00-00 00:00:00'),
(2019,	'0',	'2.17.1.1',	'Dinas Perpustakaan dan Kearsipan',	'2556045340',	'1058894150',	'0000-00-00 00:00:00'),
(2019,	'0',	'3.2.1.1',	'Dinas Pariwisata',	'3368227860',	'11334770653',	'0000-00-00 00:00:00'),
(2019,	'0',	'3.3.1.1',	'Dinas Pertanian dan Perikanan',	'17193378000',	'33537528312',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.3.1',	'Bagian Umum',	'14895782500',	'19551788259',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.3.2',	'Bagian Administrasi Perekonomian',	'0',	'853174250',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.3.3',	'Bagian Administrasi Pemerintahan Umum',	'0',	'943307500',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.3.4',	'Bagian Administrasi Pembangunan',	'0',	'745960500',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.3.5',	'Bagian Administrasi Kesejahteraan Rakyat dan Kemasyarakatan',	'0',	'8939516650',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.3.6',	'Bagian Administrasi Sumber Daya Alam',	'0',	'429852300',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.3.7',	'Bagian Hukum',	'0',	'679541250',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.3.8',	'Bagian Organisasi',	'0',	'1162357500',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.3.9',	'Bagian Humas dan Protokol',	'0',	'3714612020',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.3.10',	'Bagian Layanan Pengadaan',	'0',	'593757300',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.4.1',	'Sekretariat DPRD',	'26875712960',	'18797950000',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.9.1',	'Kecamatan Jenangan',	'2419209000',	'1752764108',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.10.1',	'Kecamatan Ngrayun',	'1343102000',	'682396765',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.11.1',	'Kecamatan Babadan',	'2969596000',	'2529894360',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.12.1',	'Kecamatan Jetis',	'1422158000',	'696097972',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.13.1',	'Kecamatan Mlarak',	'1468403000',	'648706083',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.14.1',	'Kecamatan Sawoo',	'1449981000',	'675257435',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.15.1',	'Kecamatan Balong',	'1544053000',	'672433888',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.16.1',	'Kecamatan Sambit',	'1540611000',	'605504511',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.17.1',	'Kecamatan Kauman',	'1503802000',	'796053622',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.18.1',	'Kecamatan Ngebel',	'1354519000',	'595609745',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.19.1',	'Kecamatan Sooko',	'1450096000',	'527423441',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.20.1',	'Kecamatan Badegan',	'1586971000',	'527770102',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.21.1',	'Kecamatan Pulung',	'1347469000',	'693357290',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.22.1',	'Kecamatan Ponorogo',	'11166835000',	'11791871728',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.23.1',	'Kecamatan Slahung',	'1272688000',	'674321702',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.24.1',	'Kecamatan Siman',	'2331659000',	'1644016860',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.25.1',	'Kecamatan Sampung',	'1543527000',	'546713278',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.26.1',	'Kecamatan Jambon',	'1307877000',	'705712007',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.27.1',	'Kecamatan Pudak',	'1382423000',	'506997654',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.28.1',	'Kecamatan Bungkal',	'1494867000',	'715737842',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.1.29.1',	'Kecamatan Sukorejo',	'1297629000',	'621644219',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.2.1.1',	'Inspektorat',	'3029156760',	'2678700000',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.3.1.1',	'Badan Perencanaan Pembangunan Daerah, Penelitian dan Pengembangan',	'3476178800',	'8842849000',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.4.5.1',	'Badan Pendapatan, Pengelolaan Keuangan  dan Aset Daerah (BPPKAD) - SKPD',	'565720996891',	'22287011271',	'0000-00-00 00:00:00'),
(2019,	'0',	'4.5.1.1',	'Badan Kepegawaian, Pendidikan dan Pelatihan Daerah',	'3594087910',	'7064341856',	'0000-00-00 00:00:00');

DROP TABLE IF EXISTS `table_idsatker_sirup`;
CREATE TABLE `table_idsatker_sirup` (
  `kd_skpd` varchar(65) NOT NULL,
  `id_satker` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `table_idsatker_sirup` (`kd_skpd`, `id_satker`) VALUES
('1.1.1.1',	83006),
('1.2.1.1',	83007),
('1.2.2.1',	83008),
('1.3.1.1',	108918),
('1.4.1.1',	108919),
('1.5.1.1',	108997),
('1.5.2.1',	108989),
('1.5.3.1',	108925),
('1.6.1.1',	108920),
('2.1.1.1',	108921),
('2.3.1.1',	108922),
('2.5.1.1',	108923),
('2.6.1.1',	108965),
('2.7.1.1',	109001),
('2.8.1.1',	109005),
('2.9.1.1',	109021),
('2.10.1.1',	152137),
('2.11.1.1',	109004),
('2.12.1.1',	109030),
('2.13.1.1',	109031),
('2.17.1.1',	108926),
('3.2.1.1',	108944),
('3.3.1.1',	108924),
('4.1.3.1',	108998),
('4.1.3.2',	108994),
('4.1.3.3',	108990),
('4.1.3.4',	108948),
('4.1.3.5',	108959),
('4.1.3.6',	109017),
('4.1.3.7',	109002),
('4.1.3.8',	109022),
('4.1.3.9',	108930),
('4.1.3.10',	109032),
('4.1.4.1',	108980),
('4.1.9.1',	109006),
('4.1.10.1',	108993),
('4.1.11.1',	108957),
('4.1.12.1',	108991),
('4.1.13.1',	108995),
('4.1.14.1',	108954),
('4.1.15.1',	108979),
('4.1.16.1',	109011),
('4.1.17.1',	108988),
('4.1.18.1',	108999),
('4.1.19.1',	108958),
('4.1.20.1',	109012),
('4.1.21.1',	108987),
('4.1.22.1',	108966),
('4.1.23.1',	108985),
('4.1.24.1',	108962),
('4.1.25.1',	109013),
('4.1.26.1',	108992),
('4.1.27.1',	109015),
('4.1.28.1',	109014),
('4.1.29.1',	109018),
('4.2.1.1',	109023),
('4.3.1.1',	109010),
('4.4.5.1',	108964),
('4.5.1.1',	155934);

DROP TABLE IF EXISTS `tbl_misc`;
CREATE TABLE `tbl_misc` (
  `slug` varchar(65) NOT NULL,
  `engine` text,
  `tanggal_buat` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `tanggal_update` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tbl_misc` (`slug`, `engine`, `tanggal_buat`, `tanggal_update`) VALUES
('info_privasi',	'a:1:{i:0;a:4:{s:9:\"nama_kota\";s:18:\"Kabupaten Ponorogo\";s:10:\"nama_admin\";s:23:\"LPSE Kabupaten Ponorogo\";s:9:\"url_admin\";s:33:\"https://lpse.ponorogo.go.id/eproc\";s:10:\"kode_sirup\";s:4:\"D196\";}}',	'2019-07-30 01:22:19',	'2019-07-30 01:22:19'),
('kontak_kami',	'a:1:{i:0;a:4:{s:9:\"kontak_wa\";s:62:\"Budi : 081249390505, Danang : 08118111426, Bima : 081336192134\";s:11:\"kontak_telp\";s:13:\"(0352) 481482\";s:5:\"email\";s:25:\"adbang.ponorogo@gmail.com\";s:6:\"alamat\";s:125:\"Gedung Graha Krida Praja lt. 3, Jl. Aloon-Aloon Utara no, 9, Mangkujayan, Kec. Ponorogo, Kabupaten Ponorogo, Jawa Timur 63413\";}}',	'2019-07-30 01:22:35',	'2019-07-30 01:22:35'),
('tentang_kami',	'a:1:{i:0;a:1:{s:11:\"description\";s:905:\"<p style=\"text-align:center\"><span style=\"font-size:36px\"><strong>SIP SPSE!</strong></span></p>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:12px\"><strong>SIP SPSE!&nbsp;</strong>adalah Aplikasi E-Reporting yang memberikan informasi tentang progres pengadaan barang/jasa Pemerintah Kabupaten Ponorogo. Informasi yang diberikan berupa progres dan data paket tender, non-tender, e-katalog dan informasi rekanan. Tujuan dari Aplikasi ini yaitu :</span></p>\r\n\r\n<ol>\r\n	<li style=\"text-align: justify;\"><span style=\"font-size:12px\">Memberikan informasi pengadaan barang/jasa pemerintah.</span></li>\r\n	<li style=\"text-align: justify;\"><span style=\"font-size:12px\">Memudahkan Masyarakat dan OPD untuk melihat data dan progres pengadaan.</span></li>\r\n	<li style=\"text-align: justify;\"><span style=\"font-size:12px\">Memberikan sarana yang mudah dan fleksibel dalam memantau pengadaan.</span></li>\r\n</ol>\r\n\";}}',	'2019-07-30 01:22:40',	'2019-07-30 01:22:40');

DROP TABLE IF EXISTS `tbl_pkt_epurchasing`;
CREATE TABLE `tbl_pkt_epurchasing` (
  `tahun` varchar(4) NOT NULL DEFAULT '2019',
  `no_paket` varchar(255) NOT NULL,
  `nama_komoditas` varchar(255) DEFAULT NULL,
  `nama_paket` varchar(255) DEFAULT NULL,
  `rup_id` varchar(255) DEFAULT NULL,
  `nama_sumber_dana` varchar(255) DEFAULT NULL,
  `kode_anggaran` varchar(255) DEFAULT NULL,
  `jenis_instansi` varchar(255) DEFAULT NULL,
  `nama_instansi` varchar(255) DEFAULT NULL,
  `satuan_kerja_nama` varchar(255) DEFAULT NULL,
  `satuan_kerja_alamat` varchar(255) DEFAULT NULL,
  `satuan_kerja_npwp` varchar(255) DEFAULT NULL,
  `tanggal_buat_paket` varchar(255) DEFAULT NULL,
  `tanggal_edit_paket` varchar(255) DEFAULT NULL,
  `nama_pembuat_paket` varchar(255) DEFAULT NULL,
  `no_telp_pembuat_paket` varchar(255) DEFAULT NULL,
  `email_pembuat_paket` varchar(255) DEFAULT NULL,
  `nama_ppk` varchar(255) DEFAULT NULL,
  `jabatan_ppk` varchar(255) DEFAULT NULL,
  `ppk_nip` varchar(255) DEFAULT NULL,
  `nama_penyedia` varchar(255) DEFAULT NULL,
  `alamat_penyedia` varchar(255) DEFAULT NULL,
  `email_penyedia` varchar(255) DEFAULT NULL,
  `no_telp_penyedia` varchar(255) DEFAULT NULL,
  `nama_distributor` varchar(255) DEFAULT NULL,
  `alamat_distributor` varchar(255) DEFAULT NULL,
  `email_distributor` varchar(255) DEFAULT NULL,
  `no_telp_distributor` varchar(255) DEFAULT NULL,
  `jml_jenis_produk` varchar(255) DEFAULT NULL,
  `total` varchar(255) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '0',
  `tanggal_buat` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tbl_pkt_penyedia`;
CREATE TABLE `tbl_pkt_penyedia` (
  `tahun` varchar(4) NOT NULL,
  `id_satker` varchar(10) NOT NULL,
  `nama_satker` varchar(255) NOT NULL,
  `id` varchar(10) NOT NULL,
  `namaprogram` varchar(255) DEFAULT NULL,
  `kegiatan` varchar(255) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `lokasi_pekerjaan` varchar(255) DEFAULT NULL,
  `jenis_belanja_str` varchar(200) DEFAULT NULL,
  `jenis_pengadaan_str` varchar(120) DEFAULT NULL,
  `volume` varchar(255) DEFAULT NULL,
  `motode_str` varchar(200) DEFAULT NULL,
  `tanggal_awal_pengadaan` varchar(20) DEFAULT NULL,
  `tanggal_akhir_pengadaan` varchar(20) DEFAULT NULL,
  `tanggal_awal_pekerjaan` varchar(20) DEFAULT NULL,
  `tanggal_akhir_pekerjaan` varchar(20) DEFAULT NULL,
  `sumber_dana_string` varchar(255) DEFAULT NULL,
  `mak` varchar(255) DEFAULT NULL,
  `pagu_mak` varchar(255) DEFAULT NULL,
  `create_time` varchar(255) NOT NULL,
  `status` enum('0','1','2') NOT NULL DEFAULT '0' COMMENT '''0=Belum'',''1=Sedang'',''2=Sudah''',
  `status_admin` enum('0','1','2') NOT NULL COMMENT '''0=Belum'',''1=Sedang'',''2=Sudah''',
  `total_pagu` varchar(20) DEFAULT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  `id_swakelola` varchar(10) DEFAULT NULL,
  `tgl_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tbl_pkt_penyedia_belum`;
CREATE TABLE `tbl_pkt_penyedia_belum` (
  `tahun` varchar(4) NOT NULL,
  `id_satker` varchar(10) NOT NULL,
  `nama_satker` varchar(255) NOT NULL,
  `id` varchar(10) NOT NULL,
  `namaprogram` varchar(255) DEFAULT NULL,
  `kegiatan` varchar(255) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `lokasi` varchar(255) DEFAULT NULL,
  `jenis_belanja_str` varchar(200) DEFAULT NULL,
  `jenis_pengadaan_str` varchar(120) DEFAULT NULL,
  `volume` varchar(255) DEFAULT NULL,
  `motode_str` varchar(200) DEFAULT NULL,
  `tanggal_awal_pengadaan` varchar(20) DEFAULT NULL,
  `tanggal_akhir_pengadaan` varchar(20) DEFAULT NULL,
  `tanggal_awal_pekerjaan` varchar(20) DEFAULT NULL,
  `tanggal_akhir_pekerjaan` varchar(20) DEFAULT NULL,
  `sumber_dana_string` varchar(255) DEFAULT NULL,
  `mak` varchar(255) DEFAULT NULL,
  `pagu` varchar(255) DEFAULT NULL,
  `status` enum('0','1','2') DEFAULT '0' COMMENT '''0=Belum'',''1=Sedang'',''2=Sedah''',
  `total_pagu` varchar(20) DEFAULT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  `id_swakelola` varchar(10) DEFAULT NULL,
  `tgl_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tbl_pkt_sirup`;
CREATE TABLE `tbl_pkt_sirup` (
  `tahun` varchar(25) DEFAULT NULL,
  `id_rup` varchar(65) DEFAULT NULL,
  `id_swakelola` varchar(65) DEFAULT NULL,
  `id_satker` varchar(65) DEFAULT NULL,
  `nama_satker` text,
  `id_program` varchar(65) DEFAULT NULL,
  `nama_program` text,
  `kode_kegiatan` text,
  `id_kegiatan` varchar(65) DEFAULT NULL,
  `nama_kegiatan` text,
  `kode_mak` text,
  `pagu_mak` text,
  `nama_paket` text,
  `volume_paket` text,
  `jenis_pengadaan` text,
  `jenis_pengadaan_str` text,
  `lokasi_pekerjaan` text,
  `deskripsi` text,
  `lokasi` text,
  `total_pagu` text,
  `sumber_dana` text,
  `sumber_dana_str` text,
  `asal_dana` text,
  `asal_dana_satker` text,
  `status_tkdn` text,
  `status_pradipa` text,
  `umumkan_paket` text,
  `jenis_belanja` text,
  `jenis_belanja_str` text,
  `metode_pemilihan_penyedia` text,
  `metode_pemilihan_str` text,
  `tanggal_pemilihan_awal` varchar(25) DEFAULT NULL,
  `tanggal_pemilihan_akhir` varchar(25) DEFAULT NULL,
  `tanggal_kontrak_awal` varchar(25) DEFAULT NULL,
  `tanggal_kontrak_akhir` varchar(25) DEFAULT NULL,
  `tanggal_buat` varchar(25) DEFAULT NULL,
  `tanggal_update` varchar(25) DEFAULT NULL,
  `is_aktif` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tbl_pkt_swakelola`;
CREATE TABLE `tbl_pkt_swakelola` (
  `tahun` varchar(4) NOT NULL,
  `id_satker` varchar(10) NOT NULL,
  `nama_satker` varchar(255) NOT NULL,
  `id` varchar(10) NOT NULL,
  `namaprogram` varchar(255) DEFAULT NULL,
  `nama_paket` varchar(255) DEFAULT NULL,
  `lokasi_pekerjaan` varchar(255) DEFAULT NULL,
  `tanggal_awal_pekerjaan` varchar(20) DEFAULT NULL,
  `tanggal_akhir_pekerjaan` varchar(20) DEFAULT NULL,
  `sumber_dana_string` varchar(255) DEFAULT NULL,
  `create_time` varchar(255) DEFAULT NULL,
  `total_pagu` varchar(20) DEFAULT NULL,
  `di_umumkan` varchar(255) DEFAULT NULL,
  `status` enum('0','1','2') NOT NULL DEFAULT '0',
  `tgl_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tbl_pkt_swakelola_belum`;
CREATE TABLE `tbl_pkt_swakelola_belum` (
  `tahun` varchar(4) NOT NULL,
  `id_satker` varchar(10) NOT NULL,
  `nama_satker` varchar(255) NOT NULL,
  `id` varchar(10) NOT NULL,
  `namaprogram` varchar(255) DEFAULT NULL,
  `kegiatan` varchar(255) DEFAULT NULL,
  `lokasi` varchar(255) DEFAULT NULL,
  `tanggal_awal_pekerjaan` varchar(20) DEFAULT NULL,
  `tanggal_akhir_pekerjaan` varchar(20) DEFAULT NULL,
  `sumber_dana_string` varchar(255) DEFAULT NULL,
  `total_pagu` varchar(20) DEFAULT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  `status` enum('0','1','2') NOT NULL DEFAULT '0',
  `tgl_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tbl_temporary`;
CREATE TABLE `tbl_temporary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` varchar(65) NOT NULL,
  `status` varchar(65) DEFAULT NULL,
  `kode` varchar(65) DEFAULT NULL,
  `ip_address` varchar(65) DEFAULT NULL,
  `keterangan` text,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tbl_users`;
CREATE TABLE `tbl_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` text,
  `email` varchar(65) DEFAULT NULL,
  `username` varchar(65) DEFAULT NULL,
  `password` varchar(65) DEFAULT NULL,
  `kd_skpd` varchar(25) DEFAULT NULL,
  `nip` varchar(18) DEFAULT NULL,
  `security_quest` int(1) DEFAULT NULL,
  `security_answer` text,
  `tanggal_buat` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tanggal_update` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tbl_users` (`id`, `nama`, `email`, `username`, `password`, `kd_skpd`, `nip`, `security_quest`, `security_answer`, `tanggal_buat`, `tanggal_update`) VALUES
(1,	'ADMINISTRATOR',	'adbang.ponorogo@gmail.com',	'admin_sip',	'$2y$10$hVuNB6mdKy2m8F3BQNRB4e5J9xCKVt.7ko7l.AZad0Om14s5z47Pa',	'4.1.3.4',	'123456789012345678',	1,	'administrator',	'2019-08-02 02:07:07',	'2019-08-02 09:07:07');

DROP TABLE IF EXISTS `rekap_apbd`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `rekap_apbd` AS select `a`.`tahun` AS `tahun`,(case when (`a`.`id_satker` > 0) then `a`.`id_satker` else `b`.`id_satker` end) AS `id_satker`,`a`.`kd_skpd` AS `kd_skpd`,`a`.`nama_satker` AS `nama_satker`,`a`.`pg_btl` AS `btl`,`a`.`pg_bl` AS `bl`,(`a`.`pg_btl` + `a`.`pg_bl`) AS `jml_pagu` from (`table_apbd` `a` join `table_idsatker_sirup` `b` on((`a`.`kd_skpd` = `b`.`kd_skpd`)));

DROP TABLE IF EXISTS `rekap_penyedia`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `rekap_penyedia` AS select `tbl_pkt_penyedia`.`tahun` AS `tahun`,`tbl_pkt_penyedia`.`id_satker` AS `id_satker`,`tbl_pkt_penyedia`.`nama_satker` AS `nama_satker`,count(`tbl_pkt_penyedia`.`id`) AS `jml_pkt`,sum(`tbl_pkt_penyedia`.`total_pagu`) AS `jml_pagu` from `tbl_pkt_penyedia` group by `tbl_pkt_penyedia`.`id_satker`,`tbl_pkt_penyedia`.`nama_satker`;

DROP TABLE IF EXISTS `rekap_penyedia_belum`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `rekap_penyedia_belum` AS select `tbl_pkt_penyedia_belum`.`tahun` AS `tahun`,`tbl_pkt_penyedia_belum`.`id_satker` AS `id_satker`,`tbl_pkt_penyedia_belum`.`nama_satker` AS `nama_satker`,count(`tbl_pkt_penyedia_belum`.`id`) AS `jml_pkt`,sum(`tbl_pkt_penyedia_belum`.`total_pagu`) AS `jml_pagu` from `tbl_pkt_penyedia_belum` group by `tbl_pkt_penyedia_belum`.`id_satker`,`tbl_pkt_penyedia_belum`.`nama_satker`;

DROP TABLE IF EXISTS `rekap_penyedia_tepra`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `rekap_penyedia_tepra` AS select `tbl_pkt_penyedia`.`tahun` AS `tahun`,(sum((case when (`tbl_pkt_penyedia`.`total_pagu` < 200000000) then `tbl_pkt_penyedia`.`total_pagu` else 0 end)) / 1000000) AS `pg_kur_200`,count((case when (`tbl_pkt_penyedia`.`total_pagu` < 200000000) then 1 end)) AS `pkt_kur_200`,(sum((case when (`tbl_pkt_penyedia`.`total_pagu` between 200000000 and 2500000000) then `tbl_pkt_penyedia`.`total_pagu` else 0 end)) / 1000000) AS `pg_kur_25`,count((case when (`tbl_pkt_penyedia`.`total_pagu` between 200000000 and 2500000000) then 1 end)) AS `pkt_kur_25`,(sum((case when (`tbl_pkt_penyedia`.`total_pagu` between 2500000000 and 50000000000) then `tbl_pkt_penyedia`.`total_pagu` else 0 end)) / 1000000) AS `pg_kur_50`,count((case when (`tbl_pkt_penyedia`.`total_pagu` between 2500000000 and 50000000000) then 1 end)) AS `pkt_kur_50`,(sum((case when (`tbl_pkt_penyedia`.`total_pagu` between 50000000000 and 100000000000) then `tbl_pkt_penyedia`.`total_pagu` else 0 end)) / 1000000) AS `pg_kur_100`,count((case when (`tbl_pkt_penyedia`.`total_pagu` between 50000000000 and 100000000000) then 1 end)) AS `pkt_kur_100`,(sum((case when (`tbl_pkt_penyedia`.`total_pagu` > 100000000000) then `tbl_pkt_penyedia`.`total_pagu` else 0 end)) / 1000000) AS `pg_bih_100`,count((case when (`tbl_pkt_penyedia`.`total_pagu` > 100000000000) then 1 end)) AS `pkt_bih_100`,count(`tbl_pkt_penyedia`.`id`) AS `jumlah_paket`,(sum(`tbl_pkt_penyedia`.`total_pagu`) / 1000000) AS `total_pagu` from `tbl_pkt_penyedia` group by `tbl_pkt_penyedia`.`tahun`;

DROP TABLE IF EXISTS `rekap_swakelola`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `rekap_swakelola` AS select `tbl_pkt_swakelola`.`tahun` AS `tahun`,`tbl_pkt_swakelola`.`id_satker` AS `id_satker`,`tbl_pkt_swakelola`.`nama_satker` AS `nama_satker`,count(`tbl_pkt_swakelola`.`id`) AS `jml_pkt`,sum(`tbl_pkt_swakelola`.`total_pagu`) AS `jml_pagu` from `tbl_pkt_swakelola` group by `tbl_pkt_swakelola`.`id_satker`,`tbl_pkt_swakelola`.`nama_satker`;

DROP TABLE IF EXISTS `rekap_swakelola_belum`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `rekap_swakelola_belum` AS select `tbl_pkt_swakelola_belum`.`tahun` AS `tahun`,`tbl_pkt_swakelola_belum`.`id_satker` AS `id_satker`,`tbl_pkt_swakelola_belum`.`nama_satker` AS `nama_satker`,count(`tbl_pkt_swakelola_belum`.`id`) AS `jml_pkt`,sum(`tbl_pkt_swakelola_belum`.`total_pagu`) AS `jml_pagu` from `tbl_pkt_swakelola_belum` group by `tbl_pkt_swakelola_belum`.`id_satker`,`tbl_pkt_swakelola_belum`.`nama_satker`;

DROP TABLE IF EXISTS `rekap_swakelola_tepra`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `rekap_swakelola_tepra` AS select `tbl_pkt_swakelola`.`tahun` AS `tahun`,(sum(`tbl_pkt_swakelola`.`total_pagu`) / 1000000) AS `pg_swa`,count(`tbl_pkt_swakelola`.`id`) AS `pkt_swa` from `tbl_pkt_swakelola` group by `tbl_pkt_swakelola`.`tahun`;

-- 2019-08-08 05:52:25
