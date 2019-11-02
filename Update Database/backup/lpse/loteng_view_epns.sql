--\connect epns_prod;

-- TABEL VIEW narno_semua 01 --

CREATE OR REPLACE VIEW narno_semua AS 
SELECT DISTINCT lls.lls_id,
CASE
WHEN lls.mtd_pemilihan = 0::numeric THEN 'e-Lelang Umum'::text
WHEN lls.mtd_pemilihan = 1::numeric THEN 'e-Lelang Sederhana'::text
WHEN lls.mtd_pemilihan = 2::numeric THEN 'e-Lelang Pemilihan Langsung'::text
WHEN lls.mtd_pemilihan = 3::numeric THEN 'e-Seleksi Umum'::text
WHEN lls.mtd_pemilihan = 4::numeric THEN 'e-Seleksi Sederhana'::text
WHEN lls.mtd_pemilihan = 9::numeric THEN 'e-Lelang Cepat'::text
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
FROM lelang_seleksi lls,
paket pkt,
satuan_kerja stk,
panitia pnt,
paket_satker pa,
agency agc
WHERE pa.pkt_id=pkt.pkt_id 
AND lls.pkt_id = pkt.pkt_id 
AND agc.agc_id = pnt.agc_id 
AND lls.lls_status = 1::numeric 
AND stk.stk_id = pnt.stk_id 
AND pnt.pnt_id = pkt.pnt_id
ORDER BY (date_part('year'::text, pkt.pkt_tgl_buat)) DESC;
ALTER TABLE narno_semua OWNER TO epns;

-- TABEL VIEW narno_menang 02 --

CREATE OR REPLACE VIEW narno_menang AS 
SELECT DISTINCT lls.lls_id,
ang.sbd_id AS sbd_ket,
CASE
WHEN lls.mtd_pemilihan = 0::numeric THEN 'e-Lelang Umum'::text
WHEN lls.mtd_pemilihan = 1::numeric THEN 'e-Lelang Sederhana'::text
WHEN lls.mtd_pemilihan = 2::numeric THEN 'e-Lelang Pemilihan Langsung'::text
WHEN lls.mtd_pemilihan = 3::numeric THEN 'e-Seleksi Umum'::text
WHEN lls.mtd_pemilihan = 4::numeric THEN 'e-Seleksi Sederhana'::text
WHEN lls.mtd_pemilihan = 9::numeric THEN 'e-Lelang Cepat'::text
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
END AS harga_terkoreksi
FROM lelang_seleksi lls,
paket pkt,
evaluasi eva,
nilai_evaluasi nev,
peserta pst,
rekanan rkn,
panitia pnt,
satuan_kerja stk,
paket_anggaran pa,
anggaran ang,
kabupaten kbp,
propinsi prp,
agency agc
WHERE pnt.pnt_id = pkt.pnt_id 
AND agc.agc_id = pnt.agc_id 
AND date_part('year'::text, lls.lls_tgl_setuju) > 0::double precision 
AND kbp.prp_id = prp.prp_id 
AND rkn.kbp_id = kbp.kbp_id 
AND pa.pkt_id = pkt.pkt_id 
AND pa.ang_id = ang.ang_id 
AND lls.pkt_id = pkt.pkt_id 
AND eva.lls_id = lls.lls_id 
AND ang.stk_id = stk.stk_id 
AND nev.eva_id = eva.eva_id 
AND pst.psr_id = nev.psr_id 
AND pst.rkn_id = rkn.rkn_id 
AND (eva.eva_id IN ( SELECT evaluasi_1.eva_id
   FROM evaluasi evaluasi_1
   WHERE ((evaluasi_1.lls_id, evaluasi_1.eva_versi) IN ( SELECT evaluasi_2.lls_id,
    max(evaluasi_2.eva_versi) AS max
    FROM evaluasi evaluasi_2
    GROUP BY evaluasi_2.lls_id)) AND evaluasi_1.eva_jenis = 4::numeric
   ORDER BY evaluasi_1.lls_id)) AND eva.eva_jenis = 4::numeric AND lls.lls_status = 1::numeric AND nev.nev_lulus = 1::numeric
ORDER BY lls.lls_id DESC;
ALTER TABLE narno_menang
OWNER TO epns;

-- TABEL VIEW narno_rup 03 --

CREATE OR REPLACE VIEW public.narno_rup AS
 SELECT lls.lls_id,
        CASE
            WHEN pa.rup_id > 0::numeric THEN pa.rup_id
            WHEN pa.rup_id < 0::numeric THEN pkt.rup_id
            ELSE pkt.rup_id
        END AS rup_id
   FROM lelang_seleksi lls,
    paket pkt,
    satuan_kerja stk,
    panitia pnt,
    paket_satker pa,
    agency agc
  WHERE pa.pkt_id = pkt.pkt_id AND lls.pkt_id = pkt.pkt_id AND agc.agc_id = pnt.agc_id AND lls.lls_status = 1::numeric AND stk.stk_id = pnt.stk_id AND pnt.pnt_id = pkt.pnt_id
  ORDER BY (date_part('year'::text, pkt.pkt_tgl_buat)) DESC;

ALTER TABLE public.narno_rup
    OWNER TO epns;

-- TABEL VIEW rasio_rkn_daftar 04 --

CREATE OR REPLACE VIEW public.rasio_rkn_daftar AS
SELECT b.rkn_nama,
count(b.rkn_id) AS daftar
FROM peserta a
LEFT JOIN rekanan b ON a.rkn_id = b.rkn_id
GROUP BY b.rkn_nama
ORDER BY count(b.rkn_id) DESC;
ALTER TABLE public.rasio_rkn_daftar OWNER TO epns;

-- TABEL VIEW rasio_rkn_nawar 05 --

CREATE OR REPLACE VIEW public.rasio_rkn_nawar AS
SELECT count(dok_penawaran.dok_id) AS tawar,
peserta.rkn_id,
rekanan.rkn_nama
FROM peserta,
dok_penawaran,
rekanan
WHERE peserta.rkn_id = rekanan.rkn_id 
AND dok_penawaran.psr_id = peserta.psr_id 
AND dok_penawaran.dok_disclaim = 1::numeric
GROUP BY peserta.rkn_id, rekanan.rkn_nama
ORDER BY count(dok_penawaran.dok_id) DESC;
ALTER TABLE public.rasio_rkn_nawar OWNER TO epns;

-- TABEL VIEW rasio_rkn_daftar_nawar 06 --

CREATE OR REPLACE VIEW public.rasio_rkn_daftar_nawar AS
SELECT a.rkn_nama,
a.daftar,
b.tawar
FROM rasio_rkn_daftar a
LEFT JOIN rasio_rkn_nawar b ON a.rkn_nama = b.rkn_nama;
ALTER TABLE public.rasio_rkn_daftar_nawar OWNER TO epns;

-- TABEL VIEW rasio_rkn_menang 07 --

CREATE OR REPLACE VIEW public.rasio_rkn_menang AS
SELECT narno_menang.rkn_nama,
count(narno_menang.rkn_nama) AS menang
FROM narno_menang
GROUP BY narno_menang.rkn_nama
ORDER BY count(narno_menang.rkn_nama) DESC;
ALTER TABLE public.rasio_rkn_menang OWNER TO epns;

-- TABEL VIEW status_lelang 08 --

CREATE OR REPLACE VIEW status_lelang AS 
SELECT DISTINCT lls.lls_id,
CASE
WHEN lls.mtd_pemilihan = 0::numeric THEN 'e-Lelang Umum'::text
WHEN lls.mtd_pemilihan = 1::numeric THEN 'e-Lelang Sederhana'::text
WHEN lls.mtd_pemilihan = 2::numeric THEN 'e-Lelang Pemilihan Langsung'::text
WHEN lls.mtd_pemilihan = 3::numeric THEN 'e-Seleksi Umum'::text
WHEN lls.mtd_pemilihan = 4::numeric THEN 'e-Seleksi Sederhana'::text
WHEN lls.mtd_pemilihan = 9::numeric THEN 'e-Lelang Cepat'::text
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
FROM lelang_seleksi lls,
paket pkt,
satuan_kerja stk,
panitia pnt,
agency agc
WHERE lls.pkt_id = pkt.pkt_id 
AND agc.agc_id = pnt.agc_id 
AND lls.lls_status > 0::numeric 
AND stk.stk_id = pnt.stk_id 
AND pnt.pnt_id = pkt.pnt_id
ORDER BY (date_part('year'::text, pkt.pkt_tgl_buat)) DESC;
ALTER TABLE status_lelang OWNER TO epns;

-- TABEL VIEW narno_peserta 09 --

CREATE OR REPLACE VIEW public.narno_peserta AS
SELECT l.lls_id,
count(p.psr_id) AS jml_peserta
FROM peserta p,
lelang_seleksi l
WHERE l.lls_id = p.lls_id
GROUP BY l.lls_id;
ALTER TABLE public.narno_peserta OWNER TO epns;

-- TABEL VIEW narno_dokpen 10 --

CREATE OR REPLACE VIEW public.narno_dokpen AS
SELECT a.psr_id,
count(a.dok_id) AS jumlah
FROM dok_penawaran a
WHERE (a.dok_jenis = 2::numeric OR a.dok_jenis = 3::numeric) 
AND a.dok_disclaim = 1::numeric
GROUP BY a.psr_id
ORDER BY a.psr_id DESC;
ALTER TABLE public.narno_dokpen OWNER TO epns;

-- TABEL VIEW narno_nawar 11 --

CREATE OR REPLACE VIEW public.narno_nawar AS
SELECT DISTINCT l.lls_id,
count(d.psr_id) AS jml_rkn_nawar
FROM peserta p,
lelang_seleksi l,
narno_dokpen d
WHERE l.lls_id = p.lls_id AND d.psr_id = p.psr_id
GROUP BY l.lls_id
ORDER BY l.lls_id DESC;
ALTER TABLE public.narno_nawar OWNER TO epns;

-- TABEL VIEW narno_kualifikasi 12 --

CREATE OR REPLACE VIEW public.narno_kualifikasi AS
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
FROM rekanan r
LEFT JOIN ijin_usaha i ON r.rkn_id = i.rkn_id
LEFT JOIN bentuk_usaha b ON r.btu_id = b.btu_id
LEFT JOIN kabupaten k ON k.kbp_id = r.kbp_id
LEFT JOIN propinsi p ON p.prp_id = k.prp_id
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
ALTER TABLE public.narno_kualifikasi OWNER TO epns;

-- TABEL VIEW narno_rekap 13 --

CREATE OR REPLACE VIEW public.narno_rekap AS
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
WHEN c.mtd_pemilihan = 9::numeric THEN 'e-Lelang Cepat'::text
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
FROM peserta a,
dok_penawaran b,
lelang_seleksi c,
paket d,
rekanan e,
satuan_kerja f,
kabupaten g,
anggaran i,
paket_anggaran j
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
ALTER TABLE public.narno_rekap OWNER TO epns;

-- TABEL VIEW narno_pl_semua 14 --

CREATE OR REPLACE VIEW public.narno_pl_semua AS
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
    satuan_kerja stk
  WHERE lls.pkt_id = pkt.pkt_id AND ps.pkt_id = pkt.pkt_id AND lls.lls_status = 1::numeric AND stk.stk_id = ps.stk_id
  ORDER BY (date_part('year'::text, pkt.pkt_tgl_buat)) DESC;
ALTER TABLE narno_pl_semua OWNER TO epns;

-- TABEL VIEW narno_pl_menang 15 --

CREATE OR REPLACE VIEW public.narno_pl_menang AS
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
satuan_kerja stk,
rekanan rkn,
ekontrak.peserta_nonlelang pst,
ekontrak.evaluasi eva,
ekontrak.nilai_evaluasi nev,
propinsi prp,
kabupaten kbp,
ekontrak.paket_anggaran pa,
anggaran ang
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
ALTER TABLE narno_pl_menang OWNER TO epns;

-- TABEL VIEW narno_pl_rup 16 --

CREATE OR REPLACE VIEW public.narno_pl_rup AS
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

ALTER TABLE public.narno_pl_rup OWNER TO epns;

-- TABEL VIEW narno_rekanan 17 --

CREATE OR REPLACE VIEW public.narno_rekanan AS
SELECT r.rkn_id,
r.kbp_id,
r.rkn_nama,
r.rkn_npwp,
r.rkn_email,
r.rkn_tgl_setuju,
r.rkn_status,
date_part('year'::text, r.rkn_tgl_daftar) AS tahun,
r.kota
FROM rekanan r
ORDER BY r.rkn_nama;
ALTER TABLE public.narno_rekanan OWNER TO epns;



