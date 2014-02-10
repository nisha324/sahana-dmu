<?php
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

require_once($global['approot'].'/inc/lib_menu.inc');
require_once($global['approot'].'/inc/handler_db.inc');
require_once($global['approot'].'/inc/lib_xajax.inc');
require_once($global['approot'].'/mod/mon/xajax.inc');

shn_xajax_registerFunction('mon_append_log');
shn_xajax_registerFunction('mon_prepend_log');
shn_xajax_registerFunction('mon_show_message');
shn_xajax_registerFunction('mon_show_patients');
shn_xajax_registerFunction('mon_add_data');
shn_xajax_registerFunction('mon_perform_save');
shn_xajax_registerFunction('mon_show_list_for_patient');
shn_xajax_registerFunction('mon_edit_data');

function shn_mon_default() {

	global $global;
	//echo "Monitoring module under construction";
	shn_xajax_printJavascript();
	echo "
		<div id=\"monLog\" class=\"logArea\">Loading Confirmed Patients...<br><noscript>THIS MODULE REQUIRES THAT YOU ACTIVATE JAVASCRIPT!</noscript></div>
		<div id=\"monControl\" class=\"controlArea\">&nbsp;</div>
		<div id=\"monMain\" class=\"mainArea\"></div>
		<script>".file_get_contents($global['approot']."/mod/mon/mon.js")."</script>
		<script type=\"text/javascript\" src=\"res/js/jquery-1.6.4.min.js\" ></script>
		<script type=\"text/javascript\" src=\"res/js/jquery-ui-datepicker.min.js\" ></script>
	";
}

