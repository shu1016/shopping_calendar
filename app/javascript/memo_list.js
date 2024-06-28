const menus = () => {
  const menu = document.getElementById("memo-menu")
  const pullDownMenu = document.getElementById("memo-pull-down")

  menu.addEventListener('mouseover', function() {
    this.setAttribute('style', "background-color: lightyellow;")
  })

  menu.addEventListener('mouseout', function() {
    this.removeAttribute('style', "background-color: lightyellow;")
  })

  menu.addEventListener('click', function() {
    if (pullDownMenu.style.display == "block") {
      pullDownMenu.style.display = "none";
    } else {
      pullDownMenu.style.display = "block";
    }
  })
}

window.addEventListener('turbo:load',menus)