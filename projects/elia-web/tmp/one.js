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
    console.log('cmsfilter2 Successfully loaded!');

    // The callback passes a `filterInstances` array with all the `CMSFilters` instances on the page.
    const [filterInstance] = filterInstances;

    // The `renderitems` event runs whenever the list renders items after filtering.
    filterInstance.listInstance.on('renderitems', (renderedItems) => {
      console.log(renderedItems);

      renderedItems.forEach((ele) => {
        let hmtlEle = ele.element;

        let targets = $(hmtlEle).find('.cut-off-txt');

        Array.from(targets).forEach((target) => {
          console.log('target ->', target);
          const maxCharacters = Number(
            $(target).attr('sf-cut-off-max-chars') || 100
          );
          const text = $(target).text();

          console.log('MAXCHAT ->', maxCharacters);

          $(target).text(sfApiTruncateTxtInWord(text, maxCharacters));

          console.log('MAXCHAT -> length ', $(target).text().length);
        });
      });
    });
  },
]);

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
      }, (timeout = 50));

      // The `renderitems` event runs whenever the list renders items after filtering.
      filterInstance.listInstance.on('renderitems', (renderedItems) => {
        updateFilterElements(filterInstances[0].listInstance.validItems);
      });
    },
  ]);
});
