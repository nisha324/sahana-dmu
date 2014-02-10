/**
 * @name         Monitoring Module
 * @version      1
 * @package      mon
 * @author		 Ramindu Deshapriya <rdeshapriya@virtusa.com>
 * @about        Developed in whole or part by Virtusa Corporation
 * @link		 http://virtusa.com
 * @license	 http://www.gnu.org/licenses/lgpl-2.1.html GNU Lesser General Public License (LGPL)
 * @lastModified 2013.0418
 */

mon_show_patients();

function mon_get_data() {
    //console.log("Beginning data object creation");
	var r = new Object();
	r.mon_height                	 = $("#mon_height").val();
	r.mon_weight                     = $("#mon_weight").val();
	r.waist_circumference            = $("#waist_circumference").val();
	r.physical_appearance            = $("#physical_appearance").val();
	r.mental_state                   = $("#mental_state").val();
	r.nourishment_status             = $("#nourishment_status").val();
	r.abnormal_smells                = $("#abnormal_smells").val();
	r.skin                         	 = $("#skin").val();
	r.lymph_nodes                    = $("#lymph_nodes").val();
	r.hands                    		 = $("#hands").val();
	r.cvs_pulse_rate                 = $("#cvs_pulse_rate").val();
    r.cvs_rhythm                     = $("#cvs_rhythm").val();
	r.cvs_volume                     = $("#cvs_volume").val();
	r.cvs_pressure                   = $("#cvs_pressure").val();
	r.cvs_heart_sounds               = $("#cvs_heart_sounds").val();
	r.cvs_ankle_oedema               = $("#cvs_ankle_oedema").val();
	r.cvs_peripheral_pulses          = $("#cvs_peripheral_pulses").val();
	r.res_chest_wall_deformities     = $("#res_chest_wall_deformities").val();
	r.res_tracheal_deviation         = $("#res_tracheal_deviation").val();
	r.res_percussion_note 			 = $("#res_percussion_note").val();
	r.res_breath_sounds              = $("#res_breath_sounds").val();
	r.res_vocal_resonance            = $("#res_vocal_resonance").val();
	r.ab_tenderness                  = $("#ab_tenderness").val();
	r.ab_ascites                     = $("#ab_ascites").val();
	r.ab_liver_enlargement           = $("#ab_liver_enlargement").val();
	r.ab_kidney           			 = $("#ab_kidney").val();
	r.ab_spleen_enlargement          = $("#ab_spleen_enlargement").val();
	r.cns_speech                     = $("#cns_speech").val();
	r.cns_cranial_nerves             = $("#cns_cranial_nerves").val();
	r.cns_glasgow_eyes               = $("#cns_glasgow_eyes").val();
	r.cns_glasgow_verbal 			 = $("#cns_glasgow_verbal").val();
	r.cns_glasgow_motor              = $("#cns_glasgow_motor").val();
	r.ms_gait                        = $("#ms_gait").val();
	r.ms_swelling                    = $("#ms_swelling").val();
    r.entry_date                          = $("#monitoringDate").val();

    //console.log("End data object creation");
	/*if($("#patient_id_suffix_variable:checked").val() == "default") {
		r.patient_id_suffix_variable = 1;
	} else {
		r.patient_id_suffix_variable = 0;
	}*/
	
	var rj = JSON.stringify(r);
	return(rj);
}

function initCalendar() {
    $("#monitoringDate").datepicker({ dateFormat: 'yy-mm-dd' });
}