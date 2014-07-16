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
array_push($global['xajax_functions'], 'dar_load_capacity');
array_push($global['xajax_functions'], 'dar_load_hazard');

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


/**
 * shows a status message before another ajax function is executed
 */
function dar_show_message($message = "no message specified?")
{

    global $global;
    $global['xajax_res']->addAssign('darMain', 'innerHTML', '<div class="loadingMessage"><center><blink>' . $message . '</blink></center></div>');
    return $global['xajax_res']->getXML();
}

/**
 * Function to show a list of current reports
 */
function dar_show_reports() {
    global $global;
    $htmlLog = "";
    $htmlMain = "";
    $htmlMain .= "
			<table class=\"emTable\">
			<tr>
			<td style=\"font-size: 120%; padding-left: 8px;\" ><b>Date of Report</b></td>
			<td style=\"font-size: 120%; padding-left: 8px;text-align: center;\" ><b>UUID</b></td>
			<td style=\"font-size: 120%; padding-left: 8px;text-align: center;\" ><b>Disaster</b></td>
			<td style=\"font-size: 120%; padding-left: 8px;text-align: center;\" ><b>Assessor</b></td>
			<td style=\"font-size: 120%; padding-left: 8px;text-align: center;\" ><b>View/Edit</b></td>
			</tr>
			";

    $q = "
			SELECT  d.disaster_name, dar.dar_id, dar.date_created, dg.assessor_name
			FROM disaster AS d, disaster_assessment AS dar, dar_general AS dg
			WHERE d.disaster_id = dar.disaster_id
			AND dar.dar_id = dg.dar_id
			";
    $result = $global['db']->Execute($q);
    if($result === false) {
        daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "show reports");
    }
    $rcount = 0;
    $reports = array();
    while ( $row = $result->FetchRow() ) {
        $reports[$rcount] = $row;
        $rcount++;
    }
    $eo = 0;
    for ( $i = 0; $i < count($reports); $i++ ) {
        $row		=	$reports[$i];
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
				<td style=\"padding-left: 8px; text-align: center;\" class=\"".$evenOddClass."\"><input class=\"styleTehButton\" type=\"button\" onclick=\"javascript: dar_append_log('Showing monitoring data for patient <b>".$name." </b>...<br>'); dar_show_list_for_patient('".$uuid."');\" value=\"View\"></td>
				<td style=\"padding-left: 8px; text-align: center;\" class=\"".$evenOddClass."\"><input class=\"styleTehButton\" type=\"button\" onclick=\"javascript: dar_append_log('Adding Monitoring data for patient <b>".$name." </b>...<br>'); dar_add_data('".$uuid."');\" value=\"Add\"></td>
				</tr>
				";
        $eo++;
    }
    $htmlMain .= "</table>";
    $pageControlHtml = '<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'dar_load_general();\', 250);" value="'._t('Add new Data').'">';
    $global['xajax_res']->addAssign('darMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('darMain','innerHTML',$htmlMain);
    $global['xajax_res']->addAssign('darControl','style.opacity','1.0');
    $global['xajax_res']->addAssign('darControl','innerHTML',$pageControlHtml);
    $htmlLog .= _t("Found <b>").$rcount._t("</b> Report(s).<br>");
    $global['xajax_res']->addAppend('darLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'darLog \'); e.scrollTop = e.scrollHeight+1000;', 500);");
    return $global['xajax_res']->getXML();
}
/**
 * Function to load the General Information section
 */
function dar_load_general()
{
    global $global;
    $dar_id = $global['dar_id'];
    $htmlLog = "";
    $htmlMain = "";
    $_SESSION['dar_current_page'] = "general";
    $htmlMain .= shn_form_fopen_return("", null, array('enctype' => 'enctype="multipart/form-data"', 'req_message' => true));
    $htmlMain .= shn_form_fsopen_return("General Information");
	$htmlMain .= shn_form_select_return(array("Flood" => "Flood", "Drought" => "Drought", "Landslide" => "Landslide", "Tsunami" => "Tsunami","Drought"=>"Drought","Storm"=>"Storm/Cyclone","Other"=>"Other. Please Specify"),
        "Type of Disaster", "disaster_type");
    $htmlMain .= shn_form_text_return("","other_type");
	$htmlMain .= shn_form_text_return("Disaster Name(if any)","disasterName");
	$htmlMain .= shn_form_date_return("Date of Disaster", "reportDate");
    $htmlMain .= shn_form_select_return(array("colombo"=>"Colombo","kalutara"=>"Kalutara","galle"=>"Galle","gampaha"=>"Gampaha"),
        "Affected Area", "affected_area");
   // $htmlMain .= shn_form_select_return(array("GN" => "GN", "MOH" => "MOH", "District" => "District", "Province" => "Province"),
        //"Affected Area", "area_type");
    $htmlMain .= shn_form_text_return("Assessor's Name","assessor_name");
    $htmlMain .= shn_form_select_return(array("MOH Admin" => "MOH Admin", "FP Admin" => "FP Admin",
        "HO" => "HO"), "Assessor's Designation", "assessor_designation");
	$htmlMain .= shn_form_date_return("Date of Assessment", "assDate");
	$htmlMain .= shn_form_date_return("Disaster End Date","endDate");
    $htmlMain .= shn_form_fsclose_return();
    $htmlMain .= shn_form_fclose_return();

    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'dar_load_general();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes...').'<br>\'); dar_perform_save(\''.$dar_id.'\', dar_get_general_data(), \'general\');" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes and Closing...<br>').'\'); dar_perform_save(\''.$dar_id.'\', dar_get_general_data(), \'general\'); " value="'._t('Save Changes and Close').'">
	';
    //setTimeout(\'dar_perform_save('.$uuid.', dar_get_data());\', 250)
    $global['xajax_res']->addAssign('darMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('darMain','innerHTML',$htmlMain);
    $global['xajax_res']->addAssign('darControl', 'innerHTML', $editControlHtml);
    $global['xajax_res']->addAppend('darLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'darLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    $global['xajax_res']->addScript("initCalendar();");
    $global['xajax_res']->addScript("other();");
    $global['xajax_res']->addScript("toolTip();");
    return $global['xajax_res']->getXML();
}

function dar_load_popres() {
    global $global;
    $dar_id = $global['dar_id'];
    $htmlLog = "";
    $htmlMain = "";
    $_SESSION['dar_current_page'] = "popRes";
    $htmlMain .= shn_form_fopen_return("", null, array('enctype' => 'enctype="multipart/form-data"', 'req_message' => true));
    $htmlMain .= shn_form_fsopen_return("Population and Resource Data");
    $htmlMain.="<div class='long'>";



    $q = "SELECT * FROM property WHERE feature_feature_id=(SELECT feature_id FROM map,layer,map_has_layer,feature,property WHERE map.map_id=map_has_layer.map_map_id AND layer.layer_id=map_has_layer.layer_layer_id AND property.feature_feature_id=feature.feature_id AND feature.layer_layer_id=layer.layer_id AND layer.name='districts' AND property.name='name' AND property.value='colombo');";

    $properties =Array();

    $result = $global['db']->Execute($q);
    while($row = $result->FetchRow() ){
        $properties[$row['name']] = $row['value'];

    }

    $htmlMain .= shn_form_text_return("Total Area under focal point(in km&#178)", "total_area");
    $htmlMain .= shn_form_text_return("Total Population of the focal point", "focal_population",null,array());
    $htmlMain .= shn_form_text_return("Affected Area(in km&#178)", "affected_area",null,array('value'=>substr($properties['area'],0, -2)));
    $htmlMain .= shn_form_text_return("Total population of the affected area", "area_population",null,array('value'=>substr($properties['population'], -2)));
    $htmlMain.="</div>";

    $htmlMain .= shn_form_fsopen_return("Injured Persons");
    $htmlMain .= shn_form_text_return("Male", "male_injured");
    $htmlMain .= shn_form_text_return("Female", "female_injured");
    $htmlMain .= shn_form_text_return("Pregnant Females", "pregnant_female_injured");
    $htmlMain .= shn_form_text_return("Children", "children_injured");
    $htmlMain .= shn_form_text_return("Between ages 1-5", "young_children_injured");
    $htmlMain .= shn_form_text_return("Infants", "infants_injured");
	$htmlMain .= shn_form_text_return("Total", "total_injured");
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Displaced Persons");
    $htmlMain .= shn_form_text_return("Male", "male_displaced");
    $htmlMain .= shn_form_text_return("Female", "female_displaced");
    $htmlMain .= shn_form_text_return("Pregnant Females", "pregnant_female_displaced");
    $htmlMain .= shn_form_text_return("Children", "children_displaced");
    $htmlMain .= shn_form_text_return("Between ages 1-5", "young_children_displaced");
    $htmlMain .= shn_form_text_return("Infants", "infants_displaced");
	$htmlMain .= shn_form_text_return("Total", "total_displaced");
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Missing Persons");
    $htmlMain .= shn_form_text_return("Male", "male_missing");
    $htmlMain .= shn_form_text_return("Female", "female_missing");
    $htmlMain .= shn_form_text_return("Pregnant Females", "pregnant_female_missing");
    $htmlMain .= shn_form_text_return("Children", "children_missing");
    $htmlMain .= shn_form_text_return("Between ages 1-5", "young_children_missing");
    $htmlMain .= shn_form_text_return("Infants", "infants_missing");
	$htmlMain .= shn_form_text_return("Total", "total_missing");
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Communicable Disease");
    $htmlMain .= shn_form_text_return("Respiratory diseases", "res_diseases");
    $htmlMain .= shn_form_text_return("Dysentery", "dysentery");
    $htmlMain .= shn_form_text_return("Hepatitis A", "hepatitis");
    $htmlMain .= shn_form_text_return("Dengue", "dengue");
    $htmlMain .= shn_form_text_return("Malaria", "malaria");
    $htmlMain .= shn_form_text_return("Measles", "measles");
    $htmlMain .= shn_form_text_return("Meningitis", "meningitis");
    $htmlMain .= shn_form_text_return("Chicken pox", "chikenpox");
    $htmlMain .= shn_form_text_return("Total", "total_deceased");
    $htmlMain .= shn_form_fsclose_return();
	
	$htmlMain .= shn_form_fsopen_return("Total number affected");
	$htmlMain .= shn_form_text_return("Male","total_male");
	$htmlMain .= shn_form_text_return("Female","total_female");
	$htmlMain .= shn_form_text_return("Pregnant","total_pregnant");
	$htmlMain .= shn_form_text_return("Children","total_children");
	$htmlMain .= shn_form_text_return("Children between 1-5 yrs","total_1-5_Children");
	$htmlMain .= shn_form_text_return("Infants","total_infants");
	$htmlMain .= shn_form_text_return("Total","total_full");
	$htmlMain .= shn_form_text_return("Total number of families","total_families");
    $htmlMain .= shn_form_fsclose_return();

    //$htmlMain .= shn_form_fsopen_return();
    $htmlMain.="<div class='long'>";
    $htmlMain .= shn_form_text_return("Number of health institutes in the FP","fp_hi");
    $htmlMain .= shn_form_text_return("Total bed strength of all FP health institutes","fp_bs");
    $htmlMain .= shn_form_text_return("Number of health institutes in the affected area","ae_hi");
    $htmlMain .= shn_form_text_return("Total bed strength of all health institutes in the affected area","ae_bs");
    $htmlMain .= shn_form_text_return("Number of health institutions within 10km radius of the affected area","tenKm_hi");
    $htmlMain .= shn_form_text_return("Number of district hospitals and above in the FP","fp_dh");
    $htmlMain .= shn_form_text_return("Number of other inpatient facilities in the FP","fp_if");
    $htmlMain .= shn_form_text_return("Number of Doctors in the affected area","ae_doc");
    $htmlMain .="</div>";
    //$htmlMain .= shn_form_fclose_return();

    $htmlMain .= shn_form_fclose_return();

    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'dar_load_popres();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes...').'<br>\'); dar_perform_save(\''.$dar_id.'\', dar_get_popres_data(), \'popRes\');" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes and Closing...<br>').'\'); dar_perform_save(\''.$dar_id.'\', dar_get_popres_data(), \'popRes\'); " value="'._t('Save Changes and Close').'">
	';
    //setTimeout(\'dar_perform_save('.$uuid.', dar_get_data());\', 250)
    $global['xajax_res']->addAssign('darMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('darMain','innerHTML',$htmlMain);
    $global['xajax_res']->addAssign('darControl', 'innerHTML', $editControlHtml);
    $global['xajax_res']->addAppend('darLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'darLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    $global['xajax_res']->addScript("initCalendar();");
    $global['xajax_res']->addScript("limit();");
    return $global['xajax_res']->getXML();
}

function dar_load_wash() {
    global $global;
    $dar_id = $global['dar_id'];
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
    $htmlMain .= shn_form_text_return("Within 500m", "water_sources_within_range",null,array());
    $htmlMain .= shn_form_text_return("Further than 500m", "water_sources_further_than_range");
    $htmlMain .= shn_form_fsclose_return();
    $htmlMain .= shn_form_select_return(array("1" => "Yes", "0" => "No"),
        "Requirement of water treatment", "water_treatment_required");
    $htmlMain .= shn_form_text_return("Estimated Requirement of Water/day", "estimated_requirement_per_day");

    $htmlMain .= shn_form_fsopen_return("Estimated waiting time at a single water source");
    $htmlMain .= shn_form_text_return("Pipe-borne", "waiting_time_pipe_borne", null,
        array('help'=>'Estimated waiting time = Total water requirement  of the affected population / flow dare * available number within 500m => should be less than 30min'));
    $htmlMain .= shn_form_text_return("Open Well", "waiting_time_open_well", null,
        array('help'=>'Estimated waiting time = Total water requirement  of the affected population / flow dare * available number within 500m => should be less than 30min'));
    $htmlMain .= shn_form_text_return("Hand-pump", "waiting_time_hand_pump", null,
        array('help'=>'Estimated waiting time = Total water requirement  of the affected population / flow dare * available number within 500m => should be less than 30min'));
    $htmlMain .= shn_form_fsclose_return();
    $htmlMain .= shn_form_select_return(array("Yes" => "Yes", "No" => "No"),
        "Requirement basic hygiene training", "hygiene_training_required");
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Toilets");
    $htmlMain .= shn_form_text_return("Number of appropriately designed toilets", "number_of_toilets");
    $htmlMain .= shn_form_text_return("Required Number", "required_toilets_number", null,
        array("help"=>"On basis of one toilet per 20 people", "disabled"=>true));
    $htmlMain .= shn_form_text_return("Deficit", "toilet_deficit",null,array("help"=>"Required - Available","disabled"=>true));
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Tendency for vector-borne diseases");
    $htmlMain .= shn_form_text_return("Type of vector", "vector_type");
    $htmlMain .= shn_form_text_return("Name of disease", "vector_disease");
    $htmlMain .= shn_form_fsclose_return();

    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'dar_load_wash();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes...').'<br>\'); dar_perform_save(\''.$dar_id.'\', dar_get_wash_data(), \'wash\');" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes and Closing...<br>').'\'); dar_perform_save(\''.$dar_id.'\', dar_get_wash_data(), \'wash\'); " value="'._t('Save Changes and Close').'">
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
    $dar_id = $global['dar_id'];
    $htmlLog = "";
    $htmlMain = "";
    $_SESSION['dar_current_page'] = "food";
    $htmlMain .= shn_form_fopen_return("", null, array('enctype' => 'enctype="multipart/form-data"', 'req_message' => true));
    $htmlMain .= shn_form_fsopen_return("Food Security & Nutrition");
    /*$htmlMain .= shn_form_select_return(array("Disrupted" => "Disrupted", "Not Disrupted" => "Not Disrupted"),
        "Disruption of usual food prepadarion practices", "food_practices_disruption");
    $htmlMain .= shn_form_select_return(array("Yes" => "Yes", "No" => "No"),"Is there an accessible food source within 2km?",
        "accessible_food_source");*/
    $htmlMain.='<fieldset>
    <legend>Disruption of usual food preparation practices</legend>
    <input type="radio" name="food_dist" value="Yes"> Yes<br>
    <input type="radio" name="food_dist" value="No"> No<br>
    <input type="radio" name="food_dist" value="Difficult to assess"> Difficult to assess
    <!-- etc -->
    </fieldset>
        <fieldset>
    <legend>Accessibility to food source within 2km</legend>
    <input type="radio" name="food_access" value="Yes"> Yes<br>
    <input type="radio" name="food_access" value="No"> No<br>
    <input type="radio" name="food_access" value="Difficult to assess"> Difficult to assess
    <!-- etc -->
    </fieldset>';
    ;



    $htmlMain .= shn_form_fsclose_return();

    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'dar_load_food();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes...').'<br>\'); dar_perform_save(\''.$dar_id.'\', dar_get_food_data(), \'food\');" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes and Closing...<br>').'\'); dar_perform_save(\''.$dar_id.'\', dar_get_food_data(), \'food\'); " value="'._t('Save Changes and Close').'">
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
    $dar_id = $global['dar_id'];
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
    $htmlMain .= shn_form_text_return("Required area for shelter", "required_area_for_shelter",null,array("help"=>"covered living area calculation based on 3.5m&#178"));
    $htmlMain .= shn_form_fsclose_return();

    $htmlMain .= shn_form_fsopen_return("Temporary shelter availability in the area");
    $htmlMain .= '<div class="checkBox"><form>
        <label>Schools</label><input type="checkbox" id="schools">
        <input type="text" id="schools_list" disabled><br>
        <label>Temples/Religious Places</label><input type="checkbox" id="temples">
        <input type="text" id="temples_list" disabled><br>
        <label>Government offices</label><input type="checkbox" id="gOffices">
        <input type="text" id="gOffices_list" disabled><br>
        <label>Other</label><input type="checkbox" id="other">
        <input type="text" id="other_list" disabled>
        </form></div>';
    $htmlMain .= shn_form_fsclose_return();

    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'dar_load_shelter();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes...').'<br>\'); dar_perform_save(\''.$dar_id.'\', dar_get_shelter_data(), \'shelter\');" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: dar_append_log(\''._t('Saving Changes and Closing...<br>').'\'); dar_perform_save(\''.$dar_id.'\', dar_get_shelter_data(), \'shelter\'); " value="'._t('Save Changes and Close').'">
	';
    $global['xajax_res']->addAssign('darMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('darMain','innerHTML',$htmlMain);
    $global['xajax_res']->addAssign('darControl', 'innerHTML', $editControlHtml);
    $global['xajax_res']->addAppend('darLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'darLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    $global['xajax_res']->addScript("initCalendar();");
    $global['xajax_res']->addScript("tempCheckBox()");
    return $global['xajax_res']->getXML();
}



function dar_perform_save($dar_id, $rj, $page, $update = false) {

    global $global;

    $r = json_decode($rj);

    if($page == "general"){

        $reportDate                 = mysql_real_escape_string($r['reportDate']);
        $affected_area              = mysql_real_escape_string($r['affected_area']);
        $focal_point_name           = mysql_real_escape_string($r['focal_point_name']);
        $area_type                  = mysql_real_escape_string($r['area_type']);
        $assessor_name              = mysql_real_escape_string($r['assessor_name']);
        $assessor_designation       = mysql_real_escape_string($r['assessor_designation']);
        $focal_point_coordinator    = mysql_real_escape_string($r['focal_point_coordinator']);

        if ( $update ) {
            $q = "
            UPDATE dar_general
            SET reportDate              ='".$reportDate."',
                affected_area           ='".$affected_area."',
                focal_point_name        ='".$focal_point_name."',
                area_type               ='".$area_type."',
                assessor_name           ='".$assessor_name."',
                assessor_designation    ='".$assessor_designation."',
                focal_point_coordinator ='".$focal_point_coordinator."'
            WHERE dar_id='".$dar_id."'
             ";
        }
        else {
            $q = "
            INSERT INTO dar_general
            VALUES('".$dar_id."',
                   '".$reportDate."',
                   '".$affected_area."',
                   '".$focal_point_name."',
                   '".$area_type."',
                   '".$assessor_name."',
                   '".$assessor_designation."',
                   '".$focal_point_coordinator."'

             )";
        }

        $result = $global['db']->Execute($q);
        if($result === false) { daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "Inserting General Data"); }

    }
    else if($page == "popRes"){
        $total_area                 = mysql_real_escape_string($r['total_area']);
        $area_population            = mysql_real_escape_string($r['area_population']);
        $male_injured               = mysql_real_escape_string($r['male_injured']);
        $female_injured             = mysql_real_escape_string($r['female_injured']);
        $pregnant_female_injured    = mysql_real_escape_string($r['pregnant_female_injured']);
        $children_injured           = mysql_real_escape_string($r['children_injured']);
        $young_children_injured     = mysql_real_escape_string($r['young_children_injured']);
        $infants_injured            = mysql_real_escape_string($r['infants_injured']);
        $male_displaced             = mysql_real_escape_string($r['male_displaced']);
        $female_displaced           = mysql_real_escape_string($r['female_displaced']);
        $pregnant_female_displaced  = mysql_real_escape_string($r['pregnant_female_displaced']);
        $children_displaced         = mysql_real_escape_string($r['children_displaced']);
        $young_children_displaced   = mysql_real_escape_string($r['young_children_displaced']);
        $infants_displaced          = mysql_real_escape_string($r['infants_displaced']);
        $male_missing               = mysql_real_escape_string($r['male_missing ']);
        $female_missing             = mysql_real_escape_string($r['female_missing']);
        $pregnant_female_missing    = mysql_real_escape_string($r['pregnant_female_missing']);
        $children_missing           = mysql_real_escape_string($r['children_missing']);
        $young_children_missing     = mysql_real_escape_string($r['young_children_missing']);
        $infants_missing            = mysql_real_escape_string($r['infants_missing']);
        $male_deceased              = mysql_real_escape_string($r['male_deceased ']);
        $female_deceased            = mysql_real_escape_string($r['female_deceased ']);
        $pregnant_female_deceased   = mysql_real_escape_string($r['pregnant_female_deceased']);
        $children_deceased          = mysql_real_escape_string($r['children_deceased']);
        $young_children_deceased    = mysql_real_escape_string($r['young_children_deceased']);
        $infants_deceased           = mysql_real_escape_string($r['infants_deceased']);

        if ( $update ) {
            $q = "
            UPDATE dar_popres
            SET total_area                  ='".$total_area."',
                area_population             ='".$area_population."',
                male_injured                ='".$male_injured."',
                female_injured              ='".$female_injured."',
                pregnant_female_injured     ='".$pregnant_female_injured."',
                children_injured            ='".$children_injured."',
                young_children_injured      ='".$young_children_injured."',
                infants_injured             ='".$infants_injured."',
                male_displaced              ='".$male_displaced."',
                female_displaced            ='".$female_displaced."',
                pregnant_female_displaced   ='".$pregnant_female_displaced."',
                children_displaced          ='".$children_displaced."',
                young_children_displaced    ='".$young_children_displaced."',
                infants_displaced           ='".$infants_displaced."',
                male_missing                ='".$male_missing."',
                female_missing              ='".$female_missing."',
                pregnant_female_missing     ='".$pregnant_female_missing."',
                children_missing            ='".$children_missing."',
                young_children_missing      ='".$young_children_missing."',
                infants_missing             ='".$infants_missing."',
                male_deceased               ='".$male_deceased."',
                female_deceased             ='".$female_deceased."',
                pregnant_female_deceased    ='".$pregnant_female_deceased."',
                children_deceased           ='".$children_deceased."',
                young_children_deceased     ='".$young_children_deceased."',
                infants_deceased            ='".$infants_deceased."'
            WHERE dar_id='".$dar_id."'
             ";
        }
        else {
            $q = "
            INSERT INTO dar_popres
            VALUES('".$dar_id."',
                   '".$total_area."',
                   '".$area_population."',
                   '".$male_injured."',
                   '".$female_injured."',
                   '".$pregnant_female_injured."',
                   '".$children_injured."',
                   '".$young_children_injured."',
                   '".$infants_injured."',
                   '".$male_displaced."',
                   '".$female_displaced."',
                   '".$pregnant_female_displaced."',
                   '".$children_displaced."',
                   '".$young_children_displaced."',
                   '".$infants_displaced."',
                   '".$male_missing."',
                   '".$female_missing."',
                   '".$pregnant_female_missing."',
                   '".$children_missing."',
                   '".$young_children_missing."',
                   '".$infants_missing."',
                   '".$male_deceased."',
                   '".$female_deceased."',
                   '".$pregnant_female_deceased."',
                   '".$children_deceased."',
                   '".$young_children_deceased."',
                   '".$infants_deceased."'
             )";
        }
        $result = $global['db']->Execute($q);
        if($result === false) { daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "Inserting Population data"); }

    }
    else if($page == "wash"){
        $pre_disaster_water_source          = mysql_real_escape_string($r['pre_disaster_water_source']);
        $post_disaster_water_status         = mysql_real_escape_string($r['post_disaster_water_status']);
        $water_sources_within_range         = mysql_real_escape_string($r['water_sources_within_range']);
        $water_sources_further_than_range   = mysql_real_escape_string($r['water_sources_further_than_range']);
        $water_treatment_required           = mysql_real_escape_string($r['water_treatment_required']);
        $estimated_requirement_per_day      = mysql_real_escape_string($r['estimated_requirement_per_day ']);
        $waiting_time_pipe_borne            = mysql_real_escape_string($r['waiting_time_pipe_borne']);
        $waiting_time_open_well             = mysql_real_escape_string($r['waiting_time_open_well']);
        $waiting_time_hand_pump             = mysql_real_escape_string($r['waiting_time_hand_pump']);
        $hygiene_training_required          = mysql_real_escape_string($r['hygiene_training_required']);
        $number_of_toilets                  = mysql_real_escape_string($r['number_of_toilets']);
        $required_toilets_number            = mysql_real_escape_string($r['required_toilets_number']);
        $toilet_deficit                     = mysql_real_escape_string($r['toilet_deficit']);
        $vector_type                        = mysql_real_escape_string($r['vector_type']);
        $vector_disease                     = mysql_real_escape_string($r['vector_disease']);

        if ( $update ) {
            $q = "
            UPDATE dar_wash
            SET pre_disaster_water_source         ='".$pre_disaster_water_source."',
                post_disaster_water_status        ='".$post_disaster_water_status."',
                water_sources_within_range        ='".$water_sources_within_range."',
                water_sources_further_than_range  ='".$water_sources_further_than_range."',
                water_treatment_required          ='".$water_treatment_required."',
                estimated_requirement_per_day     ='".$estimated_requirement_per_day."',
                waiting_time_pipe_borne           ='".$waiting_time_pipe_borne."',
                waiting_time_open_well            ='".$waiting_time_open_well."',
                waiting_time_hand_pump            ='".$waiting_time_hand_pump."',
                hygiene_training_required         ='".$hygiene_training_required."',
                number_of_toilets                 ='".$number_of_toilets."',
                required_toilets_number           ='".$required_toilets_number."',
                toilet_deficit                    ='".$toilet_deficit."',
                vector_type                       ='".$vector_type."',
                vector_disease                    ='".$vector_disease."'
            WHERE dar_id='".$dar_id."'
             ";
        }
        else {
            $q = "
            INSERT INTO dar_wash
            VALUES('".$dar_id."',
                   '".$pre_disaster_water_source."',
                   '".$post_disaster_water_status."',
                   '".$water_sources_within_range."',
                   '".$water_sources_further_than_range."',
                   '".$water_treatment_required."',
                   '".$estimated_requirement_per_day."',
                   '".$waiting_time_pipe_borne."',
                   '".$waiting_time_open_well."',
                   '".$waiting_time_hand_pump."',
                   '".$hygiene_training_required."',
                   '".$number_of_toilets."',
                   '".$required_toilets_number."',
                   '".$toilet_deficit."',
                   '".$vector_type."',
                   '".$vector_disease."'

             )";
        }
        $result = $global['db']->Execute($q);
        if($result === false) { daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "Inserting WASH data"); }

    }
    else if($page == "food"){
        $food_practices_disruption         = 3;//$r['food_practices_disruption'];
        $accessible_food_source         = 5;//$r['accessible_food_source'];
       // alert("hh");
        if ( $update ) {
            $q = "
            UPDATE dar_food
            SET food_practices_disruption     ='".$food_practices_disruption."',
                accessible_food_source        ='".$accessible_food_source."'
            WHERE dar_id='".$dar_id."'
             ";
        }
        else {
            $q = "
            INSERT INTO dar_food
            VALUES('".$dar_id."',
                   '".$food_practices_disruption."',
                   '".$accessible_food_source."'

             )";
        }
        $result = $global['db']->Execute($q);
        if($result === false) { daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "Inserting food data"); }

    }
    else if($page == "shelter"){
        $partially_affected_houses              = mysql_real_escape_string($r['partially_affected_houses']);
        $totally_affected_houses                = mysql_real_escape_string($r['totally_affected_houses']);
        $families_evacuation                    = mysql_real_escape_string($r['families_evacuation']);
        $population_evacuation                  = mysql_real_escape_string($r['population_evacuation']);
        $families_displaced                     = mysql_real_escape_string($r['families_displaced']);
        $population_displaced                   = mysql_real_escape_string($r['population_displaced ']);
        $estimated_number_requiring_shelter     = mysql_real_escape_string($r['estimated_number_requiring_shelter']);
        $temporary_shelter_available            = mysql_real_escape_string($r['temporary_shelter_available']);
        $temp_shelter_covered_area              = mysql_real_escape_string($r['temp_shelter_covered_area']);

        if ( $update ) {
            $q = "
            UPDATE dar_shelter
            SET partially_affected_houses           ='".$partially_affected_houses."',
                totally_affected_houses             ='".$totally_affected_houses."',
                families_evacuation                 ='".$families_evacuation."',
                population_evacuation               ='".$population_evacuation."',
                families_displaced                  ='".$families_displaced."',
                population_displaced                ='".$population_displaced."',
                estimated_number_requiring_shelter  ='".$estimated_number_requiring_shelter."',
                temporary_shelter_available         ='".$temporary_shelter_available."',
                temp_shelter_covered_area           ='".$temp_shelter_covered_area."'
            WHERE dar_id='".$dar_id."'
             ";
        }
        else {
            $q = "
            INSERT INTO dar_shelter
            VALUES('".$dar_id."',
                   '".$partially_affected_houses."',
                   '".$totally_affected_houses."',
                   '".$families_evacuation."',
                   '".$population_evacuation."',
                   '".$families_displaced."',
                   '".$population_displaced."',
                   '".$estimated_number_requiring_shelter."',
                   '".$temporary_shelter_available."',
                   '".$temp_shelter_covered_area."'
             )";
        }
        $result = $global['db']->Execute($q);
        if($result === false) { daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "Inserting WASH data"); }

    }

    //$global['xajax_res']->addAppend('darLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'darLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    return $global['xajax_res']->getXML();

}






