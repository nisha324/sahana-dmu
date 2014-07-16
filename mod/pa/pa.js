

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
            $('#dplan_field').prop('disabled', true);
            // the checkbox was unchecked
        }

    });
}