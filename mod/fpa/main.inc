<?php
/**
 * @name         Focal Point Administration
 * @version      01
 * @package      fpa
 * @author       Thilina Mendis <thilina.mendi@gmail.com>
 * @about        Developed in whole or part by the U.S. National Library of Medicine,the Sahana Foundation and Virtusa Corporation
 * @link         https://pl.nlm.nih.gov/about
 * @link         http://sahanafoundation.org
 * @link		 http://www.virtusa.com
 * @license	 	 http://www.gnu.org/licenses/lgpl-2.1.html GNU Lesser General Public License (LGPL)
 * @lastModified 2013.11.21
 */



require_once($global['approot'].'/inc/lib_menu.inc');
require_once($global['approot'].'/inc/handler_db.inc');
require_once($global['approot'].'/inc/lib_xajax.inc');
require_once($global['approot'].'/mod/fpa/xajax.inc');

shn_xajax_registerFunction('fpa_append_log');
shn_xajax_registerFunction('fpa_prepend_log');
shn_xajax_registerFunction('fpa_show_message');
shn_xajax_registerFunction('fpa_show_hospitals');
shn_xajax_registerFunction('fpa_perform_edit');
shn_xajax_registerFunction('fpa_perform_delete');
shn_xajax_registerFunction('fpa_perform_insert');
shn_xajax_registerFunction('fpa_perform_save');
shn_xajax_registerFunction('fpa_perform_help');


function shn_fpa_default() {

	global $global;
	shn_xajax_printJavascript();
	echo "
		<div id=\"rezLog\" class=\"logArea\">Loading Hospitals...<br><noscript>THIS MODULE REQUIRES THAT YOU ACTIVATE JAVASCRIPT!</noscript></div>
		<div id=\"rezControl\" class=\"controlArea\">&nbsp;</div>
		<div id=\"rezMain\" class=\"mainArea\"></div>
		<script>".file_get_contents($global['approot']."/mod/fpa/fpa.js")."</script>
	";

	// only use the pro version of Google Maps on these domains (which have a license key):
	if(($_SERVER['HTTP_HOST'] == "pl")
	|| ($_SERVER['HTTP_HOST'] == "pl.nlm.nih.gov")
	|| ($_SERVER['HTTP_HOST'] == "plstage")
	|| ($_SERVER['HTTP_HOST'] == "plstage.nlm.nih.gov")
	|| ($_SERVER['HTTP_HOST'] == "ceb-stage-lx")
	|| ($_SERVER['HTTP_HOST'] == "ceb-stage-lx.nlm.nih.gov")) {
		echo "<script type=\"text/javascript\" src=\"https://maps-api-ssl.google.com/maps/api/js?v=3&client=gme-hhs&sensor=true\"></script>";

	// else use standard Google Maps:
	} else {
		echo "<script type=\"text/javascript\" src=\"http://maps.google.com/maps/api/js?v=3&sensor=true\"></script>";
	}

	echo "
		<script type=\"text/javascript\" src=\"res/js/jquery-1.6.4.min.js\" ></script>
		<script type=\"text/javascript\" src=\"res/js/jquery-ui-autocomplete.min.js\" ></script>
		<script type=\"text/javascript\" src=\"res/js/jquery-ui-datepicker.min.js\" ></script>
	";
}













