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