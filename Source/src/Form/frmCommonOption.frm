VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmCommonOption 
   Caption         =   "RelaxTools���ʐݒ�"
   ClientHeight    =   7410
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   6525
   OleObjectBlob   =   "frmCommonOption.frx":0000
   StartUpPosition =   1  '�I�[�i�[ �t�H�[���̒���
End
Attribute VB_Name = "frmCommonOption"
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

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdOk_Click()

    Call SaveSetting(C_TITLE, "Option", "OnRepeat", chkOnRepeat.value)
    Call SaveSetting(C_TITLE, "Option", "NotHoldFormat", chkNotHoldFormat.value)
    Call SaveSetting(C_TITLE, "Log", "Level", cboLogLevel.ListIndex)
    
    Logger.Level = cboLogLevel.ListIndex
    
    Unload Me

End Sub

Private Sub UserForm_Initialize()
    
    Dim strBuf As String
    
    chkOnRepeat.value = CBool(GetSetting(C_TITLE, "Option", "OnRepeat", True))
    chkNotHoldFormat.value = CBool(GetSetting(C_TITLE, "Option", "NotHoldFormat", False))
    
    strBuf = ""
    strBuf = strBuf & "�E�Z���̍Ō�ɕ�����}��" & vbCrLf
    strBuf = strBuf & "�E�Z���̐擪�ɕ�����}��" & vbCrLf
    strBuf = strBuf & "�E�Z����n�����ڂɕ�����}��" & vbCrLf
    strBuf = strBuf & "�E�Z���̐擪����n�����폜" & vbCrLf
    strBuf = strBuf & "�E�Z���̍Ōォ��n�����폜" & vbCrLf
    strBuf = strBuf & "�E�Z���̎w�蕶�����獶�����폜" & vbCrLf
    strBuf = strBuf & "�E�Z���̎w�蕶������E�����폜" & vbCrLf
    strBuf = strBuf & "�E�Z����n�����ڈȑO�폜" & vbCrLf
    strBuf = strBuf & "�E�Z����n�����ڈȍ~�폜" & vbCrLf
    strBuf = strBuf & "�E�Z���̂��ׂẲ��s���폜" & vbCrLf
    strBuf = strBuf & "�E�E1���폜" & vbCrLf
    strBuf = strBuf & "�E��1���폜" & vbCrLf
    strBuf = strBuf & "�E�Z���̍Ō�ɉ��s��ǉ�" & vbCrLf
    strBuf = strBuf & "�E�Z���̍Ō�̉��s���폜" & vbCrLf
    
    lblTaisho.Caption = strBuf
    
    cboLogLevel.AddItem "Trace"
    cboLogLevel.AddItem "Warn"
    cboLogLevel.AddItem "Info"
    cboLogLevel.AddItem "Fatal"
    cboLogLevel.AddItem "None"
    
    cboLogLevel.ListIndex = CLng(GetSetting(C_TITLE, "Log", "Level", LogLevel.None))
    
End Sub
