VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmEditEx 
   Caption         =   "�O���G�f�B�^�̐ݒ�"
   ClientHeight    =   2190
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6855
   OleObjectBlob   =   "frmEditEx.frx":0000
   StartUpPosition =   1  '�I�[�i�[ �t�H�[���̒���
End
Attribute VB_Name = "frmEditEx"
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

Private Sub cboEncode_Change()
    If cboEncode.Text = C_UTF16 Then
        chkBOM.enabled = True
    Else
        chkBOM.value = False
        chkBOM.enabled = False
    End If
End Sub

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdFile_Click()

    Dim strFile As String

    strFile = Application.GetOpenFilename("�t�@�C��(*.*),(*.*)", , "���s�t�@�C��", , False)
    If strFile = "False" Then
        '�t�@�C�������w�肳��Ȃ������ꍇ
        Exit Sub
    End If
    
    txtEditor.Text = strFile
End Sub

Private Sub cmdOk_Click()

    Dim strEditor As String
    Dim strEncode As String
    Dim blnBOM As Boolean

    strEditor = txtEditor.Text
    strEncode = cboEncode.Text
    If strEncode = C_UTF16 Then
        blnBOM = chkBOM.value
    Else
        blnBOM = False
    End If

    SaveSetting C_TITLE, "EditEx", "Editor", strEditor
    SaveSetting C_TITLE, "EditEx", "Encode", strEncode
    SaveSetting C_TITLE, "EditEx", "BOM", blnBOM
    
    Unload Me
End Sub

Private Sub UserForm_Initialize()

    Dim strEditor As String
    Dim strEncode As String
    Dim blnBOM As Boolean
    Dim FS As Object
    Dim strNotepad As String

    Set FS = CreateObject("Scripting.FileSystemObject")
    strNotepad = rlxAddFileSeparator(FS.GetSpecialFolder(0)) & "notepad.exe"
    Set FS = Nothing

    strEditor = GetSetting(C_TITLE, "EditEx", "Editor", strNotepad)
    strEncode = GetSetting(C_TITLE, "EditEx", "Encode", C_SJIS)
    blnBOM = GetSetting(C_TITLE, "EditEx", "BOM", False)
    
    '��������̏ꍇ�ǂݑւ���
    If strEncode = C_SJIS_OLD Then
        strEncode = C_SJIS
    End If
    
    cboEncode.AddItem C_SJIS
    cboEncode.AddItem C_UTF8
    cboEncode.AddItem C_UTF16
    
    txtEditor.Text = strEditor
    cboEncode.Text = strEncode
    chkBOM.value = blnBOM
    
    Call cboEncode_Change
    
End Sub

