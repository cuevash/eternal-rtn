document.addEventListener('DOMContentLoaded', () => {
  $('[sf-process-format-number]').each(function () {
    //this is the target text string converted to a number
    var numberToFormat = Number($(this).text());

    console.log('Number is ->', numberToFormat);

    // create a function to set the International number format
    var priceFormatter = Intl.NumberFormat(`es-ES`, {
      style: 'currency',
      currency: 'EUR',
      currencyDisplay: `symbol`,
      minimumFractionDigits: 0,
      maximumFractionDigits: 2,
    });

    // replace the current value for  the new formatted value
    $(this).text(priceFormatter.format(numberToFormat));
  });
});
