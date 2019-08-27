<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Misc_download_model extends CI_Model {

    public function __construct()
    {
        $this->local_db = $this->load->database('default', TRUE);
        $this->smep_db = $this->load->database('smep_database', TRUE);
        $this->pg_db = $this->load->database('pg_database', TRUE);
    }


    /* -----------------------------------
    * ---------- App Function ------------
    * --------------------------------- */
    
}