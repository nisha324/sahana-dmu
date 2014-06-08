<?php
/**
 * @name         Geographic Information System
 * @version      11
 * @package      gis
 * @author       Milindu Sanoj Kumarage <agentmilindu@gmail.com>
 * @about        Developed in whole or part by the U.S. National Library of Medicine, the Sahana Foundation.
 * @link         http://sahanafoundation.org
 * @link		 http://www.agentmilindu.com
 * @link         https://pl.nlm.nih.gov/about
 * @license	 http://www.gnu.org/licenses/lgpl-2.1.html GNU Lesser General Public License (LGPL)
 * @lastModified 2014.06.07
 */


 global $global;

 require_once($global['approot'].'/inc/handler_db.inc');
 
/** Displays the Resources pages' content on the front end of the site. */
function shn_gis_default() {

	global $global;	
	$control = "";

	shn_tabmenu_open();
	shn_tabmenu_item("maps", _t("GIS-Menu| Maps"),        "gis");
	shn_tabmenu_item("add",  _t("GIS-Menu| Map editor"),  "gis");
	shn_tabmenu_close();
	
	if(isset($_GET['rez'])) {
		$control = "shn_rez_adm_default";
		require_once($global['approot']."mod/rez/admin.inc");

	} elseif(isset($_GET['add'])) {
		$control = "shn_gis_add_map";

	} 

	if($control == "") {
		$control = "shn_gis_build";
	}

	$control();
	
}
function shn_gis_build() {

	global $global;
	
	echo "<style> ".file_get_contents($global['approot']."/mod/gis/main.css")."</style>";
	$q = "
		select *
		from map";
		$result = $global['db']->Execute($q);
		if($result === false) {
			daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "rez pages header");
		}
		echo "<div class='map-item'><img src='http://placehold.it/150x150'/><br/>Add new map</div>";
		if($result){
			// build page info
			while($row = $result->FetchRow() ) {
				echo "<div class='map-item'><img src='".$row['thumbnail']."'/><br/>".$row['name']."</div>";
			}
		}
	
}
function shn_gis_add_map(){
	global $global;
	
	echo "<style> ".file_get_contents($global['approot']."/mod/gis/main.css")."</style>";
	
	?>
	<!-- loading resources from external sources just for testing, will replace them with local sources -->
	<script src="http://ol3js.org/en/master/build/ol.js" type="text/javascript"></script>
	<script type="text/javascript" src="res/js/jquery-1.6.4.min.js" ></script>
	
	
	<table class="emTable">
	<tbody><tr>
		<td class="mainRowEven" style=" border-bottom: none;" colspan="2">
			<label>Name: </label>
			<input id="address" type="text" class="ui-autocomplete-input" autocomplete="off" role="textbox" aria-autocomplete="list" aria-haspopup="true"> &nbsp;  &nbsp; <input type="button" style="position: relative; top: -2px;" class="styleTehButton" onclick="detect_load();" value="Delete map">
		</td>
	</tr>


	<tr>
		<td class="mainRowOdd emFirst emLast" style="border-top: none; border-bottom: none;  padding: 0px;" colspan="2">
			<div id="the-map" class="map"></div>
		</td>
	</tr>

	<tr>
		<td class="mainRowEven" style=" border-top: none;" colspan="2">
			<label>latitude: </label>
				<input id="latitude" type="text" value="0" readonly="">
			<label> &nbsp; longitude: </label>
				<input id="longitude" type="text" value="0" readonly="">
		</td>
	</tr>
</tbody></table>

	<?php
	echo "<script> ".file_get_contents($global['approot']."/mod/gis/main.js")."</script>";

}

