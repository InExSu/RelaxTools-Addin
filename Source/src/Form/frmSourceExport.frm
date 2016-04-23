VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmSourceExport 
   Caption         =   "VBA�\�[�X�G�N�X�|�[�g"
   ClientHeight    =   3360
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7560
   OleObjectBlob   =   "frmSourceExport.frx":0000
   ShowModal       =   0   'False
   StartUpPosition =   2  '��ʂ̒���
End
Attribute VB_Name = "frmSourceExport"
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

'�W�����W���[��
Const vbext_ct_StdModule As Integer = 1
'�N���X ���W���[��
Const vbext_ct_ClassModule As Integer = 2
'Microsoft Forms
Const vbext_ct_MSForm As Integer = 3
'ActiveX �f�U�C�i�[
Const vbext_ct_ActiveXDesigner As Integer = 11
'�h�L�������g ���W���[��
Const vbext_ct_Document As Integer = 100
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

Private Sub UserForm_Initialize()

    Dim b As Workbook
    
    For Each b In Workbooks
        If b.Name = "RelaxTools.xlam" Then
        Else
            cboSrcBook.AddItem b.Name
        End If
    Next
    
    If cboSrcBook.ListCount > 0 Then
        cboSrcBook.ListIndex = 0
    End If
    lblGauge.visible = False
    txtFolder.Text = GetSetting(C_TITLE, "VBAExport", "Path")
    chkCategory.value = GetSetting(C_TITLE, "VBAExport", "Category", False)
    
End Sub


Private Sub cmdOk_Click()

    Dim strFile As String
    
    On Error GoTo ErrHandle
    
    strFile = txtFolder.Text
    
    If rlxIsFolderExists(strFile) Then
    Else
        If MsgBox("�o�͐�t�H���_��������܂���B" & vbCrLf & "�쐬���܂����H", vbOKCancel + vbQuestion, C_TITLE) <> vbOK Then
           Exit Sub
        Else
            rlxCreateFolder strFile
        End If
    End If
    
    If MsgBox("VBA�\�[�X���G�N�X�|�[�g���܂��B��낵���ł����H", vbOKCancel + vbQuestion, C_TITLE) <> vbOK Then
        Exit Sub
    End If
    
    Application.ScreenUpdating = False
    

    Dim lngCnt As Long
    Dim mMm As MacroManager
    Set mMm = New MacroManager
    Set mMm.Form = Me
    mMm.Disable
    
    mMm.StartGauge Workbooks(cboSrcBook.Text).VBProject.VBComponents.count
    lngCnt = 1
    
    Dim vb_component As Object
    
    For Each vb_component In Workbooks(cboSrcBook.Text).VBProject.VBComponents
'        Debug.Print vb_component.Name
        Dim extention As String
        Dim strFolder As String
        Select Case vb_component.Type
            Case vbext_ct_StdModule
                '�W�����W���[��
                extention = ".bas"
                strFolder = "Modules"
            Case vbext_ct_ClassModule
                '�N���X ���W���[��
                extention = ".cls"
                strFolder = "Class"
            Case vbext_ct_MSForm
                'Microsoft Forms
                extention = ".frm"
                strFolder = "Form"
            Case vbext_ct_ActiveXDesigner
                'ActiveX �f�U�C�i�[
                extention = ".cls"
                strFolder = "cls"
            Case vbext_ct_Document
                '�h�L�������g ���W���[��
                extention = ".cls"
                strFolder = "Microsoft Excel Objects"
        End Select
        If chkCategory.value Then
            rlxCreateFolder rlxAddFileSeparator(strFile) & strFolder
            vb_component.Export rlxAddFileSeparator(strFile) & strFolder & "\" & vb_component.Name & extention
        Else
            vb_component.Export rlxAddFileSeparator(strFile) & vb_component.Name & extention
        End If
        lngCnt = lngCnt + 1
        mMm.DisplayGauge lngCnt
    Next
    Set mMm = Nothing
    
    SaveSetting C_TITLE, "VBAExport", "Path", strFile
    SaveSetting C_TITLE, "VBAExport", "Category", chkCategory.value
    
    Application.ScreenUpdating = True
    
    MsgBox "�G�N�X�|�[�g�������܂����B" & vbCrLf & "�n�j�������ƃG�N�X�|�[�g��̃t�H���_���J���܂��B", vbOKOnly + vbInformation, C_TITLE
    
    Unload Me
    
    Dim WSH As Object
    Set WSH = CreateObject("WScript.Shell")
    
    WSH.Run ("""" & strFile & """")
    
    Set WSH = Nothing
    
    Exit Sub
ErrHandle:
    Application.ScreenUpdating = True
    If mMm Is Nothing Then
    Else
        mMm.Enable
    End If
    MsgBox "�G���[���������܂����B" & vbCrLf & err.Description, vbOKOnly + vbCritical, C_TITLE
    Set mMm = Nothing
End Sub

