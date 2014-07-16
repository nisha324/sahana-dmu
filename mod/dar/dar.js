/**
 * @name         Disaster Assessment and Response
 * @version      01
 * @package      dar
 * @author       Ramindu Deshapriya <rdeshapriya@virtusa.com>
 * @about        Developed in whole or part by the U.S. National Library of Medicine,the Sahana Foundation and Virtusa Corporation
 * @link         https://pl.nlm.nih.gov/about
 * @link         http://sahanafoundation.org
 * @link		 http://www.virtusa.com
 * @license	 	 http://www.gnu.org/licenses/lgpl-2.1.html GNU Lesser General Public License (LGPL)
 * @lastModified 2013.11.21
 */

function initCalendar() {
    $("#reportDate").datepicker({ dateFormat: 'yy-mm-dd' });
    $("#disasterDate").datepicker({ dateFormat: 'yy-mm-dd' });
}
function dar_get_general_data() {
    var r = new Object();
    r.reportDate                     = $("#reportDate").val();
    r.affected_area                  = $("#affected_area").val();
    r.focal_point_name               = $("#focal_point_name").val();
    r.area_type                      = $("#area_type").val();
    r.assessor_name                  = $("#assessor_name").val();
    r.assessor_designation           = $("#assessor_designation").val();
    r.focal_point_coordinator        = $("#focal_point_coordinator").val();


    var rj = JSON.stringify(r);
    return(rj);
}

function dar_get_popres_data() {
    var r = new Object();
    r.total_area                     = $("#total_area").val();
    r.area_population                = $("#area_population").val();
    r.affected_area                  = $("#affected_area").val();
    r.male_injured                   = $("#male_injured").val();
    r.female_injured                 = $("#female_injured").val();
    r.pregnant_female_injured        = $("#pregnant_female_injured").val();
    r.children_injured               = $("#children_injured").val();
    r.young_children_injured         = $("#young_children_injured").val();
    r.infants_injured                = $("#infants_injured").val();
    r.male_displaced                 = $("#male_displaced").val();
    r.female_displaced               = $("#female_displaced").val();
    r.pregnant_female_displaced      = $("#pregnant_female_displaced").val();
    r.children_displaced             = $("#children_displaced").val();
    r.young_children_displaced       = $("#young_children_displaced").val();
    r.infants_displaced              = $("#infants_displaced").val();
    r.male_missing                   = $("#male_missing").val();
    r.female_missing                 = $("#female_missing").val();
    r.pregnant_female_missing        = $("#pregnant_female_missing").val();
    r.children_missing               = $("#children_missing").val();
    r.young_children_missing         = $("#young_children_missing").val();
    r.infants_missing                = $("#infants_missing").val();
    r.male_deceased                  = $("#male_deceased").val();
    r.female_deceased                = $("#female_deceased").val();
    r.pregnant_female_deceased       = $("#pregnant_female_deceased").val();
    r.children_deceased              = $("#children_deceased").val();
    r.young_children_deceased        = $("#young_children_deceased").val();
    r.infants_deceased               = $("#infants_deceased").val();


    var rj = JSON.stringify(r);
    return(rj);
}

function dar_get_wash_data() {
    var r = new Object();
    r.pre_disaster_water_source          = $("#pre_disaster_water_source").val();
    r.post_disaster_water_status         = $("#post_disaster_water_status").val();
    r.water_sources_within_range         = $("#water_sources_within_range").val();
    r.water_sources_further_than_range   = $("#water_sources_further_than_range").val();
    r.water_treatment_required           = $("#water_treatment_required").val();
    r.estimated_requirement_per_day      = $("#estimated_requirement_per_day").val();
    r.waiting_time_pipe_borne            = $("#waiting_time_pipe_borne").val();
    r.waiting_time_open_well             = $("#waiting_time_open_well").val();
    r.waiting_time_hand_pump             = $("#waiting_time_hand_pump").val();
    r.hygiene_training_required          = $("#hygiene_training_required").val();
    r.number_of_toilets                  = $("#number_of_toilets").val();
    r.required_toilets_number            = $("#required_toilets_number").val();
    r.toilet_deficit                     = $("#toilet_deficit").val();
    r.vector_type                        = $("#vector_type").val();
    r.vector_disease                     = $("#vector_disease").val();


    var rj = JSON.stringify(r);
    return(rj);
}

function dar_get_food_data() {
    var r = new Object();
    r.food_practices_disruption      = $("#food_practices_disruption").val();
    r.accessible_food_source         = $("#accessible_food_source").val();


    var rj = JSON.stringify(r);
    return(rj);
}

function dar_get_shelter_data() {
    var r = new Object();
    r.partially_affected_houses         = $("#partially_affected_houses").val();
    r.totally_affected_houses           = $("#totally_affected_houses").val();
    r.families_evacuation               = $("#families_evacuation").val();
    r.population_evacuation             = $("#population_evacuation").val();
    r.families_displaced                = $("#families_displaced").val();
    r.population_displaced              = $("#population_displaced").val();
    r.estimated_number_requiring_shelter= $("#estimated_number_requiring_shelter").val();
    r.temporary_shelter_available       = $("#temporary_shelter_available").val();
    r.temp_shelter_covered_area         = $("#temp_shelter_covered_area").val();


    var rj = JSON.stringify(r);
    return(rj);
}
>>>>>>> decd297093251786c30937f5fc6ace03e0b6a589

