<div class="col-sm-6 col-lg-3">
    <a class="card" href="javascript:void(0)">
        <div class="card-block clearfix">
            <div class="pull-right">
                <p class="h6 text-muted m-t-0 m-b-xs">Total Rekanan</p>
                <p class="h3 text-blue m-t-sm m-b-0 rekanan-rekap-box1"></p>
            </div>
            <div class="pull-left m-r">
                <span class="img-avatar img-avatar-48 bg-blue bg-inverse"><i class="ion-ios-people fa-1-5x"></i></span>
            </div>
        </div>
    </a>
</div>
<div class="col-sm-6 col-lg-3">
    <a class="card bg-green bg-inverse" href="javascript:void(0)">
        <div class="card-block clearfix">
            <div class="pull-right">
                <p class="h6 text-muted m-t-0 m-b-xs">Total Rekanan Terverifikasi</p>
                <p class="h3 m-t-sm m-b-0 rekanan-rekap-box2"></p>
            </div>
            <div class="pull-left m-r">
                <span class="img-avatar img-avatar-48 bg-gray-light-o"><i class="ion-ios-people fa-1-5x"></i></span>
            </div>
        </div>
    </a>
</div>
<div class="col-sm-6 col-lg-3">
    <a class="card bg-blue bg-inverse" href="javascript:void(0)">
        <div class="card-block clearfix">
            <div class="pull-right">
                <p class="h6 text-muted m-t-0 m-b-xs">Total Rekanan Roaming</p>
                <p class="h3 m-t-sm m-b-0 rekanan-rekap-box3"></p>
            </div>
            <div class="pull-left m-r">
                <span class="img-avatar img-avatar-48 bg-gray-light-o"><i class="ion-ios-people fa-1-5x"></i></span>
            </div>
        </div>
    </a>
</div>
<!-- <div class="col-sm-6 col-lg-3">
    <a class="card bg-purple bg-inverse" href="javascript:void(0)">
        <div class="card-block clearfix">
            <div class="pull-right">
                <p class="h6 text-muted m-t-0 m-b-xs">Prosentase</p>
                <p class="h3 m-t-sm m-b-0 dashboard-rekap-box4"></p>
            </div>
            <div class="pull-left m-r">
                <span class="img-avatar img-avatar-48 bg-gray-light-o"><i class="ion-ios-email fa-1-5x"></i></span>
            </div>
        </div>
    </a>
</div> -->

<script type="text/javascript">
    
    //**********************************************
    //*                                             
    //*     STATISTIK REKAP DATA REKANAN 
    //*                                             
    //**********************************************

    create_rekanan_info_rekap_rekanan(
        jQuery(".rekanan-info-pencarian-data-tahun").val()
        );

    function refresh_rekanan_info_rekap_rekanan(tahun){
        create_rekanan_info_rekap_rekanan(tahun);
    }
    

    function data_rekanan_info_rekap_rekanan(tahun){
        var data = null;
        jQuery.ajax({
          type      : 'AJAX',
          method    : 'GET',
          url       : '../rekanan/info/data/rekap/'+tahun,
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

    function create_rekanan_info_rekap_rekanan(tahun){
        var data = data_rekanan_info_rekap_rekanan(tahun);
        jQuery(".rekanan-rekap-box1").html(data.total_rekanan+"&nbsp;<b style='font-size: 18px;'>Rekanan</b>");
        jQuery(".rekanan-rekap-box2").html(data.total_verifikasi+"&nbsp;<b style='font-size: 18px;'>Rekanan</b>");
        jQuery(".rekanan-rekap-box3").html(data.total_roaming+"&nbsp;<b style='font-size: 18px;'>Rekanan</b>");
    }

</script>