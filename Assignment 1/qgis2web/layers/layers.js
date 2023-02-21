var wms_layers = [];

var format_Counties_0 = new ol.format.GeoJSON();
var features_Counties_0 = format_Counties_0.readFeatures(json_Counties_0, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_Counties_0 = new ol.source.Vector({
    attributions: ' ',
});
jsonSource_Counties_0.addFeatures(features_Counties_0);
var lyr_Counties_0 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_Counties_0, 
                style: style_Counties_0,
                interactive: false,
                title: '<img src="styles/legend/Counties_0.png" /> Counties'
            });
var format_Buffered_1 = new ol.format.GeoJSON();
var features_Buffered_1 = format_Buffered_1.readFeatures(json_Buffered_1, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_Buffered_1 = new ol.source.Vector({
    attributions: ' ',
});
jsonSource_Buffered_1.addFeatures(features_Buffered_1);
var lyr_Buffered_1 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_Buffered_1, 
                style: style_Buffered_1,
                interactive: false,
                title: '<img src="styles/legend/Buffered_1.png" /> Buffered'
            });
var format_citiesund75_2 = new ol.format.GeoJSON();
var features_citiesund75_2 = format_citiesund75_2.readFeatures(json_citiesund75_2, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_citiesund75_2 = new ol.source.Vector({
    attributions: ' ',
});
jsonSource_citiesund75_2.addFeatures(features_citiesund75_2);
var lyr_citiesund75_2 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_citiesund75_2, 
                style: style_citiesund75_2,
                interactive: true,
                title: '<img src="styles/legend/citiesund75_2.png" /> citiesund75'
            });

lyr_Counties_0.setVisible(true);lyr_Buffered_1.setVisible(true);lyr_citiesund75_2.setVisible(true);
var layersList = [lyr_Counties_0,lyr_Buffered_1,lyr_citiesund75_2];
lyr_Counties_0.set('fieldAliases', {'AREA': 'AREA', 'PERIMETER': 'PERIMETER', 'COUNTY_': 'COUNTY_', 'COUNTY_ID': 'COUNTY_ID', 'CO_NUMBER': 'CO_NUMBER', 'CO_FIPS': 'CO_FIPS', 'ACRES_SF': 'ACRES_SF', 'ACRES': 'ACRES', 'FIPS': 'FIPS', 'COUNTY': 'COUNTY', 'ST': 'ST', 'OID_': 'OID_', 'ID': 'ID', 'COUNTY_1': 'COUNTY_1', 'TOT_POP': 'TOT_POP', 'TOT_POP_UR': 'TOT_POP_UR', 'TOT_POP_RU': 'TOT_POP_RU', 'URBAN': 'URBAN', 'Rural': 'Rural', 'FIPS_no': 'FIPS_no', });
lyr_Buffered_1.set('fieldAliases', {'GEOID': 'GEOID', 'NAME': 'NAME', 'popOver18': 'popOver18', 'totalPop': 'totalPop', 'per18o': 'per18o', 'per75und18': 'per75und18', });
lyr_citiesund75_2.set('fieldAliases', {'GEOID': 'GEOID', 'NAME': 'NAME', 'popOver18': 'popOver18', 'totalPop': 'totalPop', 'per18o': 'per18o', 'per75und18': 'per75und18', });
lyr_Counties_0.set('fieldImages', {'AREA': 'TextEdit', 'PERIMETER': 'TextEdit', 'COUNTY_': 'TextEdit', 'COUNTY_ID': 'TextEdit', 'CO_NUMBER': 'TextEdit', 'CO_FIPS': 'Range', 'ACRES_SF': 'TextEdit', 'ACRES': 'TextEdit', 'FIPS': 'TextEdit', 'COUNTY': 'TextEdit', 'ST': 'TextEdit', 'OID_': 'Range', 'ID': 'TextEdit', 'COUNTY_1': 'TextEdit', 'TOT_POP': 'TextEdit', 'TOT_POP_UR': 'TextEdit', 'TOT_POP_RU': 'TextEdit', 'URBAN': 'Range', 'Rural': 'Range', 'FIPS_no': 'Range', });
lyr_Buffered_1.set('fieldImages', {'GEOID': '', 'NAME': '', 'popOver18': '', 'totalPop': '', 'per18o': '', 'per75und18': '', });
lyr_citiesund75_2.set('fieldImages', {'GEOID': '', 'NAME': '', 'popOver18': '', 'totalPop': '', 'per18o': '', 'per75und18': '', });
lyr_Counties_0.set('fieldLabels', {'AREA': 'no label', 'PERIMETER': 'no label', 'COUNTY_': 'no label', 'COUNTY_ID': 'no label', 'CO_NUMBER': 'no label', 'CO_FIPS': 'no label', 'ACRES_SF': 'no label', 'ACRES': 'no label', 'FIPS': 'no label', 'COUNTY': 'no label', 'ST': 'no label', 'OID_': 'no label', 'ID': 'no label', 'COUNTY_1': 'no label', 'TOT_POP': 'no label', 'TOT_POP_UR': 'no label', 'TOT_POP_RU': 'no label', 'URBAN': 'no label', 'Rural': 'no label', 'FIPS_no': 'no label', });
lyr_Buffered_1.set('fieldLabels', {'GEOID': 'no label', 'NAME': 'no label', 'popOver18': 'no label', 'totalPop': 'no label', 'per18o': 'no label', 'per75und18': 'no label', });
lyr_citiesund75_2.set('fieldLabels', {'GEOID': 'inline label', 'NAME': 'header label', 'popOver18': 'inline label', 'totalPop': 'inline label', 'per18o': 'inline label', 'per75und18': 'inline label', });
lyr_citiesund75_2.on('precompose', function(evt) {
    evt.context.globalCompositeOperation = 'normal';
});