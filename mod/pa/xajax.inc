<?php
/**
 * @name         Disaster Assessment and Response
 * @version      01
 * @package      pa
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
array_push($global['xajax_functions'], 'pa_append_log');
array_push($global['xajax_functions'], 'pa_prepend_log');
array_push($global['xajax_functions'], 'pa_show_message');
array_push($global['xajax_functions'], 'pa_load_capacity');
array_push($global['xajax_functions'], 'pa_load_hazard');

array_push($global['xajax_functions'], 'pa_perform_save');


// adds a message to the log div @ tail
function pa_append_log($message = "no message specified?")
{

    global $global;
    $global['xajax_res']->addAppend('paLog', 'innerHTML', $message);
    //---- scroll the log to the bottom
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'paLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    return $global['xajax_res']->getXML();
}


// adds a message to the log div @ head
function pa_prepend_log($message = "no message specified?")
{

    global $global;
    $global['xajax_res']->addPrepend('paLog', 'innerHTML', $message);
    return $global['xajax_res']->getXML();
}


/**
 * shows a status message before another ajax function is executed
 */
function pa_show_message($message = "no message specified?")
{

    global $global;
    $global['xajax_res']->addAssign('paMain', 'innerHTML', '<div class="loadingMessage"><center><blink>' . $message . '</blink></center></div>');
    return $global['xajax_res']->getXML();
}

/**
 * Function to show a list of current reports
 */
function pa_show_reports() {
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
				<td style=\"padding-left: 8px; text-align: center;\" class=\"".$evenOddClass."\"><input class=\"styleTehButton\" type=\"button\" onclick=\"javascript: dar_append_log('Showing monitoring data for patient <b>".$name." </b>...<br>'); pa_show_list_for_patient('".$uuid."');\" value=\"View\"></td>
				<td style=\"padding-left: 8px; text-align: center;\" class=\"".$evenOddClass."\"><input class=\"styleTehButton\" type=\"button\" onclick=\"javascript: pa_append_log('Adding Monitoring data for patient <b>".$name." </b>...<br>'); pa_add_data('".$uuid."');\" value=\"Add\"></td>
				</tr>
				";
        $eo++;
    }
    $htmlMain .= "</table>";
    $pageControlHtml = '<input class="styleTehButton" type="button" onclick="javascript: pa_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'pa_load_general();\', 250);" value="'._t('Add new Data').'">';
    $global['xajax_res']->addAssign('paMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('paMain','innerHTML',$htmlMain);
    $global['xajax_res']->addAssign('paControl','style.opacity','1.0');
    $global['xajax_res']->addAssign('paControl','innerHTML',$pageControlHtml);
    $htmlLog .= _t("Found <b>").$rcount._t("</b> Report(s).<br>");
    $global['xajax_res']->addAppend('paLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'paLog \'); e.scrollTop = e.scrollHeight+1000;', 500);");
    return $global['xajax_res']->getXML();
}
/**
 * Function to load the General Information section
 */

function pa_load_capacity(){

    global $global;
    $pa_id = $global['pa_id'];
    $htmlLog = "";
    $htmlMain = "";
    $_SESSION['pa_current_page'] = "loadCap";
    $htmlMain .= shn_form_fopen_return("", null, array('enctype' => 'enctype="multipart/form-data"', 'req_message' => true));
    $htmlMain .= shn_form_fsopen_return("Capacity Assessment");

    $htmlMain .=
       '<fieldset>
        <legend>Updating disaster data and related information in the system</legend>
        <p>Select one</p>
        <form id="marks">
        <input type="radio" name="update_dis_data" value="Complete"> Yes<br>
        <input type="radio" name="update_dis_data" value="Partially complete"> No<br>
        <input type="radio" name="update_dis_data" value="Not Done"> Difficult to assess<br>
        </form>

        </fieldset>';
    $htmlMain .=
        '<fieldset>
         <legend>Public Awareness</legend>
         <p>Identifying possible risk groups</p>
         <div class="checkBox">
         <input type="radio" name="pA" id="pA_yes">Yes<br>
         <input type="radio" name="pA" id="pA_no">No
         <br><br>
         </div>
         <fieldset id="pA_field" disabled>
         <legend>If yes</legend>
         <label id="pa">Date/s</label><input type="text" id="pa_date"><br>
         <label id="pa">Place/s</label><input type="text" id="pa_Partially complete"><br>
         <div class="checkBox">
         <input type="checkbox" id="pa_not_plan">Not Planned
         </div>
         </fieldset>

         </fieldset>';

    $htmlMain .=
        '<fieldset>
         <legend>Mechanism for community-based early warning system</legend>
         <p>Mechanism in place</p>
         <div class="checkBox">
         <input type="radio" name="eW" id="eW_yes">Yes<br>
         <input type="radio" name="eW" id="eW_no">No
         <br><br>
         </div>
         <fieldset id="eW_field" disabled>
         <legend>If yes</legend>
         <input type="radio" name="eW2" id="eW_complete">Complete<br>
         <input type="radio" name="eW2" id="eW_not_complete">Partial or non-functional
         </fieldset>

         </fieldset>';

    $htmlMain .=
        '<fieldset>
         <legend>Management of Self areas</legend>
         <p>Identification</p>
         <div class="checkBox">
         <input type="radio" name="sA" id="sA_yes">Yes<br>
         <input type="radio" name="sA" id="sA_no">No
         <br><br>
         </div>
         <fieldset id="sA_field" disabled>
         <legend>If yes</legend>
         <p>Mapping</p>
         <input type="radio" name="sA2" id="sA_satisfactory">Satisfactory<br>
         <input type="radio" name="sA2" id="sA_unsatisfactory">Unsatisfactory
         </fieldset>
         <p>GIS coordinates</p>
         <div class="checkBox">
         <input type="radio" name="sA3" id="sA3_yes">Yes<br>
         <input type="radio" name="sA3" id="sA3_no">No
         <br><br>
         </div>

         </fieldset>';

    $htmlMain .=
        '<fieldset>
         <legend>Disaster Management Staff</legend>
         <label id="emp">Number of employees</label><br><br>
         <input type="radio" name="employees" id="emp_adequate">Adequate<br>
         <input type="radio" name="employees" id="emp_Inadequate">Inadequate<br><br>
         <label id="emp">Training of Staff</label><br><br>
         <input type="radio" name="staff" id="staff_satisfactory">Satisfactory<br>
         <input type="radio" name="staff" id="staff_unsatisfactory">Unsatisfactory<br>
         </fieldset>';

    $htmlMain .=
        '<fieldset>
         <legend>Stockpiling of emergency relief materials</legend>
         <input type="radio" name="eRM" id="eRM_satisfactory">Satisfactory<br>
         <input type="radio" name="eRM" id="eRM_unsatisfactory">Unsatisfactory<br>
         </fieldset>';

    $htmlMain .=
        '<fieldset>
         <legend>Conducting drills and rehearsals</legend>
         <p>Planned</p>
         <div class="checkBox">
         <input type="radio" name="drill" id="drill_yes">Yes<br>
         <input type="radio" name="drill" id="drill_no">No
         <br><br>
         </div>
         <fieldset id="drill_field" disabled>
         <legend>If yes</legend>
         <label id="drill">Date/s</label><input type="text" id="drill_date"><br><br>
         <div class="checkBox">
         <input type="checkbox" id="drill_not_plan">Not Planned
         </div>
         </fieldset>

         </fieldset>';

    $htmlMain .=
        '<fieldset>
         <legend>Disaster Preparedness Plan for the Fiscal Year<br>(according to the format proposedby DPRD)</legend>
         <p>Complete</p>
         <div class="checkBox">
         <input type="radio" name="plan" id="plan_yes">Yes<br>
         <input type="radio" name="plan" id="plan_no">No
         <br><br>
         </div>
         <fieldset id="plan_field" disabled>
         <legend>If yes</legend>
         <p>Uploaded or emailed a copy to DPRD</p>
         <div class="checkBox">
         <input type="radio" name="plan2" id="plan2_yes">Yes<br>
         <input type="radio" name="plan2" id="plan2_no">No
         <br><br>
         </div>
         </fieldset>

         </fieldset>';

    $htmlMain .= shn_form_fsclose_return();


    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: pa_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'pa_load_capacity();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: pa_append_log(\''._t('Saving Changes...').'<br>\'); pa_perform_save(\''.$pa_id.'\', pa_get_capacity_data(), \'loadCap\');" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: pa_append_log(\''._t('Saving Changes and Closing...<br>').'\'); pa_perform_save(\''.$pa_id.'\', pa_get_capacity_data(), \'loadCap\'); " value="'._t('Save Changes and Close').'">
	';
    $global['xajax_res']->addAssign('paMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('paMain','innerHTML',$htmlMain);
    $global['xajax_res']->addAssign('paControl', 'innerHTML', $editControlHtml);
    $global['xajax_res']->addAppend('paLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'paLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    $global['xajax_res']->addScript("tempCheckBox()");
    return $global['xajax_res']->getXML();

}

function pa_load_hazard(){
    global $global;
    $pa_id = $global['pa_id'];
    $htmlLog = "";
    $htmlMain = "";
    $_SESSION['pa_current_page'] = "loadHazard";
    $htmlMain .= shn_form_fopen_return("", null, array('enctype' => 'enctype="multipart/form-data"', 'req_message' => true));
    $htmlMain .= shn_form_fsopen_return("Hazard Assessment");
    //$htmlMain .= shn_form_fsclose_return();


    $editControlHtml = '

		<input class="styleTehButton" type="button" onclick="javascript: pa_append_log(\''._t('Canceling Changes...').'<br>\'); setTimeout(\'pa_load_hazard();\', 250);" value="'._t('Cancel Edit / Close').'">
		<input class="styleTehButton" type="button" onclick="javascript: pa_append_log(\''._t('Saving Changes...').'<br>\'); pa_perform_save(\''.$pa_id.'\', pa_get_hazard_data(), \'loadHazard\');" value="'._t('Save Changes').'">
		<input class="styleTehButton" type="button" onclick="javascript: pa_append_log(\''._t('Saving Changes and Closing...<br>').'\'); pa_perform_save(\''.$pa_id.'\', pa_get_hazard_data(), \'loadHazard\'); " value="'._t('Save Changes and Close').'">
	';
    $global['xajax_res']->addAssign('paMain','style.opacity','1.0');
    $global['xajax_res']->addAssign('paMain','innerHTML',$htmlMain);
    $global['xajax_res']->addAssign('paControl', 'innerHTML', $editControlHtml);
    $global['xajax_res']->addAppend('paLog','innerHTML',$htmlLog);
    $global['xajax_res']->addScript("setTimeout('e = document.getElementById(\'paLog\'); e.scrollTop = e.scrollHeight+1000;', 500);");
    return $global['xajax_res']->getXML();
}


function pa_perform_save($pa_id, $rj, $page, $update = false) {



}






