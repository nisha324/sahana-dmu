<?php
/**
 * @name         Rapid Assessment Tool
 * @version      01
 * @package      rat
 * @author       Ramindu Deshapriya <rdeshapriya@virtusa.com>
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
require_once($global['approot'].'/mod/rat/xajax.inc');

shn_xajax_registerFunction('rat_append_log');
shn_xajax_registerFunction('rat_prepend_log');
shn_xajax_registerFunction('rat_show_message');
//shn_xajax_registerFunction('rat_store_values');
shn_xajax_registerFunction('rat_load_general');
shn_xajax_registerFunction('rat_load_popres');
shn_xajax_registerFunction('rat_load_wash');
shn_xajax_registerFunction('rat_load_food');
shn_xajax_registerFunction('rat_load_shelter');


shn_xajax_registerFunction('rat_perform_save');



function shn_rat_default() {

	global $global;
    shn_tabmenu_open();
    shn_tabmenu_item("general", _t("Rat-Menu|General Info"),                 "rat");
    shn_tabmenu_item("popRes",  _t("Rat-Menu|Population and Resource Data"), "rat");
    /*shn_tabmenu_item("indicators", _t("Rat-Menu|Indicators"),                "rat");*/
    shn_tabmenu_item("wash", _t("Rat-Menu|WASH Indicators"),                 "rat");
    shn_tabmenu_item("food",   _t("Rat-Menu|Food security and nutrition"),   "rat");
    shn_tabmenu_item("shelter",  _t("Rat-Menu|Shelter Indicators"),          "rat");
    shn_tabmenu_close();
	shn_xajax_printJavascript();
	echo "
		<div id=\"ratLog\" class=\"logArea\">Loading RAT Data...<br><noscript>THIS MODULE REQUIRES THAT YOU ACTIVATE JAVASCRIPT!</noscript></div>
		<div id=\"ratControl\" class=\"controlArea\">&nbsp;</div>
		<div id=\"ratMain\" class=\"mainArea\"></div>
		<script>".file_get_contents($global['approot']."/mod/rat/rat.js")."</script>
		<script type=\"text/javascript\" src=\"res/js/jquery-1.6.4.min.js\" ></script>
		<script type=\"text/javascript\" src=\"res/js/jquery-ui-datepicker.min.js\" ></script>
	";
    if(isset($_GET['general'])) {
        $control = "rat_load_general";

    } elseif(isset($_GET['popRes'])) {
        $control = "rat_load_popres";

    } /*elseif(isset($_GET['indicators'])) {
        $control = "rat_load_indicators";

    } */elseif(isset($_GET['wash'])) {
        $control = "rat_load_wash";

    } elseif(isset($_GET['food'])) {
        $control = "rat_load_food";

    } elseif(isset($_GET['shelter'])) {
        $control = "rat_load_shelter";

    } else {
        $control = "rat_load_general";
    }
	echo "
        <script type=\"text/javascript\">".$control."();</script>
		<script type=\"text/javascript\" src=\"res/js/jquery-1.6.4.min.js\" ></script>
		<script type=\"text/javascript\" src=\"res/js/jquery-ui-autocomplete.min.js\" ></script>
		<script type=\"text/javascript\" src=\"res/js/jquery-ui-datepicker.min.js\" ></script>
	";
}













