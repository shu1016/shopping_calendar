const topContents = () => {
  const topModals = document.querySelectorAll('.top-js-modal');
  const topModalButtons = document.querySelectorAll('.top-js-modal-button');
  const topModalCloses = document.querySelectorAll('.top-js-close-button');
  const topVideos = document.querySelectorAll('.landing_video');
  
  topModalButtons.forEach((topModalButton, index) => {
    topModalButton.addEventListener('click', (e) => {
      e.preventDefault()
      topModals[index].classList.add('top_is-open');
      topVideos[index].play();
    });
  });

  topModalCloses.forEach((topModalClose, index) => {
    topModalClose.addEventListener('click', () => {
      topModals[index].classList.remove('top_is-open');
      topVideos[index].pause();
    });
  });
};

window.addEventListener('turbo:load',topContents)