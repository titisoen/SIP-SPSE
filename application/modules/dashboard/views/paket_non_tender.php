<div class="col-md-12">
    <div class="card dashboard-paket-non-tender">
        <div class="card-header">
            <h4>GRAFIK PAKET NON TENDER</h4>
        </div>
        <div class="card-block">
            <div id="dashboard-paket-non_tender" style="width: 100%; height: 350px;"></div>
            <p style="text-align: center;padding-top: 20px;"><b>Jumlah Hasil Tender/Seleksi Tahun <?=$tahun_awal.'-'.$tahun_akhir;?></b></p>
        </div>
    </div>
</div>

<script type="text/javascript">
    //**********************************************
    //*                                             
    //* GRAFIK PAKET NON TENDER
    //*                                             
    //**********************************************

    function dynamic_colors() {
        var r = Math.floor(Math.random() * 255);
        var g = Math.floor(Math.random() * 255);
        var b = Math.floor(Math.random() * 255);
        return "rgb(" + r + "," + g + "," + b + ")";
    }

    function toggleDataSeries(e) {
        if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
            e.dataSeries.visible = false;
        }
        else {
            e.dataSeries.visible = true;
        }
        chart.render();
    }

    function refresh_dashboard_paket_non_tender(tahun){
        create_dashboard_paket_non_tender(tahun);
    }


    create_dashboard_paket_non_tender(jQuery(".dashboard-pencarian-data").val());
    function data_dashboard_paket_non_tender(tahun){
        var data = null;
        jQuery.ajax({
          type      : 'AJAX',
          method    : 'GET',
          url       : '../dashboard/data/paket_non_tender/'+tahun,
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

    function create_dashboard_paket_non_tender(tahun){
        var get_data                = data_dashboard_paket_non_tender(tahun);
        var data_total_paket        = [];
        var data_paket_selesai        = [];
        for (var i = 0; i < get_data.length; i++) {
            data_total_paket[i]  = {y: parseInt(get_data[i].total_paket), label: get_data[i].tahun};
            data_paket_selesai[i]  = {y: parseInt(get_data[i].paket_selesai), label: get_data[i].tahun};
        }

        var chart = new CanvasJS.Chart("dashboard-paket-non_tender", {
            theme               : "light2",
            animationEnabled    : true,
            exportEnabled       : true,
            axisX               : {interval: 1},
            axisY               : {valueFormatString: "###0"},
            toolTip             : {shared: true},
            legend              : {
                                    cursor: "pointer",
                                    itemclick: toggleDataSeries
                                  },
            data                : [
                                    {
                                        type: "column",
                                        yValueFormatString: "###0 Paket",
                                        name: "Total Paket",
                                        showInLegend: true,
                                        indexLabelOrientation: "vertical",
                                        indexLabelFontColor: "black",
                                        dataPoints: data_total_paket
                                    },
                                    {
                                        type: "column",
                                        yValueFormatString: "###0 Paket",
                                        name: "Paket Selesai",
                                        showInLegend: true,
                                        indexLabelOrientation: "vertical",
                                        indexLabelFontColor: "black",
                                        dataPoints: data_paket_selesai
                                    }
                                  ]
        });
        chart.render();
    }
</script>