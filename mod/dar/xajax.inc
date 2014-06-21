<?php
/**
 * @name         Disaster Assessment and Response
 * @version      01
 * @package      dar
 * @author       Ramindu Deshapriya <rdeshapriya@virtusa.com>
 * @about        Developed in whole or part by the U.S. National Library of Medicine,the Sahana Foundation and Virtusa Corpodarion
 * @link         https://pl.nlm.nih.gov/about
 * @link         http://sahanafoundation.org
 * @link         http://www.virtusa.com
 * @license         http://www.gnu.org/licenses/lgpl-2.1.html GNU Lesser General Public License (LGPL)
 * @lastModified 2013.11.21
 */

require_once($global['approot']."/inc/lib_form_return.inc");
global $global;

// create an array as it does not exist previosuly and will make warnings
$global['xajax_functions'] = array();

// publicly register accessible xajax funtions
array_push($global['xajax_functions'], 'dar_append_log');
array_push($global['xajax_functions'], 'dar_prepend_log');
array_push($global['xajax_functions'], 'dar_show_message');
array_push($global['xajax_functions'], 'dar_load_general');
array_push($global['xajax_functions'], 'dar_load_popres');
array_push($global['xajax_functions'], 'dar_load_wash');
array_push($global['xajax_functions'], 'dar_load_food');
array_push($global['xajax_functions'], 'dar_load_shelter');

array_push($global['xajax_functions'], 'dar_perform_save');


// adds a message to the log div @ tail
function dar_append_log($message = "no message specified?")
{

    global $global;
    $global['xajax_res']->addAppend('darLog', 'innerHTML', $message);
    //---- scroll the log to the bottom
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'darLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    return $global['xajax_res']->getXML();
}


// adds a message to the log div @ head
function dar_prepend_log($message = "no message specified?")
{

    global $global;
    $global['xajax_res']->addPrepend('darLog', 'innerHTML', $message);
    return $global['xajax_res']->getXML();
}


// shows a status message before another ajax function is executed
function dar_show_message($message = "no message specified?")
{

    global $global;
    $global['xajax_res']->addAssign('darMain', 'innerHTML', '<div class="loadingMessage"><center><blink>' . $message . '</blink></center></div>');
    return $global['xajax_res']->getXML();
}

/**
 * Function to load the General Information section
 */
function dar_load_general()
{
    global $global;
    $htmlLog = "";
    $htmlMain = "";
    $_SESSION['dar_current_page'] = "general";
    $htmlMain .= shn_form_fopen_return("", null, array('enctype' => 'enctype="multipart/form-data"', 'req_message' => true));
    $htmlMain .= shn_form_fsopen_return("General Information");
    $htmlMain .= shn_form_select_return(array("Flood" => "Flood", "Drought" => "Drought", "Landslide" => "Landslide"),
        "Type of Disaster", "disaster_type");
    $htmlMain .= shn_form_text_return("Date of Assessment", "reportDate");
    $htmlMain .= shn_form_text_return("Date of Disaster", "disasterDate");
    $htmlMain .= shn_form_select_return(array("Galle" => "Galle", "Nuwara Eliya" => "Nuwara Eliya", "Ampara" => "Ampara"),
        "Affected Area Name", "affected_area");
    $htmlMain .= shn_form_select_return(array("A1" => "A1", "A2" => "A2", "A3" => "A3"), "Name of Focal Point", "focal_point_name");
    $htmlMain .= shn_form_select_return(array("GN" => "GN", "MOH" => "MOH", "District" => "District", "Province" => "Province"), "GN, MOH, District, Province", "area_type");
    $htmlMain .= shn_form_select_return(array("Ramindu Deshapriya" => "Ramindu Deshapriya", "Rasika Hedarh" => "Rasika Hedarh",
            "Chathura Thennakoon" => "Chathura Thennakoon", "Thilina Mendis" => "Thilina Mendis"), "Assessor's Name", "assessor_name");
    $htmlMain .= shn_form_select_return(array("MOH Admin" => "MOH Admin", "FP Admin" => "FP Admin",
        "HO" => "HO"), "Assessor's Designation", "assessor_designation");
    $htmlMain .= shn_form_select_return(array("Ramindu Deshapriya" => "Ramindu Deshapriya", "Rasika Hedarh" => "Rasika Hedarh"),
        "Focal Point Coordinator Name", "focal_point_coordinator");
    $htmlMain .= shn_form_fsclose_return();
    $htmlMain .= shn_form_fclose_return();

    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'dar_show_patients();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes...').'<br>\'); dar_perform_save(\''.$uuid.'\', dar_get_data());" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes and Closing...<br>').'\'); dar_perform_save(\''.$uuid.'\', dar_get_data()); " value="'._t('Save Changes and Close').'">
	';
    //setTimeout(\'dar_perform_save('.$uuid.', dar_get_data());\', 250)
    $global['xajax_res']->addAssign('darMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('darMain','innerHTML',$htmlMain);
    $global['xajax_res']->addAssign('darControl', 'innerHTML', $editControlHtml);
    $global['xajax_res']->addAppend('darLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'darLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    $global['xajax_res']->addScript("initCalendar();");
    return $global['xajax_res']->getXML();
}

function dar_load_popres() {
    global $global;
    $htmlLog = "";
    $htmlMain = "";
    $_SESSION['dar_current_page'] = "popRes";
    $htmlMain .= shn_form_fopen_return("", null, array('enctype' => 'enctype="multipart/form-data"', 'req_message' => true));
    $htmlMain .= shn_form_fsopen_return("Population and Resource Data");
    $htmlMain .= shn_form_text_return("Total Area", "total_area");
    $htmlMain .= shn_form_text_return("Total Population in area", "area_population");
    $htmlMain .= shn_form_text_return("Affected Area", "affected_area");

    $htmlMain .= shn_form_fsopen_return("Injured Persons");
    $htmlMain .= shn_form_text_return("Male", "male_injured");
    $htmlMain .= shn_form_text_return("Female", "female_injured");
    $htmlMain .= shn_form_text_return("Pregnant Females", "pregnant_female_injured");
    $htmlMain .= shn_form_text_return("Children", "children_injured");
    $htmlMain .= shn_form_text_return("Between ages 1-5", "young_children_injured");
    $htmlMain .= shn_form_text_return("Infants", "infants_injured");
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Displaced Persons");
    $htmlMain .= shn_form_text_return("Male", "male_displaced");
    $htmlMain .= shn_form_text_return("Female", "female_displaced");
    $htmlMain .= shn_form_text_return("Pregnant Females", "pregnant_female_displaced");
    $htmlMain .= shn_form_text_return("Children", "children_displaced");
    $htmlMain .= shn_form_text_return("Between ages 1-5", "young_children_displaced");
    $htmlMain .= shn_form_text_return("Infants", "infants_displaced");
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Missing Persons");
    $htmlMain .= shn_form_text_return("Male", "male_missing");
    $htmlMain .= shn_form_text_return("Female", "female_missing");
    $htmlMain .= shn_form_text_return("Pregnant Females", "pregnant_female_missing");
    $htmlMain .= shn_form_text_return("Children", "children_missing");
    $htmlMain .= shn_form_text_return("Between ages 1-5", "young_children_missing");
    $htmlMain .= shn_form_text_return("Infants", "infants_missing");
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Deceased Persons");
    $htmlMain .= shn_form_text_return("Male", "male_deceased");
    $htmlMain .= shn_form_text_return("Female", "female_deceased");
    $htmlMain .= shn_form_text_return("Pregnant Females", "pregnant_female_deceased");
    $htmlMain .= shn_form_text_return("Children", "children_deceased");
    $htmlMain .= shn_form_text_return("Between ages 1-5", "young_children_deceased");
    $htmlMain .= shn_form_text_return("Infants", "infants_deceased");
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_select_return(array("Galle" => "Galle", "Nuwara Eliya" => "Nuwara Eliya", "Ampara" => "Ampara"),
        "Affected Area Name", "affected_area");
    $htmlMain .= shn_form_select_return(array("A1" => "A1", "A2" => "A2", "A3" => "A3"), "Name of Focal Point", "focal_point_name");
    $htmlMain .= shn_form_select_return(array("GN" => "GN", "MOH" => "MOH", "District" => "District", "Province" => "Province"), "GN, MOH, District, Province", "area_type");
    $htmlMain .= shn_form_select_return(array("Ramindu Deshapriya" => "Ramindu Deshapriya", "Rasika Hedarh" => "Rasika Hedarh",
        "Chathura Thennakoon" => "Chathura Thennakoon", "Thilina Mendis" => "Thilina Mendis"), "Assessor's Name", "assessor_name");
    $htmlMain .= shn_form_select_return(array("MOH Admin" => "MOH Admin", "FP Admin" => "FP Admin",
        "HO" => "HO"), "Assessor's Designation", "assessor_designation");
    $htmlMain .= shn_form_select_return(array("Ramindu Deshapriya" => "Ramindu Deshapriya", "Rasika Hedarh" => "Rasika Hedarh"),
        "Team Leader Name", "team_leader");
    $htmlMain .= shn_form_fsclose_return();
    $htmlMain .= shn_form_fclose_return();

    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'dar_show_patients();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes...').'<br>\'); dar_perform_save(\''.$uuid.'\', dar_get_data());" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes and Closing...<br>').'\'); dar_perform_save(\''.$uuid.'\', dar_get_data()); " value="'._t('Save Changes and Close').'">
	';
    //setTimeout(\'dar_perform_save('.$uuid.', dar_get_data());\', 250)
    $global['xajax_res']->addAssign('darMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('darMain','innerHTML',$htmlMain);
    $global['xajax_res']->addAssign('darControl', 'innerHTML', $editControlHtml);
    $global['xajax_res']->addAppend('darLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'darLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    $global['xajax_res']->addScript("initCalendar();");
    return $global['xajax_res']->getXML();
}

function dar_load_wash() {
    global $global;
    $htmlLog = "";
    $htmlMain = "";
    $_SESSION['dar_current_page'] = "wash";
    $htmlMain .= shn_form_fopen_return("", null, array('enctype' => 'enctype="multipart/form-data"', 'req_message' => true));
    $htmlMain .= shn_form_fsopen_return("Water");
    $htmlMain .= shn_form_select_return(array("1" => "Pipe-borne", "1" => "Open Well", "2" => "Reservoir"
    , "3" => "Hand-pumped well", "4" => "Other"),"Pre-disaster water source", "pre_disaster_water_source");
    $htmlMain .= shn_form_select_return(array("1" => "Similar to pre-disaster", "2" => "Greater than 75%",
        "3" => "Greater than 50%", "4" => "Less than 50%", "5" => "Less than 25%",
    "6" => "All damaged"),"Post-disaster water status", "post_disaster_water_status");
    $htmlMain .= shn_form_fsopen_return("Number of water sources");
    $htmlMain .= shn_form_text_return("Within 500m", "water_sources_within_range");
    $htmlMain .= shn_form_text_return("Further than 500m", "water_sources_further_than_range");
    $htmlMain .= shn_form_fsclose_return();
    $htmlMain .= shn_form_select_return(array("1" => "Yes", "0" => "No"),
        "Requirement of water treatment", "water_treatment_required");
    $htmlMain .= shn_form_text_return("Estimated Requirement of Water/day", "estimated_requirement_per_day");

    $htmlMain .= shn_form_fsopen_return("Estimated waiting time at a single water source");
    $htmlMain .= shn_form_text_return("Pipe-borne", "waiting_time_pipe_borne", null, array('help'=>'Estimated waiting time = Total water requirement  of the affected population / flow dare * available number within 500m => should be less than 30min'));
    $htmlMain .= shn_form_text_return("Open Well", "waiting_time_open_well", null, array('help'=>'Estimated waiting time = Total water requirement  of the affected population / flow dare * available number within 500m => should be less than 30min'));
    $htmlMain .= shn_form_text_return("Hand-pump", "waiting_time_hand_pump", null, array('help'=>'Estimated waiting time = Total water requirement  of the affected population / flow dare * available number within 500m => should be less than 30min'));
    $htmlMain .= shn_form_fsclose_return();
    $htmlMain .= shn_form_select_return(array("Yes" => "Yes", "No" => "No"),
        "Requirement basic hygiene training", "hygiene_training_required");
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Toilets");
    $htmlMain .= shn_form_text_return("Number of appropriately designed toilets", "number_of_toilets");
    $htmlMain .= shn_form_text_return("Required Number", "required_toilets_number", null, array("help"=>"On basis of one toilet per 20 people", "disabled"=>true));
    $htmlMain .= shn_form_text_return("Deficit", "toilet_deficit",null,array("help"=>"Required - Available","disabled"=>true));
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Tendency for vector-borne diseases");
    $htmlMain .= shn_form_text_return("Type of vector", "vector_type");
    $htmlMain .= shn_form_text_return("Name of disease", "vector_disease");
    $htmlMain .= shn_form_fsclose_return();

    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'dar_show_patients();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes...').'<br>\'); dar_perform_save(\''.$uuid.'\', dar_get_data());" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes and Closing...<br>').'\'); dar_perform_save(\''.$uuid.'\', dar_get_data()); " value="'._t('Save Changes and Close').'">
	';
    $global['xajax_res']->addAssign('darMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('darMain','innerHTML',$htmlMain);
    $global['xajax_res']->addAssign('darControl', 'innerHTML', $editControlHtml);
    $global['xajax_res']->addAppend('darLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'darLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    $global['xajax_res']->addScript("initCalendar();");
    return $global['xajax_res']->getXML();


}

function dar_load_food() {
    global $global;
    $htmlLog = "";
    $htmlMain = "";
    $_SESSION['dar_current_page'] = "food";
    $htmlMain .= shn_form_fopen_return("", null, array('enctype' => 'enctype="multipart/form-data"', 'req_message' => true));
    $htmlMain .= shn_form_fsopen_return("Food Security");
    $htmlMain .= shn_form_select_return(array("Disrupted" => "Disrupted", "Not Disrupted" => "Not Disrupted"),
        "Disruption of usual food prepadarion practices", "food_practices_disruption");
    $htmlMain .= shn_form_select_return(array("Yes" => "Yes", "No" => "No"),"Is there an accessible food source within 2km?",
        "accessible_food_source");


    $htmlMain .= shn_form_fsclose_return();

    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'dar_show_patients();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes...').'<br>\'); dar_perform_save(\''.$uuid.'\', dar_get_data());" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes and Closing...<br>').'\'); dar_perform_save(\''.$uuid.'\', dar_get_data()); " value="'._t('Save Changes and Close').'">
	';
    $global['xajax_res']->addAssign('darMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('darMain','innerHTML',$htmlMain);
    $global['xajax_res']->addAssign('darControl', 'innerHTML', $editControlHtml);
    $global['xajax_res']->addAppend('darLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'darLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    $global['xajax_res']->addScript("initCalendar();");
    return $global['xajax_res']->getXML();
}

function dar_load_shelter() {
    global $global;
    $htmlLog = "";
    $htmlMain = "";
    $_SESSION['dar_current_page'] = "shelter";
    $htmlMain .= shn_form_fopen_return("", null, array('enctype' => 'enctype="multipart/form-data"', 'req_message' => true));
    $htmlMain .= shn_form_fsopen_return("Number of Affected Houses");
    $htmlMain .= shn_form_text_return("Partially affected", "partially_affected_houses");
    $htmlMain .= shn_form_text_return("Totally affected", "totally_affected_houses");
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Number of People needing evacuation");
    $htmlMain .= shn_form_text_return("Families", "families_evacuation");
    $htmlMain .= shn_form_text_return("Population", "population_evacuation");
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Number of displaced people");
    $htmlMain .= shn_form_text_return("Families", "families_displaced");
    $htmlMain .= shn_form_text_return("Population", "population_displaced");
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Shelter estimates");
    $htmlMain .= shn_form_text_return("Estimated Number requiring shelter", "estimated_number_requiring_shelter");
    $htmlMain .= shn_form_text_return("Required area for shelter", "required_area_for_shelter");
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Temporary shelter availability");
    $htmlMain .= shn_form_select_return(array("Yes" => "Yes", "No" => "No"),"Is there temporary shelter available?",
        "temporary_shelter_available");
    $htmlMain .= shn_form_text_return("Total Covered Area", "temp_shelter_covered_area");
    $htmlMain .= shn_form_fsclose_return();

    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'dar_show_patients();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes...').'<br>\'); dar_perform_save(\''.$uuid.'\', dar_get_data());" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes and Closing...<br>').'\'); dar_perform_save(\''.$uuid.'\', dar_get_data()); " value="'._t('Save Changes and Close').'">
	';
    $global['xajax_res']->addAssign('darMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('darMain','innerHTML',$htmlMain);
    $global['xajax_res']->addAssign('darControl', 'innerHTML', $editControlHtml);
    $global['xajax_res']->addAppend('darLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'darLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    $global['xajax_res']->addScript("initCalendar();");
    return $global['xajax_res']->getXML();
}

function dar_perform_save($disaster_id, $data) {

	global $global;
	$q = "
		SELECT incident_id
		FROM incident
		WHERE shortname = '".mysql_real_escape_string($_GET['shortname'])."';
	";
	$result   = $global['db']->Execute($q);
	if($result === false) { daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "report default 1 ((".$q."))"); }
	$row      = $result->FetchRow();
	$incident_id   = $row['incident_id'];
		
	parse_str($data);

	if($_SESSION['dar_current_page'] == "popRes"){
		$q = "
			INSERT INTO population(disaster_id, total_area, area_population, affected_area, male_injured, female_injured, pregnant_female_injured, young_children_injured, infants_injured, children_injured, male_displaced, female_displaced, pregnant_female_displaced, children_displaced, young_children_displaced, infants_displaced, male_missing, female_missing, pregnant_female_missing, children_missing, young_children_missing, infants_missing, male_deceased, female_deceased, pregnant_female_deceased, children_deceased, young_children_deceased, infants_deceased  )
			VALUES ( $disaster_id, $total_area, $area_population, $affected_area, $male_injured, $female_injured, $pregnant_female_injured, $young_children_injured, $infants_injured, $children_injured, $male_displaced, $female_displaced, $pregnant_female_displaced, $children_displaced, $young_children_displaced, $infants_displaced, $male_missing, $female_missing, $pregnant_female_missing, $children_missing, $young_children_missing, $infants_missing, $male_deceased, $female_deceased, $pregnant_female_deceased, $children_deceased, $young_children_deceased, $infants_deceased  );
		";
		$result = $global['db']->Execute($q);
		if($result === false) { daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "Inserting feature"); }

	}
	else if($_SESSION['dar_current_page'] == "wash"){
		$q = "
			INSERT INTO wash(disaster_id, water_resources_id, water_status, water_in500, water_out500, need_treatment, water_per_day, wait_pipe_borne, wait_open_well, wait_hand_pump, need_hygin_training, toilets, required_toilets, deficit_toilet, vector_type, vector_name  )
			VALUES ( $disaster_id, $pre_disaster_water_source, $post_disaster_water_status, $water_sources_within_range, $water_sources_further_than_range, $water_treatment_required, $estimated_requirement_per_day, 
			$waiting_time_pipe_borne, $waiting_time_open_well, $waiting_time_hand_pump, $hygiene_training_required, $number_of_toilets, $required_toilets_number, $toilet_deficit, $vector_type, $vector_disease );
		";
		$result = $global['db']->Execute($q);
		if($result === false) { daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "Inserting feature"); }

	}
	else if($_SESSION['dar_current_page'] == "food"){
		$q = "
			INSERT INTO wash(disaster_id, food_disruption, food_in200 )
			VALUES ( $disaster_id, $food_practices_disruption, $accessible_food_source );
		";
		$result = $global['db']->Execute($q);
		if($result === false) { daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "Inserting feature"); }

	}

	//$global['xajax_res']->addAppend('darLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'darLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    return $global['xajax_res']->getXML();
	
}






