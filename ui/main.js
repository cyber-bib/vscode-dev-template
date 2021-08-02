// Modules to control application life and create native browser window
const electron = require('electron')
const child_process = require('child_process')
const path = require('path')

const { app, BrowserWindow, ipcMain} = electron
const {spawn} = child_process

// #region default main.js {
  function createWindow () {
    // Create the browser window.
    const mainWindow = new BrowserWindow({
      width: 800,
      height: 600,
      // frame: false,
      webPreferences: {
        nodeIntegration: false,
        contextIsolation: true,
        enableRemoteModule: false,
        preload: path.join(__dirname, 'preload.js')
      }
    })

    mainWindow.removeMenu()

    // and load the index.html of the app.
    mainWindow.loadFile('@UI_LAYOUT_DIR@/index.html')

    // Open the DevTools.
    mainWindow.webContents.openDevTools()
  }

  // This method will be called when Electron has finished
  // initialization and is ready to create browser windows.
  // Some APIs can only be used after this event occurs.
  app.whenReady().then(() => {
    createWindow()

    app.on('activate', function () {
      // On macOS it's common to re-create a window in the app when the
      // dock icon is clicked and there are no other windows open.
      if (BrowserWindow.getAllWindows().length === 0) createWindow()
    })

    // execFile('@MAIN_EXECUTABLE_PATH@', (error, stdout, stderr) => {
    //   if(error) {
    //     console.log('error: ${error.message}')
    //   }
    //   if(stderr) {
    //     console.log('stderr: ${stderr}')
    //   }
    //   if(stdout) {
    //     console.log('stdout: ${stdout}')
    //   }
    // })
  })

  // Quit when all windows are closed, except on macOS. There, it's common
  // for applications and their menu bar to stay active until the user quits
  // explicitly with Cmd + Q.
  app.on('window-all-closed', function () {
    if (process.platform !== 'darwin') {
      app.quit()
    }
  })

  // In this file you can include the rest of your app's specific main process
  // code. You can also put them in separate files and require them here.
// #endregion } default main.js


ipcMain.on('msg', (event, arg) => {
  console.log(`recieved: ${arg}`)
  extern_run('powershell', ['echo', 'hello'])
  event.reply('msg-reply', 'pong')
})

function extern_run(cmd, args) {
  const spn = spawn(cmd, args)

  spn.stdout.on('data', (data) => {
    console.log(`stdout: ${data}`)
  })
  spn.stderr.on('data', (data) => {
    console.log(`stderr: ${data}`)
  })
  spn.on('error', (error) => {
    console.log(`error: ${error.message}`)
  })
  spn.on('exit', (code, signal) => {
    if(code) {console.log(`child process exited with code ${code}`)}
    if(signal) {console.log(`child process killed with signal ${signal}`)}
  })
  spn.on('close', (code) => {
    console.log(`child process closed with code ${code}`)
  })
}