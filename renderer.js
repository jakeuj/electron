const { ipcRenderer } = require('electron');

document.getElementById('run-script-1').addEventListener('click', () => {
  ipcRenderer.send('run-script', '1.sh');
});

document.getElementById('run-script-2').addEventListener('click', () => {
  ipcRenderer.send('run-script', '2.sh');
});

document.getElementById('run-script-3').addEventListener('click', () => {
  ipcRenderer.send('run-script', '3.sh');
});

ipcRenderer.on('script-output', (event, output) => {
  const outputElement = document.getElementById('output');
  outputElement.textContent += output + '\n';
  outputElement.scrollTop = outputElement.scrollHeight; // 自動滾動到最底部
});
