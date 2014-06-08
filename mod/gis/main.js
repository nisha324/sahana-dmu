//init
$(document).ready(function(){
layers = [
          new ol.layer.Tile({
            source: new ol.source.OSM()
          })
        ];

olmap = new ol.Map({
        target: 'the-map',
		
        layers: layers,
        view: new ol.View2D({
          center: [0,0],
          zoom: 2
        })
      });
});	 