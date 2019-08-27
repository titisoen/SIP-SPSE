<div class="col-md-12">
    <div class="card">
        <div class="card-header">
            <h4>DATA PAKET TENDER GAGAL</h4>
        </div>
        <div class="card-block">
            <div class="table-responsive">
                <table class="tendering-paketgagal-data-gagal-table table table-hover">
                    <thead>
                        <tr>
                            <th width="5%">No</th>
                            <th width="10%">Tahun</th>
                            <th width="15%">SKPD</th>
                            <th width="10%">Kode Lelang</th>
                            <th width="20%">Nama Paket</th>
                            <th width="15%">Pagu Dana</th>
                            <th width="25%">Alasan</th>
                        </tr>
                    </thead>
                    <tbody class="tbody-paket-tendering-paketgagal-data-gagal-pertahun"></tbody>
                    <tfoot class="tfoot-paket-tendering-paketgagal-data-gagal-pertahun"></tfoot>
                </table>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    //*****************************************************
    //*                                             
    //* Data Lelang Per Tahun
    //*                                             
    //*****************************************************
    create_tendering_paketgagal_data_gagal_pertahun(
                                                    jQuery(".tender-paketgagal-pencarian-data-tahun").val(),
                                                    jQuery(".tender-paketgagal-pencarian-data-nama-satker").val()
                                                );
    function refresh_tendering_paketgagal_data_gagal_pertahun(tahun, satker){
        create_tendering_paketgagal_data_gagal_pertahun(tahun, satker);
    }

    function data_tendering_paketgagal_data_gagal_pertahun(tahun, satker){
        var data = null;
        jQuery.ajax({
          type      : 'AJAX',
          method    : 'GET',
          url       : '../paket-tendering/paket-gagal/data/data-gagal/'+tahun+'/'+satker,
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

    function create_tendering_paketgagal_data_gagal_pertahun(tahun, satker){
        var get_data = data_tendering_paketgagal_data_gagal_pertahun(tahun, satker);
        var data_baris = [];
        var data_total = [];
        for (var i = 0; i < get_data.baris_data.length; i++) {
            data_baris[i] =  [
                                get_data.baris_data[i].no,
                                get_data.baris_data[i].tahun,
                                get_data.baris_data[i].nama_opd,
                                get_data.baris_data[i].kode_lelang,
                                get_data.baris_data[i].nama_paket,
                                get_data.baris_data[i].total_pagu,
                                get_data.baris_data[i].alasan
                            ];
        }
        
        jQuery(".tendering-paketgagal-data-gagal-table").DataTable({
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

        // jQuery(".tbody-paket-tendering-paketgagal-data-gagal-pertahun tr").first().css("text-align", "center");
        jQuery(".tbody-paket-tendering-paketgagal-data-gagal-pertahun tr td").css("vertical-align", "middle");

        for (var j = 0; j < get_data.total_data.length; j++) {
            data_total +=   "<tr>"+
                                "<th colspan='5'>Jumlah</th>"+
                                "<th>"+get_data.total_data[j].total_pagu+"</th>"+
                                "<th></th>"+
                            "</tr>";
        }
        jQuery(".tfoot-paket-tendering-paketgagal-data-gagal-pertahun").html(data_total);
        jQuery(".tfoot-paket-tendering-paketgagal-data-gagal-pertahun tr th").css("text-align", "center");
        jQuery(".tfoot-paket-tendering-paketgagal-data-gagal-pertahun tr th").css("vertical-align", "middle");
    }
</script>