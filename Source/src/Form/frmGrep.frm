VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmGrep 
   Caption         =   "Excel�t�@�C����Grep"
   ClientHeight    =   4860
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8115
   OleObjectBlob   =   "frmGrep.frx":0000
   ShowModal       =   0   'False
   StartUpPosition =   2  '��ʂ̒���
End
Attribute VB_Name = "frmGrep"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'-----------------------------------------------------------------------------------------------------
'
' [RelaxTools-Addin] v4
'
' Copyright (c) 2009 Yasuhiro Watanabe
' https://github.com/RelaxTools/RelaxTools-Addin
' author:relaxtools@opensquare.net
'
' The MIT License (MIT)
'
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
'
' The above copyright notice and this permission notice shall be included in all
' copies or substantial portions of the Software.
'
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
' SOFTWARE.
'
'-----------------------------------------------------------------------------------------------------





Option Explicit
Private mRange As Range
Private mblnSelectMode As Boolean
Private mobjRegx As Object
Private mlngCount As Long
Private mblnCancel As Boolean

Private mblnRefresh As Boolean

Private Const C_START_ROW As Long = 11
Private Const C_SEARCH_NO As Long = 1
Private Const C_SEARCH_BOOK As Long = 2
Private Const C_SEARCH_SHEET As Long = 3
Private Const C_SEARCH_ADDRESS As Long = 4
Private Const C_SEARCH_STR As Long = 5
'Private Const C_SEARCH_ID As Long = 6

Private Const C_SEARCH_OBJECT_CELL = "�Z���̂�"
Private Const C_SEARCH_OBJECT_SHAPE = "�V�F�C�v�̂�"
Private Const C_SEARCH_OBJECT_CELL_AND_SHAPE = "�Z�����V�F�C�v"
Private Const C_SEARCH_VALUE_VALUE = "�l"
Private Const C_SEARCH_VALUE_FORMULA = "��"

Private mMm As MacroManager


Private Sub chkRegEx_Change()
'    chkZenHan.enabled = Not (chkRegEx.Value)
End Sub

'Private Sub chkRegEx_Change()
'    chkCase.enabled = chkRegEx.Value
'    If chkRegEx.Value = False Then
'        chkCase.Value = False
'    End If
'End Sub

Private Sub cmdCancel_Click()
    If cmdCancel.Caption = "����" Then
        Unload Me
    Else
        mblnCancel = True
    End If
End Sub

Private Sub cmdFolder_Click()

    Dim strFile As String

    '�t�H���_���擾
    strFile = rlxSelectFolder()
    
    If Trim(strFile) <> "" Then
        cboFolder.Text = strFile
    End If
    
End Sub

Private Sub cmdHelp_Click()
    
    If MsgBox("�C���^�[�l�b�g�ɐڑ����܂��B��낵���ł����H", vbOKCancel + vbQuestion, C_TITLE) <> vbOK Then
        Exit Sub
    End If
    
    Call GotoRegExpHelp
    
End Sub

Private Sub cmdOk_Click()

    Dim XL As Excel.Application
    Dim WB As Workbook
    Dim WS As Worksheet
    Dim colBook As Collection
    Dim varBook As Variant
    Dim objFs As Object
    Dim lngBookCount As Long
    Dim lngBookMax As Long
    
    Dim ResultWS As Worksheet
    
    Dim strPath As String
    Dim strPatterns() As String
    
'    Dim a As Variant
'
'    a = Timer
    
    If Len(Trim(cboSearch.Text)) = 0 Then
        MsgBox "������������w�肵�Ă�������...", vbExclamation, C_TITLE
        cboSearch.SetFocus
        Exit Sub
    End If
    
    
    '���K�\���̏ꍇ
    If chkRegEx.value Then
        Dim o As Object
        Set o = CreateObject("VBScript.RegExp")
        o.Pattern = cboSearch.Text
        o.IgnoreCase = Not (chkCase.value)
        o.Global = True
        err.Clear
        On Error Resume Next
        o.Execute ""
        If err.Number <> 0 Then
            MsgBox "����������̐��K�\��������������܂���B", vbExclamation, C_TITLE
            cboSearch.SetFocus
            Exit Sub
        End If
    End If
    
    strPath = cboFolder.Text
    strPatterns = Split(txtPattern.Text, ";")

    Set colBook = New Collection
    
    Set objFs = CreateObject("Scripting.FileSystemObject")
    
    On Error Resume Next
    
    Set mMm = New MacroManager
    Set mMm.Form = Me
    mMm.Disable
    mMm.DispGuidance "�t�@�C���̐����J�E���g���Ă��܂�..."
    
    FileSearch objFs, strPath, strPatterns(), colBook
    Select Case err.Number
    Case 75, 76
        mMm.Enable
        Set mMm = Nothing
        MsgBox "�t�H���_�����݂��܂���B", vbExclamation, "ExcelGrep"
        cboFolder.SetFocus
        Exit Sub
    End Select
    
    
    Set objFs = Nothing
    
    ThisWorkbook.Worksheets("Grep����").Copy
    Set ResultWS = ActiveSheet
    
    'Set ResultWS = Workbooks.Add.Worksheets(1)
    ResultWS.Name = "Grep����"
    
    ResultWS.Cells(1, C_SEARCH_NO).value = "Excel�t�@�C����Grep"
    ResultWS.Cells(2, C_SEARCH_NO).value = "�����F" & cboSearch.Text
    ResultWS.Cells(3, C_SEARCH_NO).value = "�t�@�C���F" & txtPattern.Text
    ResultWS.Cells(4, C_SEARCH_NO).value = "�t�H���_�F" & cboFolder.Text
    ResultWS.Cells(5, C_SEARCH_NO).value = "�����I�u�W�F�N�g�F" & cboObj.Text
    ResultWS.Cells(6, C_SEARCH_NO).value = "�����ΏہF" & cboValue.Text
    ResultWS.Cells(7, C_SEARCH_NO).value = "���K�\���F" & chkRegEx.value
    ResultWS.Cells(8, C_SEARCH_NO).value = "�ǎ�p�X���[�h�F" & txtPassword.Text
    
    ResultWS.Cells(10, C_SEARCH_NO).value = "No."
    ResultWS.Cells(10, C_SEARCH_BOOK).value = "�u�b�N��"
    ResultWS.Cells(10, C_SEARCH_BOOK).ColumnWidth = 60
    ResultWS.Cells(10, C_SEARCH_SHEET).value = "�V�[�g��"
    ResultWS.Cells(10, C_SEARCH_ADDRESS).value = "�Z��/�V�F�C�v"
    ResultWS.Cells(10, C_SEARCH_STR).value = "����������"
'    ResultWS.Cells(9, C_SEARCH_ID).Value = "ID"
    mlngCount = C_START_ROW

    cmdCancel.Caption = "�L�����Z��"
    
    Set XL = New Excel.Application
    
    AppActivate Me.Caption
    
    lngBookCount = 0
    lngBookMax = colBook.count
    mMm.StartGauge lngBookMax
    
    XL.DisplayAlerts = False
    XL.EnableEvents = False
    
    Dim varPassword As Variant
    Dim pass As Variant
    
    If Len(txtPassword.Text) <> 0 Then
        varPassword = Split(txtPassword.Text, ",")
    Else
        varPassword = Array("")
    End If
 
    For Each varBook In colBook
    
        If mblnCancel Then
            Exit For
        End If
    
'        If Len(txtPassword.Text) <> 0 Then
            For Each pass In varPassword
                err.Clear
                Set WB = XL.Workbooks.Open(FileName:=varBook, ReadOnly:=True, IgnoreReadOnlyRecommended:=True, Notify:=False, Password:=pass, Local:=True)
                If err.Number = 0 Then
                    Exit For
                End If
            Next
'        Else
'            err.Clear
'            Set WB = XL.Workbooks.Open(filename:=varBook, ReadOnly:=True, IgnoreReadOnlyRecommended:=True, Notify:=False, Password:="", Local:=True)
'        End If
        If err.Number = 0 Then
            For Each WS In WB.Worksheets
                If WS.visible = xlSheetVisible Then
                    Select Case cboObj.Text
                        Case C_SEARCH_OBJECT_CELL
                            Call seachCell(WS, ResultWS)
                            
                        Case C_SEARCH_OBJECT_SHAPE
                            Call searchShape(WS, ResultWS)
                            
                        Case C_SEARCH_OBJECT_CELL_AND_SHAPE
                            Call seachCell(WS, ResultWS)
                            Call searchShape(WS, ResultWS)
                    End Select
                End If
                Set WS = Nothing
            Next
        Else
            ResultWS.Cells(mlngCount, C_SEARCH_NO).value = mlngCount - C_START_ROW + 1
            ResultWS.Cells(mlngCount, C_SEARCH_BOOK).value = varBook
            ResultWS.Cells(mlngCount, C_SEARCH_SHEET).value = "�u�b�N���J���܂���ł���"
            ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS).value = ""
    
            ResultWS.Cells(mlngCount, C_SEARCH_STR).NumberFormatLocal = "@"
            ResultWS.Cells(mlngCount, C_SEARCH_STR).value = err.Description
            mlngCount = mlngCount + 1
        End If
        WB.Close SaveChanges:=False
        Set WB = Nothing
        lngBookCount = lngBookCount + 1
        mMm.DisplayGauge lngBookCount
    Next
    
    XL.EnableEvents = True
    XL.DisplayAlerts = True
    XL.Quit
    Set XL = Nothing
    
    
'    ResultWS.Columns("B:E").AutoFit
'    ResultWS.Columns("B:B").ColumnWidth = 70
'    ResultWS.Columns("C:C").ColumnWidth = 20
'    ResultWS.Columns("D:D").ColumnWidth = 20
'    ResultWS.Columns("E:E").ColumnWidth = 120
'    ResultWS.Columns("F:F").ColumnWidth = 0
    Dim r As Range
    Set r = ResultWS.Cells(C_START_ROW, 1).CurrentRegion
    
    r.VerticalAlignment = xlTop
    r.Select
    
    Dim strBuf As String
    Dim i As Long
    Dim lngCount As Long
    
    strBuf = cboSearch.Text
    lngCount = 1
    For i = 0 To cboSearch.ListCount - 1
        If cboSearch.List(i) <> cboSearch.Text Then
            strBuf = strBuf & vbTab & cboSearch.List(i)
            lngCount = lngCount + 1
            '���X�g�͍ő�P�O
            If lngCount >= 10 Then
                Exit For
            End If
        End If
    Next
    SaveSetting C_TITLE, "ExcelGrep", "SearchStr", strBuf
    
    strBuf = cboFolder.Text
    lngCount = 1
    For i = 0 To cboFolder.ListCount - 1
        If cboFolder.List(i) <> cboFolder.Text Then
            strBuf = strBuf & vbTab & cboFolder.List(i)
            lngCount = lngCount + 1
            '���X�g�͍ő�P�O
            If lngCount >= 10 Then
                Exit For
            End If
        End If
    Next
    SaveSetting C_TITLE, "ExcelGrep", "FolderStr", strBuf
    
    SaveSetting C_TITLE, "ExcelGrep", "cboObj", cboObj.ListIndex
    SaveSetting C_TITLE, "ExcelGrep", "chkRegEx", chkRegEx.value
    SaveSetting C_TITLE, "ExcelGrep", "chkCase", chkCase.value
    SaveSetting C_TITLE, "ExcelGrep", "chkSubFolder", chkSubFolder.value
    SaveSetting C_TITLE, "ExcelGrep", "cboValue", cboValue.ListIndex
    SaveSetting C_TITLE, "ExcelGrep", "chkZenHan", chkZenHan.value
    SaveSetting C_TITLE, "ExcelGrep", "Password", txtPassword.Text
    
    Set mMm = Nothing
    
'    MsgBox Timer - a
    
    Unload Me
    
    AppActivate ResultWS.Application.Caption
    execSelectionRowDrawGrid

    Set ResultWS = Nothing
    
    If mlngCount - C_START_ROW = 0 Then
        MsgBox "�����Ώۂ�������܂���ł����B", vbInformation + vbOKOnly, C_TITLE
    End If
    
End Sub
Private Sub FileSearch(objFs As Object, strPath As String, strPatterns() As String, objCol As Collection)

    Dim objfld As Object
    Dim objfl As Object
    Dim objSub As Object
    Dim f As Variant
    
    Dim lngCol2 As Long

    Set objfld = objFs.GetFolder(strPath)
    
    '�t�@�C�����擾
    For Each objfl In objfld.files
    
        Dim blnFind As Boolean
        blnFind = False
        DoEvents
        DoEvents
        DoEvents
        For Each f In strPatterns
            If LCase(objfl.Name) Like LCase(f) Then
                blnFind = True
                Exit For
            End If
        Next
        
        If blnFind Then
            objCol.Add rlxAddFileSeparator(objfl.ParentFolder.Path) & objfl.Name
        End If
    Next
    
    '�T�u�t�H���_��������
    If chkSubFolder.value Then
        For Each objSub In objfld.SubFolders
            DoEvents
            DoEvents
            DoEvents
            FileSearch objFs, objSub.Path, strPatterns(), objCol
        Next
    End If
End Sub

'Private Sub seachCell(ByRef objSheet As Worksheet, ByRef ResultWS As Worksheet)
'
'    Dim objRegx As Object
'    Dim matchCount As Long
'    Dim objMatch As Object
'    Dim strPattern As String
'    Dim c As Range
'
'    strPattern = cboSearch.Text
'
'    '���K�\���̏ꍇ
'    If chkRegEx Then
'        Set mobjRegx = CreateObject("VBScript.RegExp")
'        mobjRegx.Pattern = strPattern
'        mobjRegx.IgnoreCase = Not (chkCase.Value)
'        mobjRegx.Global = True
'    End If
'
'    For Each c In objSheet.UsedRange
'
'        '���K�\���̏ꍇ
'        If chkRegEx Then
'            err.Clear
'            On Error Resume Next
'            Set objMatch = mobjRegx.Execute(c.Value)
'            If err.Number <> 0 Then
'                MsgBox "����������̐��K�\��������������܂���B", vbExclamation, C_TITLE
'                cboSearch.SetFocus
'                Exit Sub
'            End If
'            matchCount = objMatch.count
'        Else
'            matchCount = InStr(c.Value, strPattern)
'        End If
'
'        If matchCount > 0 Then
'            ResultWS.Cells(mlngCount, C_SEARCH_NO).Value = mlngCount - C_START_ROW + 1
'            ResultWS.Cells(mlngCount, C_SEARCH_BOOK).Value = objSheet.Parent.FullName
'            ResultWS.Cells(mlngCount, C_SEARCH_SHEET).Value = objSheet.Name
'            ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS).Value = c.Address
'            ResultWS.Cells(mlngCount, C_SEARCH_STR).NumberFormatLocal = "@"
'            ResultWS.Cells(mlngCount, C_SEARCH_STR).Value = c.Value
'            mlngCount = mlngCount + 1
'        End If
'    Next
'
'
'End Sub
'Private Sub seachCell(ByRef objSheet As Worksheet, ByRef ResultWS As Worksheet)
'
'    Dim objRegx As Object
'    Dim strPattern As String
'    Dim c As Range
'
'    Dim d As Variant
'    Dim i As Long
'    Dim j As Long
'
'    strPattern = cboSearch.Text
'
'    '���K�\���̏ꍇ
'    If chkRegEx Then
'        Set mobjRegx = CreateObject("VBScript.RegExp")
'        mobjRegx.Pattern = strPattern
'        mobjRegx.IgnoreCase = Not (chkCase.Value)
'        mobjRegx.Global = True
'    End If
'
'    d = objSheet.UsedRange
'    If IsEmpty(d) Then
'        Exit Sub
'    End If
'
'    If IsArray(d) Then
'        For i = LBound(d, 1) To UBound(d, 1)
'            For j = LBound(d, 2) To UBound(d, 2)
'
'                Call searchStr(objSheet, ResultWS, d(i, j), strPattern, i, j)
'
'            Next
'        Next
'    Else
'        Call searchStr(objSheet, ResultWS, d, strPattern, 1, 1)
'    End If
'
'    Erase d
'
'End Sub
'Private Sub searchStr(ByRef objSheet As Worksheet, ByRef ResultWS As Worksheet, ByVal strSearch As Variant, ByVal strPattern As String, ByVal i As Long, ByVal j As Long)
'
'    Dim objMatch As Object
'    Dim matchCount As Long
'
'    If IsError(strSearch) Then
'        Exit Sub
'    End If
'
'    '���K�\���̏ꍇ
'    If chkRegEx Then
'        err.Clear
'        On Error Resume Next
'        Set objMatch = mobjRegx.Execute(strSearch)
'        If err.Number <> 0 Then
'            MsgBox "����������̐��K�\��������������܂���B", vbExclamation, C_TITLE
'            cboSearch.SetFocus
'            Exit Sub
'        End If
'        matchCount = objMatch.count
'    Else
'        matchCount = InStr(strSearch, strPattern)
'    End If
'
'    If matchCount > 0 Then
'        ResultWS.Cells(mlngCount, C_SEARCH_NO).Value = mlngCount - C_START_ROW + 1
'        ResultWS.Cells(mlngCount, C_SEARCH_BOOK).Value = objSheet.Parent.FullName
'        ResultWS.Cells(mlngCount, C_SEARCH_SHEET).Value = objSheet.Name
'        ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS).Value = objSheet.UsedRange(i, j).Address
'        ResultWS.Hyperlinks.Add _
'            Anchor:=Cells(mlngCount, C_SEARCH_ADDRESS), _
'            Address:="", _
'            SubAddress:=Cells(mlngCount, C_SEARCH_ADDRESS).Address, _
'            TextToDisplay:=objSheet.UsedRange(i, j).Address
'
'        ResultWS.Cells(mlngCount, C_SEARCH_STR).NumberFormatLocal = "@"
'        ResultWS.Cells(mlngCount, C_SEARCH_STR).Value = strSearch
'        mlngCount = mlngCount + 1
'    End If
'End Sub
Private Sub seachCell(ByRef objSheet As Worksheet, ByRef ResultWS As Worksheet)

    Dim strPattern As String
    
    strPattern = cboSearch.Text
        
    '���K�\���̏ꍇ
    If chkRegEx Then
    
        Dim objRegx As Object
        Set objRegx = CreateObject("VBScript.RegExp")
        
        objRegx.Pattern = strPattern
        objRegx.IgnoreCase = Not (chkCase.value)
        objRegx.Global = True
    
        Dim c As Range
        For Each c In objSheet.UsedRange
    
            Dim schStr As Variant
            
            If cboValue.value = C_SEARCH_VALUE_VALUE Then
                schStr = c.value
            Else
                schStr = c.FormulaLocal
            End If
            
            Dim objMatch As Object
            Set objMatch = objRegx.Execute(schStr)

            If objMatch.count > 0 Then
                ResultWS.Cells(mlngCount, C_SEARCH_NO).value = mlngCount - C_START_ROW + 1
                ResultWS.Cells(mlngCount, C_SEARCH_BOOK).value = objSheet.Parent.FullName
                ResultWS.Cells(mlngCount, C_SEARCH_SHEET).value = objSheet.Name
                ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS).value = c.Address
'                ResultWS.Cells(mlngCount, C_SEARCH_ID).Value = c.Address
        
                ResultWS.Hyperlinks.Add _
                    Anchor:=ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS), _
                    Address:="", _
                    SubAddress:=ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS).Address, _
                    TextToDisplay:=c.Address
        
                ResultWS.Cells(mlngCount, C_SEARCH_STR).NumberFormatLocal = "@"
                ResultWS.Cells(mlngCount, C_SEARCH_STR).value = schStr
                mlngCount = mlngCount + 1
            End If
            
            Set objMatch = Nothing
        
        Next
        Set objRegx = Nothing
        
    Else
        Dim objFind As Range
        Dim strFirstAddress As String
        
        If cboValue.value = C_SEARCH_VALUE_VALUE Then
            Set objFind = objSheet.UsedRange.Find(strPattern, , xlValues, xlPart, xlByColumns, xlNext, chkCase.value, chkZenHan.value)
        Else
            Set objFind = objSheet.UsedRange.Find(strPattern, , xlFormulas, xlPart, xlByColumns, xlNext, chkCase.value, chkZenHan.value)
        End If
        
        If Not objFind Is Nothing Then
        
            strFirstAddress = objFind.Address
    
            Do
            
                ResultWS.Cells(mlngCount, C_SEARCH_NO).value = mlngCount - C_START_ROW + 1
                ResultWS.Cells(mlngCount, C_SEARCH_BOOK).value = objSheet.Parent.FullName
                ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS).value = objFind.Address
'                ResultWS.Cells(mlngCount, C_SEARCH_ID).Value = objFind.Address
                ResultWS.Cells(mlngCount, C_SEARCH_SHEET).value = objSheet.Name
                
                ResultWS.Hyperlinks.Add _
                    Anchor:=ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS), _
                    Address:="", _
                    SubAddress:=ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS).Address, _
                    TextToDisplay:=objFind.Address
        
                ResultWS.Cells(mlngCount, C_SEARCH_STR).NumberFormatLocal = "@"
                
                If cboValue.value = C_SEARCH_VALUE_VALUE Then
                    ResultWS.Cells(mlngCount, C_SEARCH_STR).value = objFind.value
                Else
                    ResultWS.Cells(mlngCount, C_SEARCH_STR).value = objFind.FormulaLocal
                End If

                mlngCount = mlngCount + 1
        
                Set objFind = objSheet.UsedRange.FindNext(objFind)
                
                If objFind Is Nothing Then
                    Exit Do
                End If
                
            Loop Until strFirstAddress = objFind.Address
            
        End If
    End If
    
End Sub
Private Sub searchShape(ByRef objSheet As Worksheet, ByRef ResultWS As Worksheet)

    Dim matchCount As Long
    Dim objMatch As Object
    Dim strPattern As String

    Dim objShape As Shape
    Dim objAct As Worksheet
    Dim c As Shape
    
    Dim strBuf As String

    Dim colShapes As Collection
    Set colShapes = New Collection

    Const C_RESULT_NAME As String = "�V�F�C�v����Result"
    
    strPattern = cboSearch.Text
    
    '���K�\���̏ꍇ
    If chkRegEx Then
        Set mobjRegx = CreateObject("VBScript.RegExp")
        mobjRegx.Pattern = strPattern
        mobjRegx.IgnoreCase = Not (chkCase.value)
        mobjRegx.Global = True
    End If
    
    For Each c In objSheet.Shapes
        
        Select Case c.Type
            Case msoAutoShape, msoTextBox, msoCallout, msoFreeform
                '�V�F�C�v�ɕ��������邩�Ȃ������f�����Ȃ����߃G���[���o�ɂď���
                On Error Resume Next
                strBuf = c.TextFrame.Characters.Text
                If err.Number = 0 Then
                    On Error GoTo 0
                    
                    '���K�\���̏ꍇ
                    If chkRegEx Then
                        err.Clear
                        On Error Resume Next
                        Set objMatch = mobjRegx.Execute(strBuf)
                        If err.Number <> 0 Then
                            MsgBox "����������̐��K�\��������������܂���B", vbExclamation, C_TITLE
                            cboSearch.SetFocus
                            Exit Sub
                        End If
                        matchCount = objMatch.count
                    Else
'                        matchCount = InStr(strBuf, strPattern)
                        If chkCase.value Then
                            matchCount = InStr(strBuf, strPattern)
                        Else
                            matchCount = InStr(UCase(strBuf), UCase(strPattern))
                        End If
                    End If
                    
                    If matchCount > 0 Then
                    
                        ResultWS.Cells(mlngCount, C_SEARCH_NO).value = mlngCount - C_START_ROW + 1
                        ResultWS.Cells(mlngCount, C_SEARCH_BOOK).value = objSheet.Parent.FullName
                        ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS).value = c.Name & ":" & c.id
'                        ResultWS.Cells(mlngCount, C_SEARCH_ID).Value = "Shape:" & c.ID
                        
'                        ResultWS.Hyperlinks.Add _
'                            Anchor:=Cells(mlngCount, C_SEARCH_ADDRESS), _
'                            Address:=objSheet.Parent.FullName, _
'                            SubAddress:="'" & objSheet.Name & "'!" & c.TopLeftCell.Address(0, 0), _
'                            TextToDisplay:=c.Name
'                ResultWS.Hyperlinks.Add _
'                    Anchor:=ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS), _
'                    Address:="", _
'                    SubAddress:=ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS).Address, _
'                    TextToDisplay:=c.Name
                ResultWS.Hyperlinks.Add _
                    Anchor:=ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS), _
                    Address:="", _
                    SubAddress:=ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS).Address, _
                    TextToDisplay:=c.Name & ":" & c.id
                    
                        ResultWS.Cells(mlngCount, C_SEARCH_SHEET).value = objSheet.Name
                        ResultWS.Cells(mlngCount, C_SEARCH_STR).NumberFormatLocal = "@"
                        ResultWS.Cells(mlngCount, C_SEARCH_STR).value = strBuf
                        mlngCount = mlngCount + 1
                        
                    End If
                Else
                    On Error GoTo 0
                    err.Clear
                End If
            Case msoGroup
                grouprc c, c, colShapes, ResultWS

        End Select
    Next

End Sub
'�ċA�ɂăO���[�v�ȉ��̃V�F�C�v������
Private Sub grouprc(ByRef objTop As Shape, ByRef objShape As Shape, ByRef colShapes As Collection, ByRef ResultWS As Worksheet)

    Dim matchCount As Long
    Dim c As Shape
    Dim strBuf As String
    Dim objMatch As Object
    Dim strPattern As String
    strPattern = cboSearch.Text
    
    For Each c In objShape.GroupItems
        
        Select Case c.Type
            Case msoAutoShape, msoTextBox, msoCallout, msoFreeform
                '�V�F�C�v�ɕ��������邩�Ȃ������f�����Ȃ����߃G���[���o�ɂď���
                On Error Resume Next
                strBuf = c.TextFrame.Characters.Text
                If err.Number = 0 Then
                    On Error GoTo 0
                    
                    '���K�\���̏ꍇ
                    If chkRegEx Then
                        err.Clear
                        On Error Resume Next
                        Set objMatch = mobjRegx.Execute(strBuf)
                        If err.Number <> 0 Then
                            MsgBox "����������̐��K�\��������������܂���B", vbExclamation, C_TITLE
                            cboSearch.SetFocus
                            Exit Sub
                        End If
                        matchCount = objMatch.count
                    Else
                        matchCount = InStr(strBuf, strPattern)
                    End If
                    
                    If matchCount > 0 Then
                    
                        ResultWS.Cells(mlngCount, C_SEARCH_NO).value = mlngCount - C_START_ROW + 1
                        ResultWS.Cells(mlngCount, C_SEARCH_BOOK).value = objShape.Parent.Parent.FullName
                        ResultWS.Cells(mlngCount, C_SEARCH_SHEET).value = objShape.Parent.Name
                        ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS).value = c.Name & ":" & c.id
'                        ResultWS.Cells(mlngCount, C_SEARCH_ID).Value = "Shape:" & c.ID
                        
'                        ResultWS.Hyperlinks.Add _
'                            Anchor:=Cells(mlngCount, C_SEARCH_ADDRESS), _
'                            Address:=objShape.Parent.Parent.FullName, _
'                            SubAddress:="'" & objShape.Parent.Name & "'!" & c.TopLeftCell.Address(0, 0), _
'                            TextToDisplay:=c.Name
'                ResultWS.Hyperlinks.Add _
'                    Anchor:=Cells(mlngCount, C_SEARCH_ADDRESS), _
'                    Address:="", _
'                    SubAddress:=Cells(mlngCount, C_SEARCH_ADDRESS).Address, _
'                    TextToDisplay:=c.Name
                ResultWS.Hyperlinks.Add _
                    Anchor:=ResultWS.Cells(mlngCount, C_SEARCH_ADDRESS), _
                    Address:="", _
                    SubAddress:=Cells(mlngCount, C_SEARCH_ADDRESS).Address, _
                    TextToDisplay:=c.Name & ":" & c.id
                        
                        ResultWS.Cells(mlngCount, C_SEARCH_STR).NumberFormatLocal = "@"
                        ResultWS.Cells(mlngCount, C_SEARCH_STR).value = strBuf
                        mlngCount = mlngCount + 1
                    
                    End If
                Else
                    On Error GoTo 0
                    err.Clear
                End If
            Case msoGroup
                '�ċA�ďo
                grouprc objTop, c, colShapes, ResultWS
            
        End Select
    Next

End Sub




Private Sub TextBox1_Change()

End Sub

Private Sub UserForm_Initialize()
    
    Dim strBuf As String
    Dim strSearch() As String
    Dim strFolder() As String
    Dim i As Long
    
    mblnRefresh = True
    
    cboObj.AddItem C_SEARCH_OBJECT_CELL
    cboObj.AddItem C_SEARCH_OBJECT_SHAPE
    cboObj.AddItem C_SEARCH_OBJECT_CELL_AND_SHAPE
    cboObj.ListIndex = GetSetting(C_TITLE, "ExcelGrep", "cboObj", 0)
    
    cboValue.AddItem C_SEARCH_VALUE_FORMULA
    cboValue.AddItem C_SEARCH_VALUE_VALUE
    cboValue.ListIndex = GetSetting(C_TITLE, "ExcelGrep", "cboValue", 0)
    
    chkSubFolder.value = GetSetting(C_TITLE, "ExcelGrep", "chkSubFolder", False)
    
    chkRegEx.value = GetSetting(C_TITLE, "ExcelGrep", "chkRegEx", False)
'    chkRegEx_Change
    chkCase.value = GetSetting(C_TITLE, "ExcelGrep", "chkCase", False)
    chkZenHan.value = GetSetting(C_TITLE, "ExcelGrep", "chkZenHan", False)
    
'    chkCase.Value = False
'    chkCase.enabled = False
    
    txtPattern.Text = "*.xlsx;*.xlsm;*.xls"
    
    
    strBuf = GetSetting(C_TITLE, "ExcelGrep", "SearchStr", "")
    strSearch = Split(strBuf, vbTab)
    
    txtPassword.Text = GetSetting(C_TITLE, "ExcelGrep", "Password", "")
    
    For i = LBound(strSearch) To UBound(strSearch)
        cboSearch.AddItem strSearch(i)
    Next
    If cboSearch.ListCount > 0 Then
        cboSearch.ListIndex = 0
    End If
    
    strBuf = GetSetting(C_TITLE, "ExcelGrep", "FolderStr", "")
    strFolder = Split(strBuf, vbTab)
    
    For i = LBound(strFolder) To UBound(strFolder)
        cboFolder.AddItem strFolder(i)
    Next
    If cboFolder.ListCount > 0 Then
        cboFolder.ListIndex = 0
    End If

    lblGauge.visible = False

   ' txtBack.Value = "Excel�u�b�N��Grep���s���܂�"

'    Me.Top = (Application.Top + Application.Height - Me.Height) - 20
'    Me.Left = (Application.Left + Application.Width - Me.Width) - 20

    
End Sub

