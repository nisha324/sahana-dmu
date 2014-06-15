//init

app = {}

$(document).ready(function(){

	olmap = new ol.Map({
        target: 'the-map',
		
        layers: [],
        view: new ol.View2D({
          center: [0,0],
          zoom: 2
        })
      });
	olmap.on('click', function(evt) {
		displayFeatureInfo(evt.pixel);
	});
	var highlightStyleCache = {};

	featureOverlay = new ol.FeatureOverlay({
	  map: olmap,
	  style: function(feature, resolution) {
		var text =  feature.getId();
		if (!highlightStyleCache[text]) {
		  highlightStyleCache[text] = [new ol.style.Style({
			stroke: new ol.style.Stroke({
			  color: '#f00',
			  width: 1
			}),
			fill: new ol.style.Fill({
			  color: 'rgba(255,0,0,0.1)'
			})
		  })];
		}
		return highlightStyleCache[text];
	  }
	});
	  
});	 


function confirm_delete_map( map_id ){
	if(confirm("Are you sure?")){
		gis_delete_map(map_id)
	}
}
function save_map(){
	gis_save_map($('#map-name').val());
}
function cancle_add_layer(){
	$('#add-layer').html('');
}
function init_map( map_id ){
	$(document).ready(function(){
		gis_get_layer_data(map_id);
	});
}
function init_layers( data ){
	app.layers  = data;
	
	//alert(JSON.stringify(data));
	$(data).each(function(){
		$('#layers').append("<tr> <td class='mainRow'><input type='checkbox'  />"+this.name+" </td></tr>");
		if(this.type == "0" ){
			add_tile_layer(this.options );
		}
		else if(this.type == "1" ){
			gis_get_Vector_layer_data(this.id);
		}
	});
}
function add_vector_layer( data ){
	var jsonLayer = new ol.layer.Vector({
     source: new ol.source.GeoJSON({
        object: data,
        projection: 'EPSG:3857'
     })
  });
olmap.addLayer(jsonLayer);
}
function add_tile_layer( data ){
	olmap.addLayer( 
		new ol.layer.Tile(  eval("( "+data+")") )
	);
}


var highlight;
function displayFeatureInfo(pixel) {

  var feature = olmap.forEachFeatureAtPixel(pixel, function(feature, layer) {
    return feature;
  });

  var info = document.getElementById('add-layer');
  if (feature) {
    info.innerHTML = '<table class="emTable" id="properties"> <tr> <td class="mainRowEven"><b style="line-height: 28px;">Properties</b></td></tr></table>';
	$(feature.getKeys()).each(function(key, element){
		if( element != 'geometry'){
			$('#properties').append('<tr><td>' + element + ' : ' + feature.get(element) + ' </td></tr>');
		}
	});
  } else {
    info.innerHTML = '&nbsp;';
  }

  if (feature !== highlight) {
    if (highlight) {
      featureOverlay.removeFeature(highlight);
    }
    if (feature) {
      featureOverlay.addFeature(feature);
    }
    highlight = feature;
  }

};

function test(){
    
    
    gis_create_vector_layer(2, 'Central Hospitals', '', '{"type":"FeatureCollection","features":[{"type":"Feature","id":"LKA","properties":{"name":"Sri Lanka"},"geometry":{"type":"Polygon","coordinates":[[[81.787959,7.523055],[81.637322,6.481775],[81.21802,6.197141],[80.348357,5.96837],[79.872469,6.763463],[79.695167,8.200843],[80.147801,9.824078],[80.838818,9.268427],[81.304319,8.564206],[81.787959,7.523055            ]] ]}}]}');
}