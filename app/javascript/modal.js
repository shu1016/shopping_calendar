const contents = () => {
  const modals = document.querySelectorAll('.js-modal');
  const modalButtons = document.querySelectorAll('.js-modal-button');
  const modalCloses = document.querySelectorAll('.js-close-button');

  modalButtons.forEach((modalButton, index) => {
    modalButton.addEventListener('click', (e) => {
      e.preventDefault()
      modals[index].classList.add('is-open');
      const x = e.clientX;

      if (x > window.innerWidth / 2.6){
        modals[index].style.right = '336px';
      }else{
        modals[index].style.left = '10px';
      }
  
    });
  });

  modalCloses.forEach((modalClose, index) => {
    modalClose.addEventListener('click', () => {
      modals[index].classList.remove('is-open');
    });
  });
};

window.addEventListener('turbo:load',contents)