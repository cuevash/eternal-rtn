let sf_filtered_elements = [];

let debugElement;

document.addEventListener('DOMContentLoaded', () => {
  // Marker
  const markerIcon = {
    url:
      'https://uploads-ssl.webflow.com/6383a44a3096111ea3010988/63a500e56c31f241da19451c_house-icon-primary-color.svg',
    scaledSize: new google.maps.Size(40, 40),
  };

  //Markers
  let markers = [];
  let infoWindow = new google.maps.InfoWindow({
    content: '',
    maxWidth: 300,
  });
  let markerCluster = null;

  window.fsAttributes = window.fsAttributes || [];

  window.fsAttributes.push([
    'cmsfilter',
    (filterInstances) => {
      console.log('cmsfilter Successfully loaded!');

      // The callback passes a `filterInstances` array with all the `CMSFilters` instances on the page.
      const [filterInstance] = filterInstances;

      console.log('filterInstances', filterInstances);

      let updateFilterElements = sf_debounce(function (filteredEle) {
        console.log('It works!', filteredEle);

        sf_filtered_elements = filteredEle;

        // Remove all markers
        markerCluster && markerCluster.removeMarkers(markers);
        removeMarkers();

        // Add markers for each filtered premise
        sf_filtered_elements.forEach((ele) => {
          let premiseDataEle = $(ele.element).find('[sf-slug]');

          let premisePopupEle = $(ele.element).find(
            '[sf-p-element-type="sf-p-popup_premise"]'
          )[0];

          console.log('slug', premiseDataEle.attr('sf-slug'));

          debugElement = premisePopupEle;
          console.log('premisePopupEle', premisePopupEle);

          let [latitude, longitude] = [
            parseFloat(premiseDataEle.attr('sf-latitude')),
            parseFloat(premiseDataEle.attr('sf-longitude')),
          ];

          console.log('latitude', latitude);
          console.log('longitude', longitude);

          if (!isNaN(latitude) && !isNaN(longitude)) {
            const position = { lat: latitude, lng: longitude };

            addMarkerWithInfoContent(position, premisePopupEle.outerHTML);

            // // Mrker
            // const markerHtml = document.createElement('div');
            // markerHtml.id = 'sf-marker';

            // const popup = new mapboxgl.Popup({
            //   offset: 25,
            //   closeButton: false,
            //   maxWidth: 'auto',
            // }).setHTML(premisePopupEle.outerHTML);

            // // Marker with popup
            // const marker = new mapboxgl.Marker(markerHtml)
            //   .setLngLat([parseFloat(longitude), parseFloat(latitude)])
            //   .setPopup(popup)
            //   .addTo(map);

            // // Add marker to global list
            // sf_g_allMarkers.push(marker);
          }
        });

        console.log('markers ->', markers);

        // Create cluster with all the markers
        new markerClusterer.MarkerClusterer({ map, markers });

        // Fit map to cluster
        // Create a new LatLngBounds object
        var bounds = new google.maps.LatLngBounds();

        // Add each marker to the bounds
        for (var i = 0; i < markers.length; i++) {
          bounds.extend(markers[i].getPosition());
        }

        // Fit the map to the newly inclusive bounds
        map.fitBounds(bounds);
        map.setZoom(map.getZoom() - 1);
      });

      // The `renderitems` event runs whenever the list renders items after filtering.
      filterInstance.listInstance.on('renderitems', (renderedItems) => {
        console.log(renderedItems);

        let listInstances = filterInstances[0].listInstance.validItems;

        updateFilterElements(listInstances);
      });
    },
  ]);

  const monument = { lat: 40.409587, lng: -3.699525 };
  const map = new google.maps.Map(document.getElementById('sf-map'), {
    zoom: 16,
    center: monument,
  });

  // Set event to close infowindow
  map.addListener('click', () => {
    if (infoWindow) {
      infoWindow.close();
    }
  });

  console.log('MAP ADDED!! BEWARE!!');

  // Util Methods

  // Adds a marker to the map and push to the array.
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
    });
  }

  // Sets the map on all markers in the array.
  function removeMarkers() {
    for (let i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
    }

    markers = [];
  }
});
