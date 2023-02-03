document.addEventListener('DOMContentLoaded', () => {
  ///////////////////////////////////////////////////
  //
  // VARIABLES - Sort of global to the module
  //
  ///////////////////////////////////////////////////

  // Standard zoom level
  const zoomLevel = 16;

  // Map
  let map = null;

  // Marker Icon
  const markerIcon = {
    url:
      'https://uploads-ssl.webflow.com/6383a44a3096111ea3010988/63a500e56c31f241da19451c_house-icon-primary-color.svg',
    scaledSize: new google.maps.Size(40, 40),
  };

  // Markers
  let markers = [];

  ///////////////////////////////////////////////////
  //
  // UTIL METHODS
  //
  ///////////////////////////////////////////////////

  // Adds a marker to the map and push to the array.
  function addMarker(position) {
    const marker = new google.maps.Marker({
      position,
      icon: markerIcon,
      map,
    });
    markers.push(marker);
  }

  function centerMapToMarkers() {
    if (map && markers.length > 0) {
      // Create a new LatLngBounds object
      let bounds = new google.maps.LatLngBounds();

      // Add each marker to the bounds
      for (var i = 0; i < markers.length; i++) {
        bounds.extend(markers[i].getPosition());
      }

      map.setCenter(bounds.getCenter());
    }
  }

  ///////////////////////////////////////////////////
  //
  // CREATING MAP
  //
  ///////////////////////////////////////////////////

  const solSquareMadrid = { lat: 40.416762, lng: -3.703902 };
  map = new google.maps.Map(document.getElementById('sf-map'), {
    zoom: zoomLevel,
    center: solSquareMadrid,
  });

  ///////////////////////////////////////////////////
  //
  // Add Mark Icon for element
  //
  ///////////////////////////////////////////////////

  let dataElement = document.getElementById('premise-data_info');

  let [latitudeTxt, longitudeTxt] = [
    dataElement.getAttribute('sf-latitude'),
    dataElement.getAttribute('sf-longitude'),
  ];

  let [latitude, longitude] = [
    parseFloat(latitudeTxt),
    parseFloat(longitudeTxt),
  ];

  // If there is geolocation data then add a Mark Icon
  if (!isNaN(latitude) && !isNaN(longitude)) {
    addMarker({ lat: latitude, lng: longitude });
  }

  centerMapToMarkers();
});
