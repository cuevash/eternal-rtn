const monument = [12.65147, 55.608166];
mapboxgl.accessToken =
  'pk.eyJ1IjoiaHVyc3RlbGNsZW1lbnQiLCJhIjoiY2w4ZW80ZGRqMDl6ZDN4bnprOTJ3d3d5YSJ9.Qmhfa2IfhZR8waS3Ixwaww';
var map = new mapboxgl.Map({
  container: 'map',
  style: 'mapbox://styles/hurstelclement/cl8fontw000k614ntg9zj2q74',
  center: monument,
  zoom: 8,
  projection: 'globe',
});

var current_popup, current_marker, current_item;

$('.location').each(function (index) {
  let cmsItem = $(this);
  let img = cmsItem
    .find('.location-profile')
    .css('background-image')
    .slice(4, -1)
    .replace(/["']/g, '');
  let name = cmsItem.find('.location-name').text();
  let lat = cmsItem.find('.lat').text();
  let lon = cmsItem.find('.lon').text();
  let detail1 = cmsItem.find('.popup-detail').text();
  let detail2 = cmsItem.find('.popup-detail-2').text();
  let pop = this.popup;

  let el = document.createElement('div');
  el.classList.add('star');
  let body = cmsItem.find('.pre-popup');

  pop = new mapboxgl.Popup({
    offset: 25,
    closeButton: false,
    maxWidth: 'auto',
  }).setHTML(body[0].outerHTML);

  let mark = this.marker;
  mark = new mapboxgl.Marker(el).setLngLat([lon, lat]).setPopup(pop).addTo(map);

  map.on('click', (e) => {
    if (e.originalEvent.srcElement.ariaLabel === 'Map') {
      current_marker.classList.remove('show');
    }
  });

  //MARKERS EVENT

  el.addEventListener('click', () => {
    pop.addTo(map); // show popup
    if (current_marker != undefined) {
      current_item.classList.remove('active');
      current_marker.classList.remove('show'); // we also come back to the original marker's image for the previous active marker
      pop.remove(); // remove the previous active popup if it's existing
    }
    current_item = this;
    current_item.classList.add('active');
    current_marker = el; // set the current popup active
    current_marker.classList.add('show'); // add class to marker to change the image
    map.flyTo({
      center: [lon, lat],
      zoom: 8,
      essential: true, // this animation is considered essential with respect to prefers-reduced-motion
    });
  });

  el.addEventListener('mouseover', () => {
    pop.addTo(map); // show popup
    el.classList.add('show'); // add class show to manage the marker's image
  });

  el.addEventListener('mouseout', () => {
    if (current_marker !== el) {
      pop.remove();
      el.classList.remove('show'); // we also come back to the original marker's image
    }
  });

  //LIST ITEMS EVENT

  this.addEventListener('click', () => {
    map.flyTo({
      center: [lon, lat],
      zoom: 8,
      essential: true, // this animation is considered essential with respect to prefers-reduced-motion
    });

    if (current_marker != undefined) {
      current_item.classList.remove('active');
      current_marker.classList.remove('show'); // we also come back to the original marker's image for the previous active marker
      current_popup.remove(); // remove the previous active popup if it's existing
    }
    pop.addTo(map); // toggle popup open or closed
    el.classList.add('show');
    current_marker = el;
    current_popup = pop;
    current_item = this;
    current_item.classList.add('active');
  });

  this.addEventListener('mouseover', () => {
    pop.addTo(map); // toggle popup open or closed
    el.classList.add('show');
  });

  this.addEventListener('mouseout', () => {
    // toggle popup open or closed
    if (current_marker !== el) {
      pop.remove();
      el.classList.remove('show');
    }
  });
});

document.addEventListener('DOMContentLoaded', () => {
  $('#premise-searcher_search-button-id').click(function () {
    console.log('Clicking!!!');

    let value_100 = $('#field-100').val();
    let value_300 = $('#field-300').val();
    let value_400 = $('#field-400').val();

    window.gbl_field_300 = value_100;
    console.log(
      'Changing val ->',
      `https://asdasdasd?tipology=${value_100}&city=${value_300}`
    );

    window.location.assign(
      `https://deapi-project-v1-0.webflow.io/premises?tipology=${value_100}&city=${value_300}`
    );
  });
});

document.addEventListener('DOMContentLoaded', () => {
  let defaultValue = $('#field-100-main').find('#default-value').text();

  let allOptions = $('#field-100-main').find('a[role="option"]');

  let ele = allOptions.filter(function () {
    return $(this).text() === defaultValue;
  });

  console.log('Element -> ', ele);
});

document.addEventListener('DOMContentLoaded', () => {
  let targets = $('.cut-off-txt');

  // Create an observer instance.
  var observer = new MutationObserver(function (mutations) {
    console.log(target.innerText);
  });

  Array.from(targets).forEach((target) => {
    // Pass in the target node, as well as the observer options.
    observer.observe(target, {
      attributes: true,
      childList: true,
      characterData: true,
    });
  });

  Array.from(targets).forEach((target) => {
    console.log('target ->', target);
    const maxCharacters = Number($(target).attr('sf-cut-off-max-chars') || 100);
    const text = $(target).text();
    const truncate = text.substring(0, maxCharacters);
    const lastIdxSpace =
      truncate.lastIndexOf(' ') < 1 ? 1 : truncate.lastIndexOf(' ');
    const truncateInLastWord = truncate.substring(0, lastIdxSpace);
    $(target).text(`${truncateInLastWord}...`);
  });
});
