<div class="col-md-12">
    <div class="card">
        <div class="card-header">
            <h4>PENCARIAN DATA</h4>
        </div>
        <div class="card-block">
            <form action="#" method="GET" class="form-horizontal">
                <div class="form-group">
                    <label class="col-md-2 control-label" for="example-select2">Tahun Data</label>
                    <div class="col-md-10">
                        <select class="catat-nontender-paketpengadaan-pencarian-data-tahun js-select2 form-control"style="width: 100%;">
                            <?php $date = date('Y');?>
                            <option value="all">:: Dari Tahun 2019 - <?=$date?> ::</option>
                            <?php
                                for ($i=2019; $i <= $date ; $i++) {
                            ?>
                                    <option value="<?=$i?>">Tahun <?=$i?></option>
                            <?php
                                }
                            ?>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label" for="example-select2">Pencarian Data</label>
                    <div class="col-md-2">
                        <button class="btn btn-primary btn-block catat-nontender-paketpengadaan-pencarian-data-btn">
                            <i class="fa fa-search"></i>&nbsp;Cari Data
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
    jQuery(".catat-nontender-paketpengadaan-pencarian-data-tahun").select2();

    jQuery(document).on("click", ".catat-nontender-paketpengadaan-pencarian-data-btn", function(){
        var tahun = jQuery(".catat-nontender-paketpengadaan-pencarian-data-tahun").val();
        refresh_catat_nontender_paketpengadaan_data_paket_pertahun(tahun);
        return false;
    });
</script>