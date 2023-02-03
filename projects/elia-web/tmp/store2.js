let sf_filtered_elements = [];

document.addEventListener('DOMContentLoaded', () => {
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

        // Add markers for each filtered premise
        sf_filtered_elements.forEach((element) => {
          let premiseDataEle = $(sf_filtered_elements[0].element).find(
            '[sf-slug]'
          );
          let [latitude, longitude] = [
            premiseDataEle.attr('sf-latitude'),
            premiseDataEle.attr('sf-longitude'),
          ];

          console.log('latitude', latitude);
          console.log('longitude', longitude);

          const marker = new mapboxgl.Marker()
            .setLngLat([parseFloat(latitude), parseFloat(longitude)])
            .addTo(map);
        });
      });

      // The `renderitems` event runs whenever the list renders items after filtering.
      filterInstance.listInstance.on('renderitems', (renderedItems) => {
        console.log(renderedItems);

        let listInstances = filterInstances[0].listInstance.validItems;

        updateFilterElements(listInstances);
      });
    },
  ]);

  // Adding map
  mapboxgl.accessToken =
    'pk.eyJ1IjoiY3VldmFzaHNwIiwiYSI6ImNsYWEyeWJqazA0ZnAzdXFnZzEycmN6Y2gifQ.QIhOxWvVF62u65QYXUMqMw';
  const monument = [40.409587, -3.699525];

  /*   const map = new mapboxgl.Map({
    container: 'sf-map',
    // Choose from Mapbox's core styles, or make your own style with Mapbox Studio
    style: 'mapbox://styles/mapbox/light-v11',
    center: monument,
    zoom: 15,
  }); */

  const map = new mapboxgl.Map({
    container: 'map',
    style: {
      version: 8,
      sources: {
        osm: {
          type: 'raster',
          tiles: ['https://tile.openstreetmap.org/{z}/{x}/{y}.png'],
          tileSize: 256,
          attribution:
            'Map tiles by <a target="_top" rel="noopener" href="https://tile.openstreetmap.org/">OpenStreetMap tile servers</a>, under the <a target="_top" rel="noopener" href="https://operations.osmfoundation.org/policies/tiles/">tile usage policy</a>. Data by <a target="_top" rel="noopener" href="http://openstreetmap.org">OpenStreetMap</a>',
        },
      },
      layers: [
        {
          id: 'osm',
          type: 'raster',
          source: 'osm',
        },
      ],
      center: monument,
      zoom: 15,
    },
  });

  console.log('MAP ADDED!! BEWARE!!');

  // Resise when click on tab parent
  $('#sf-tab-map').click(function () {
    sf_debounce(() => map.resize(), 250)();
    console.log('Map resizing');
  });

  // Adding resizer for the map
  // const resizer = new ResizeObserver(debounce(() => map.resize()));
  // resizer.observe(mapWrapper.current);
});

<iframe
  src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d6076.050794778534!2d-3.6997391999999993!3d40.408288150000004!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd42262b630ef5c5%3A0x719eabe8f5f085d0!2sLavapi%C3%A9s%2C%2028012%20Madrid!5e0!3m2!1sen!2ses!4v1671881841752!5m2!1sen!2ses"
  width="600"
  height="450"
  style="border:0;"
  allowfullscreen=""
  loading="lazy"
  referrerpolicy="no-referrer-when-downgrade"
></iframe>;

<iframe
  width="100%"
  height="450"
  frameborder="0"
  title="Felt Map"
  src="https://felt.com/embed/map/Tutorial-Learn-to-Use-Felt-JkDfEE3NSKqp2NROP9AyN1C?lat=40.801969&lon=-73.951852&zoom=16.652"
></iframe>;
