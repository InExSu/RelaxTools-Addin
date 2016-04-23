VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmTreeList 
   Caption         =   "�t�H���_�c���[�\���擾"
   ClientHeight    =   2775
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7230
   OleObjectBlob   =   "frmTreeList.frx":0000
   StartUpPosition =   1  '�I�[�i�[ �t�H�[���̒���
End
Attribute VB_Name = "frmTreeList"
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
Private mblnCancel As Boolean
Private mMm As MacroManager

Private mdblLineWidth As Double

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdFolder_Click()

    Dim strFile As String

    '�t�H���_���擾
    strFile = rlxSelectFolder()
    
    If Trim(strFile) <> "" Then
        txtFolder.Text = strFile
    End If
    
    
End Sub

Private Sub cmdRun_Click()
    
    Dim lngRow As Long
    Dim lngCol As Long
    Dim strFolder As String
    Dim objFs As Object
    Dim strLine As String
    Dim lngFCnt As Long
    Dim lngFolderCnt As Long
    
    If ActiveCell Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃZ�����݂���܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    '�t�H���_���擾
    strFolder = txtFolder.Text
    If strFolder = "" Then
        MsgBox "�c���[�\�����擾����t�H���_����͂��Ă��������B", vbExclamation, "�c���[�\���擾"
        txtFolder.SetFocus
        Exit Sub
    End If
    
    
    If Val(txtLineWidth.Text) < 0.5 Then
        MsgBox "0.5�ȏ����͂��Ă��������B", vbExclamation, "�c���[�\���擾"
        txtLineWidth.SetFocus
        Exit Sub
    End If
    
    mdblLineWidth = Val(txtLineWidth.Text)
    
    
    Set objFs = CreateObject("Scripting.FileSystemObject")
    
    lngRow = ActiveCell.row
    lngCol = ActiveCell.Column
    
    strLine = ""
    
    Set mMm = New MacroManager
    Set mMm.Form = Me
    
    mMm.Disable
    mMm.DispGuidance "�t�@�C���̐����J�E���g���Ă��܂�..."
    
    rlxGetFilesCount objFs, strFolder, lngFCnt, chkFileName.value, True, True
    
    mMm.StartGauge lngFCnt
    
    Dim strPath As String
    If Mid$(strFolder, 2, 1) = ":" Then
        '�h���C�u����UNC�ɕϊ�
        strPath = rlxDriveToUNC(strFolder)
    Else
        strPath = strFolder
    End If
    
    '�t�H���_���o���i�J�n���j
    Cells(lngRow, lngCol).value = strPath
    
    '�t�H���_�w��̏ꍇ
    If chkFolder.value Then
        ActiveSheet.Hyperlinks.Add _
            Anchor:=Cells(lngRow, lngCol), _
            Address:=strPath, _
            TextToDisplay:=strPath
    End If
    
    On Error Resume Next
    
    lngFolderCnt = 0
    FileDisp objFs, strFolder, lngRow, lngCol, lngCol, strLine, lngFolderCnt
    
    Set mMm = Nothing
    Set objFs = Nothing
    
    Select Case err.Number
    Case 75, 76
        MsgBox "�t�H���_�����݂��܂���B", vbExclamation, "�c���[�\���擾"
        txtFolder.SetFocus
        Exit Sub
    End Select
       
    Unload Me
    MsgBox "�������������܂����B", vbInformation, C_TITLE

End Sub
Private Sub FileDisp(objFs, ByVal strPath, lngRow, ByVal lngCol, ByVal lngHCol As Long, ByVal strLineParent As String, ByRef lngFolderCnt As Long)

    Dim objfld As Object
    Dim objfl As Object
    Dim objSub As Object
    
    Dim i As Long
    Dim lngFolderCount As Long
    Dim lngCol2 As Long
    
    Dim strLine As String
    Dim colFolders As Collection
    Dim colFiles As Collection
    
    '�r���̗񕝂��Q�Ƃ���B
    Columns(lngCol).ColumnWidth = mdblLineWidth
    Columns(lngCol + 1).ColumnWidth = mdblLineWidth
    
    Set objfld = objFs.GetFolder(strPath)
    
    lngCol2 = lngCol + 2
    lngRow = lngRow + 1
    
    lngFolderCount = objfld.SubFolders.count
    
    Select Case lngFolderCount > 0
        Case 0
            strLine = strLineParent & "�@�@"
        Case Else
            strLine = strLineParent & "���@"
    End Select
    
    If chkFileName.value Then
        
        Set colFiles = New Collection
        
        For Each objfl In objfld.files
            colFiles.Add objfl, objfl.Name
        Next
        
        rlxSortCollection colFiles
        
        '�t�@�C���̈ꗗ���쐬����B
        For Each objfl In colFiles
            DoEvents
            If mblnCancel Then
                Exit Sub
            End If
            '�r��
            SetTree strLine, lngRow, lngHCol
            
            '�t�@�C����
            Cells(lngRow, lngCol2).NumberFormatLocal = "@"
            Cells(lngRow, lngCol2).value = objfl.Name
    
            
            '�n�C�p�[�����N
            'Office �v���O�������̃n�C�p�[�����N�̃t�@�C�����Ń|���h�������g�p�ł��܂���B(KB202261)
            'http://support.microsoft.com/kb/202261/ja
            '�t�@�C���w��̏ꍇ
            If chkFile.value Then
                ActiveSheet.Hyperlinks.Add _
                    Anchor:=Cells(lngRow, lngCol2), _
                    Address:=rlxAddFileSeparator(strPath) & objfl.Name, _
                    TextToDisplay:=objfl.Name
            End If
            
            lngRow = lngRow + 1
            lngFolderCnt = lngFolderCnt + 1
            mMm.DisplayGauge lngFolderCnt
        Next
        Set colFiles = Nothing
    End If
    
    '�r��
    SetTree strLine, lngRow, lngHCol
    lngRow = lngRow + 1
    
    '�T�u�t�H���_��������
    i = 1
    
    Set colFolders = New Collection
    
    For Each objSub In objfld.SubFolders
        colFolders.Add objSub, objSub.Name
    Next
    
    rlxSortCollection colFolders
        
    For Each objSub In colFolders
        DoEvents
        If mblnCancel Then
            Exit Sub
        End If
        '�r��
        Select Case lngFolderCount
            Case i
                SetTree strLineParent & "����", lngRow, lngHCol
                strLine = strLineParent & "�@�@"
        
            Case Else
                SetTree strLineParent & "����", lngRow, lngHCol
                strLine = strLineParent & "���@"
        End Select
        
        '�t�H���_���o��
        Cells(lngRow, lngCol2).NumberFormatLocal = "@"
        Cells(lngRow, lngCol2).value = rlxGetFullpathFromFileName(objSub.Path)
        
        '�t�H���_�w��̏ꍇ
        If chkFolder.value Then
            ActiveSheet.Hyperlinks.Add _
                Anchor:=Cells(lngRow, lngCol2), _
                Address:=objSub.Path, _
                TextToDisplay:=rlxGetFullpathFromFileName(objSub.Path)
        End If
                
        '�������g���Ăяo���i�ċA�j
        FileDisp objFs, objSub.Path, lngRow, lngCol2, lngHCol, strLine, lngFolderCnt
        
        i = i + 1
        lngFolderCnt = lngFolderCnt + 1
        mMm.DisplayGauge lngFolderCnt
        
    Next
    Set colFolders = Nothing
    
End Sub
'Tree�`��
Private Sub SetTree(ByVal strLine As String, ByVal lngRow As Long, ByVal lngCol As Long)

    Dim lngLen As Long
    Dim i As Long

    
    lngLen = Len(strLine)
    
    For i = 1 To lngLen

        Cells(lngRow, lngCol + i - 1).value = Mid$(strLine, i, 1)
    Next


End Sub

Private Sub spnWidth_SpinDown()
    txtLineWidth.Text = spinDown(txtLineWidth.Text)
End Sub

Private Sub spnWidth_SpinUp()
    txtLineWidth.Text = spinUp(txtLineWidth.Text)
End Sub
Private Function spinUp(ByVal vntValue As Variant) As Variant

    Dim lngValue As Long
    
    lngValue = Val(vntValue)
    lngValue = lngValue + 1
    spinUp = lngValue

End Function

Private Function spinDown(ByVal vntValue As Variant) As Variant

    Dim lngValue As Long
    
    lngValue = Val(vntValue)
    lngValue = lngValue - 1
    If lngValue < 0 Then
        lngValue = 0
    End If
    spinDown = lngValue

End Function

Private Sub UserForm_Initialize()
    mblnCancel = False
    lblGauge.visible = False
End Sub

Private Sub UserForm_Terminate()
    mblnCancel = True
End Sub
