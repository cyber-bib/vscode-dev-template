// preload.js
const electron = require('electron')

const {ipcRenderer} = electron

// #region default preload.js
  // All of the Node.js APIs are available in the preload process.
  // It has the same sandbox as a Chrome extension.
  window.addEventListener('DOMContentLoaded', () => {
    const replaceText = (selector, text) => {
      const element = document.getElementById(selector)
      if (element) element.innerText = text
    }

    for (const dependency of ['chrome', 'node', 'electron']) {
      replaceText(`${dependency}-version`, process.versions[dependency])
    }
  })
// #endregion default preload.js


// window.addEventListener('load', (event) => {
//   ipcRenderer.send('msg', 'ping')
// })

// ipcRenderer.on('msg-reply', (event, arg) => {
//   console.log(`reply: ${arg}`)
// })