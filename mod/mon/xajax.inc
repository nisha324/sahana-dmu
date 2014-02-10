<?php
/**
 * @name         Monitoring Module
 * @version      1
 * @package      mon
 * @author		 Ramindu Deshapriya <rdeshapriya@virtusa.com>
 * @about        Developed in whole or part by Virtusa Corporation and the Sahana Software Foundation
 * @link		 http://virtusa.com
 * @link		 http://sahanafoundation.org
 * @license	 http://www.gnu.org/licenses/lgpl-2.1.html GNU Lesser General Public License (LGPL)
 * @lastModified 2013.0418
 */


require_once($global['approot']."/inc/lib_form_return.inc");
// create an array as it does not exist previosuly and will make warnings
$global['xajax_functions'] = array();

// publicly register accessible xajax funtions
array_push($global['xajax_functions'],'mon_append_log');
array_push($global['xajax_functions'],'mon_prepend_log');
array_push($global['xajax_functions'],'mon_show_message');
array_push($global['xajax_functions'],'mon_show_patients');
array_push($global['xajax_functions'],'mon_add_data');
array_push($global['xajax_functions'],'mon_perform_save');
array_push($global['xajax_functions'],'mon_show_list_for_patient');
array_push($global['xajax_functions'],'mon_edit_data');

/**
 * adds a message to the log div @ tail
 * @param string $message
 * @return mixed
 */
function mon_append_log($message = "no message specified?") {

	global $global;
	$global['xajax_res']->addAppend('monLog', 'innerHTML', $message);
	//---- scroll the log to the bottom
	$global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'monLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
	return $global['xajax_res']->getXML();
}


/**
 * adds a message to the log div @ head
 * @param string $message
 * @return mixed
 */
function mon_prepend_log($message = "no message specified?") {

	global $global;
	$global['xajax_res']->addPrepend('monLog','innerHTML',$message);
	return $global['xajax_res']->getXML();
}

/**
 * shows a status message before another ajax function is executed
 * @param string $message
 * @return mixed
 */
function mon_show_message($message = "no message specified?") {

	global $global;
	$global['xajax_res']->addAssign('monMain','innerHTML','<div class="loadingMessage"><center><blink>'.$message.'</blink></center></div>');
	return $global['xajax_res']->getXML();
}

/**
 * Function to show patient list for all diseases
 * @param bool $internal Whether the function call is internal
 * @return string
 */
function mon_show_patients($internal = FALSE) {
	global $conf;
	global $global;
	$htmlLog = "";
	$htmlMain = "";
	$total = 0;
	$char = "<span style=\"text-shadow: 1px 1px 1px #000;\">▶</span>";

	$htmlMain .= "
			<table class=\"emTable\">
			<tr>
			<td style=\"font-size: 120%; padding-left: 8px;\" ><b>Name</b></td>
			<td style=\"font-size: 120%; padding-left: 8px;text-align: center;\" ><b>UUID</b></td>
			<td style=\"font-size: 120%; padding-left: 8px;text-align: center;\" ><b>Disease</b></td>
			<td style=\"font-size: 120%; padding-left: 8px;text-align: center;\" ><b>View Current Data</b></td>
			<td style=\"font-size: 120%; padding-left: 8px;text-align: center;\" ><b>Add monitoring Data</b></td>
			</tr>
			";

	$q = "
			SELECT p.p_uuid, p.full_name, d.name
			FROM patient_uuid AS p, patient_status AS s, disease AS d
			WHERE p.p_uuid = s.p_uuid
			AND s.opt_status = 'sus'
			AND p.disease_id IS NOT NULL
			AND p.disease_id = d.disease_id;
			";
	$result = $global['db']->Execute($q);
	if($result === false) {
		daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "show patients");
	}
	$pcount = 0;
	$patients = array();
	while ( $row = $result->FetchRow() ) {
		$patients[$pcount] = $row;
		$pcount++;
	}
	$eo = 0;
	for ( $i = 0; $i < count($patients); $i++ ) {
		$row		=	$patients[$i];
		$uuid		=	$row['p_uuid'];
		$name		=	'<b>'.$row['full_name'].'</b>';
		$disease	=	$row['name'];

		if(($eo % 2) == 0) {
			$evenOddClass = "mainRowEven";
		} else {
			$evenOddClass = "mainRowOdd";
		}

		$htmlMain .= "
				<tr>
				<td style=\"padding-left: 8px;\" class=\"".$evenOddClass."\">".$name."</td>
				<td style=\"padding-left: 8px; text-align: center;\" class=\"".$evenOddClass."\"><a href=\"http://{$uuid}\">".$uuid."</a></td>
				<td style=\"padding-left: 8px; text-align: center;\" class=\"".$evenOddClass."\">".$disease."</td>
				<td style=\"padding-left: 8px; text-align: center;\" class=\"".$evenOddClass."\"><input class=\"styleTehButton\" type=\"button\" onclick=\"javascript: mon_append_log('Showing monitoring data for patient <b>".$name." </b>...<br>'); mon_show_list_for_patient('".$uuid."');\" value=\"View\"></td>
				<td style=\"padding-left: 8px; text-align: center;\" class=\"".$evenOddClass."\"><input class=\"styleTehButton\" type=\"button\" onclick=\"javascript: mon_append_log('Adding Monitoring data for patient <b>".$name." </b>...<br>'); mon_add_data('".$uuid."');\" value=\"Add\"></td>
				</tr>
				";
		$eo++;
	}
	$htmlMain .= "</table>";
	$pageControlHtml = "";
    if ( $internal ) {
        return $htmlMain;
    }
    else {
        $global['xajax_res']->addAssign('monMain','style.opacity','1.0');
        $global['xajax_res']->addAssign('monMain','innerHTML',$htmlMain);
        $global['xajax_res']->addAssign('monControl','style.opacity','1.0');
	    $global['xajax_res']->addAssign('monControl','innerHTML',$pageControlHtml);
        $htmlLog .= _t("Found <b>").$pcount._t("</b> Patient(s).<br>");
        $global['xajax_res']->addAppend('monLog','innerHTML',$htmlLog);
        $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'monLog \'); e.scrollTop = e.scrollHeight+1000;', 500);");
        return $global['xajax_res']->getXML();
    }
}

/**
 * Function to add new monitoring data for a single patient
 * @param $uuid patient UUID
 * @return mixed XAJAX XML
 */
function mon_add_data($uuid) {
	global $global;
	$htmlLog = "";
	$htmlMain = "";
	
	$htmlMain .= shn_form_fopen_return("", null, array('enctype'=>'enctype="multipart/form-data"', 'req_message' => true));
    $htmlMain .= shn_form_fsopen_return("Monitoring Date");
    $htmlMain .= shn_form_text_return("Date of report", "monitoringDate");
    $htmlMain .= shn_form_fsclose_return();

	$htmlMain .= shn_form_fsopen_return("Basic Metrics");
	$htmlMain .= shn_form_text_return("Height", "mon_height")
				.shn_form_text_return("Weight", "mon_weight")
				.shn_form_text_return("Waist Circumference", "waist_circumference");
	$htmlMain .= shn_form_fsclose_return();

	
	$htmlMain .= shn_form_fsopen_return("General Examination");
	$htmlMain .= shn_form_select_return(array("Normal" => "Normal","Frail" => "Frail", "Drowsy" => "Drowsy", "Breathless" => "Breathless"), "Physical Appearance", "physical_appearance");
	$htmlMain .= shn_form_select_return(array("Normal" => "Normal", "Anxious" => "Anxious", "Distressed" => "Distressed", "Confused" => "Confused"), "Mental State", "mental_state");
	$htmlMain .= shn_form_select_return(array("Normal" => "Normal","Undernourised" => "Undernourised", "Cachectic" => "Cachectic", "Obese" => "Obese"), "Nourishment Status", "nourishment_status");
	$htmlMain .= shn_form_select_return(array("None" => "None","Ketones" => "Ketones", "Alcohol" => "Alcohol", "Ureamia" => "Ureamia", "Foetor Hepaticus"=>"Foetor Hepaticus"), "Abnormal Smells", "abnormal_smells");
	$htmlMain .= shn_form_select_return(array("Normal" => "Normal","Cyanosis" => "Cyanosis", "Pallor" => "Pallor", "Jaundice" => "Jaundice", "Lesions/Rashes"=>"Lesions/Rashes"), "Skin", "skin");
	$htmlMain .= shn_form_textarea_return("Lymph Nodes: Characteristics and sites", "lymph_nodes");
	$htmlMain .= shn_form_textarea_return("Hands: Characteristics", "hands");
	$htmlMain .= shn_form_fsclose_return();
	
	$htmlMain .= shn_form_fsopen_return("Cardiovascular System");
	$htmlMain .= shn_form_text_return("Pulse Rate", "cvs_pulse_rate")
				.shn_form_text_return("Rhythm Character", "cvs_rhythm")
				.shn_form_text_return("Volume", "cvs_volume")
				.shn_form_text_return("Blood Pressure", "cvs_pressure")
				.shn_form_text_return("Heart Sounds", "cvs_heart_sounds")
				.shn_form_text_return("Ankle Oedema", "cvs_ankle_oedema")
				.shn_form_text_return("Peripheral pulses", "cvs_peripheral_pulses")
					;
	$htmlMain .= shn_form_fsclose_return();
	
	$htmlMain .= shn_form_fsopen_return("Respiratory System");
	$htmlMain .= shn_form_textarea_return("Chest Wall Deformities", "res_chest_wall_deformities")
				.shn_form_text_return("Tracheal Deviation", "res_tracheal_deviation")
				.shn_form_text_return("Percussion Note", "res_percussion_note")
				.shn_form_text_return("Breath Sounds", "res_breath_sounds")
				.shn_form_text_return("Vocal Resonance", "res_vocal_resonance");
	$htmlMain .= shn_form_fsclose_return();
	
	$htmlMain .= shn_form_fsopen_return("Abdomen");
	$htmlMain .= shn_form_text_return("Tenderness", "ab_tenderness")
	.shn_form_text_return("Ascites", "ab_ascites")
	.shn_form_text_return("Enlargement of the Liver", "ab_liver_enlargement")
	.shn_form_text_return("Kidney Status", "ab_kidney")
	.shn_form_text_return("Spleen enlargement", "ab_spleen_enlargement");
	$htmlMain .= shn_form_fsclose_return();
	
	$htmlMain .= shn_form_fsopen_return("Central Nervous System");
	$htmlMain .= shn_form_text_return("Speech", "cns_speech")
			  	.shn_form_text_return("Cranial Nerves", "cns_cranial_nerves");
	$htmlMain .= shn_form_label_return("Glasgow Coma Scale","GCS");
	$htmlMain .= shn_form_select_return(array("1"=>"1","2"=>"2","3"=>"3","4"=>"4","5"=>"5","6"=>"6"), "Eyes", "cns_glasgow_eyes");
	$htmlMain .= shn_form_select_return(array("1"=>"1","2"=>"2","3"=>"3","4"=>"4","5"=>"5","6"=>"6"), "Verbal", "cns_glasgow_verbal");
	$htmlMain .= shn_form_select_return(array("1"=>"1","2"=>"2","3"=>"3","4"=>"4","5"=>"5","6"=>"6"), "Motor", "cns_glasgow_motor");
	$htmlMain .= shn_form_fsclose_return();
	
	
	$htmlMain .= shn_form_fsopen_return("Musculoskeletal");
	$htmlMain .= shn_form_text_return("Gait", "ms_gait")
	.shn_form_text_return("Swelling", "ms_swelling");
	$htmlMain .= shn_form_fsclose_return();
	$htmlMain .= shn_form_fclose_return();
	
	// control HTML
	$editControlHtml = '
	
		<input class="styleTehButton" type="button" onclick="javascript: mon_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'mon_show_patients();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: mon_append_log(\''._t('Saving Changes...').'<br>\'); mon_perform_save(\''.$uuid.'\', mon_get_data());" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: mon_append_log(\''._t('Saving Changes and Closing...<br>').'\'); mon_perform_save(\''.$uuid.'\', mon_get_data()); " value="'._t('Save Changes and Close').'">
	';
    //setTimeout(\'mon_perform_save('.$uuid.', mon_get_data());\', 250)
	$global['xajax_res']->addAssign('monMain','style.opacity','1.0');
	$global['xajax_res']->addAssign('monMain','innerHTML',$htmlMain);
	$global['xajax_res']->addAssign('monControl', 'innerHTML', $editControlHtml);
	$global['xajax_res']->addAppend('monLog','innerHTML',$htmlLog);
	$global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'monLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    $global['xajax_res']->addScript("initCalendar();");
	return $global['xajax_res']->getXML();
}

/**
 * Performs save on new data
 * @param string $uuid Patient UUID
 * @param string $rj JSON string returned by JS
 */
function mon_perform_save($uuid, $rj, $update = false) {

	global $global;
	$r = json_decode($rj, true);
	$log = "";
	
	$mon_height                	 	= mysql_real_escape_string($r["mon_height"]);
	$mon_weight                     = mysql_real_escape_string($r["mon_weight"]);
	$waist_circumference            = mysql_real_escape_string($r["waist_circumference"]);
	$physical_appearance            = mysql_real_escape_string($r["physical_appearance"]);
	$mental_state                   = mysql_real_escape_string($r["mental_state"]);
	$nourishment_status             = mysql_real_escape_string($r["nourishment_status"]);
	$abnormal_smells                = mysql_real_escape_string($r["abnormal_smells"]);
	$skin                         	= mysql_real_escape_string($r["skin"]);
	$lymph_nodes                    = mysql_real_escape_string($r["lymph_nodes"]);
	$hands                    		= mysql_real_escape_string($r["hands"]);
	$cvs_pulse_rate                 = mysql_real_escape_string($r["cvs_pulse_rate"]);
    $cvs_rhythm                     = mysql_real_escape_string($r["cvs_rhythm"]);
	$cvs_volume                     = mysql_real_escape_string($r["cvs_volume"]);
	$cvs_pressure                   = mysql_real_escape_string($r["cvs_pressure"]);
	$cvs_heart_sounds               = mysql_real_escape_string($r["cvs_heart_sounds"]);
	$cvs_ankle_oedema               = mysql_real_escape_string($r["cvs_ankle_oedema"]);
	$cvs_peripheral_pulses          = mysql_real_escape_string($r["cvs_peripheral_pulses"]);
	$res_chest_wall_deformities     = mysql_real_escape_string($r["res_chest_wall_deformities"]);
	$res_tracheal_deviation         = mysql_real_escape_string($r["res_tracheal_deviation"]);
	$res_percussion_note 			= mysql_real_escape_string($r["res_percussion_note"]);
	$res_breath_sounds              = mysql_real_escape_string($r["res_breath_sounds"]);
	$res_vocal_resonance            = mysql_real_escape_string($r["res_vocal_resonance"]);
	$ab_tenderness                  = mysql_real_escape_string($r["ab_tenderness"]);
	$ab_ascites                     = mysql_real_escape_string($r["ab_ascites"]);
	$ab_liver_enlargement           = mysql_real_escape_string($r["ab_liver_enlargement"]);
    $ab_kidney                      = mysql_real_escape_string($r["ab_kidney"]);
    $ab_spleen_enlargement          = mysql_real_escape_string($r["ab_spleen_enlargement"]);
	$cns_speech                     = mysql_real_escape_string($r["cns_speech"]);
	$cns_cranial_nerves             = mysql_real_escape_string($r["cns_cranial_nerves"]);
	$cns_glasgow_eyes               = mysql_real_escape_string($r["cns_glasgow_eyes"]);
	$cns_glasgow_verbal 			= mysql_real_escape_string($r["cns_glasgow_verbal"]);
	$cns_glasgow_motor              = mysql_real_escape_string($r["cns_glasgow_motor"]);
	$ms_gait                        = mysql_real_escape_string($r["ms_gait"]);
	$ms_swelling                    = mysql_real_escape_string($r["ms_swelling"]);
    $entry_date                     = mysql_real_escape_string($r["entry_date"]);

    if ( $update ) {
        $q = "
            UPDATE patient_monitoring
            SET mon_height                  ='".$mon_height."',
                mon_weight                  ='".$mon_weight."',
                waist_circumference         ='".$waist_circumference."',
                physical_appearance         ='".$physical_appearance."',
                mental_state                ='".$mental_state."',
                nourishment_status          ='".$nourishment_status."',
                abnormal_smells             ='".$abnormal_smells."',
                skin                        ='".$skin."',
                lymph_nodes                 ='".$lymph_nodes."',
                hands                       ='".$hands."',
                cvs_pulse_rate              ='".$cvs_pulse_rate."',
                cvs_rhythm                  ='".$cvs_rhythm."',
                cvs_volume                  ='".$cvs_volume."',
                cvs_pressure                ='".$cvs_pressure."',
                cvs_heart_sounds            ='".$cvs_heart_sounds."',
                cvs_ankle_oedema            ='".$cvs_ankle_oedema."',
                cvs_peripheral_pulses       ='".$cvs_peripheral_pulses."',
                res_chest_wall_deformities  ='".$res_chest_wall_deformities."',
                res_tracheal_deviation      ='".$res_tracheal_deviation."',
                res_percussion_note         ='".$res_percussion_note."',
                res_breath_sounds           ='".$res_breath_sounds."',
                res_vocal_resonance         ='".$res_vocal_resonance."',
                ab_tenderness               ='".$ab_tenderness."',
                ab_ascites                  ='".$ab_ascites."',
                ab_liver_enlargement        ='".$ab_liver_enlargement."',
                ab_kidney                   ='".$ab_kidney."',
                ab_spleen_enlargement       ='".$ab_spleen_enlargement."',
                cns_speech                  ='".$cns_speech."',
                cns_cranial_nerves          ='".$cns_cranial_nerves."',
                cns_glasgow_eyes            ='".$cns_glasgow_eyes."',
                cns_glasgow_verbal          ='".$cns_glasgow_verbal."',
                cns_glasgow_motor           ='".$cns_glasgow_motor."',
                ms_gait                     ='".$ms_gait."',
                ms_swelling                 ='".$ms_swelling."',
                entry_date                  ='".$entry_date."'
            WHERE p_uuid='".$uuid."'
            AND disease_id=1
            AND entry_date='".$entry_date."'
             ";
    }
    else {
        $q = "
            INSERT INTO patient_monitoring
            VALUES('',
                   '".$uuid."',
                   '1',
                   '".$mon_height."',
                   '".$mon_weight."',
                   '".$waist_circumference."',
                   '".$physical_appearance."',
                   '".$mental_state."',
                   '".$nourishment_status."',
                   '".$abnormal_smells."',
                   '".$skin."',
                   '".$lymph_nodes."',
                   '".$hands."',
                   '".$cvs_pulse_rate."',
                   '".$cvs_rhythm."',
                   '".$cvs_volume."',
                   '".$cvs_pressure."',
                   '".$cvs_heart_sounds."',
                   '".$cvs_ankle_oedema."',
                   '".$cvs_peripheral_pulses."',
                   '".$res_chest_wall_deformities."',
                   '".$res_tracheal_deviation."',
                   '".$res_percussion_note."',
                   '".$res_breath_sounds."',
                   '".$res_vocal_resonance."',
                   '".$ab_tenderness."',
                   '".$ab_ascites."',
                   '".$ab_liver_enlargement."',
                   '".$ab_kidney."',
                   '".$ab_spleen_enlargement."',
                   '".$cns_speech."',
                   '".$cns_cranial_nerves."',
                   '".$cns_glasgow_eyes."',
                   '".$cns_glasgow_verbal."',
                   '".$cns_glasgow_motor."',
                   '".$ms_gait."',
                   '".$ms_swelling."',
                   '".$entry_date."'
             )";
    }
    $result = $global['db']->Execute($q);
    if($result === false) { daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "monitoring save 1"); }

    $log .= "Monitoring details for patient #<b>".$uuid."</b> <span style=\"color: green;\">Saved</span>.<b><br>";
    //$global['xajax_res']->addAssign('rezMain', 'innerHTML', mon_show_patients(TRUE));
    $global['xajax_res']->addAppend('monLog', 'innerHTML', $log);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'monLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    return $global['xajax_res']->getXML();


}

/**
 * Function to list out previous monitoring reports for a patient
 * @param $uuid
 */
function mon_show_list_for_patient($uuid) {
    global $global;
    $htmlMain = "";
    $htmlMain .= "
			<table class=\"emTable\">
			<tr>
			<td style=\"font-size: 120%; padding-left: 8px;\" ><b>Date</b></td>
			<td style=\"font-size: 120%; padding-left: 8px;text-align: center;\" ><b>View/Edit</b></td>
			</tr>
			";
    $q = "
			SELECT entry_date
			FROM patient_monitoring
			WHERE p_uuid = '{$uuid}';
			";
    $result = $global['db']->Execute($q);
    if($result === false) {
        daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "show monitoring dates");
    }
    $pcount = 0;
    $dates = array();
    while ( $row = $result->FetchRow() ) {
        $dates[$pcount] = $row;
        $pcount++;
    }
    $eo = 0;
    for ( $i = 0; $i < count($dates); $i++ ) {
        $row		            =	$dates[$i];
        $monitoring_date		=	$row['entry_date'];

        if(($eo % 2) == 0) {
            $evenOddClass = "mainRowEven";
        } else {
            $evenOddClass = "mainRowOdd";
        }
        $htmlMain .= "
				<tr>
				<td style=\"padding-left: 8px;\" class=\"".$evenOddClass."\"><b>".$monitoring_date."</b></td>
				<td style=\"padding-left: 8px; text-align: center;\" class=\"".$evenOddClass."\"><input class=\"styleTehButton\" type=\"button\" onclick=\"javascript: mon_append_log('Showing monitoring data for patient on date <b>".$monitoring_date." </b>...<br>'); mon_edit_data('".$uuid."','".$monitoring_date."');\" value=\"View/Edit\"></td>
				</tr>
				";
        $eo++;
    }

    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: mon_append_log(\''._t('Closing Monitoring List...').'<br>\'); setTimeout(\'mon_show_patients();\', 250);" value="'._t('Cancel Edit / Close').'">

		';
    $global['xajax_res']->addAssign('monControl','innerHTML',$editControlHtml);
    $global['xajax_res']->addAssign('monControl','style.opacity','1.0');
    $global['xajax_res']->addAssign('monMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('monMain','innerHTML',$htmlMain);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'monLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    return $global['xajax_res']->getXML();
}

/**
 *
 * Functino to view/edit monitoring for a particular patient on a particular date
 * @param $uuid
 * @param $monitoring_date
 */
function mon_edit_data($uuid, $monitoring_date) {
    global $global;
    $htmlLog = "";
    $htmlMain = "";
    $q = "
			SELECT *
			FROM patient_monitoring
			WHERE p_uuid = '{$uuid}'
			AND entry_date = '{$monitoring_date}';
			";
    $result = $global['db']->Execute($q);
    if($result === false) {
        daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "show monitoring data 1");
    }

    $row = $result->FetchRow();

    $htmlMain .= shn_form_fopen_return("", null, array('enctype'=>'enctype="multipart/form-data"', 'req_message' => true));
    $htmlMain .= shn_form_fsopen_return("Monitoring Date");
    $htmlMain .= shn_form_text_return("Date of report", "monitoringDate", null, array("value"=>$row['entry_date'], "disabled"=>TRUE));
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Basic Metrics");
    $htmlMain .= shn_form_text_return("Height", "mon_height", null, array("value" => $row['mon_height']))
        .shn_form_text_return("Weight", "mon_weight", null, array("value" => $row['mon_weight']))
        .shn_form_text_return("Waist Circumference", "waist_circumference", null, array("value" => $row['waist_circumference']));
    $htmlMain .= shn_form_fsclose_return();


    $htmlMain .= shn_form_fsopen_return("General Examination");
    $htmlMain .= shn_form_select_return(array("Normal" => "Normal","Frail" => "Frail", "Drowsy" => "Drowsy", "Breathless" => "Breathless"),
        "Physical Appearance", "physical_appearance","",array("value" => $row['physical_appearance']));
    $htmlMain .= shn_form_select_return(array("Normal" => "Normal", "Anxious" => "Anxious", "Distressed" => "Distressed", "Confused" => "Confused"),
        "Mental State", "mental_state","",array("value" => $row['mental_state']));
    $htmlMain .= shn_form_select_return(array("Normal" => "Normal","Undernourised" => "Undernourised", "Cachectic" => "Cachectic", "Obese" => "Obese"),
        "Nourishment Status", "nourishment_status","",array("value" => $row['nourishment_status']));
    $htmlMain .= shn_form_select_return(array("None" => "None","Ketones" => "Ketones", "Alcohol" => "Alcohol", "Ureamia" => "Ureamia", "Foetor Hepaticus"=>"Foetor Hepaticus"),
        "Abnormal Smells", "abnormal_smells","",array("value" => $row['abnormal_smells']));
    $htmlMain .= shn_form_select_return(array("Normal" => "Normal","Cyanosis" => "Cyanosis", "Pallor" => "Pallor", "Jaundice" => "Jaundice", "Lesions/Rashes"=>"Lesions/Rashes"),
        "Skin", "skin","",array("value" => $row['skin']));
    $htmlMain .= shn_form_textarea_return("Lymph Nodes: Characteristics and sites", "lymph_nodes" ,"",array("value" => $row['lymph_nodes']));
    $htmlMain .= shn_form_textarea_return("Hands: Characteristics", "hands","",array("value" => $row['hands']));
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Cardiovascular System");
    $htmlMain .= shn_form_text_return("Pulse Rate", "cvs_pulse_rate", null, array("value" => $row['cvs_pulse_rate']))
        .shn_form_text_return("Rhythm Character", "cvs_rhythm", null, array("value" => $row['cvs_rhythm']))
        .shn_form_text_return("Volume", "cvs_volume", null, array("value" => $row['cvs_volume']))
        .shn_form_text_return("Blood Pressure", "cvs_pressure", null, array("value" => $row['cvs_pressure']))
        .shn_form_text_return("Heart Sounds", "cvs_heart_sounds", null, array("value" => $row['cvs_heart_sounds']))
        .shn_form_text_return("Ankle Oedema", "cvs_ankle_oedema", null, array("value" => $row['cvs_ankle_oedema']))
        .shn_form_text_return("Peripheral pulses", "cvs_peripheral_pulses", null, array("value" => $row['cvs_peripheral_pulses']))
    ;
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Respiratory System");
    $htmlMain .= shn_form_textarea_return("Chest Wall Deformities", "res_chest_wall_deformities", null, array("value" => $row['res_chest_wall_deformities']))
        .shn_form_text_return("Tracheal Deviation", "res_tracheal_deviation", null, array("value" => $row['res_tracheal_deviation']))
        .shn_form_text_return("Percussion Note", "res_percussion_note", null, array("value" => $row['res_percussion_note']))
        .shn_form_text_return("Breath Sounds", "res_breath_sounds", null, array("value" => $row['res_breath_sounds']))
        .shn_form_text_return("Vocal Resonance", "res_vocal_resonance", null, array("value" => $row['res_vocal_resonance']));
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Abdomen");
    $htmlMain .= shn_form_text_return("Tenderness", "ab_tenderness", null, array("value" => $row['ab_tenderness']))
        .shn_form_text_return("Ascites", "ab_ascites", null, array("value" => $row['ab_ascites']))
        .shn_form_text_return("Enlargement of the Liver", "ab_liver_enlargement", null, array("value" => $row['ab_liver_enlargement']))
        .shn_form_text_return("Kidney Status", "ab_kidney", null, array("value" => $row['ab_kidney']))
        .shn_form_text_return("Spleen enlargement", "ab_spleen_enlargement", null, array("value" => $row['ab_spleen_enlaragement']));
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Central Nervous System");
    $htmlMain .= shn_form_text_return("Speech", "cns_speech")
        .shn_form_text_return("Cranial Nerves", "cns_cranial_nerves");
    $htmlMain .= shn_form_label_return("Glasgow Coma Scale","GCS");
    $htmlMain .= shn_form_select_return(array("1"=>"1","2"=>"2","3"=>"3","4"=>"4","5"=>"5","6"=>"6"), "Eyes", "cns_glasgow_eyes"
        ,"",array("value" => $row['cns_glasgow_eyes']));
    $htmlMain .= shn_form_select_return(array("1"=>"1","2"=>"2","3"=>"3","4"=>"4","5"=>"5","6"=>"6"), "Verbal", "cns_glasgow_verbal"
        ,"",array("value" => $row['cns_gloasgow_verbal']));
    $htmlMain .= shn_form_select_return(array("1"=>"1","2"=>"2","3"=>"3","4"=>"4","5"=>"5","6"=>"6"), "Motor", "cns_glasgow_motor"
        ,"",array("value" => $row['cns_glasgow_motor']));
    $htmlMain .= shn_form_fsclose_return();


    $htmlMain .= shn_form_fsopen_return("Musculoskeletal");
    $htmlMain .= shn_form_text_return("Gait", "ms_gait", null, array("value" => $row['ms_gait']))
        .shn_form_text_return("Swelling", "ms_swelling", null, array("value" => $row['ms_swelling']));
    $htmlMain .= shn_form_fsclose_return();
    $htmlMain .= shn_form_fclose_return();

    // control HTML
    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: mon_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'mon_show_patients();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: mon_append_log(\''._t('Saving Changes...').'<br>\'); mon_perform_save(\''.$uuid.'\', mon_get_data(), true);" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: mon_append_log(\''._t('Saving Changes and Closing...<br>').'\'); mon_perform_save(\''.$uuid.'\', mon_get_data(), true); " value="'._t('Save Changes and Close').'">
	';
    $global['xajax_res']->addAssign('monControl','innerHTML',$editControlHtml);
    $global['xajax_res']->addAssign('monControl','style.opacity','1.0');
    $global['xajax_res']->addAssign('monMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('monMain','innerHTML',$htmlMain);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'monLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    return $global['xajax_res']->getXML();
}