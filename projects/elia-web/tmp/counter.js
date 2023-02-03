(() => {
  console.log(' we do it just once right???');

  let currentNode = document.currentScript;

  document.addEventListener('DOMContentLoaded', () => {
    let parent = currentNode.closest('[sf-parent-component]');
    let counterNode = parent.querySelector('.sf-slider_counter-txt');

    console.log('counterNode -> ', counterNode);

    // Observe any mutations in the slider navigation
    const targetNode = parent.querySelector('.w-slider-nav');
    console.log('targetNode -> ', targetNode);
    console.log('PARENT HTML ->', parent.innerHTML);

    // Options for the observer (which mutations to observe)
    const config = { attributes: true, childList: true, subtree: true };

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

        // Current Slider Page
        let currentSliderDot = parent.querySelector('.w-slider-dot.w-active');
        console.log('currentSliderDot -< ', currentSliderDot);

        const numCurrentSliderPage = currentSliderDot
          ? Array.from(currentSliderDot.parentElement.children).indexOf(
              currentSliderDot
            )
          : 0;

        // Num of Slider Pages
        let numSliderPages = parent.querySelectorAll('.w-slider-dot').length;

        console.log('numCurrentSliderPage -< ', numCurrentSliderPage);
        console.log('numSliderPages -< ', numSliderPages);

        // Update counter txt
        counterNode.textContent = `${
          numCurrentSliderPage + 1
        } of ${numSliderPages}`;
      }
    };

    // Create an observer instance linked to the callback function
    const observer = new MutationObserver(callback);

    // Start observing the target node for configured mutations
    observer.observe(targetNode, config);
  });
})();
