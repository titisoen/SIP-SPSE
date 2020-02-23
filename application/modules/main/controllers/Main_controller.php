<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Main_controller extends CI_Controller {

	public function __construct(){
		parent::__construct();
		$this->load->model('Main_model', 'model');
	}

	public function index()
	{
		redirect('app/main');
	}

	public function welcome_page(){
		$this->load->view('Welcome_view');
	}

	public function main_page(){
		// Field
		$email 			= '';
		$nama_kota 		= '';
		$nama_admin 	= '';
		$url_admin 		= '';

		// Get Data
		$result_data		= $this->model->get_all_data_kontak_kami();
		if ($result_data->num_rows() > 0) {
			foreach ($result_data->result() as $rows_data) {
				
				// Get Data Array
				foreach (unserialize($rows_data->engine) as $rows) {
					$email 			= $rows["email"];
				}
			}
		}

		$result_data		= $this->model->get_all_data_info_privasi();
		if ($result_data->num_rows() > 0) {
			foreach ($result_data->result() as $rows_data) {
				
				// Get Data Array
				foreach (unserialize($rows_data->engine) as $rows) {
					$nama_kota 		= $rows["nama_kota"];
					$nama_admin 	= $rows["nama_admin"];
					$url_admin 		= $rows["url_admin"];
				}
			}
		}
		$data["misc"] 	= array("nama_kota" => $nama_kota, "nama_admin" => $nama_admin, "url_admin" => $url_admin);
		$data['kode_klpd'] = $this->model->get_info_klpd()->row()->kode_klpd;
		$data['klpd'] = $this->model->get_info_klpd()->row()->nama_klpd;
		$data['build'] = $this->get_latest_build();
		$this->load->view('Main_view', $data);
	}
	
	public function get_latest_build(){
		$log_num = 1; // Load Last 1 Git Logs
		$git_history = [];
		$git_logs = [];
		exec("git log -".$log_num, $git_logs);

		// Parse Logs
		$last_hash = null;
		foreach ($git_logs as $line)
		{
				// Clean Line
				$line = trim($line);

				// Proceed If There Are Any Lines
				if (!empty($line))
				{
						// Commit
						if (strpos($line, 'commit') !== false)
						{
								$hash = explode(' ', $line);
								$hash = trim(end($hash));
								$git_history[$hash] = [
										'message' => ''
								];
								$last_hash = $hash;
						}

						// Author
						else if (strpos($line, 'Author') !== false) {
								$author = explode(':', $line);
								$author = trim(end($author));
								$git_history[$last_hash]['author'] = $author;
						}

						// Date
						else if (strpos($line, 'Date') !== false) {
								$date = explode(':', $line, 2);
								$date = trim(end($date));
								$git_history[$last_hash]['date'] = date('d-m-Y H:i:s', strtotime($date));
						}

						// Message
						else {
								$git_history[$last_hash]['message'] .= $line ." ";
						}
				}
		}

		return 'Build: ' . $git_history[$last_hash]['date'];
	}
}
