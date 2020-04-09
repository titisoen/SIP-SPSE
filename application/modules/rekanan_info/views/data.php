<div class="row">
    <?php
        include_once 'pencarian_data.php';
        include_once 'rekanan_verifikasi.php';
    ?>
    
</div>


<script type="text/javascript">
    jQuery(".navbar-page-title").html("Data Rekanan - Informasi Rekanan");

    // Initialize Bootstrap Tabs
    jQuery( '[data-toggle="tabs"] a, .js-tabs a' ).click( function(e) {
        e.preventDefault();
        jQuery( this ).tab( 'show' );
    });
</script>