const { app, BrowserWindow, ipcMain } = require('electron');
const path = require('path');
const { spawn } = require('child_process');

function createWindow() {
  const mainWindow = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      preload: path.join(__dirname, 'renderer.js'),
      nodeIntegration: true,
      contextIsolation: false,
    },
  });

  mainWindow.loadFile('index.html');
}

app.whenReady().then(() => {
  createWindow();

  app.on('activate', function () {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on('window-all-closed', function () {
  if (process.platform !== 'darwin') app.quit();
});

ipcMain.on('run-script', (event, scriptName) => {
  const scriptPath = path.join(process.resourcesPath, 'scripts', scriptName);
  const scriptProcess = spawn('bash', [scriptPath]);

  scriptProcess.stdout.on('data', (data) => {
    event.reply('script-output', data.toString());
  });

  scriptProcess.stderr.on('data', (data) => {
    event.reply('script-output', `Error: ${data.toString()}`);
  });

  scriptProcess.on('close', (code) => {
    event.reply('script-output', `Script finished with exit code ${code}`);
  });
});
