(() => {
  ///////////////////////////////////////////////////
  //
  // Variables
  //
  ///////////////////////////////////////////////////

  // create a function to set the International number format
  let priceFormatter = Intl.NumberFormat('es-es', {
    style: 'currency',
    currency: 'EUR',
    currencyDisplay: 'symbol',
    minimumFractionDigits: 0,
    maximumFractionDigits: 2,
  });

  ///////////////////////////////////////////////////
  //
  // Update markers with given list.
  //
  ///////////////////////////////////////////////////



  document.addEventListener("DOMContentLoaded", () => {
    const setTxts = new Set();
    for (const div of document.querySelectorAll(".sf-p-checkbox_premise-element")) {
      if (setTxts.has(div.textContent.trim())) {
        div.parentNode.removeChild(div);
      } else {
        setTxts.add(div.textContent.trim());
      }
    }
  });


  // We use a debounce so it does help the system to settle on internal calculations

  let updateFilterElements = sf_debounce(function (filteredElements) {
    filteredElements.forEach((ele) => {
      console.log('ele ->', ele.element);
      let dataElements = ele.element.querySelectorAll(
        '[sf-process-format-number]'
      );
      console.log('dataElements ->', dataElements);

      dataElements.forEach(function (dataEle) {
        let valueInTxt = dataEle.getAttribute('value-reference');
        console.log('dataEle ->', valueInTxt);
        let valueIn = parseFloat(valueInTxt);

        if (!Number.isNaN(valueIn)) {
          // replace the current value for  the new formatted value
          dataEle.textContent = priceFormatter.format(valueIn);
        }
      });
    });
  });

  ///////////////////////////////////////////////////
  //
  // Listener to changes on pagination
  //
  ///////////////////////////////////////////////////

  console.log(' do we get them mayor ???!!!! ', window.fsAttributes);

  window.fsAttributes = window.fsAttributes || [];

  window.fsAttributes.push([
    'cmsfilter',
    (instances) => {
      console.log('cmsload Successfully loaded!');
      // The callback passes a `filterInstances` array with all the `CMSFilters` instances on the page.
      const [instance] = instances;

      console.log('listInstance -> ', instances);

      // The `renderitems` event runs whenever the list renders items after filtering.
      instance.listInstance.on('renderitems', (renderedItems) => {
        console.log('TO BE F:: RENDERED', renderedItems);
        updateFilterElements(renderedItems);
      });
    },
  ]);
})();
