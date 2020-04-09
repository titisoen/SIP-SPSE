<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Rekanan_info_controller extends CI_Controller {

	public function __construct(){
		parent::__construct();
		$this->load->model('Rekanan_info_model', 'model');
	}

	public function main_page(){
		$this->load->view('data');
	}

	// *************************************************
	// | *********************************************
	// | -------- DATA INFORMASI REKANAN --------
	// | *********************************************
	// *************************************************

	public function rekanan_verifikasi($tahun){
		$repo_id = $this->model->get_repo();
		
		$data["baris_data"] = array();
		$data["total_data"] = array();
		$no 	= 1;


		$result_data		= $this->model->rekanan_verifikasi($tahun, $repo_id);
		foreach ($result_data->result() as $rows_data) {
			$data["baris_data"][] = array(
											"no"							=> $no++,
											"rkn_nama"		 				=> strtoupper($rows_data->rkn_nama),
											"jenisrekanan" 					=> ($rows_data->jenisrekanan),
											"rkn_alamat"					=> ($rows_data->rkn_alamat),
											"kbp_nama"		 				=> ($rows_data->kbp_nama),
											"rkn_npwp" 						=> ($rows_data->rkn_npwp),
											"rkn_email"						=> ($rows_data->rkn_email),
											"tgl_daftar"					=> ($rows_data->tgl_daftar),
											"tgl_setuju"					=> ($rows_data->tgl_setuju),
									);
		}
		echo json_encode($data);
	}
}
