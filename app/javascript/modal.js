document.addEventListener("turbo:load", function() {
  const modals = document.querySelectorAll('.js-modal');
  const modalButtons = document.querySelectorAll('.js-modal-button');
  const modalCloses = document.querySelectorAll('.js-close-button');

  modalButtons.forEach((modalButton, index) => {
    modalButton.addEventListener('click', (e) => {
      e.preventDefault()
      modals[index].classList.add('is-open');
      let x = e.clientX;

      // manipulate the modal position
      // Here, you can add your own logic to decide the modal position, for now, we will use the simplest one, decide based on the half of the width
      if (x > window.innerWidth / 2){
        modals[index].style.left = 'auto';
        modals[index].style.right = '0px';
      }else{
        modals[index].style.left = '0px';
        modals[index].style.right = 'auto';
      }
  
    });
  });

  modalCloses.forEach((modalClose, index) => {
    modalClose.addEventListener('click', () => {
      modals[index].classList.remove('is-open');
    });
  });
});