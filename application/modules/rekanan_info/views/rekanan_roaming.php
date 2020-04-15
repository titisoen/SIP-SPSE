<div class="col-md-12">
    <div class="card">
        <div class="card-header">
            <h4>DATA REKANAN ROAMING</h4>
        </div>
        <div class="card-block">
            <div class="table-responsive">
                <table class="rekanan-info-rekanan-roaming-table table table-hover">
                    <thead>
                        <tr>
                            <th width="5%">No</th>
                            <th width="20%">Nama Rekanan</th>
                            <th width="5%">Bentuk Usaha</th>
                            <th width="20%">Alamat</th>
                            <th width="10%">Kota/Kabupaten</th>
                            <th width="15%">NPWP</th>
                            <th width="5%">Email</th>
                            <th width="10%">Tanggal Terdaftar</th>
                            <th width="10%">Tanggal Disetujui</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    //*****************************************************
    //*                                             
    //* Data Penyedia Roaming
    //*                                             
    //*****************************************************
    create_rekanan_info_rekanan_roaming(
                                                    jQuery(".rekanan-info-pencarian-data-tahun").val()
                                                );
    function refresh_rekanan_info_rekanan_roaming(tahun){
        create_rekanan_info_rekanan_roaming(tahun);
    }

    function data_rekanan_info_rekanan_roaming(tahun){
        var data = null;
        jQuery.ajax({
          type      : 'AJAX',
          method    : 'GET',
          url       : '../rekanan/info/data/rekanan-roaming/'+tahun,
          async     : false,
          dataType  : 'JSON',
          success   : function(JSON){
            data = JSON;
          },
          error     : function(jqXHR, textStatus, errorThrown){
            console.log("error");
          }
        });
        return data;
    }

    function create_rekanan_info_rekanan_roaming(tahun){
        var get_data = data_rekanan_info_rekanan_roaming(tahun);
        var data_baris = [];
        var data_total = [];
        for (var i = 0; i < get_data.baris_data.length; i++) {
            data_baris[i] =  [
                                get_data.baris_data[i].no,
                                get_data.baris_data[i].rkn_nama,
                                get_data.baris_data[i].jenisrekanan,
                                get_data.baris_data[i].rkn_alamat,
                                get_data.baris_data[i].kbp_nama,
                                get_data.baris_data[i].rkn_npwp,
                                get_data.baris_data[i].rkn_email,
                                get_data.baris_data[i].tgl_daftar,
                                get_data.baris_data[i].tgl_setuju
                            ];
        }
        
        jQuery(".rekanan-info-rekanan-roaming-table").DataTable({
            destroy         : true,
            processing      : true,
            lengthMenu      : [10],
            dom             : 'Bfrtip',
            buttons         : {
                                buttons : [
                                            {
                                                extend : 'copy',
                                                text : '<i class="fa fa-copy"></i>&nbsp;Salin Data',
                                                className : 'btn btn-success'
                                            },
                                            {
                                                extend : 'csv',
                                                text : '<i class="fa fa-file-excel-o"></i>&nbsp;Export to CSV',
                                                className : 'btn btn-success'
                                            },
                                            {
                                                extend : 'excel',
                                                text : '<i class="fa fa-file-excel-o"></i>&nbsp;Export to Excel',
                                                className : 'btn btn-success'
                                            },
                                            {
                                                extend : 'pdf',
                                                text : '<i class="fa fa-file-pdf-o"></i>&nbsp;Export to PDF',
                                                className : 'btn btn-success'
                                            },
                                            {
                                                extend : 'print',
                                                text : '<i class="fa fa-print"></i>&nbsp;Print Table',
                                                className : 'btn btn-success'
                                            },
                                          ]
                              },
            data            : data_baris
        });
    }
</script>