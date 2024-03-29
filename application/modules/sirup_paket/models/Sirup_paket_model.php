<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Sirup_paket_model extends CI_Model {

    public function __construct()
    {
        $this->local_db = $this->load->database('default', TRUE);
        $this->pg_db = $this->load->database('pg_database', TRUE);
    }


    // ****************************************
    // ||
    // || GLOBAL FUNCTION
    // ||
    // ****************************************

    public function get_repo(){
        $this->pg_db->select("cfg_value");
        $this->pg_db->from("configuration");
        $this->pg_db->where("cfg_sub_category", "ppe.id");
        $result = $this->pg_db->get();
        $data = '';
        foreach ($result->result() as $rows) {
            $data = $rows->cfg_value;
        }
        return $data;
    }

    public function get_provinsi(){
        $this->pg_db->select("DISTINCT(a.prp_id) prp_id, a.prp_nama");
        $this->pg_db->from("propinsi a");
        $this->pg_db->join("kabupaten b", "a.prp_id = b.prp_id");
        $this->pg_db->join("agency c", "b.kbp_id = c.kbp_id");
        $this->pg_db->limit(1);
        $result = $this->pg_db->get();
        $data = '';
        foreach ($result->result() as $rows) {
            $data = array('id_provinsi' => $rows->prp_id, 'nama_provinsi' => $rows->prp_nama);
        }
        return $data;
    }

    public function get_kabupaten(){
        $this->pg_db->select("DISTINCT(b.kbp_id) kbp_id, b.kbp_nama");
        $this->pg_db->from("propinsi a");
        $this->pg_db->join("kabupaten b", "a.prp_id = b.prp_id");
        $this->pg_db->join("agency c", "b.kbp_id = c.kbp_id");
        $this->pg_db->limit(1);
        $result = $this->pg_db->get();
        $data = '';
        foreach ($result->result() as $rows) {
            $data = $rows->kbp_id;
        }
        return $data;
    }

    public function get_agency(){
        $this->pg_db->select("agc_id, agc_nama");
        $this->pg_db->from("agency");
        $this->pg_db->order_by("agc_id", "ASC");
        $data = $this->pg_db->get();
        return $data;
    }

    public function get_total_pagu_apbd($tahun){
        $this->local_db->select("SUM(btl) AS btl, SUM(bl) AS bl");
        $this->local_db->from("sip.rekap_apbd");
        if ($tahun != 'all') {
            $this->local_db->where("tahun", $tahun);
        }
        $result = $this->local_db->get();
        $data = '';
        foreach ($result->result() as $rows) {
            $data = array('pagu_btl' => $rows->btl, 'pagu_bl' => $rows->bl);
        }
        return $data;
    }

    public function get_total_opd($tahun){
        $this->local_db->select("COUNT(id_satker) AS total_opd");
        $this->local_db->from("sip.rekap_apbd");
        if ($tahun != 'all') {
            $this->local_db->where("tahun", $tahun);
        }
        $result = $this->local_db->get();
        $data = '';
        foreach ($result->result() as $rows) {
            $data = array('total_opd' => $rows->total_opd);
        }
        return $data;
    }



    // ****************************************
    // ||
    // || APP FUNCTION
    // ||
    // ****************************************

    public function statistik_rekap($tahun){
        $this->local_db->select("
            COUNT(
                    CASE
                        WHEN jenis_pengadaan_str IN ('Barang','Jasa Lainnya','Pekerjaan Konstruksi','Jasa Konsultansi') AND total_pagu::NUMERIC < 50000000 THEN id
                    END
                ) AS pencatatan_non_tender,
            (
                COUNT(
                        CASE
                            WHEN jenis_pengadaan_str IN ('Barang','Jasa Lainnya','Pekerjaan Konstruksi') AND total_pagu::NUMERIC BETWEEN 50000000 AND 200000000 THEN id
                        END
                    )
                        +
                COUNT(
                        CASE
                            WHEN jenis_pengadaan_str IN ('Jasa Konsultansi') AND total_pagu::NUMERIC BETWEEN 50000000 AND 100000000 THEN id
                        END
                    )
            ) AS non_tender,
            COUNT(
                    CASE
                        WHEN motode_str = 'Tender' THEN motode_str
                    END
                ) AS tender,
            COUNT(
                    CASE
                        WHEN motode_str = 'Seleksi' THEN motode_str
                    END
                ) AS seleksi 
        ");
        $this->local_db->from("sip.tbl_pkt_penyedia");
        if ($tahun != 'all') {
            $this->local_db->where("tahun", $tahun+0);
        }
        $data = $this->local_db->get();
        return $data;
    }


    public function rekapitulasi_paket_opd($tahun){
        $this->local_db->select("
            nama_satker,
            COUNT(
                    CASE
                        WHEN jenis_pengadaan_str IN ('Barang','Jasa Lainnya','Pekerjaan Konstruksi','Jasa Konsultansi') AND total_pagu::NUMERIC < 50000000 THEN id
                    END
                ) AS pencatatan_non_tender,
            (
                COUNT(
                        CASE
                            WHEN jenis_pengadaan_str IN ('Barang','Jasa Lainnya','Pekerjaan Konstruksi') AND total_pagu::NUMERIC BETWEEN 50000000 AND 200000000 THEN id
                        END
                    )
                        +
                COUNT(
                        CASE
                            WHEN jenis_pengadaan_str IN ('Jasa Konsultansi') AND total_pagu::NUMERIC BETWEEN 50000000 AND 100000000 THEN id
                        END
                    )
            ) AS non_tender,
            COUNT(
                    CASE
                        WHEN motode_str = 'Tender' THEN motode_str
                    END
                ) AS tender,
            COUNT(
                    CASE
                        WHEN motode_str = 'Seleksi' THEN motode_str
                    END
                ) AS seleksi 
        ");
        $this->local_db->from("sip.tbl_pkt_penyedia");
        if ($tahun != 'all') {
            $this->local_db->where("tahun", $tahun+0);
        }
        $this->local_db->group_by("nama_satker");
        $data = $this->local_db->get();
        return $data;
    }


    public function total_rekapitulasi_paket_opd($tahun){
        $this->local_db->select("
            COUNT(
                    CASE
                        WHEN jenis_pengadaan_str IN ('Barang','Jasa Lainnya','Pekerjaan Konstruksi','Jasa Konsultansi') AND total_pagu::NUMERIC < 50000000 THEN id
                    END
                ) AS pencatatan_non_tender,
            (
                COUNT(
                        CASE
                            WHEN jenis_pengadaan_str IN ('Barang','Jasa Lainnya','Pekerjaan Konstruksi') AND total_pagu::NUMERIC BETWEEN 50000000 AND 200000000 THEN id
                        END
                    )
                        +
                COUNT(
                        CASE
                            WHEN jenis_pengadaan_str IN ('Jasa Konsultansi') AND total_pagu::NUMERIC BETWEEN 50000000 AND 100000000 THEN id
                        END
                    )
            ) AS non_tender,
            COUNT(
                    CASE
                        WHEN motode_str = 'Tender' THEN motode_str
                    END
                ) AS tender,
            COUNT(
                    CASE
                        WHEN motode_str = 'Seleksi' THEN motode_str
                    END
                ) AS seleksi 
        ");
        $this->local_db->from("sip.tbl_pkt_penyedia");
        if ($tahun != 'all') {
            $this->local_db->where("tahun", $tahun+0);
        }
        $data = $this->local_db->get();
        return $data;
    }


    public function paket_tender_seleksi($tahun){
        $this->local_db->select("
            nama_satker, 
            nama, 
            total_pagu, 
            motode_str, 
            sumber_dana_string, 
            id,
            tanggal_awal_pengadaan AS waktu_pemilihan, 
            tanggal_akhir_pengadaan AS akhir_pengadaan,
            tanggal_akhir_pekerjaan AS akhir_pekerjaan,
            create_time
        ");
        $this->local_db->from("sip.tbl_pkt_penyedia");
        $this->local_db->where_in("motode_str", array('tender','seleksi'));
        if ($tahun != 'all') {
            $this->local_db->where("tahun", $tahun+0);
        }
        $this->local_db->order_by("nama_satker", "DESC");
        $data = $this->local_db->get();
        return $data;
    }


    public function rincian_paket($tahun){
        $this->local_db->select("
            id, 
            nama_satker, 
            kegiatan, 
            nama,
            jenis_pengadaan_str, 
            motode_str,
            total_pagu,
            COUNT(
                    CASE
                        WHEN jenis_pengadaan_str IN ('Barang','Jasa Lainnya','Pekerjaan Konstruksi','Jasa Konsultansi') AND total_pagu::NUMERIC < 50000000 THEN id
                    END
                ) AS pencatatan_non_tender,
            (
                COUNT(
                        CASE
                            WHEN jenis_pengadaan_str IN ('Barang','Jasa Lainnya','Pekerjaan Konstruksi') AND total_pagu::NUMERIC BETWEEN 50000000 AND 200000000 THEN id
                        END
                    )
                        +
                COUNT(
                        CASE
                            WHEN jenis_pengadaan_str IN ('Jasa Konsultansi') AND total_pagu::NUMERIC BETWEEN 50000000 AND 100000000 THEN id
                        END
                    )
            ) AS non_tender,
            COUNT(
                    CASE
                        WHEN motode_str = 'Tender' THEN motode_str
                    END
                ) AS tender,
            COUNT(
                    CASE
                        WHEN motode_str = 'Seleksi' THEN motode_str
                    END
                ) AS seleksi 
        ");
        $this->local_db->from("sip.tbl_pkt_penyedia");
        if ($tahun != 'all') {
            $this->local_db->where("tahun", $tahun+0);
        }
        $this->local_db->group_by("id");
        $this->local_db->group_by("nama_satker");
        $this->local_db->group_by("kegiatan");
        $this->local_db->group_by("nama");
        $this->local_db->group_by("jenis_pengadaan_str");
        $this->local_db->group_by("motode_str");
        $this->local_db->group_by("total_pagu");
        $data = $this->local_db->get();
        return $data;
    }

    
}