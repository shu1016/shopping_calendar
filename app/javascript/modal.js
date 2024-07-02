document.addEventListener("turbo:load", function() {
  const modals = document.querySelectorAll('.js-modal');
  const modalButtons = document.querySelectorAll('.js-modal-button');
  const modalCloses = document.querySelectorAll('.js-close-button');

  modalButtons.forEach((modalButton, index) => {
    modalButton.addEventListener('click', (e) => {
      e.preventDefault()
      modals[index].classList.add('is-open');
    });
  });

  modalCloses.forEach((modalClose, index) => {
    modalClose.addEventListener('click', (e) => {
      modals[index].classList.remove('is-open');
    });
  });
});