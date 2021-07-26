@JS_HELPERS_FILE@
@JS_ACTIONS_FILE@

window.addEventListener('DOMContentLoaded', () => {
  navbar = JSON.parse(`@JSON_NAVBAR_FILE@`).navbar
  render_navbar(navbar)

})


function render_navbar(arr) {
  let query = 'body > nav.navbar:first-child > ul.navbar-nav:first-child'
  let navbar = document.querySelector(query)
  let nav = nodes.navbar(arr)

  // console.log("nav", nav)
  navbar.innerHTML = nav.querySelector('.navbar-nav').innerHTML
}

// document.querySelector('#tmp-nav-item')

// document.querySelector('body').appendChild(templates);

// document.getElementById('hi-btn').addEventListener('click', () => {
//   console.log('button clicked!!!')
//   const xhttp = new XMLHttpRequest();
//   xhttp.onload = function() {
//     console.log(this.responseText);
//   }
//   xhttp.open("GET", "ajax_info.txt", true);
//   xhttp.send();
// });