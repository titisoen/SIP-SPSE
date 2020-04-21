<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Catatnontender_paketpengadaan_model extends CI_Model {

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



    // ****************************************
    // ||
    // || APP FUNCTION
    // ||
    // ****************************************

    public function data_paket($tahun){
        $this->pg_db->select("DATE_PART('year'::text, lls.lls_dibuat_tanggal) AS tahun");
        $this->pg_db->select("lls.lls_id");
        $this->pg_db->select("CASE
                            WHEN (sikap.rsk_id) IS NOT NULL 
                            THEN (sikap.rsk_id)
                            ELSE (nonsikap.rsk_id)
                            END AS rsk_id_gabung");
        $this->pg_db->select("
                    pkt.pkt_id,
                    pktstr.rup_id,
                    pkt.pkt_nama,
                    sikap.audituser,
                    peg.peg_nama,
                    str.stk_id,
                    str.stk_nama,
                    pkt.pkt_pagu,
                    jns.rsk_nilai");
        $this->pg_db->select("CASE
                            WHEN (sikap.rp_nama_rekanan) IS NOT NULL 
                            THEN (sikap.rp_nama_rekanan)
                            ELSE (nonsikap.rn_nama_rekanan)
                            END AS nama_rekanan_gabung");
        $this->pg_db->from("ekontrak.realisasi_penyedia_non_spk sikap");
        $this->pg_db->join("ekontrak.jenis_realisasi_non_spk jns", "sikap.rsk_id = jns.rsk_id", "right");
        $this->pg_db->join("ekontrak.realisasi_non_penyedia_non_spk nonsikap", "nonsikap.rsk_id = jns.rsk_id", "left");
        $this->pg_db->join("ekontrak.non_spk_seleksi lls", "jns.lls_id = lls.lls_id", "inner");
        $this->pg_db->join("ekontrak.paket pkt", "lls.pkt_id = pkt.pkt_id", "inner");
        $this->pg_db->join("ekontrak.paket_satker pktstr", "pkt.pkt_id = pktstr.pkt_id", "inner");
        $this->pg_db->join("public.satuan_kerja str", "pktstr.stk_id = str.stk_id", "inner");
        $this->pg_db->join("public.ppk ppk", "pkt.ppk_id = ppk.ppk_id", "inner");
        $this->pg_db->join("public.pegawai peg", "ppk.peg_id = peg.peg_id", "inner");
        $this->pg_db->where("lls.lls_tanggal_paket_mulai IS NOT NULL", NULL, FALSE);
        if ($tahun != 'all') {
            $this->pg_db->where("DATE_PART('year'::text, lls.lls_dibuat_tanggal) =", $tahun+0);
        }
        $this->pg_db->order_by("tahun", "DESC");
        $data = $this->pg_db->get();
        return $data;
    }
}

