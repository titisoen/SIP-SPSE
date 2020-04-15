<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Rekanan_info_model extends CI_Model {

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

    public function rekap_rekanan($tahun, $repo_id) {
        $this->pg_db->select("
        SUM(CASE WHEN rkn_status = '1' THEN 1 ELSE 0 END) AS rekanan_semua,
        SUM(CASE WHEN repo_id = $repo_id AND rkn_status = '1' THEN 1 ELSE 0 END) AS rekanan_verifikasi,
        SUM(CASE WHEN repo_id != $repo_id AND rkn_status = '1' THEN 1 ELSE 0 END) AS rekanan_roaming");
        $this->pg_db->from("rekanan");
        if ($tahun != 'all') {
            $this->pg_db->where("DATE_PART('year'::text, rkn_tgl_daftar) =", $tahun+0);
        }
        $data = $this->pg_db->get();
        return $data;
    }

    public function rekanan_verifikasi($tahun, $repo_id) {
        $this->pg_db->select("a.rkn_nama");
        $this->pg_db->select("
        CASE
        WHEN a.btu_id = '01'::bpchar THEN 'CV'::text
        WHEN a.btu_id = '02'::bpchar THEN 'PT'::text
        WHEN a.btu_id = '03'::bpchar THEN 'UD'::text
        WHEN a.btu_id = '04'::bpchar THEN 'Koperasi'::text
        WHEN a.btu_id = '05'::bpchar THEN 'Firma'::text
        WHEN a.btu_id = '06'::bpchar THEN 'Perusahaan Perseorangan'::text
        WHEN a.btu_id = '07'::bpchar THEN 'Konsultan Perorangan'::text
        WHEN a.btu_id = '08'::bpchar THEN 'Perusahaan Dagang'::text
        WHEN a.btu_id = '09'::bpchar THEN 'Perusahaan Asing'::text
        WHEN a.btu_id = '10'::bpchar THEN 'Lembaga Penyiaran Publik'::text
        END AS jenisrekanan");
        $this->pg_db->select("b.kbp_nama,
        a.rkn_alamat,
        a.rkn_npwp,
        a.rkn_email,
        to_char(a.rkn_tgl_daftar, 'DD-MM-YYYY') AS tgl_daftar,
        to_char(a.rkn_tgl_setuju, 'DD-MM-YYYY') AS tgl_setuju");
        $this->pg_db->from("rekanan a");
        $this->pg_db->join("kabupaten b", "a.kbp_id = b.kbp_id", "left outer");
        $this->pg_db->where("rkn_status" , "1");
        $this->pg_db->where("repo_id", $repo_id);
        if ($tahun != 'all') {
            $this->pg_db->where("DATE_PART('year'::text, a.rkn_tgl_daftar) =", $tahun+0);
        }
        $this->pg_db->order_by("a.rkn_nama", "ASC");
        $data = $this->pg_db->get();
        return $data;
      }

      public function rekanan_roaming($tahun, $repo_id) {
        $this->pg_db->select("a.rkn_nama");
        $this->pg_db->select("
        CASE
        WHEN a.btu_id = '01'::bpchar THEN 'CV'::text
        WHEN a.btu_id = '02'::bpchar THEN 'PT'::text
        WHEN a.btu_id = '03'::bpchar THEN 'UD'::text
        WHEN a.btu_id = '04'::bpchar THEN 'Koperasi'::text
        WHEN a.btu_id = '05'::bpchar THEN 'Firma'::text
        WHEN a.btu_id = '06'::bpchar THEN 'Perusahaan Perseorangan'::text
        WHEN a.btu_id = '07'::bpchar THEN 'Konsultan Perorangan'::text
        WHEN a.btu_id = '08'::bpchar THEN 'Perusahaan Dagang'::text
        WHEN a.btu_id = '09'::bpchar THEN 'Perusahaan Asing'::text
        WHEN a.btu_id = '10'::bpchar THEN 'Lembaga Penyiaran Publik'::text
        END AS jenisrekanan");
        $this->pg_db->select("b.kbp_nama,
        a.rkn_alamat,
        a.rkn_npwp,
        a.rkn_email,
        to_char(a.rkn_tgl_daftar, 'DD-MM-YYYY') AS tgl_daftar,
        to_char(a.rkn_tgl_setuju, 'DD-MM-YYYY') AS tgl_setuju");
        $this->pg_db->from("rekanan a");
        $this->pg_db->join("kabupaten b", "a.kbp_id = b.kbp_id", "left outer");
        $this->pg_db->where("rkn_status" , "1");
        $this->pg_db->where("repo_id !=", $repo_id);
        if ($tahun != 'all') {
            $this->pg_db->where("DATE_PART('year'::text, a.rkn_tgl_daftar) =", $tahun+0);
        }
        $this->pg_db->order_by("a.rkn_nama", "ASC");
        $data = $this->pg_db->get();
        return $data;
      }

   
}