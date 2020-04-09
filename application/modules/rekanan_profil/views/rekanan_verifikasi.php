<div class="col-md-12">
    <div class="card">
        <div class="card-header">
            <h4>DATA REKANAN TERVERIFIKASI</h4>
        </div>
        <div class="card-block">
            <div class="table-responsive">
                <table class="rekanan-profil-rekanan-verifikasi-table table table-hover">
                    <thead>
                        <tr>
                            <th width="5%">No</th>
                            <th width="30%">Nama Rekanan</th>
                            <th width="5%">Bentuk Usaha</th>
                            <th width="20%">Kota/Kabupaten</th>
                            <th width="10%">NPWP</th>
                            <th width="10%">Email</th>
                            <th width="10%">Tanggal Terdaftar</th>
                            <th width="15%">Tanggal Disetujui</th>
                        </tr>
                    </thead>
                    <!-- <tbody class="tbody-rekanan-profil-rekanan-verifikasi-pertahun"></tbody>
                    <tfoot class="tfoot-rekanan-profil-rekanan-verifikasi-pertahun"></tfoot> -->
                </table>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    //*****************************************************
    //*                                             
    //* Data Penyedia Terverifikasi
    //*                                             
    //*****************************************************
    create_rekanan_profil_rekanan_verifikasi(
                                                    jQuery(".rekanan-profil-pencarian-data-tahun").val()
                                                );
    function refresh_rekanan_profil_rekanan_verifikasi(tahun){
        create_rekanan_profil_rekanan_verifikasi(tahun);
    }

    function data_rekanan_profil_rekanan_verifikasi(tahun){
        var data = null;
        jQuery.ajax({
          type      : 'AJAX',
          method    : 'GET',
          url       : '../rekanan/profil/data/rekanan-verifikasi/'+tahun,
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

    function create_rekanan_profil_rekanan_verifikasi(tahun){
        var get_data = data_rekanan_profil_rekanan_verifikasi(tahun);
        var data_baris = [];
        var data_total = [];
        for (var i = 0; i < get_data.baris_data.length; i++) {
            data_baris[i] =  [
                                get_data.baris_data[i].no,
                                get_data.baris_data[i].rkn_nama,
                                get_data.baris_data[i].jenisrekanan,
                                get_data.baris_data[i].kbp_nama,
                                get_data.baris_data[i].rkn_npwp,
                                get_data.baris_data[i].rkn_email,
                                get_data.baris_data[i].tgl_daftar,
                                get_data.baris_data[i].tgl_setuju
                            ];
        }
        
        jQuery(".rekanan-profil-rekanan-verifikasi-table").DataTable({
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

        // jQuery(".tbody-rekanan-profil-rekanan-verifikasi-pertahun tr td").css("vertical-align", "middle");

        // for (var j = 0; j < get_data.total_data.length; j++) {
        //     data_total +=   "<tr>"+
        //                         "<th colspan='2'>Jumlah</th>"+
        //                         "<th>"+get_data.total_data[j].terdaftar+"</th>"+
        //                         "<th>"+get_data.total_data[j].terverifikasi+"</th>"+
        //                         "<th>"+get_data.total_data[j].belum_verifikasi+"</th>"+
        //                         "<th>"+get_data.total_data[j].tertolak+"</th>"+
        //                     "</tr>";
        // }
        // jQuery(".tfoot-rekanan-profil-rekanan-kabupaten-pertahun").html(data_total);
        // jQuery(".tfoot-rekanan-profil-rekanan-kabupaten-pertahun tr th").css("text-align", "center");
        // jQuery(".tfoot-rekanan-profil-rekanan-kabupaten-pertahun tr th").css("vertical-align", "middle");
    }
</script>