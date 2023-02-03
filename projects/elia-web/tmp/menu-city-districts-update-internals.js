document.addEventListener('DOMContentLoaded', () => {
  ///////////////////////////////////////////////////
  //
  // BUILD MENU:
  //
  ///////////////////////////////////////////////////

  let cityDistrictSelect = $('#city-district-select');
  let cityDistrictSelectText = $('#city-district-select-text');

  $(cityDistrictSelect).change(function () {
    const cityDistrictTxt = $(cityDistrictSelectText).text();
    const [city, district] = cityDistrictTxt
      .split('-')
      .map((txt) => txt.trim());
  });
});
