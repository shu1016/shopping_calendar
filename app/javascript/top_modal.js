document.addEventListener("turbo:load", function() {
  const topModals = document.querySelectorAll('.top-js-modal');
  const topModalButtons = document.querySelectorAll('.top-js-modal-button');
  const topModalCloses = document.querySelectorAll('.top-js-close-button');

  topModalButtons.forEach((topModalButton, index) => {
    topModalButton.addEventListener('click', (e) => {
      e.preventDefault()
      topModals[index].classList.add('top_is-open');
    });
    topModalButton.addEventListener('touchstart', (e) => {
      e.preventDefault();
      topModals[index].classList.add('top_is-open');
    });
  });

  topModalCloses.forEach((topModalClose, index) => {
    topModalClose.addEventListener('click', () => {
      topModals[index].classList.remove('top_is-open');
    });
    topModalClose.addEventListener('touchstart', () => {
      topModals[index].classList.remove('top_is-open');
    });
  });
});