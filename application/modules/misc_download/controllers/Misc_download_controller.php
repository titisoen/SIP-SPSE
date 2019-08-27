<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Misc_download_controller extends CI_Controller {

	public function __construct(){
		parent::__construct();
		$this->load->model('Misc_download_model', 'model');
		
	}

	public function main_page(){
		$this->load->view('data');
	}




	// *************************************************
	// | *********************************************
	// | ------------  DATA AUTENTIKASI -------------
	// | *********************************************
	// *************************************************

	public function download_sipspse_rar(){
		redirect(base_url('assets/files/sip_spse.rar'));
	}


	public function download_video_install_rar(){
		redirect(base_url('assets/files/Video.rar'));
	}
}