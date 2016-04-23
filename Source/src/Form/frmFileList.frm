VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmFileList 
   Caption         =   "�t�@�C���ꗗ�擾"
   ClientHeight    =   2520
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7260
   OleObjectBlob   =   "frmFileList.frx":0000
   StartUpPosition =   1  '�I�[�i�[ �t�H�[���̒���
End
Attribute VB_Name = "frmFileList"
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
Dim mblnCancel As Boolean
Dim mMm As MacroManager


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
    Dim FileName As String
    Dim objFs As Object
    
    If ActiveCell Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃZ�����݂���܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    '�t�H���_���擾
    FileName = txtFolder.Text
    If FileName = "" Then
        MsgBox "�t�@�C���ꗗ���擾����t�H���_����͂��Ă��������B", vbExclamation, "�t�@�C���ꗗ�擾"
        txtFolder.SetFocus
        Exit Sub
    End If
    
    '�`�F�b�N���ǂꂩ�P�ł����͂���Ă��Ȃ��ꍇ
    If chkFile.value Or chkFolder.value Or chkFileSize.value Or chkDate.value Then
    Else
        MsgBox "�o�͍��ڂ��P�ȏ�I�����Ă��������B", vbExclamation, "�t�@�C���ꗗ�擾"
        chkFile.SetFocus
        Exit Sub
    End If
    
    Set objFs = CreateObject("Scripting.FileSystemObject")
    
    Dim lngFCnt As Long
    
    Set mMm = New MacroManager
    Set mMm.Form = Me
    
    mMm.Disable
    mMm.DispGuidance "�t�@�C���̐����J�E���g���Ă��܂�..."
    
    rlxGetFilesCount objFs, FileName, lngFCnt, True, chkFolder.value, chkSubFolder.value
    
    mMm.StartGauge lngFCnt
    
    lngRow = ActiveCell.row
    lngCol = ActiveCell.Column
    
    Dim lngCount As Long
    
    On Error Resume Next
    
    FileDisp objFs, FileName, lngRow, lngCol, lngCount, lngFCnt
    
    Set mMm = Nothing
    Select Case err.Number
    Case 75, 76
        MsgBox "�t�H���_�����݂��܂���B", vbExclamation, "�t�@�C���ꗗ�擾"
        txtFolder.SetFocus
        Exit Sub
    End Select
    
    Unload Me
    
End Sub


Private Sub FileDisp(objFs, strPath, lngRow, lngCol, lngCount, lngMax)

    Dim objfld As Object
    Dim objfl As Object
    Dim objSub As Object
    Dim colFiles As Collection
    Dim colFolders As Collection
    
    Dim lngCol2 As Long

    Set objfld = objFs.GetFolder(strPath)
    Set colFiles = New Collection
    
    '�t�@�C�����擾
    For Each objfl In objfld.files
        DoEvents
        If mblnCancel Then
            Exit Sub
        End If
        colFiles.Add objfl, objfl.Name
    Next
    
    '�R���N�V�����̃\�[�g
    rlxSortCollection colFiles
    
    For Each objfl In colFiles
        DoEvents
        If mblnCancel Then
            Exit Sub
        End If
        lngCol2 = lngCol
        If chkFile.value Then
            Cells(lngRow, lngCol2).NumberFormatLocal = "@"
            Cells(lngRow, lngCol2) = objfl.Name
            lngCol2 = lngCol2 + 1
        End If
        If chkFolder.value Then
            Cells(lngRow, lngCol2).NumberFormatLocal = "@"
            Cells(lngRow, lngCol2) = objfl.ParentFolder.Path
            lngCol2 = lngCol2 + 1
        End If
        If chkFileSize.value Then
            Cells(lngRow, lngCol2) = Format(objfl.Size, "#,##0")
            lngCol2 = lngCol2 + 1
        End If
        If chkDate.value Then
            Cells(lngRow, lngCol2).NumberFormatLocal = "@"
            Cells(lngRow, lngCol2) = Format(objfl.DateLastModified, "yyyy/mm/dd hh:mm:ss")
            lngCol2 = lngCol2 + 1
        End If
        lngRow = lngRow + 1
        lngCount = lngCount + 1
    Next
    Set colFiles = Nothing
    
    
    Set colFolders = New Collection

    For Each objSub In objfld.SubFolders
        DoEvents
        If mblnCancel Then
            Exit Sub
        End If
        colFolders.Add objSub, objSub.Name
    Next
    
    '�R���N�V�����̃\�[�g
    rlxSortCollection colFolders
    
    For Each objSub In colFolders
        DoEvents
        If mblnCancel Then
            Exit Sub
        End If
        '�t�H���_�擾����
        If chkFolders.value Then
            lngCol2 = lngCol
            If chkFile.value Then
                Cells(lngRow, lngCol2).NumberFormatLocal = "@"
                Cells(lngRow, lngCol2) = objSub.Name
                lngCol2 = lngCol2 + 1
            End If
            If chkFolder.value Then
                Cells(lngRow, lngCol2).NumberFormatLocal = "@"
                Cells(lngRow, lngCol2) = objSub.ParentFolder.Path
                lngCol2 = lngCol2 + 1
            End If
            If chkFileSize.value Then
                Cells(lngRow, lngCol2) = Format(objSub.Size, "#,##0")
                lngCol2 = lngCol2 + 1
            End If
            If chkDate.value Then
                Cells(lngRow, lngCol2).NumberFormatLocal = "@"
                Cells(lngRow, lngCol2) = Format(objSub.DateLastModified, "yyyy/mm/dd hh:mm:ss")
                lngCol2 = lngCol2 + 1
            End If
            lngRow = lngRow + 1
            lngCount = lngCount + 1
        End If
        '�T�u�t�H���_��������
        If chkSubFolder.value Then
            FileDisp objFs, objSub.Path, lngRow, lngCol, lngCount, lngMax
        End If
    Next
    Set colFolders = Nothing
    
    mMm.DisplayGauge lngCount

End Sub

Private Sub UserForm_Initialize()
    lblGauge.visible = False
    mblnCancel = False
End Sub

Private Sub UserForm_Terminate()
    mblnCancel = True
End Sub
