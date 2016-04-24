VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmScreenShot 
   Caption         =   "Eccel�X�N�V�����[�h�J�n"
   ClientHeight    =   4095
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7125
   OleObjectBlob   =   "frmScreenShot.frx":0000
   StartUpPosition =   1  '�I�[�i�[ �t�H�[���̒���
End
Attribute VB_Name = "frmScreenShot"
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

Public Message As String
Private blnCancel As Boolean

#If VBA7 And Win64 Then
    Private Declare PtrSafe Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As Any, ByVal lpWindowName As String) As LongPtr
    Public hwnd As LongPtr
#Else
    Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As Any, ByVal lpWindowName As String) As Long
    Public hwnd As Long
#End If

Private Sub cmdCancel_Click()
    blnCancel = True
    Unload Me
End Sub

Private Sub cmdOk_Click()
    
    Dim blnZoomEnable As Boolean
    Dim lngZoomNum As Long
    Dim blnSave As Boolean
    Dim lngBlankNum As Long
    Dim blnPageBreakEnable As Boolean
    Dim lngPageBreakNun As Long

    GetScreenSetting blnZoomEnable, lngZoomNum, blnSave, lngBlankNum, blnPageBreakEnable, lngPageBreakNun
    
    If blnSave Then
        If rlxIsFileExists(ActiveWorkbook.FullName) Then
        Else
            MsgBox "�u�b�N�̕ۑ����L���ɂȂ��Ă��܂����A���݂̃u�b�N���P�x���ۑ�����Ă��܂���B" & vbCrLf & "�ۑ����Ă�����s���Ă��������B", vbOKOnly + vbExclamation, C_TITLE
            Exit Sub
        End If
    End If
    
    '�E�B���h�E�n���h���̎擾
    hwnd = FindWindow(0&, Me.Caption)

    '�X�N���[���V���b�g�����J�n
    basScreenShot.StartScreenShot
    
    Me.Hide
    
End Sub

Private Sub UserForm_Initialize()
    blnCancel = False
End Sub

Private Sub UserForm_MouseMove(ByVal Button As Integer, ByVal Shift As Integer, ByVal X As Single, ByVal Y As Single)
'    Select Case X \ screen.TwipsPerPixelX
'            Case WM_MOUSEMOVE
'            Case WM_LBUTTONDOWN
'            Case WM_LBUTTONUP
'            Case WM_LBUTTONDBLCLK
'                    Form2.Show vbModal
'            Case WM_RBUTTONDOWN
'                    Call SetForegroundWindow(Me.hWnd)
'                    DoEvents
'                    Me.PopupMenu menu0
'            Case WM_RBUTTONUP
'            Case WM_RBUTTONDBLCLK
'    End Select
End Sub

Private Sub UserForm_QueryClose(Cancel As Integer, CloseMode As Integer)
    
    mScreenEnable = False
    Call RefreshRibbon

    If blnCancel Or CloseMode = 0 Then
    Else
    
        '�X�N���[���V���b�g�����I��
        basScreenShot.StopScreenShot
        
    End If

End Sub

