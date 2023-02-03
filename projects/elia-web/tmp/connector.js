document.addEventListener('DOMContentLoaded', () => {
  ///////////////////////////////////////////////////
  //
  // CONNECTORS
  //
  ///////////////////////////////////////////////////

  ///////////////////////////////////////////////////
  //
  // CONNECT: Button, Click Image Slider <-> To PopUp Slider Images
  //
  ///////////////////////////////////////////////////

  sf_debounce(function (filteredElements) {
    // Clik on zoom button or click on image slider -> put popup slider images on the backgound
    $('#premise_button-zoom').on('click', function () {
      console.log('Clikcing -> opening');
      $('.popup_premise-images').removeClass('sf-fixed-z-index-neg-1000');
      $('.popup_premise-images').addClass('sf-fixed-z-index-10000');
    });

    let eles = $('.premise_component').find('.sf-p-slider_mask');

    console.log('ELESSSS -> ', eles);

    $('.premise_component')
      .find('.sf-p-slider_mask')
      .on('click', function () {
        console.log('Clikcing -> opening');
        $('.popup_premise-images').removeClass('sf-fixed-z-index-neg-1000');
        $('.popup_premise-images').addClass('sf-fixed-z-index-10000');
      });

    // Clik button x popup set slider images to the background
    $('.popup_premise-images .popup_premise-images-close').on(
      'click',
      function () {
        $('.popup_premise-images').removeClass('sf-fixed-z-index-10000');
        $('.popup_premise-images').addClass('sf-fixed-z-index-neg-1000');
      }
    );
  }, 50)();
});
