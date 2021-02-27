-- dump n restore epns_prod windows:
-- # pg_dump -Fc -U postgres -d epns_prod > epns_prod_13-09-2019.backup.gz
-- # su - postgres -c "psql"
-- # CREATE DATABASE epns_prod;
-- # CREATE USER epns WITH PASSWORD 'epns';
-- # \q	
-- # pg_restore -vc --if-exists -U postgres -j 8 -d epns_prod epns_prod_13-09-2019.backup
-- # psql -U postgres -d epns_prod -f data.sip.sql

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6
-- Dumped by pg_dump version 10.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: sip; Type: SCHEMA; Schema: -; Owner: epns
--

CREATE SCHEMA IF NOT EXISTS sip;

ALTER SCHEMA sip OWNER TO epns;
ALTER SCHEMA public OWNER TO epns;
ALTER SCHEMA ekontrak OWNER TO epns;

--
-- Name: table_apbd; Type: TABLE; Schema: sip; Owner: epns
--

CREATE TABLE IF NOT EXISTS sip.table_apbd(
    tahun numeric(4,0) DEFAULT 2019 NOT NULL,
    id_satker character varying(65) DEFAULT '0'::character varying NOT NULL,
    kd_skpd character varying(25) NOT NULL,
    nama_satker text DEFAULT NULL,
    pg_btl character varying(25) NOT NULL,
    pg_bl character varying(25) NOT NULL,
    tanggal_buat timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE sip.table_apbd OWNER TO epns;

--
-- Name: table_idsatker_sirup; Type: TABLE; Schema: sip; Owner: epns
--

CREATE TABLE IF NOT EXISTS sip.table_idsatker_sirup(
    kd_skpd character varying(65) NOT NULL,
    id_satker integer
);

ALTER TABLE sip.table_idsatker_sirup OWNER TO epns;

--
-- Name: tbl_misc; Type: TABLE; Schema: sip; Owner: epns
--

CREATE TABLE IF NOT EXISTS sip.tbl_misc(
    slug character varying(65) NOT NULL,
    engine text,
    tanggal_buat timestamp without time zone DEFAULT now() NOT NULL,
    tanggal_update timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE sip.tbl_misc OWNER TO epns;
CREATE UNIQUE INDEX IF NOT EXISTS tbl_misc_slug_unique ON sip.tbl_misc USING btree (slug);

--
-- Name: tbl_pkt_epurchasing; Type: TABLE; Schema: sip; Owner: epns
--

CREATE TABLE IF NOT EXISTS sip.tbl_pkt_epurchasing(
    tahun numeric(4,0) DEFAULT 2019 NOT NULL,
    no_paket character varying(255) NOT NULL,
    nama_komoditas text DEFAULT NULL,
    nama_paket text DEFAULT NULL,
    rup_id character varying(255) DEFAULT NULL,
    nama_sumber_dana text DEFAULT NULL,
    kode_anggaran character varying(255) DEFAULT NULL,
    jenis_instansi character varying(255) DEFAULT NULL,
		nama_instansi text DEFAULT NULL,
		satuan_kerja_nama text DEFAULT NULL,
		satuan_kerja_alamat text DEFAULT NULL,
		satuan_kerja_npwp character varying(255) DEFAULT NULL,
		tanggal_buat_paket character varying(255) DEFAULT NULL,
		tanggal_edit_paket character varying(255) DEFAULT NULL,
		nama_pembuat_paket text DEFAULT NULL,
		no_telp_pembuat_paket character varying(255) DEFAULT NULL,
		email_pembuat_paket character varying(255) DEFAULT NULL,
		nama_ppk text DEFAULT NULL,
		jabatan_ppk character varying(255) DEFAULT NULL,
		ppk_nip character varying(255) DEFAULT NULL,
		nama_penyedia text DEFAULT NULL,
		alamat_penyedia text DEFAULT NULL,
		email_penyedia character varying(255) DEFAULT NULL,
		no_telp_penyedia character varying(255) DEFAULT NULL,
		nama_distributor text DEFAULT NULL,
		alamat_distributor text DEFAULT NULL,
		email_distributor character varying(255) DEFAULT NULL,
		no_telp_distributor character varying(255) DEFAULT NULL,
		jml_jenis_produk character varying(255) DEFAULT NULL,
		total character varying(255) DEFAULT NULL,
		status numeric(1,0) DEFAULT 0 NOT NULL,
		tanggal_buat timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE sip.tbl_pkt_epurchasing OWNER TO epns;

--
-- Name: tbl_pkt_penyedia; Type: TABLE; Schema: sip; Owner: epns
--

CREATE TABLE IF NOT EXISTS sip.tbl_pkt_penyedia
(
    tahun numeric(4,0) NOT NULL DEFAULT 2019,
    id_satker character varying(10) COLLATE pg_catalog."default" NOT NULL,
    nama_satker text DEFAULT NULL,
    id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    namaprogram text DEFAULT NULL,
    kegiatan text DEFAULT NULL,
    nama text DEFAULT NULL,
    lokasi_pekerjaan text DEFAULT NULL,
    jenis_belanja_str character varying(200) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    jenis_pengadaan_str character varying(120) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    volume character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    motode_str character varying(200) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    tanggal_awal_pengadaan character varying(20) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    tanggal_akhir_pengadaan character varying(20) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    tanggal_awal_pekerjaan character varying(20) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    tanggal_akhir_pekerjaan character varying(20) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    sumber_dana_string text COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    mak text COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    pagu_mak text COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    create_time character varying(255) COLLATE pg_catalog."default" NOT NULL,
    status numeric(1,0) NOT NULL DEFAULT 0,
    status_admin numeric(1,0),
    total_pagu character varying(20) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    deskripsi text DEFAULT NULL,
    id_swakelola character varying(10) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    tgl_update timestamp without time zone NOT NULL DEFAULT now()
);

ALTER TABLE sip.tbl_pkt_penyedia OWNER TO epns;

--
-- Name: tbl_pkt_penyedia_belum; Type: TABLE; Schema: sip; Owner: epns
--

CREATE TABLE IF NOT EXISTS sip.tbl_pkt_penyedia_belum(
		tahun character varying(4) NOT NULL,
		id_satker character varying(10) NOT NULL,
		nama_satker text DEFAULT NULL,
		id character varying(10) NOT NULL,
		namaprogram text DEFAULT NULL,
		kegiatan text DEFAULT NULL,
		nama text DEFAULT NULL,
		lokasi text DEFAULT NULL,
		jenis_belanja_str character varying(200) DEFAULT NULL,
		jenis_pengadaan_str character varying(120) DEFAULT NULL,
		volume character varying(255) DEFAULT NULL,
		motode_str character varying(200) DEFAULT NULL,
		tanggal_awal_pengadaan character varying(20) DEFAULT NULL,
		tanggal_akhir_pengadaan character varying(20) DEFAULT NULL,
		tanggal_awal_pekerjaan character varying(20) DEFAULT NULL,
		tanggal_akhir_pekerjaan character varying(20) DEFAULT NULL,
		sumber_dana_string text DEFAULT NULL,
		mak text DEFAULT NULL,
		pagu text DEFAULT NULL,
		status numeric(1,0) DEFAULT 0 NOT NULL,
		total_pagu character varying(20) DEFAULT NULL,
		deskripsi text DEFAULT NULL,
		id_swakelola character varying(10) DEFAULT NULL,
		tgl_update timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE sip.tbl_pkt_penyedia_belum OWNER TO epns;

--
-- Name: tbl_pkt_sirup; Type: TABLE; Schema: sip; Owner: epns
--

CREATE TABLE IF NOT EXISTS sip.tbl_pkt_sirup(
		tahun character varying(25) DEFAULT NULL,
		id_rup character varying(65) DEFAULT NULL,
		id_swakelola character varying(65) DEFAULT NULL,
		id_satker character varying(65) DEFAULT NULL,
		nama_satker text DEFAULT NULL,
		id_program character varying(65) DEFAULT NULL,
		nama_program text DEFAULT NULL,
		kode_kegiatan character varying(255) DEFAULT NULL,
		id_kegiatan character varying(65) DEFAULT NULL,
		nama_kegiatan text DEFAULT NULL,
		kode_mak text DEFAULT NULL,
		pagu_mak text DEFAULT NULL,
		nama_paket text DEFAULT NULL,
		volume_paket text DEFAULT NULL,
		jenis_pengadaan text DEFAULT NULL,
		jenis_pengadaan_str text DEFAULT NULL,
		lokasi_pekerjaan text DEFAULT NULL,
		deskripsi text DEFAULT NULL,
		lokasi text DEFAULT NULL,
		total_pagu text DEFAULT NULL,
		sumber_dana text DEFAULT NULL,
		sumber_dana_str text DEFAULT NULL,
		asal_dana text DEFAULT NULL,
		asal_dana_satker text DEFAULT NULL,
		status_tkdn text DEFAULT NULL,
		status_pradipa text DEFAULT NULL,
		umumkan_paket text DEFAULT NULL,
		jenis_belanja text DEFAULT NULL,
		jenis_belanja_str text DEFAULT NULL,
		metode_pemilihan_penyedia text DEFAULT NULL,
		metode_pemilihan_str text DEFAULT NULL,
		tanggal_pemilihan_awal character varying(25) DEFAULT NULL,
		tanggal_pemilihan_akhir character varying(25) DEFAULT NULL,
		tanggal_kontrak_awal character varying(25) DEFAULT NULL,
		tanggal_kontrak_akhir character varying(25) DEFAULT NULL,
		tanggal_buat character varying(25) DEFAULT NULL,
		tanggal_update character varying(25) DEFAULT NULL,
		is_aktif character varying(25) DEFAULT NULL
);

ALTER TABLE sip.tbl_pkt_sirup OWNER TO epns;

--
-- Name: tbl_pkt_swakelola; Type: TABLE; Schema: sip; Owner: epns
--

CREATE TABLE IF NOT EXISTS sip.tbl_pkt_swakelola(
		tahun character varying(25) DEFAULT NULL,
		id_satker character varying(10) NOT NULL,
		nama_satker character varying(255) NOT NULL,
		id character varying(10) NOT NULL,
		namaprogram text DEFAULT NULL,
		nama_paket text DEFAULT NULL,
		lokasi_pekerjaan text DEFAULT NULL,
		tanggal_awal_pekerjaan character varying(20) DEFAULT NULL,
		tanggal_akhir_pekerjaan character varying(20) DEFAULT NULL,
		sumber_dana_string text DEFAULT NULL,
		create_time character varying(255) DEFAULT NULL,
		total_pagu text DEFAULT NULL,
		di_umumkan character varying(255) DEFAULT NULL,
		status numeric(1,0) DEFAULT 0 NOT NULL,
		tgl_update timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE sip.tbl_pkt_swakelola OWNER TO epns;

--
-- Name: tbl_pkt_swakelola_belum; Type: TABLE; Schema: sip; Owner: epns
--

CREATE TABLE IF NOT EXISTS sip.tbl_pkt_swakelola_belum(
		tahun character varying(25) DEFAULT NULL,
		id_satker character varying(10) NOT NULL,
		nama_satker text DEFAULT NULL,
		id character varying(10) NOT NULL,
		namaprogram text DEFAULT NULL,
		kegiatan text DEFAULT NULL,
		lokasi text DEFAULT NULL,
		tanggal_awal_pekerjaan character varying(20) DEFAULT NULL,
		tanggal_akhir_pekerjaan character varying(20) DEFAULT NULL,
		sumber_dana_string text DEFAULT NULL,
		total_pagu text DEFAULT NULL,
		deskripsi text DEFAULT NULL,
		status numeric(1,0) DEFAULT 0 NOT NULL,
		tgl_update timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE sip.tbl_pkt_swakelola_belum OWNER TO epns;

--
-- Name: tbl_temporary; Type: TABLE; Schema: sip; Owner: epns
--

CREATE TABLE IF NOT EXISTS sip.tbl_temporary(
		id SERIAL PRIMARY KEY,
		id_user character varying(65) NOT NULL,
		status character varying(65) DEFAULT NULL,
		kode character varying(65) DEFAULT NULL,
		ip_address character varying(65) DEFAULT NULL,
		keterangan text DEFAULT NULL,
		tanggal timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE sip.tbl_temporary OWNER TO epns;

--
-- Name: tbl_users; Type: TABLE; Schema: sip; Owner: epns
--

CREATE TABLE IF NOT EXISTS sip.tbl_users(
		id SERIAL PRIMARY KEY,
		nama text,
		email character varying(65) DEFAULT NULL,
		username character varying(65) DEFAULT NULL,
		password character varying(65) DEFAULT NULL,
		kd_skpd character varying(25) DEFAULT NULL,
		nip character varying(18) DEFAULT NULL,
		security_quest integer DEFAULT NULL,
		security_answer text,
		tanggal_buat timestamp without time zone DEFAULT now() NOT NULL,
		tanggal_update timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE sip.tbl_users OWNER TO epns;

INSERT INTO sip.tbl_users (id, nama, email, username, password, kd_skpd, nip, security_quest, security_answer, tanggal_buat, tanggal_update) VALUES (1,	'ADMINISTRATOR',	'adbang.ponorogo@gmail.com',	'admin_sip',	'$2y$10$hVuNB6mdKy2m8F3BQNRB4e5J9xCKVt.7ko7l.AZad0Om14s5z47Pa',	'4.1.3.4',	123456789012345678,	'1',	'administrator',	'2019-08-02 02:07:07.888',	'2019-08-02 09:07:07.888') ON CONFLICT (id) DO NOTHING;

-- TABEL VIEW rekap_apbd 01 --

CREATE OR REPLACE VIEW sip.rekap_apbd AS
	SELECT
		a.tahun AS tahun,
		CASE
				WHEN a.id_satker::numeric > 0::numeric THEN a.id_satker::numeric
				ELSE b.id_satker::numeric
		END AS id_satker,
		a.kd_skpd AS kd_skpd,
		a.nama_satker AS nama_satker,
		a.pg_btl AS btl,
		a.pg_bl AS bl,
		a.pg_btl::numeric + a.pg_bl::numeric AS jml_pagu
	FROM sip.table_apbd a
	JOIN sip.table_idsatker_sirup b ON a.kd_skpd = b.kd_skpd;

ALTER TABLE sip.rekap_apbd OWNER TO epns;

-- TABEL VIEW rekap_penyedia 02 --

CREATE OR REPLACE VIEW sip.rekap_penyedia AS
	SELECT
		tahun,
		id_satker,
		nama_satker,
		COUNT(id) AS jml_pkt,
		SUM(total_pagu::numeric) AS jml_pagu
	FROM sip.tbl_pkt_penyedia
	GROUP BY id_satker, nama_satker, tahun;

ALTER TABLE sip.rekap_penyedia OWNER TO epns;

-- TABEL VIEW rekap_penyedia_belum 03 --

CREATE OR REPLACE VIEW sip.rekap_penyedia_belum AS
	SELECT
		tahun,
		id_satker,
		nama_satker,
		COUNT(id) AS jml_pkt,
		SUM(total_pagu::numeric) AS jml_pagu
	FROM sip.tbl_pkt_penyedia_belum
	GROUP BY id_satker, nama_satker, tahun;
	
ALTER TABLE sip.rekap_penyedia_belum OWNER TO epns;

-- TABEL VIEW rekap_penyedia_tepra 04 --

CREATE OR REPLACE VIEW sip.rekap_penyedia_tepra AS
	SELECT
		tahun,
		SUM(CASE WHEN total_pagu::numeric < 200000000 THEN total_pagu::numeric ELSE 0 END) / 1000000 AS pg_kur_200,
		COUNT(CASE WHEN total_pagu::numeric < 200000000 THEN 1 END) AS pkt_kur_200,
		SUM(CASE WHEN total_pagu::numeric BETWEEN 200000000 AND 2500000000 THEN total_pagu::numeric ELSE 0 END) / 1000000 AS pg_kur_25,
		COUNT(CASE WHEN total_pagu::numeric BETWEEN 200000000 AND 2500000000 THEN 1 END) AS pkt_kur_25,
		SUM(CASE WHEN total_pagu::numeric BETWEEN 2500000000 AND 50000000000 THEN total_pagu::numeric ELSE 0 END) / 1000000 AS pg_kur_50,
		COUNT(CASE WHEN total_pagu::numeric BETWEEN 2500000000 AND 50000000000 THEN 1 END) AS pkt_kur_50,
		SUM(CASE WHEN total_pagu::numeric BETWEEN 50000000000 AND 100000000000 THEN total_pagu::numeric ELSE 0 END) / 1000000 AS pg_kur_100,
		COUNT(CASE WHEN total_pagu::numeric BETWEEN 50000000000 AND 100000000000 THEN 1 END) AS pkt_kur_100,
		SUM(CASE WHEN total_pagu::numeric > 100000000000 THEN total_pagu::numeric ELSE 0 END) / 1000000 AS pg_bih_100,
		COUNT(CASE WHEN total_pagu::numeric > 100000000000 THEN 1 END) AS pkt_bih_100,
		COUNT(id) AS jumlah_paket,
		SUM(total_pagu::numeric) / 1000000 AS total_pagu
	FROM sip.tbl_pkt_penyedia
	GROUP BY tahun;
	
ALTER TABLE sip.rekap_penyedia_tepra OWNER TO epns;

-- TABEL VIEW rekap_swakelola 05 --

CREATE OR REPLACE VIEW sip.rekap_swakelola AS
	SELECT
		tahun,
		id_satker,
		nama_satker,
		COUNT(id) AS jml_pkt,
		SUM(total_pagu::numeric) AS jml_pagu
	FROM sip.tbl_pkt_swakelola
	GROUP BY id_satker, nama_satker, tahun;
	
ALTER TABLE sip.rekap_swakelola OWNER TO epns;

-- TABEL VIEW rekap_swakelola_belum 06 --

CREATE OR REPLACE VIEW sip.rekap_swakelola_belum AS
	SELECT
		tahun,
		id_satker,
		nama_satker,
		COUNT(id) AS jml_pkt,
		SUM(total_pagu::numeric) AS jml_pagu
	FROM sip.tbl_pkt_swakelola_belum
	GROUP BY id_satker, nama_satker, tahun;
	
ALTER TABLE sip.rekap_swakelola_belum OWNER TO epns;

-- TABEL VIEW rekap_swakelola_tepra 07 --

CREATE OR REPLACE VIEW sip.rekap_swakelola_tepra AS
	SELECT
		tahun,
		SUM(total_pagu::numeric) / 1000000 AS pg_swa,
		COUNT(id) AS pkt_swa
	FROM sip.tbl_pkt_swakelola
	GROUP BY tahun;
	
ALTER TABLE sip.rekap_swakelola_tepra OWNER TO epns;

-- TABEL VIEW narno_semua 01 --

CREATE OR REPLACE VIEW sip.narno_semua AS 
SELECT DISTINCT lls.lls_id,
CASE
WHEN lls.mtd_pemilihan = 0::numeric THEN 'e-Lelang Umum'::text
WHEN lls.mtd_pemilihan = 1::numeric THEN 'e-Lelang Sederhana'::text
WHEN lls.mtd_pemilihan = 2::numeric THEN 'e-Lelang Pemilihan Langsung'::text
WHEN lls.mtd_pemilihan = 3::numeric THEN 'e-Seleksi Umum'::text
WHEN lls.mtd_pemilihan = 4::numeric THEN 'e-Seleksi Sederhana'::text
WHEN lls.mtd_pemilihan = 9::numeric THEN 'Tender Cepat'::text
WHEN lls.mtd_pemilihan = 15::numeric THEN 'Tender'::text
WHEN lls.mtd_pemilihan = 16::numeric THEN 'Seleksi'::text
ELSE 'Belum Kategori'::text
END AS metode,
date_part('year'::text, pkt.pkt_tgl_buat) AS tahun,
date_part('month'::text, pkt.pkt_tgl_buat) AS bulan,
pkt.pkt_id,
pkt.pkt_nama,
pkt.pkt_tgl_buat,
pnt.pnt_nama,
stk.stk_id,
stk.instansi_id,
lls.lls_tgl_setuju,
lls.lls_versi_lelang,
lls.lls_diulang_karena,
lls.lls_ditutup_karena,
lls.lls_status,
agc.agc_id,
agc.agc_nama,
stk.stk_nama,
pkt.pkt_flag,
pkt.pkt_pagu,
CASE
WHEN pkt.pkt_flag = 1::numeric THEN 'SPSE 3.6'::text
WHEN pkt.pkt_flag = 2::numeric THEN 'SPSE 4.2'::text
ELSE 'SPSE 4.3'::text
END AS versi_lelang,
lls.mtd_pemilihan,
pkt.pkt_hps,
CASE
WHEN pkt.kgr_id = 0::numeric THEN 'Pengadaan Barang'::text
WHEN pkt.kgr_id = 1::numeric THEN 'Jasa Konsultansi'::text
WHEN pkt.kgr_id = 2::numeric THEN 'Pekerjaan Konstruksi'::text
WHEN pkt.kgr_id = 3::numeric THEN 'Jasa Lainnya'::text
ELSE 'Jasa Konsultansi Perorangan'::text
END AS kategori,
pkt.kgr_id
FROM public.lelang_seleksi lls,
public.paket pkt,
public.satuan_kerja stk,
public.panitia pnt,
public.paket_satker pa,
public.agency agc
WHERE pa.pkt_id=pkt.pkt_id 
AND lls.pkt_id = pkt.pkt_id 
AND agc.agc_id = pnt.agc_id 
AND lls.lls_status = 1::numeric 
AND stk.stk_id = pa.stk_id 
AND pnt.pnt_id = pkt.pnt_id
ORDER BY (date_part('year'::text, pkt.pkt_tgl_buat)) DESC;

ALTER TABLE sip.narno_semua OWNER TO epns;

-- TABEL VIEW narno_menang 02 --

CREATE OR REPLACE VIEW sip.narno_menang AS 
 SELECT DISTINCT lls.lls_id,
    ang.sbd_id AS sbd_ket,
        CASE
            WHEN lls.mtd_pemilihan = 0::numeric THEN 'e-Lelang Umum'::text
            WHEN lls.mtd_pemilihan = 1::numeric THEN 'e-Lelang Sederhana'::text
            WHEN lls.mtd_pemilihan = 2::numeric THEN 'e-Lelang Pemilihan Langsung'::text
            WHEN lls.mtd_pemilihan = 3::numeric THEN 'e-Seleksi Umum'::text
            WHEN lls.mtd_pemilihan = 4::numeric THEN 'e-Seleksi Sederhana'::text
            WHEN lls.mtd_pemilihan = 9::numeric THEN 'Tender Cepat'::text
            WHEN lls.mtd_pemilihan = 15::numeric THEN 'Tender'::text
            WHEN lls.mtd_pemilihan = 16::numeric THEN 'Seleksi'::text
            ELSE 'Belum Kategori'::text
        END AS metode,
    lls.mtd_pemilihan,
        CASE
            WHEN pkt.kgr_id = 0::numeric THEN 'Pengadaan Barang'::text
            WHEN pkt.kgr_id = 1::numeric THEN 'Jasa Konsultansi'::text
            WHEN pkt.kgr_id = 2::numeric THEN 'Pekerjaan Konstruksi'::text
            WHEN pkt.kgr_id = 3::numeric THEN 'Jasa Lainnya'::text
            ELSE 'Jasa Konsultansi Perorangan'::text
        END AS kategori,
    pkt.kgr_id,
    date_part('year'::text, pkt.pkt_tgl_buat) AS tahun,
    date_part('month'::text, pkt.pkt_tgl_buat) AS bulan,
    ang.ang_tahun,
    rkn.rkn_nama,
    rkn.rkn_npwp,
    pst.psr_harga,
    kbp.kbp_id,
    kbp.kbp_nama,
    prp.prp_id,
    prp.prp_nama,
    pkt.pkt_pagu,
    pkt.pkt_hps,
    agc.agc_id,
    pkt.pkt_flag,
    nev.nev_harga,
        CASE
            WHEN nev.nev_harga_terkoreksi = 0::numeric THEN pst.psr_harga
            WHEN nev.nev_harga = 0::numeric THEN pst.psr_harga_terkoreksi
            WHEN pst.psr_harga_terkoreksi > nev.nev_harga THEN nev.nev_harga
            WHEN nev.nev_harga = 0::numeric THEN pst.psr_harga
            WHEN pst.psr_harga > nev.nev_harga THEN nev.nev_harga
            WHEN pst.psr_harga_terkoreksi > pst.psr_harga THEN pst.psr_harga_terkoreksi
            WHEN pst.psr_harga_terkoreksi = pst.psr_harga THEN pst.psr_harga
            WHEN pst.psr_harga_terkoreksi = 0::numeric OR nev.nev_harga = 0::numeric THEN pst.psr_harga
            WHEN pst.psr_harga = nev.nev_harga_terkoreksi THEN nev.nev_harga_terkoreksi
            WHEN nev.nev_harga_terkoreksi = 0::numeric THEN nev.nev_harga
            ELSE nev.nev_harga
        END AS harga_terkoreksi,
				CASE
						WHEN iu.kls_id = '21'::bpchar THEN 'Perusahaan Kecil'::text
						WHEN iu.kls_id = '22'::bpchar THEN 'Perusahaan Non Kecil'::text
						WHEN iu.kls_id = '23'::bpchar THEN 'Gabungan'::text
						ELSE 'Belum Pilih Kualifikasi'::text
				END AS kualifikasi
   FROM public.lelang_seleksi lls
   JOIN public.paket pkt ON lls.pkt_id = pkt.pkt_id
   JOIN public.paket_anggaran pa ON pa.pkt_id = pkt.pkt_id
   JOIN public.evaluasi eva ON eva.lls_id = lls.lls_id
   JOIN public.nilai_evaluasi nev ON nev.eva_id = eva.eva_id
   JOIN public.peserta pst ON pst.psr_id = nev.psr_id
   JOIN public.rekanan rkn ON pst.rkn_id = rkn.rkn_id
   JOIN public.panitia pnt ON pnt.pnt_id = pkt.pnt_id
	 JOIN public.agency agc ON agc.agc_id = pnt.agc_id
   JOIN public.anggaran ang ON pa.ang_id = ang.ang_id
   JOIN public.satuan_kerja stk ON ang.stk_id = stk.stk_id
   JOIN public.kabupaten kbp ON rkn.kbp_id = kbp.kbp_id
   JOIN public.propinsi prp ON kbp.prp_id = prp.prp_id
	 LEFT JOIN public.ijin_usaha iu ON rkn.rkn_id = iu.rkn_id AND pkt.kls_id = iu.kls_id
  WHERE date_part('year'::text, lls.lls_tgl_setuju) > 0::double precision AND (eva.eva_id IN ( SELECT evaluasi_1.eva_id
           FROM public.evaluasi evaluasi_1
          WHERE ((evaluasi_1.lls_id, evaluasi_1.eva_versi) IN ( SELECT evaluasi_2.lls_id,
                    max(evaluasi_2.eva_versi) AS max
                   FROM public.evaluasi evaluasi_2
                  GROUP BY evaluasi_2.lls_id)) AND evaluasi_1.eva_jenis = 4::numeric
          ORDER BY evaluasi_1.lls_id)) AND eva.eva_jenis = 4::numeric AND lls.lls_status = 1::numeric AND nev.nev_lulus = 1::numeric
  ORDER BY lls.lls_id DESC;

ALTER TABLE sip.narno_menang OWNER TO epns;

-- TABEL VIEW narno_rup 03 --

CREATE OR REPLACE VIEW sip.narno_rup AS
 SELECT lls.lls_id,
        CASE
            WHEN pa.rup_id > 0::numeric THEN pa.rup_id
            WHEN pa.rup_id < 0::numeric THEN pkt.rup_id
            ELSE pkt.rup_id
        END AS rup_id
   FROM public.lelang_seleksi lls,
    public.paket pkt,
    public.satuan_kerja stk,
    public.panitia pnt,
    public.paket_satker pa,
    public.agency agc
  WHERE pa.pkt_id = pkt.pkt_id AND lls.pkt_id = pkt.pkt_id AND agc.agc_id = pnt.agc_id AND lls.lls_status = 1::numeric AND stk.stk_id = pnt.stk_id AND pnt.pnt_id = pkt.pnt_id
  ORDER BY (date_part('year'::text, pkt.pkt_tgl_buat)) DESC;

ALTER TABLE sip.narno_rup OWNER TO epns;

-- TABEL VIEW rasio_rkn_daftar 04 --

CREATE OR REPLACE VIEW sip.rasio_rkn_daftar AS
SELECT b.rkn_nama,
count(b.rkn_id) AS daftar
FROM public.peserta a
LEFT JOIN public.rekanan b ON a.rkn_id = b.rkn_id
GROUP BY b.rkn_nama
ORDER BY count(b.rkn_id) DESC;

ALTER TABLE sip.rasio_rkn_daftar OWNER TO epns;

-- TABEL VIEW rasio_rkn_nawar 05 --

CREATE OR REPLACE VIEW sip.rasio_rkn_nawar AS
SELECT count(dok_penawaran.dok_id) AS tawar,
peserta.rkn_id,
rekanan.rkn_nama
FROM public.peserta,
public.dok_penawaran,
public.rekanan
WHERE peserta.rkn_id = rekanan.rkn_id 
AND dok_penawaran.psr_id = peserta.psr_id 
AND dok_penawaran.dok_disclaim = 1::numeric
GROUP BY peserta.rkn_id, rekanan.rkn_nama
ORDER BY count(dok_penawaran.dok_id) DESC;

ALTER TABLE sip.rasio_rkn_nawar OWNER TO epns;

-- TABEL VIEW rasio_rkn_daftar_nawar 06 --

CREATE OR REPLACE VIEW sip.rasio_rkn_daftar_nawar AS
SELECT a.rkn_nama,
a.daftar,
b.tawar
FROM sip.rasio_rkn_daftar a
LEFT JOIN sip.rasio_rkn_nawar b ON a.rkn_nama = b.rkn_nama;

ALTER TABLE sip.rasio_rkn_daftar_nawar OWNER TO epns;

-- TABEL VIEW rasio_rkn_menang 07 --

CREATE OR REPLACE VIEW sip.rasio_rkn_menang AS
SELECT narno_menang.rkn_nama,
count(narno_menang.rkn_nama) AS menang
FROM sip.narno_menang
GROUP BY narno_menang.rkn_nama
ORDER BY count(narno_menang.rkn_nama) DESC;

ALTER TABLE sip.rasio_rkn_menang OWNER TO epns;

-- TABEL VIEW status_lelang 08 --

CREATE OR REPLACE VIEW sip.status_lelang AS 
SELECT DISTINCT lls.lls_id,
CASE
WHEN lls.mtd_pemilihan = 0::numeric THEN 'e-Lelang Umum'::text
WHEN lls.mtd_pemilihan = 1::numeric THEN 'e-Lelang Sederhana'::text
WHEN lls.mtd_pemilihan = 2::numeric THEN 'e-Lelang Pemilihan Langsung'::text
WHEN lls.mtd_pemilihan = 3::numeric THEN 'e-Seleksi Umum'::text
WHEN lls.mtd_pemilihan = 4::numeric THEN 'e-Seleksi Sederhana'::text
WHEN lls.mtd_pemilihan = 9::numeric THEN 'Tender Cepat'::text
WHEN lls.mtd_pemilihan = 15::numeric THEN 'Tender'::text
WHEN lls.mtd_pemilihan = 16::numeric THEN 'Seleksi'::text
ELSE 'Belum Kategori'::text
END AS metode,
date_part('year'::text, pkt.pkt_tgl_buat) AS tahun,
date_part('month'::text, pkt.pkt_tgl_buat) AS bulan,
pkt.pkt_nama,
pkt.pkt_tgl_buat,
agc.agc_nama,
agc.agc_id,
pnt.pnt_nama,
stk.stk_id,
stk.instansi_id,
lls.lls_versi_lelang,
lls.lls_diulang_karena,
lls.lls_ditutup_karena,
lls.lls_status,
CASE
WHEN pkt.pkt_flag = 1::numeric THEN 'SPSE 3.6'::text
WHEN pkt.pkt_flag = 2::numeric THEN 'SPSE 4.2'::text
ELSE 'SPSE 4.3'::text
END AS versi_lelang,
stk.stk_nama,
pkt.pkt_pagu,
pkt.pkt_hps,
CASE
WHEN pkt.kgr_id = 0::numeric THEN 'Pengadaan Barang'::text
WHEN pkt.kgr_id = 1::numeric THEN 'Jasa Konsultansi'::text
WHEN pkt.kgr_id = 2::numeric THEN 'Pekerjaan Konstruksi'::text
WHEN pkt.kgr_id = 3::numeric THEN 'Jasa Lainnya'::text
ELSE 'J.Konsultansi P.Org'::text
END AS kategori,
pkt.kgr_id

FROM public.lelang_seleksi lls,
public.paket pkt,
public.satuan_kerja stk,
public.panitia pnt,
public.paket_satker pa,
public.agency agc

WHERE pa.pkt_id=pkt.pkt_id
AND lls.pkt_id = pkt.pkt_id 
AND agc.agc_id = pnt.agc_id 
AND lls.lls_status > 0::numeric 
AND stk.stk_id = pa.stk_id 
AND pnt.pnt_id = pkt.pnt_id

ORDER BY (date_part('year'::text, pkt.pkt_tgl_buat)) DESC;

ALTER TABLE sip.status_lelang OWNER TO epns;

-- TABEL VIEW narno_peserta 09 --

CREATE OR REPLACE VIEW sip.narno_peserta AS
SELECT l.lls_id,
count(p.psr_id) AS jml_peserta
FROM public.peserta p,
public.lelang_seleksi l
WHERE l.lls_id = p.lls_id
GROUP BY l.lls_id;

ALTER TABLE sip.narno_peserta OWNER TO epns;

-- TABEL VIEW narno_dokpen 10 --

CREATE OR REPLACE VIEW sip.narno_dokpen AS
SELECT a.psr_id,
count(a.dok_id) AS jumlah
FROM public.dok_penawaran a
WHERE (a.dok_jenis = 2::numeric OR a.dok_jenis = 3::numeric) 
AND a.dok_disclaim = 1::numeric
GROUP BY a.psr_id
ORDER BY a.psr_id DESC;

ALTER TABLE sip.narno_dokpen OWNER TO epns;

-- TABEL VIEW narno_nawar 11 --

CREATE OR REPLACE VIEW sip.narno_nawar AS
SELECT DISTINCT l.lls_id,
count(d.psr_id) AS jml_rkn_nawar
FROM public.peserta p,
public.lelang_seleksi l,
sip.narno_dokpen d
WHERE l.lls_id = p.lls_id AND d.psr_id = p.psr_id
GROUP BY l.lls_id
ORDER BY l.lls_id DESC;
ALTER TABLE sip.narno_nawar OWNER TO epns;

-- TABEL VIEW narno_kualifikasi 12 --

CREATE OR REPLACE VIEW sip.narno_kualifikasi AS
SELECT p.prp_id,
p.prp_nama,
k.kbp_id,
k.kbp_nama,
r.repo_id,
r.rkn_id,
r.rkn_nama,
date_part('year'::text, r.rkn_tgl_daftar) AS tahun,
r.btu_id,
b.btu_nama,
r.rkn_status_verifikasi,
CASE
WHEN i.kls_id = '21'::bpchar THEN 'Perusahaan Kecil'::text
WHEN i.kls_id = '22'::bpchar THEN 'Perusahaan Non Kecil'::text
WHEN i.kls_id = '23'::bpchar THEN 'Gabungan'::text
ELSE 'Belum Pilih Kualifikasi'::text
END AS kualifikasi,
CASE
WHEN i.kls_id = '21'::bpchar THEN 1::bigint
WHEN i.kls_id = '22'::bpchar THEN 1::bigint
WHEN i.kls_id = '23'::bpchar THEN 1::bigint
ELSE 1::bigint
END AS kode_kualifikasi
FROM public.rekanan r
LEFT JOIN public.ijin_usaha i ON r.rkn_id = i.rkn_id
LEFT JOIN public.bentuk_usaha b ON r.btu_id = b.btu_id
LEFT JOIN public.kabupaten k ON k.kbp_id = r.kbp_id
LEFT JOIN public.propinsi p ON p.prp_id = k.prp_id
WHERE r.rkn_status_verifikasi::text = '1111111'::text OR r.rkn_status_verifikasi::text = '1111'::text
GROUP BY r.rkn_nama, 
i.kls_id, 
r.rkn_id, 
date_part('year'::text, r.rkn_tgl_daftar),
b.btu_nama, 
r.btu_id, 
r.rkn_status_verifikasi, 
p.prp_id, 
p.prp_nama, 
k.kbp_id, 
k.kbp_nama, 
r.repo_id
ORDER BY r.rkn_nama;
ALTER TABLE sip.narno_kualifikasi OWNER TO epns;

-- TABEL VIEW narno_rekap 13 --

CREATE OR REPLACE VIEW sip.narno_rekap AS
SELECT date_part('year'::text, d.pkt_tgl_buat) AS tahun,
CASE
WHEN date_part('month'::text, d.pkt_tgl_buat) = 1::double precision THEN 'Jan'::text
WHEN date_part('month'::text, d.pkt_tgl_buat) = 2::double precision THEN 'Feb'::text
WHEN date_part('month'::text, d.pkt_tgl_buat) = 3::double precision THEN 'Mar'::text
WHEN date_part('month'::text, d.pkt_tgl_buat) = 4::double precision THEN 'Apr'::text
WHEN date_part('month'::text, d.pkt_tgl_buat) = 5::double precision THEN 'Mei'::text
WHEN date_part('month'::text, d.pkt_tgl_buat) = 6::double precision THEN 'Jun'::text
WHEN date_part('month'::text, d.pkt_tgl_buat) = 7::double precision THEN 'Jul'::text
WHEN date_part('month'::text, d.pkt_tgl_buat) = 8::double precision THEN 'Ags'::text
WHEN date_part('month'::text, d.pkt_tgl_buat) = 9::double precision THEN 'Sep'::text
WHEN date_part('month'::text, d.pkt_tgl_buat) = 10::double precision THEN 'Okt'::text
WHEN date_part('month'::text, d.pkt_tgl_buat) = 11::double precision THEN 'Nov'::text
ELSE 'Des'::text
END AS bulan,
c.lls_id,
f.stk_nama,
f.instansi_id,
d.pkt_nama,
d.pkt_hps,
e.rkn_nama,
a.psr_harga,
e.rkn_alamat,
g.kbp_nama,
b.dok_tgljam,
CASE
WHEN a.is_pemenang = 1::numeric THEN 'Pemenang'::text
ELSE ''::text
END AS status,
d.pkt_hps - a.psr_harga AS efisiensi,
CASE
WHEN c.mtd_pemilihan = 0::numeric THEN 'e-Lelang Umum'::text
WHEN c.mtd_pemilihan = 1::numeric THEN 'e-Lelang Sederhana'::text
WHEN c.mtd_pemilihan = 2::numeric THEN 'e-Lelang Pemilihan Langsung'::text
WHEN c.mtd_pemilihan = 3::numeric THEN 'e-Seleksi Umum'::text
WHEN c.mtd_pemilihan = 4::numeric THEN 'e-Seleksi Sederhana'::text
WHEN c.mtd_pemilihan = 9::numeric THEN 'Tender Cepat'::text
WHEN c.mtd_pemilihan = 15::numeric THEN 'Tender'::text
WHEN c.mtd_pemilihan = 16::numeric THEN 'Seleksi'::text
ELSE 'Belum Kategori'::text
END AS metode,
CASE
WHEN d.kgr_id = 0::numeric THEN 'Pengadaan Barang'::text
WHEN d.kgr_id = 1::numeric THEN 'Jasa Konsultansi'::text
WHEN d.kgr_id = 2::numeric THEN 'Pekerjaan Konstruksi'::text
WHEN d.kgr_id = 3::numeric THEN 'Jasa Lainnya'::text
ELSE 'Jasa Konsultansi Perorangan'::text
END AS kategori,
i.sbd_id
FROM public.peserta a,
public.dok_penawaran b,
public.lelang_seleksi c,
public.paket d,
public.rekanan e,
public.satuan_kerja f,
public.kabupaten g,
public.anggaran i,
public.paket_anggaran j
WHERE (b.dok_jenis = 2::numeric OR b.dok_jenis = 3::numeric) 
AND b.dok_disclaim = 1::numeric 
AND c.pkt_id = d.pkt_id 
AND a.lls_id = c.lls_id 
AND e.rkn_id = a.rkn_id 
AND b.psr_id = a.psr_id 
AND d.stk_id = f.stk_id 
AND f.stk_id = i.stk_id 
AND e.kbp_id = g.kbp_id 
AND j.pkt_id = d.pkt_id 
AND j.ang_id = i.ang_id 
AND a.psr_harga > 0::numeric
ORDER BY c.lls_id DESC, a.psr_harga;

ALTER TABLE sip.narno_rekap OWNER TO epns;

-- TABEL VIEW narno_pl_semua 14 --

CREATE OR REPLACE VIEW sip.narno_pl_semua AS
 SELECT DISTINCT lls.lls_id,
    date_part('year'::text, pkt.pkt_tgl_buat) AS tahun,
    date_part('month'::text, pkt.pkt_tgl_buat) AS bulan,
    pkt.pkt_nama,
    ps.stk_id,
    stk.stk_nama,
    stk.instansi_id,
    pkt.pkt_tgl_buat,
    lls.lls_versi_lelang,
    lls.mtd_pemilihan,
        CASE
            WHEN lls.mtd_pemilihan = 8::numeric THEN 'Pengadaan Langsung'::text
            WHEN lls.mtd_pemilihan = 11::numeric THEN 'Pengadaan Langsung'::text
            WHEN lls.mtd_pemilihan = 12::numeric THEN 'Penunjukan Langsung'::text
            ELSE 'Pengadaan Langsung'::text
        END AS metoda,
    pkt.pkt_id,
    pkt.pkt_flag,
    pkt.pkt_pagu,
    pkt.pkt_hps,
    pkt.kgr_id,
        CASE
            WHEN pkt.kgr_id = 0::numeric THEN 'Pengadaan Barang'::text
            WHEN pkt.kgr_id = 1::numeric THEN 'Jasa Konsultasi'::text
            WHEN pkt.kgr_id = 2::numeric THEN 'Pekerjaan Konstruksi'::text
            WHEN pkt.kgr_id = 3::numeric THEN 'Jasa Lainnya'::text
            ELSE 'Jasa Konsultasi Perorangan'::text
        END AS kategori
   FROM ekontrak.nonlelang_seleksi lls,
    ekontrak.paket pkt,
    ekontrak.paket_satker ps,
    public.satuan_kerja stk
  WHERE lls.pkt_id = pkt.pkt_id AND ps.pkt_id = pkt.pkt_id AND lls.lls_status = 1::numeric AND stk.stk_id = ps.stk_id
  ORDER BY (date_part('year'::text, pkt.pkt_tgl_buat)) DESC;
	
ALTER TABLE sip.narno_pl_semua OWNER TO epns;

-- TABEL VIEW narno_pl_menang 15 --

CREATE OR REPLACE VIEW sip.narno_pl_menang AS
SELECT lls.lls_id,
date_part('year'::text, pkt.pkt_tgl_buat) AS tahun,
date_part('month'::text, pkt.pkt_tgl_buat) AS bulan,
lls.lls_versi_lelang,
lls.lls_diulang_karena,
lls.lls_ditutup_karena,
lls.lls_status,
pkt.kgr_id,
lls.mtd_pemilihan,
CASE
WHEN lls.mtd_pemilihan = 8::numeric THEN 'Pengadaan Langsung'::text
WHEN lls.mtd_pemilihan = 11::numeric THEN 'Pengadaan Langsung'::text
WHEN lls.mtd_pemilihan = 12::numeric THEN 'Penunjukan Langsung'::text
ELSE 'Pengadaan Langsung'::text
END AS metoda,
pst.psr_harga,
nev.auditupdate,
ang.sbd_id AS sbd_ket,
ang.ang_tahun,
rkn.rkn_nama,
rkn.rkn_npwp,
kbp.kbp_id,
kbp.kbp_nama,
prp.prp_id,
prp.prp_nama,
nev.nev_harga,
CASE
WHEN nev.nev_harga_terkoreksi = 0::numeric THEN pst.psr_harga
WHEN nev.nev_harga = 0::numeric THEN pst.psr_harga_terkoreksi
WHEN pst.psr_harga_terkoreksi > nev.nev_harga THEN nev.nev_harga
WHEN nev.nev_harga = 0::numeric THEN pst.psr_harga
WHEN pst.psr_harga > nev.nev_harga THEN nev.nev_harga
WHEN pst.psr_harga_terkoreksi > pst.psr_harga THEN pst.psr_harga_terkoreksi
WHEN pst.psr_harga_terkoreksi = pst.psr_harga THEN pst.psr_harga
WHEN pst.psr_harga_terkoreksi = 0::numeric OR nev.nev_harga = 0::numeric THEN pst.psr_harga
WHEN pst.psr_harga = nev.nev_harga_terkoreksi THEN nev.nev_harga_terkoreksi
WHEN nev.nev_harga_terkoreksi = 0::numeric THEN nev.nev_harga
ELSE nev.nev_harga
END AS harga_terkoreksi
FROM ekontrak.nonlelang_seleksi lls,
ekontrak.paket pkt,
ekontrak.paket_satker ps,
public.satuan_kerja stk,
public.rekanan rkn,
ekontrak.peserta_nonlelang pst,
ekontrak.evaluasi eva,
ekontrak.nilai_evaluasi nev,
public.propinsi prp,
public.kabupaten kbp,
ekontrak.paket_anggaran pa,
public.anggaran ang
WHERE kbp.prp_id = prp.prp_id 
AND rkn.kbp_id = kbp.kbp_id 
AND pa.pkt_id = pkt.pkt_id 
AND pa.ang_id = ang.ang_id 
AND eva.lls_id = lls.lls_id 
AND nev.eva_id = eva.eva_id 
AND pst.psr_id = nev.psr_id 
AND pst.rkn_id = rkn.rkn_id 
AND pst.psr_harga > 0::numeric 
AND nev.nev_urutan = 1::numeric 
AND lls.pkt_id = pkt.pkt_id 
AND ps.pkt_id = pkt.pkt_id 
AND lls.lls_status = 1::numeric 
AND stk.stk_id = ps.stk_id
GROUP BY lls.lls_id, 
(date_part('year'::text, pkt.pkt_tgl_buat)), 
lls.mtd_pemilihan, 
(date_part('month'::text, pkt.pkt_tgl_buat)), 
nev.auditupdate, 
ang.sbd_id, 
ang.ang_tahun, 
rkn.rkn_nama, 
rkn.rkn_npwp,
pkt.kgr_id, 
pkt.pkt_tgl_buat, 
pst.psr_harga, 
kbp.kbp_id, 
lls.lls_versi_lelang, 
lls.lls_diulang_karena, 
lls.lls_ditutup_karena, 
lls.lls_status, 
kbp.kbp_nama, 
prp.prp_id, 
prp.prp_nama, 
nev.nev_harga, 
(CASE
    WHEN nev.nev_harga_terkoreksi = 0::numeric THEN pst.psr_harga
    WHEN nev.nev_harga = 0::numeric THEN pst.psr_harga_terkoreksi
    WHEN pst.psr_harga_terkoreksi > nev.nev_harga THEN nev.nev_harga
    WHEN nev.nev_harga = 0::numeric THEN pst.psr_harga
    WHEN pst.psr_harga > nev.nev_harga THEN nev.nev_harga
    WHEN pst.psr_harga_terkoreksi > pst.psr_harga THEN pst.psr_harga_terkoreksi
    WHEN pst.psr_harga_terkoreksi = pst.psr_harga THEN pst.psr_harga
    WHEN pst.psr_harga_terkoreksi = 0::numeric OR nev.nev_harga = 0::numeric THEN pst.psr_harga
    WHEN pst.psr_harga = nev.nev_harga_terkoreksi THEN nev.nev_harga_terkoreksi
    WHEN nev.nev_harga_terkoreksi = 0::numeric THEN nev.nev_harga
    ELSE nev.nev_harga
    END), pkt.pkt_nama
ORDER BY lls.lls_id DESC;

ALTER TABLE sip.narno_pl_menang OWNER TO epns;

-- TABEL VIEW narno_pl_rup 16 --

CREATE OR REPLACE VIEW sip.narno_pl_rup AS
 SELECT lls.lls_id,
        CASE
            WHEN ps.rup_id > 0::numeric THEN ps.rup_id
            WHEN ps.rup_id < 0::numeric THEN pkt.rup_id
            ELSE pkt.rup_id
        END AS rup_id
   FROM ekontrak.nonlelang_seleksi lls,
    ekontrak.paket pkt,
    ekontrak.paket_satker ps
  WHERE ps.pkt_id = pkt.pkt_id AND lls.pkt_id = pkt.pkt_id AND lls.lls_status = 1::numeric;

ALTER TABLE sip.narno_pl_rup OWNER TO epns;

-- TABEL VIEW narno_rekanan 17 --

CREATE OR REPLACE VIEW sip.narno_rekanan AS
SELECT r.rkn_id,
r.kbp_id,
r.rkn_nama,
r.rkn_npwp,
r.rkn_email,
r.rkn_tgl_setuju,
r.rkn_status,
date_part('year'::text, r.rkn_tgl_daftar) AS tahun,
r.kota
FROM public.rekanan r
ORDER BY r.rkn_nama;

ALTER TABLE sip.narno_rekanan OWNER TO epns;

-- ----------------------------
-- View structure for danang_klpd
-- ----------------------------

CREATE OR REPLACE VIEW sip.danang_klpd AS
SELECT
	b.id kode_klpd,
	cfg.nama nama_klpd
FROM public.instansi b
JOIN (
	SELECT
		TRIM(SUBSTRING (cfg_value, 6)) nama
	FROM public.configuration
	WHERE
		cfg_sub_category='ppe.nama'
	) cfg
ON
	UPPER(b.nama) LIKE '%' || UPPER(cfg.nama)
	;
	
ALTER TABLE sip.danang_klpd OWNER TO epns;
				
-- ----------------------------
-- View structure for narno_user
-- ----------------------------

CREATE OR REPLACE VIEW sip.narno_user AS
SELECT DISTINCT a.peg_id,
    a.peg_namauser,
    a.passw,
    a.peg_nama,
    a.peg_email,
    e.kpl_unit_pemilihan_id,
        CASE
            WHEN (c.ppk_id IS NOT NULL) THEN 'PPK'::text
            WHEN (b.ukpbj_id IS NOT NULL) THEN 'POKJA'::text
            WHEN (d.pp_id IS NOT NULL) THEN 'PP'::text
            WHEN (((a.peg_namauser)::text = 'PPE'::text) OR ((a.peg_namauser)::text = 'ppe'::text)) THEN 'ADMIN'::text
            WHEN ((a.peg_namauser)::text = '******'::text) THEN 'UKPBJ'::text
            ELSE NULL::text
        END AS user_group
   FROM ((((public.pegawai a
     LEFT JOIN public.pegawai_ukpbj b ON ((b.peg_id = a.peg_id)))
     LEFT JOIN public.ppk c ON ((c.peg_id = a.peg_id)))
     LEFT JOIN ekontrak.pp d ON ((d.peg_id = a.peg_id)))
     LEFT JOIN public.ukpbj e ON ((e.kpl_unit_pemilihan_id = a.peg_id)))
  WHERE ((c.ppk_id IS NOT NULL) OR (b.ukpbj_id IS NOT NULL) OR (d.pp_id IS NOT NULL) OR ((a.peg_namauser)::text = 'PPE'::text) OR ((a.peg_namauser)::text = '******'::text))
  ORDER BY
        CASE
            WHEN (c.ppk_id IS NOT NULL) THEN 'PPK'::text
            WHEN (b.ukpbj_id IS NOT NULL) THEN 'POKJA'::text
            WHEN (d.pp_id IS NOT NULL) THEN 'PP'::text
            WHEN (((a.peg_namauser)::text = 'PPE'::text) OR ((a.peg_namauser)::text = 'ppe'::text)) THEN 'ADMIN'::text
            WHEN ((a.peg_namauser)::text = '******'::text) THEN 'UKPBJ'::text 
            ELSE NULL::text
        END;
-- ****** = User ID Kepala UKPBJ
				
ALTER TABLE sip.narno_user OWNER TO epns;
				
--
-- PostgreSQL database dump complete
--
