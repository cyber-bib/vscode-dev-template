function clone(id) {
  let temp = document.querySelector(`#${id}`)
  return temp.content.cloneNode(true)
}

function json_to_node() {
  this.navbar = function(arr) {
    let id = 'tmp-navbar'
    let navbar = clone(id).querySelector('.navbar')
    let nav = navbar.querySelector('.navbar-nav')
    let items = this.navbar_items(arr)

    nav.replaceChildren()
    for(let it = 0; it < items.length; it++) {
      nav.appendChild(items[it])
    }

    return navbar
  }
  this.navbar_items = function(arr) {
    let objs = [];

    for(let it = 0; it < arr.length; it++) {
      objs[it] = this.navbar_item(arr[it])
    }

    return objs
  }
  this.navbar_item = function(obj) {
    let id = 'tmp-nav-item'
    let ni = clone(id).querySelector('.nav-item')
    let link = ni.querySelector('.nav-link')
    let menu = ni.querySelector('.dropdown-menu')
    let context = this.dropdown(obj.menu)

    link.id = `navbar-link-${obj.link.toLowerCase().replace(" ", "_")}`
    link.innerHTML = obj.link

    menu.setAttribute("aria-labelledby", link.id)
    menu.innerHTML = context.innerHTML

    return ni
  }
  this.dropdown = function (arr) {
    let id = 'tmp-dropdown-menu'
    let menu = clone(id).querySelector('.dropdown-menu')
    let items = this.dropdown_items(arr)

    menu.replaceChildren()
    for(let it = 0; it < items.length; it++) {
      menu.appendChild(items[it])
    }

    return menu
  }
  this.dropdown_items = function (arr) {
    let objs = [];

    for(let it = 0; it < arr.length; it++) {
      objs[it] = this.dropdown_item(arr[it])
    }

    return objs
  }
  this.dropdown_item = function (obj) {
    let id = 'tmp-dropdown-item'
    let li = clone(id).querySelector('.dropdown-item')

    if(obj.text === "<br>") {
      li.setAttribute("class", "dropdown-divider")
    } else {
      li.setAttribute('onclick', obj.action)
      li.innerHTML = obj.text
    }

    return li
  }
}

var nodes = new json_to_node()