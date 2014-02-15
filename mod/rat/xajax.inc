<?php
/**
 * @name         Rapid Assessment Tool
 * @version      01
 * @package      rat
 * @author       Ramindu Deshapriya <rdeshapriya@virtusa.com>
 * @about        Developed in whole or part by the U.S. National Library of Medicine,the Sahana Foundation and Virtusa Corporation
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
array_push($global['xajax_functions'], 'rat_append_log');
array_push($global['xajax_functions'], 'rat_prepend_log');
array_push($global['xajax_functions'], 'rat_show_message');
array_push($global['xajax_functions'], 'rat_load_general');
array_push($global['xajax_functions'], 'rat_load_popres');


// adds a message to the log div @ tail
function rat_append_log($message = "no message specified?")
{

    global $global;
    $global['xajax_res']->addAppend('ratLog', 'innerHTML', $message);
    //---- scroll the log to the bottom
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'ratLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    return $global['xajax_res']->getXML();
}


// adds a message to the log div @ head
function rat_prepend_log($message = "no message specified?")
{

    global $global;
    $global['xajax_res']->addPrepend('ratLog', 'innerHTML', $message);
    return $global['xajax_res']->getXML();
}


// shows a status message before another ajax function is executed
function rat_show_message($message = "no message specified?")
{

    global $global;
    $global['xajax_res']->addAssign('ratMain', 'innerHTML', '<div class="loadingMessage"><center><blink>' . $message . '</blink></center></div>');
    return $global['xajax_res']->getXML();
}

/**
 * Function to load the General Information section
 */
function rat_load_general()
{
    global $global;
    $htmlLog = "";
    $htmlMain = "";
    $_SESSION['rat_current_page'] = "general";
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
    $htmlMain .= shn_form_select_return(array("Ramindu Deshapriya" => "Ramindu Deshapriya", "Rasika Herath" => "Rasika Herath",
            "Chathura Thennakoon" => "Chathura Thennakoon", "Thilina Mendis" => "Thilina Mendis"), "Assessor's Name", "assessor_name");
    $htmlMain .= shn_form_select_return(array("MOH Admin" => "MOH Admin", "FP Admin" => "FP Admin",
        "HO" => "HO"), "Assessor's Designation", "assessor_designation");
    $htmlMain .= shn_form_select_return(array("Ramindu Deshapriya" => "Ramindu Deshapriya", "Rasika Herath" => "Rasika Herath"),
        "Team Leader Name", "team_leader");
    $htmlMain .= shn_form_fsclose_return();
    $htmlMain .= shn_form_fclose_return();

    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: rat_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'rat_show_patients();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: rat_append_log(\''._t('Saving Changes...').'<br>\'); rat_perform_save(\''.$uuid.'\', rat_get_data());" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: rat_append_log(\''._t('Saving Changes and Closing...<br>').'\'); rat_perform_save(\''.$uuid.'\', rat_get_data()); " value="'._t('Save Changes and Close').'">
	';
    //setTimeout(\'rat_perform_save('.$uuid.', rat_get_data());\', 250)
    $global['xajax_res']->addAssign('ratMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('ratMain','innerHTML',$htmlMain);
    $global['xajax_res']->addAssign('ratControl', 'innerHTML', $editControlHtml);
    $global['xajax_res']->addAppend('ratLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'ratLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    $global['xajax_res']->addScript("initCalendar();");
    return $global['xajax_res']->getXML();
}

function rat_load_popres() {
    global $global;
    $htmlLog = "";
    $htmlMain = "";
    $_SESSION['rat_current_page'] = "popRes";
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
    $htmlMain .= shn_form_select_return(array("Ramindu Deshapriya" => "Ramindu Deshapriya", "Rasika Herath" => "Rasika Herath",
        "Chathura Thennakoon" => "Chathura Thennakoon", "Thilina Mendis" => "Thilina Mendis"), "Assessor's Name", "assessor_name");
    $htmlMain .= shn_form_select_return(array("MOH Admin" => "MOH Admin", "FP Admin" => "FP Admin",
        "HO" => "HO"), "Assessor's Designation", "assessor_designation");
    $htmlMain .= shn_form_select_return(array("Ramindu Deshapriya" => "Ramindu Deshapriya", "Rasika Herath" => "Rasika Herath"),
        "Team Leader Name", "team_leader");
    $htmlMain .= shn_form_fsclose_return();
    $htmlMain .= shn_form_fclose_return();

    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: rat_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'rat_show_patients();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: rat_append_log(\''._t('Saving Changes...').'<br>\'); rat_perform_save(\''.$uuid.'\', rat_get_data());" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: rat_append_log(\''._t('Saving Changes and Closing...<br>').'\'); rat_perform_save(\''.$uuid.'\', rat_get_data()); " value="'._t('Save Changes and Close').'">
	';
    //setTimeout(\'rat_perform_save('.$uuid.', rat_get_data());\', 250)
    $global['xajax_res']->addAssign('ratMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('ratMain','innerHTML',$htmlMain);
    $global['xajax_res']->addAssign('ratControl', 'innerHTML', $editControlHtml);
    $global['xajax_res']->addAppend('ratLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'ratLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    $global['xajax_res']->addScript("initCalendar();");
    return $global['xajax_res']->getXML();
}






