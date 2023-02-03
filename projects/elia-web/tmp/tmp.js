
<script>


var map = new maplibregl.Map({
    container: 'map',
    style:'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoiY3VldmFzaHNwIiwiYSI6ImNpc2owNmZtOTAwMnQyeXJud3I2dDN5OTAifQ.cwvqX7PvAwWheN6B8BIyaQ',
center: [-122.407702, 37.793244],
zoom: 15.5,
pitch: 45,
bearing: -17.6,
container: 'map',
antialias: true,
interactive: false
});
 
// The 'building' layer in the mapbox-streets vector source contains building-height
// data from OpenStreetMap.
map.on('load', function() {
// Insert the layer beneath any symbol layer.
var layers = map.getStyle().layers;
 
var labelLayerId;
for (var i = 0; i < layers.length; i++) {
if (layers[i].type === 'symbol' && layers[i].layout['text-field']) {
labelLayerId = layers[i].id;
break;
}
}
 
// map.addLayer({
// 'id': '3d-buildings',
// 'source': 'composite',
// 'source-layer': 'building',
// 'filter': ['==', 'extrude', 'true'],
// 'type': 'fill-extrusion',
// 'minzoom': 15,
// 'paint': {
// 'fill-extrusion-color': '#aaa',
 
// // use an 'interpolate' expression to add a smooth transition effect to the
// // buildings as the user zooms in
// 'fill-extrusion-height': [
// "interpolate", ["linear"], ["zoom"],
// 15, 0,
// 15.05, ["get", "height"]
// ],
// 'fill-extrusion-base': [
// "interpolate", ["linear"], ["zoom"],
// 15, 0,
// 15.05, ["get", "min_height"]
// ],
// 'fill-extrusion-opacity': .6
// }
// }, labelLayerId);

});

var chapters = {
    'chinatown': {
        bearing: -17.6,
        center: [-122.407702, 37.793244],
        zoom: 15.5,
        pitch: 45
    },
    'coit-tower': {
        duration: 5000,
        center: [-122.4063694, 37.802396],
        bearing: 27,
        zoom: 17.5,
        pitch: 90
    },
    'north-beach': {
        bearing: 27,
        duration: 5000,
        center: [-122.4169511, 37.8047288],
        zoom: 16,
        pitch: 40
    },
    'fishermans-wharf': {
        bearing: 90,
        duration: 5000,
        center: [-122.4253858, 37.8081269],
        zoom: 16
    },
    'nob-hill': {
        bearing: 27,
        duration: 5000,
        center: [-122.4204894, 37.7929521],
        zoom: 16,
        pitch: 40,
    },
    'fairmont': {
        bearing: 90,
        duration: 5000,
        center: [-122.412633, 37.7923939],
        zoom: 17,
        pitch: 60
    },
    'ferry-building': {
        bearing: 120,
        duration: 5000,
        center: [-122.3955095, 37.7955745],
        zoom: 17.3,
        pitch: 60
    },
    'market-street': {
        bearing: 90,
        duration: 5000,
        center: [-122.4025016, 37.789555],
        zoom: 14.3,
        pitch: 20
    }
};

// On every scroll event, check which element is on screen
window.onscroll = function() {
    var chapterNames = Object.keys(chapters);
    for (var i = 0; i < chapterNames.length; i++) {
        var chapterName = chapterNames[i];
        if (isElementOnScreen(chapterName)) {
            setActiveChapter(chapterName);
            break;
        }
    }
};

var activeChapterName = 'chinatown';
function setActiveChapter(chapterName) {
    if (chapterName === activeChapterName) return;

    map.flyTo(chapters[chapterName]);

    document.getElementById(chapterName).setAttribute('class', 'active');
    document.getElementById(activeChapterName).setAttribute('class', '');

    activeChapterName = chapterName;
}

function isElementOnScreen(id) {
    var element = document.getElementById(id);
    var bounds = element.getBoundingClientRect();
    return bounds.top < window.innerHeight && bounds.bottom > 300;
}

</script>