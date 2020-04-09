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
                        <select class="rekanan-info-pencarian-data-tahun js-select2 form-control"style="width: 100%;">
                            <?php
                                $date = date('Y');
                                if ($date > 2011) {
                            ?>
                                    <option value="all">:: Semua Tahun ::</option>
                            <?php
                                    for ($i=2011; $i <= $date ; $date--) {
                                ?>
                                        <option value="<?=$date?>">Tahun <?=$date?></option>
                                <?php
                                    }
                                }
                                else{
                            ?>
                                    <option value="2011">:: Tahun 2011 ::</option>
                            <?php
                                }
                            ?>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label" for="example-select2">Pencarian Data</label>
                    <div class="col-md-2">
                        <button class="btn btn-primary btn-block rekanan-info-pencarian-data-btn">
                            <i class="fa fa-search"></i>&nbsp;Cari Data
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
    jQuery(".rekanan-info-pencarian-data-tahun").select2();

    jQuery(document).on("click", ".rekanan-info-pencarian-data-btn", function(){
        var tahun = jQuery(".rekanan-info-pencarian-data-tahun").val();
        refresh_rekanan_info_rekanan_verifikasi(tahun);
        return false;
    });
</script>