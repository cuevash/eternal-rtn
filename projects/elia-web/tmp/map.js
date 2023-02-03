document.addEventListener('DOMContentLoaded', () => {
  ///////////////////////////////////////////////////
  //
  // VARIABLES - Sort of global to the module
  //
  ///////////////////////////////////////////////////

  // Standard zoom level
  const zoomLevel = 16;

  // Map
  let map = undefined;

  // Marker Icon
  const markerIcon = {
    url:
      'https://uploads-ssl.webflow.com/6383a44a3096111ea3010988/63a500e56c31f241da19451c_house-icon-primary-color.svg',
    scaledSize: new google.maps.Size(40, 40),
  };

  // Markers
  let markers = [];

  // InfoWindow
  let infoWindow = new google.maps.InfoWindow({
    content: '',
    maxWidth: 300,
  });

  // Cluster of markers
  let markerCluster = undefined;

  ///////////////////////////////////////////////////
  //
  // UTIL METHODS
  //
  ///////////////////////////////////////////////////

  // Adds a marker to markers array
  function addMarkerWithInfoContent(position, infoWindowContent) {
    const marker = new google.maps.Marker({
      position,
      icon: markerIcon,
    });
    markers.push(marker);

    marker.addListener('click', function () {
      infoWindow.close();
      infoWindow.setContent(infoWindowContent);
      infoWindow.open(marker.get('map'), marker);
      event.stopPropagation(); // Prevent the map to getting this event
    });
  }

  // Sets the map on all markers in the array.
  function emptyClusterAndMarkers() {
    if (markerCluster) {
      markerCluster.clearMarkers();

      // clear listeners
      for (var i = 0; i < markers.length; i++) {
        google.maps.event.clearInstanceListeners(markers[i]);
      }

      markers = [];
      markerCluster = null;
    }
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

  // Close infowindow on click
  google.maps.event.addListener(map, 'click', function () {
    infoWindow.close();
  });

  ///////////////////////////////////////////////////
  //
  // Update markers with given list.
  //
  ///////////////////////////////////////////////////

  // We use a debounce so it does help the system to settle on internal calculations

  let updateFilterElements = sf_debounce(function (filteredElements) {
    emptyClusterAndMarkers();

    // Add markers for each filtered premise
    filteredElements.forEach((ele) => {
      let premiseDataEle = $(ele.element).find('[sf-slug]');

      let premisePopupEle = $(ele.element).find(
        '[sf-p-element-type="sf-p-popup_premise"]'
      )[0];

      let [latitude, longitude] = [
        parseFloat(premiseDataEle.attr('sf-latitude')),
        parseFloat(premiseDataEle.attr('sf-longitude')),
      ];

      if (!isNaN(latitude) && !isNaN(longitude)) {
        addMarkerWithInfoContent(
          { lat: latitude, lng: longitude },
          premisePopupEle.outerHTML
        );
      }
    });

    // Create cluster with all the markers
    markerCluster = new markerClusterer.MarkerClusterer({ map, markers });

    centerMapToMarkers();
  });

  ///////////////////////////////////////////////////
  //
  // Listener to changes on filter
  //
  ///////////////////////////////////////////////////

  window.fsAttributes = window.fsAttributes || [];

  window.fsAttributes.push([
    'cmsfilter',
    (filterInstances) => {
      // The callback passes a `filterInstances` array with all the `CMSFilters` instances on the page.
      const [filterInstance] = filterInstances;

      // The `renderitems` event runs whenever the list renders items after filtering.
      filterInstance.listInstance.on('renderitems', (renderedItems) => {
        let listInstances = filterInstances[0].listInstance.validItems;

        updateFilterElements(listInstances);
      });
    },
  ]);
});
