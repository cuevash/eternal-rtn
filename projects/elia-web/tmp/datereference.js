document.addEventListener('DOMContentLoaded', () => {
  window.fsAttributes = window.fsAttributes || [];

  window.fsAttributes.push([
    'cmsfilter',
    (filterInstances) => {
      // The callback passes a `filterInstances` array with all the `CMSFilters` instances on the page.
      const [filterInstance] = filterInstances;

      let updateFilterElements = sf_debounce(function (filteredEles) {
        console.log('It works!', filteredEles);

        // Format date for each element
        filteredEles.forEach((ele) => {
          let hmtlEle = ele.element;

          let targets = $(hmtlEle)
            .find('.blog-summary_date-reference')
            .find('[date-reference]');

          Array.from(targets).forEach((target) => {
            console.log('target ->', target);

            const maxCharacters = Number(
              $(target).attr('sf-cut-off-max-chars') || 100
            );
            let dateIn = new Date($(target).attr('date-reference'));

            let formattedDate = Intl.DateTimeFormat('es-ES', {
              day: '2-digit',
              month: 'long',
              year: 'numeric',
            }).format(dateIn);

            $(target).text(formattedDate);
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

(() => {
  let element = document.getElementById(
    '{{wf {&quot;path&quot;:&quot;slug&quot;,&quot;type&quot;:&quot;PlainText&quot;} }}-blog-summary-date-reference'
  );
  let dateIn = new Date(
    '{{wf {&quot;path&quot;:&quot;fecha-referencia&quot;,&quot;transformers&quot;:[{&quot;name&quot;:&quot;date&quot;,&quot;arguments&quot;:[&quot;MMM DD, YYYY&quot;]}],&quot;type&quot;:&quot;Date&quot;} }}'
  );

  let formattedDate = Intl.DateTimeFormat('es-ES', {
    day: '2-digit',
    month: 'long',
    year: 'numeric',
  }).format(dateIn);

  element.textContent = formattedDate;
})();
