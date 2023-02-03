// cut-off-all-texts





document.addEventListener('DOMContentLoaded', () => {
  window.fsAttributes = window.fsAttributes || [];

  window.fsAttributes.push([
    'cmsfilter',
    (filterInstances) => {
      // The callback passes a `filterInstances` array with all the `CMSFilters` instances on the page.
      const [filterInstance] = filterInstances;

      let updateFilterElements = function (filteredEles) {
        console.log('It works!', filteredEles);

        // Cut text for each element
        filteredEles.forEach((ele) => {
          let hmtlEle = ele.element;

          let targets = $(hmtlEle).find('.cut-off-txt');

          Array.from(targets).forEach((target) => {
            console.log('target ->', target);
            const maxCharacters = Number(
              $(target).attr('sf-cut-off-max-chars') || 100
            );
            const text = $(target).text();
            const truncate = text.substring(0, maxCharacters);
            const lastIdxSpace =
              truncate.lastIndexOf(' ') < 1 ? 1 : truncate.lastIndexOf(' ');
            const truncateInLastWord = truncate.substring(0, lastIdxSpace);
            $(target).text(`${truncateInLastWord}...`);
          });
        });
      };

      // The `renderitems` event runs whenever the list renders items after filtering.
      filterInstance.listInstance.on('renderitems', (renderedItems) => {
        updateFilterElements(filterInstances[0].listInstance.validItems);
      });
    },
  ]);
});









document.addEventListener('DOMContentLoaded', () => {
  window.fsAttributes = window.fsAttributes || [];

  window.fsAttributes.push([
    'cmsfilter',
    (filterInstances) => {
      // The callback passes a `filterInstances` array with all the `CMSFilters` instances on the page.
      const [filterInstance] = filterInstances;

      let updateFilterElements = sf_debounce(function (filteredEles) {
        console.log('It works!', filteredEles);

        // Cut text for each element
        filteredEles.forEach((ele) => {
          let hmtlEle = ele.element;

          let targets = $(hmtlEle).find('.cut-off-txt');

          Array.from(targets).forEach((target) => {
            console.log('target ->', target);
            const maxCharacters = Number(
              $(target).attr('sf-cut-off-max-chars') || 100
            );
            const text = $(target).text();
            const truncate = text.substring(0, maxCharacters);
            const lastIdxSpace =
              truncate.lastIndexOf(' ') < 1 ? 1 : truncate.lastIndexOf(' ');
            const truncateInLastWord = truncate.substring(0, lastIdxSpace);
            $(target).text(`${truncateInLastWord}...`);
          });
        });
      }, document.addEventListener('DOMContentLoaded', () => {
  window.fsAttributes = window.fsAttributes || [];

  window.fsAttributes.push([
    'cmsfilter',
    (filterInstances) => {
      // The callback passes a `filterInstances` array with all the `CMSFilters` instances on the page.
      const [filterInstance] = filterInstances;

      let updateFilterElements = sf_debounce(function (filteredEles) {
        console.log('It works!', filteredEles);

        // Cut text for each element
        filteredEles.forEach((ele) => {
          let hmtlEle = ele.element;

          let targets = $(hmtlEle).find('.cut-off-txt');

          Array.from(targets).forEach((target) => {
            console.log('target ->', target);
            const maxCharacters = Number(
              $(target).attr('sf-cut-off-max-chars') || 100
            );
            const text = $(target).text();
            const truncate = text.substring(0, maxCharacters);
            const lastIdxSpace =
              truncate.lastIndexOf(' ') < 1 ? 1 : truncate.lastIndexOf(' ');
            const truncateInLastWord = truncate.substring(0, lastIdxSpace);
            $(target).text(`${truncateInLastWord}...`);
          });
        });
      }, timeout = 50);

      // The `renderitems` event runs whenever the list renders items after filtering.
      filterInstance.listInstance.on('renderitems', (renderedItems) => {
        updateFilterElements(filterInstances[0].listInstance.validItems);
      });
    },
  ]);
}););

      // The `renderitems` event runs whenever the list renders items after filtering.
      filterInstance.listInstance.on('renderitems', (renderedItems) => {
        updateFilterElements(filterInstances[0].listInstance.validItems);
      });
    },
  ]);
});



document.addEventListener('DOMContentLoaded', () => {
  window.fsAttributes = window.fsAttributes || [];

  window.fsAttributes.push([
    'cmsfilter',
    (filterInstances) => {
      // The callback passes a `filterInstances` array with all the `CMSFilters` instances on the page.
      const [filterInstance] = filterInstances;

      let updateFilterElements = sf_debounce(function (filteredEles) {
        console.log('It works!', filteredEles);

        // Cut text for each element
        filteredEles.forEach((ele) => {
          let hmtlEle = ele.element;

          let targets = $(hmtlEle).find('.cut-off-txt');

          Array.from(targets).forEach((target) => {
            console.log('target ->', target);
            const maxCharacters = Number(
              $(target).attr('sf-cut-off-max-chars') || 100
            );
            const text = $(target).text();
            const truncate = text.substring(0, maxCharacters);
            const lastIdxSpace =
              truncate.lastIndexOf(' ') < 1 ? 1 : truncate.lastIndexOf(' ');
            const truncateInLastWord = truncate.substring(0, lastIdxSpace);
            $(target).text(`${truncateInLastWord}...`);
          });
        });
      });

      // The `renderitems` event runs whenever the list renders items after filtering.
      filterInstance.listInstance.on('renderitems', (renderedItems) => {
        updateFilterElements(filterInstances[0].listInstance.validItems);
      });
    },
  ]);
});



document.addEventListener('DOMContentLoaded', () => {
  (() => {
      console.log("AHAAAAA")
      let wholeTxt =
        '{{wf {&quot;path&quot;:&quot;description&quot;,&quot;type&quot;:&quot;PlainText&quot;\} }}';
      
      const maxCharacters = 200;
      const truncate = wholeTxt.substring(0, maxCharacters);
      const lastIdxSpace =
        truncate.lastIndexOf(' ') < 1 ? 1 : truncate.lastIndexOf(' ');
      const truncateInLastWord = truncate.substring(0, lastIdxSpace);
      const truncatedtTxt = `${truncateInLastWord}...`;
      
      console.log("asdasd", truncatedtTxt)
      
      $('#{{wf {&quot;path&quot;:&quot;slug&quot;,&quot;type&quot;:&quot;PlainText&quot;\} }}').text(truncatedtTxt)
  })()
  }


  document.addEventListener('DOMContentLoaded', () => {
  window.fsAttributes = window.fsAttributes || [];

  window.fsAttributes.push([
    'cmsfilter',
    (filterInstances) => {
      // The callback passes a `filterInstances` array with all the `CMSFilters` instances on the page.
      const [filterInstance] = filterInstances;

      let updateFilterElements = sf_debounce(function (filteredEles) {
        console.log('It works!', filteredEles);

        // Cut text for each element
        filteredEles.forEach((ele) => {
          let hmtlEle = ele.element;

          let targets = $(hmtlEle).find('.cut-off-txt');

          Array.from(targets).forEach((target) => {
            console.log('target ->', target);
            const maxCharacters = Number(
              $(target).attr('sf-cut-off-max-chars') || 100
            );
            const text = $(target).text();
            const truncate = text.substring(0, maxCharacters);
            const lastIdxSpace =
              truncate.lastIndexOf(' ') < 1 ? 1 : truncate.lastIndexOf(' ');
            const truncateInLastWord = truncate.substring(0, lastIdxSpace);
            $(target).text(`${truncateInLastWord}...`);
          });
        });
      });

      // The `renderitems` event runs whenever the list renders items after filtering.
      filterInstance.listInstance.on('renderitems', (renderedItems) => {
        updateFilterElements(filterInstances[0].listInstance.validItems);
      });
    },
  ]);
});+




console.log("{{wf {&quot;path&quot;:&quot;slug&quot;,&quot;type&quot;:&quot;PlainText&quot;\} }} ->" , "{{wf {&quot;path&quot;:&quot;description&quot;,&quot;type&quot;:&quot;PlainText&quot;\} }}" )


let wholeTxt =
  '{{wf {&quot;path&quot;:&quot;description&quot;,&quot;type&quot;:&quot;PlainText&quot;\} }}';
  
const maxCharacters = 200;
const truncate = wholeTxt.substring(0, maxCharacters);
const lastIdxSpace =
  truncate.lastIndexOf(' ') < 1 ? 1 : truncate.lastIndexOf(' ');
const truncateInLastWord = truncate.substring(0, lastIdxSpace);
const truncatedtTxt = `${truncateInLastWord}...`;

console.log("asdasd", truncatedtTxt)

const elem = document.getElementById('{{wf {&quot;path&quot;:&quot;slug&quot;,&quot;type&quot;:&quot;PlainText&quot;\} }}')

if (elem) {
  elem.textContent = truncatedtTxt
}


function sfApiTruncateTxtInWord(txt, maxCharacters = 200) {

const truncate = txt.substring(0, maxCharacters);
const lastIdxSpace =
  truncate.lastIndexOf(' ') < 1 ? 1 : truncate.lastIndexOf(' ');
const truncateInLastWord = truncate.substring(0, lastIdxSpace);
return `${truncateInLastWord}...`;

}


window.fsAttributes = window.fsAttributes || [];
window.fsAttributes.push([
  'cmsfilter',
  (filterInstances) => {
    console.log('cmsfilter Successfully loaded!');

    // The callback passes a `filterInstances` array with all the `CMSFilters` instances on the page.
    const [filterInstance] = filterInstances;

    // The `renderitems` event runs whenever the list renders items after filtering.
    filterInstance.listInstance.on('renderitems', (renderedItems) => {
      console.log(renderedItems);
    });
  },
]);




 $(document).ready(function () {

$(".prixthumb").each(function () { 
                //this is the target text string converted to a number
            var numprice = Number($(this).text());
                // create a function to set the International number format  
                var nprice = Intl.NumberFormat(`en-US`, {
                        style : 'currency',
                        currency: 'EUR',
                        currencyDisplay: `symbol`,
                        minimumFractionDigits: 0
                        //maximumFractionDigits: 0
                    }
                );
            // replace the current value for  the new formatted value      
            $(this).text(nprice.format(numprice));
            })
        });
