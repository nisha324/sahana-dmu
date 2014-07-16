

function tempCheckBox(){
    $(":radio").click(function(){

        if ($("#pA_yes").is(':checked')) {
            $('#pA_field').prop('disabled', false);
            // the checkbox was checked
        } if ($("#pA_no").is(':checked')){
            $('#pA_field').prop('disabled', true);
            // the checkbox was unchecked
        }
        if ($("#eW_yes").is(':checked')){
            $('#eW_field').prop('disabled', false);
            // the checkbox was unchecked
        }
        if ($("#eW_no").is(':checked')){
            $('#eW_field').prop('disabled', true);
            // the checkbox was unchecked
        }
        if ($("#sA_yes").is(':checked')){
            $('#sA_field').prop('disabled', false);
            // the checkbox was unchecked
        }
        if ($("#sA_no").is(':checked')){
            $('#sA_field').prop('disabled', true);
            // the checkbox was unchecked
        }
        if ($("#drill_yes").is(':checked')){
            $('#drill_field').prop('disabled', false);
            // the checkbox was unchecked
        }
        if ($("#drill_no").is(':checked')){
            $('#drill_field').prop('disabled', true);
            // the checkbox was unchecked
        }
        if ($("#plan_yes").is(':checked')){
            $('#plan_field').prop('disabled', false);
            // the checkbox was unchecked
        }
        if ($("#plan_no").is(':checked')){
            $('#plan_field').prop('disabled', true);
            // the checkbox was unchecked
        }

    });
}

function cal(){
    $('select').change(function(){t_score()});
}

function t_score(){
    var f_1 = document.getElementById("flood_poten").value;
    var f_2 = document.getElementById("flood_frq").value;
    var f_3 = document.getElementById("flood_SP").value;
    document.getElementById("t_flood").innerHTML = parseInt(f_1)*parseInt(f_2)*parseInt(f_3);

    var l_1 = document.getElementById("landslide_poten").value;
    var l_2 = document.getElementById("landslide_frq").value;
    var l_3 = document.getElementById("landslide_SP").value;
    document.getElementById("t_landslide").innerHTML = parseInt(l_1)*parseInt(l_2)*parseInt(l_3);

    var d_1 = document.getElementById("drought_poten").value;
    var d_2 = document.getElementById("drought_frq").value;
    var d_3 = document.getElementById("drought_SP").value;
    document.getElementById("t_drought").innerHTML = parseInt(d_1)*parseInt(d_2)*parseInt(d_3);

    var c_1 = document.getElementById("cyclones_poten").value;
    var c_2 = document.getElementById("cyclones_frq").value;
    var c_3 = document.getElementById("cyclones_SP").value;
    document.getElementById("t_cyclones").innerHTML = parseInt(c_1)*parseInt(c_2)*parseInt(c_3);

    var t_1 = document.getElementById("tsunami_poten").value;
    var t_2 = document.getElementById("tsunami_frq").value;
    var t_3 = document.getElementById("tsunami_SP").value;
    document.getElementById("t_tsunami").innerHTML = parseInt(t_1)*parseInt(t_2)*parseInt(t_3);

}