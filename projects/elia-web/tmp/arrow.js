document.addEventListener('DOMContentLoaded', () => {
  // Mirroring position of nav link to another.
  // When updating position by clicking actions one the other gets updated as well

  let mainSliderRoot = $('#slider-mask_100-percent-n1');
  let mirroredSliderRoot = $('#slider-mask_100-percent-n3');

  function mirroredSliderIdx(mainSliderRoot, mirroredSliderRoot) {
    // CSS nth-child index starts at 1
    let sliderIdx = $(mainSliderRoot).find('.w-active').index() + 1;

    let navElementMirror = $(mirroredSliderRoot).find(
      `.w-slider-dot:nth-child(${sliderIdx})`
    );

    $(navElementMirror).click();
  }

  let onUpdateSliderIdx = sf_debounce(function () {
    mirroredSliderIdx(mainSliderRoot, mirroredSliderRoot);
  }, 100);

  $(mainSliderRoot)
    .find('.sf-p-slider_nav, .sf-p-slider_arrow, .sf-p-slider_mask')
    .on('click', function () {
      onUpdateSliderIdx();
    });
});
