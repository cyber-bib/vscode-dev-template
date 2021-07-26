function actions() {
  this.openPLY = function() {
    console.log('open PLY file triggered!')
  }
  this.exit = function() {
    console.log('exit app triggered!')
  }
  this.undo = function() {
    console.log('undo triggered!')
  }
  this.redo = function() {
    console.log('redo triggered!')
  }
  this.cut = function() {
    console.log('cut triggered!')
  }
  this.copy = function() {
    console.log('copy triggered!')
  }
  this.paste = function() {
    console.log('paste triggered!')
  }
  this.delete = function() {
    console.log('delete triggered!')
  }
  this.select_all = function() {
    console.log('select all triggered!')
  }
  this.reload = function() {
    console.log('reload triggered!')
  }
  this.force_reload = function() {
    console.log('force reload triggered!')
  }
  this.toggle_devtools = function() {
    console.log('toggle devtools triggered!')
  }
  this.actual_size = function() {
    console.log('actual size triggered!')
  }
  this.zoom_in = function() {
    console.log('zoom in triggered!')
  }
  this.zoom_out = function() {
    console.log('zoom out triggered!')
  }
  this.toggle_fullscreen = function() {
    console.log('toggle fullscreen triggered!')
  }
  this.learn_more = function() {
    console.log('learn more triggered!')
  }
  this.documentation = function() {
    console.log('documentation triggered!')
  }
}

var app = new actions()