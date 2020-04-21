<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Catatnontender_paketpengadaan_controller extends CI_Controller {

	public function __construct(){
		parent::__construct();
		$this->load->model('Catatnontender_paketpengadaan_model', 'model');
	}

	public function main_page(){
		$this->load->view('data');
	}


	// *************************************************
	// | *********************************************
	// | ------- SISTEM PENCATATAN NON TENDER ------
	// | *********************************************
	// *************************************************

	public function data_paket($tahun){
		$data["baris_data"] = array();
		$data["total_data"] = array();
		$no 	= 1;


		$result_data		= $this->model->data_paket($tahun);
		foreach ($result_data->result() as $rows_data) {
			$data["baris_data"][] = array(
											"no"						=> $no++,
                                            "id_paket"					=> $rows_data->lls_id,
                                            "nama_paket"				=>
                                                                            "<b>Nama Paket : </b>".$rows_data->pkt_nama."<br>".
                                                                            "<b>Kode SiRUP : </b>".$rows_data->rup_id."<br>".
                                                                            "<b>Tahun : </b>".$rows_data->tahun."<br>",
											"nama_opd"					=> $rows_data->stk_nama,
                                            "nama_ppk"                  => $rows_data->peg_nama,
											"total_pagu"				=> number_format($rows_data->pkt_pagu),
											"pemenang"					=> $rows_data->nama_rekanan_gabung,
											"total_realisasi"			=> number_format($rows_data->rsk_nilai)
									);
		}
		echo json_encode($data);
    }
}
