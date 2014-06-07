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
	echo "<style> ".file_get_contents($global['approot']."/mod/gis/main.css")."</style>";
	$q = "
		select *
		from map";
		$result = $global['db']->Execute($q);
		if($result === false) {
			daoErrorLog(__FILE__, __LINE__, __METHOD__, __CLASS__, __FUNCTION__, $global['db']->ErrorMsg(), "rez pages header");
		}
		if($result){
			// build page info
			while($row = $result->FetchRow() ) {
				echo "<div class='map-item'><img src='".$row['thumbnail']."'/><br/>".$row['name']."</div>";
			}
		}
	
}

