document.addEventListener('DOMContentLoaded', () => {
  ///////////////////////////////////////////////////
  //
  // BUILD MENU:
  //
  ///////////////////////////////////////////////////

  let city_districts = {};
  $('.city-district-menu').each(function () {
    console.log('ONE more ->', $(this));
    let city = $(this).attr('city');
    let district = $(this).attr('district');

    let districtsForCities = city_districts[city] || new Set();
    city_districts[city] = districtsForCities.add(district);
  });

  // Sort cities
  const obj = { a: 1, b: 3, c: 2 };
  const entries = Object.entries(city_districts);
  entries.sort((a, b) => a[0].localeCompare(b[0]));

  // Sort districts
  const sortedAll = entries.map(([key, setValues]) => [
    key,
    [...setValues].sort((a, b) => a[0].localeCompare(b[0])),
  ]);

  // Find list parent element
  let menuElementParent = $('#cms-city-district-list-menu');

  sortedAll.forEach(([city, districts]) => {
    $(menuElementParent).append(
      `<div city="${city}" district="" fs-cmsselect-element="text-value-800">${city}</div>`
    );
    districts.forEach((district) => {
      $(menuElementParent).append(
        `<div city="${city}" district="${district}" fs-cmsselect-element="text-value-800">${city} - ${district}</div>`
      );
    });
  });

  sortedAll;

  $('#container').append('<div>This is a new div</div>');

  console.log('All ones!! ->', sortedAll);
});
