(() => {
  console.log(' we do it just once right???');

  let currentNode = document.currentScript;

  document.addEventListener('DOMContentLoaded', () => {
    const SEPARATOR = ' > ';

    let parent = currentNode.closest('[sf-parent-component]');
    let selectNode = parent.querySelector('nav');

    // Listen to changes ->

    let selectNodetar = parent.querySelector('select');
    console.log('selectNodetar');
    $(selectNodetar).change(function (value) {
      console.log('Changes -> ', value);
    });

    // Observe any mutations in the slider navigation
    // const targetNode = parent.querySelector('.w-slider-nav');
    console.log('selectNode -> ', selectNode);
    console.log('PARENT HTML ->', parent.innerHTML);

    function processElements() {
      let selectOptions = selectNode.querySelectorAll('a');

      selectOptions.forEach((element) => {
        let initialTxt = element.text;
        let posOfSeparator = initialTxt.indexOf(SEPARATOR);

        if (posOfSeparator >= 0) {
          let piecesTxt = initialTxt.split(SEPARATOR).slice(1);

          console.log('Pieces -> ', piecesTxt);

          let newTxt = `  ${SEPARATOR} ${piecesTxt.join('')}`;
          console.log('newTxt -> ', newTxt);
          element.textContent = newTxt;
        }
      });
    }

    const processChange = sf_debounce(() => processElements(), 500);

    // Options for the observer (which mutations to observe)
    const config = { childList: true };

    // Callback function to execute when mutations are observed
    const callback = (mutationList, observer) => {
      for (const mutation of mutationList) {
        if (mutation.type === 'childList') {
          console.log('A child node has been added or removed.');
        } else if (mutation.type === 'attributes') {
          console.log(`The ${mutation.attributeName} attribute was modified.`);
        } else if (mutation.type === 'subtree') {
          console.log(`The subtree attribute was modified.`);
        }

        processChange();

        /*         // Update counter txt
        counterNode.textContent = `${
          numCurrentSliderPage + 1
        } of ${numSliderPages}`; */
      }
    };

    // Create an observer instance linked to the callback function
    const observer = new MutationObserver(callback);

    // Start observing the target node for configured mutations
    observer.observe(selectNode, config);
  });
})();
