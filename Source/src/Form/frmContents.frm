VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmContents 
   Caption         =   "�ڎ��̍쐬"
   ClientHeight    =   7545
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5985
   OleObjectBlob   =   "frmContents.frx":0000
   StartUpPosition =   1  '�I�[�i�[ �t�H�[���̒���
End
Attribute VB_Name = "frmContents"
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

Private Const C_NAME As String = "�ڎ�"
Private Const C_NO As Long = 1
Private Const C_SHEET_NAME As Long = 2
Private Const C_PAPER_SIZE As Long = 3
Private Const C_PAGES As Long = 4
Private Const C_HEAD_ROW = 1
Private Const C_START_ROW = 3
    
Private Const C_COLUMN_LIST As Long = 1
Private Const C_COLUMN_PAGE As Long = 2
Private WithEvents MW As MouseWheel
Attribute MW.VB_VarHelpID = -1

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdOk_Click()


    Dim i As Long
    Dim j As Long
    Dim k As Long
    Dim m As Long
    Dim p() As Long
    Dim l As Long
    
    Dim lngCol As Long
    Dim lngRow As Long
    Dim lngLevel As Long
    Dim strBuf As String
    

    
    Dim C_PERIOD As String
    Dim C_CONTENT_LIST As Long
    Dim C_CONTENT_PAGE As Long
    Dim C_ROW As Long

    Dim WB As Workbook
    Dim WS As Worksheet
    Dim s As Worksheet
    Dim lngCount As Long
    Dim lngPage As Long
    Dim varView As Variant
    
    Select Case Val(txtLevel.Text)
        Case 1 To 10
        Case Else
            MsgBox "���x���́u�P�`�P�O�œ��͂��Ă��������B", vbOKOnly, C_TITLE
            Exit Sub
    End Select
    
    If optNew.value Then
    Else
    
        If Len(txtDanrakuCell.Text) = 0 Then
            MsgBox "��(�i���ԍ�)����͂��Ă��������B", vbOKOnly + vbExclamation, C_TITLE
            txtDanrakuCell.SetFocus
            Exit Sub
        End If
        If rlxIsAlphabet(txtDanrakuCell.Text) Then
        Else
            MsgBox "(�i���ԍ�)��̓A���t�@�x�b�g�œ��͂��Ă��������B", vbOKOnly + vbExclamation, C_TITLE
            txtDanrakuCell.SetFocus
            Exit Sub
        End If
        If getAto1(txtDanrakuCell.Text) > ActiveSheet.Columns.count Then
            MsgBox "��(�i���ԍ�)�̍ő�l�𒴂��Ă��܂��B", vbOKOnly + vbExclamation, C_TITLE
            txtDanrakuCell.SetFocus
            Exit Sub
        End If
        
        If Len(txtPageCell.Text) = 0 Then
            MsgBox "��(�y�[�W)����͂��Ă��������B", vbOKOnly + vbExclamation, C_TITLE
            txtPageCell.SetFocus
            Exit Sub
        End If
        If rlxIsAlphabet(txtPageCell.Text) Then
        Else
            MsgBox "��(�y�[�W)�̓A���t�@�x�b�g�œ��͂��Ă��������B", vbOKOnly + vbExclamation, C_TITLE
            txtPageCell.SetFocus
            Exit Sub
        End If
        If getAto1(txtPageCell.Text) > ActiveSheet.Columns.count Then
            MsgBox "��(�y�[�W)�̍ő�l�𒴂��Ă��܂��B", vbOKOnly + vbExclamation, C_TITLE
            txtPageCell.SetFocus
            Exit Sub
        End If
        
        
        If getAto1(txtPageCell.Text) = getAto1(txtDanrakuCell.Text) Then
            MsgBox "�i���ԍ��ƃy�[�W�͈قȂ��ɂ��Ă��������B", vbOKOnly + vbExclamation, C_TITLE
            txtPageCell.SetFocus
            Exit Sub
        End If
        
        
        If Len(txtRow.Text) = 0 Then
            MsgBox "�s����͂��Ă��������B", vbOKOnly + vbExclamation, C_TITLE
            txtRow.SetFocus
            Exit Sub
        End If
        If rlxIsNumber(txtRow.Text) Then
        Else
            MsgBox "�s�͐��l�œ��͂��Ă��������B", vbOKOnly + vbExclamation, C_TITLE
            txtRow.SetFocus
            Exit Sub
        End If
        If Val(txtRow.Text) > ActiveSheet.Rows.count Then
            MsgBox "�s�̍ő�l�𒴂��Ă��܂��B", vbOKOnly + vbExclamation, C_TITLE
            txtRow.SetFocus
            Exit Sub
        End If
    End If
    
    lngPage = 0

    C_PERIOD = " " & String$(300, ".") & " "

    Set WB = ActiveWorkbook
    
    If optNew.value Then
        
        '�V�[�g�̑��݃`�F�b�N
        For Each s In WB.Worksheets
            If s.Name = C_NAME Then
                If MsgBox("�u" & C_NAME & "�v�V�[�g�����ɑ��݂��܂��B�폜���Ă����ł����H", vbOKCancel + vbQuestion, C_TITLE) <> vbOK Then
                    Exit Sub
                Else
                    '���݂���ꍇ�͍폜
                    Application.DisplayAlerts = False
                    s.Delete
                    Application.DisplayAlerts = True
                End If
            End If
        Next
        
        C_CONTENT_LIST = C_COLUMN_LIST
        C_CONTENT_PAGE = C_COLUMN_PAGE
        C_ROW = C_START_ROW
    
        Set WS = WB.Worksheets.Add(WB.Worksheets(1))
        WS.Name = C_NAME
        WS.Cells(C_HEAD_ROW, C_CONTENT_LIST).value = C_NAME
        WS.Cells(C_HEAD_ROW, C_CONTENT_PAGE).value = "�y�[�W"
    Else
        C_CONTENT_LIST = getAto1(txtDanrakuCell.Text)
        C_CONTENT_PAGE = getAto1(txtPageCell.Text)
        C_ROW = txtRow.Text
        Set WS = WB.Worksheets(cboSheet.Text)
    End If
    
    Application.ScreenUpdating = False
    
    lngLevel = Val(txtLevel.Text)
    
    lngPage = 0
    j = C_ROW

    For lngCount = 0 To lstSheets.ListCount - 1
    
        If lstSheets.Selected(lngCount) Then
        
            Dim strSheet As String
            
            strSheet = lstSheets.List(lngCount, 1)
            
            Worksheets(strSheet).Activate
            varView = ActiveWindow.View
            ActiveWindow.View = xlPageBreakPreview
    
            l = Worksheets(strSheet).HPageBreaks.count
            If l <> 0 Then
                ReDim p(1 To l)
                For k = 1 To l
                    p(k) = Worksheets(strSheet).HPageBreaks(k).Location.row
                Next
            End If
            
            lngRow = Worksheets(strSheet).UsedRange.Item(Worksheets(strSheet).UsedRange.count).row
            lngCol = getSectionCol(Worksheets(strSheet))
            If lngCol = 0 Then
                Exit For
            End If
            
'            WS.Cells(j, C_CONTENT_LIST).Value = "<<" & Worksheets(strSheet).Name & ">>"
'            j = j + 1
                        
            For i = 1 To lngRow
            
                strBuf = Worksheets(strSheet).Cells(i, lngCol).value
                            
                If Worksheets(strSheet).Cells(i, lngCol).IndentLevel < lngLevel Then
                
                    Dim blnAns As Boolean
                    blnAns = False
                    For m = 0 To lngLevel - 1
                        blnAns = blnAns Or rlxHasSectionNo(strBuf, m)
                    Next
                    
                    If blnAns Then

                        
                        If chkPeriod.value Then
                            WS.Cells(j, C_CONTENT_LIST).value = Worksheets(strSheet).Cells(i, lngCol).value & C_PERIOD
                        Else
                            WS.Cells(j, C_CONTENT_LIST).value = Worksheets(strSheet).Cells(i, lngCol).value
                        End If
                        WS.Cells(j, C_CONTENT_LIST).IndentLevel = Worksheets(strSheet).Cells(i, lngCol).IndentLevel
                        
                        If l = 0 Then
                            k = 1
                            WS.Cells(j, C_CONTENT_PAGE).value = k + lngPage
                        Else
                            For k = 1 To UBound(p)
                                If p(k) > i Then
                                    WS.Cells(j, C_CONTENT_PAGE).value = k + lngPage
                                    Exit For
                                End If
                            Next
                            WS.Cells(j, C_CONTENT_PAGE).value = k + lngPage
                        End If
                        
                        If chkHyperLink.value Then
                            WS.Hyperlinks.Add _
                                Anchor:=WS.Cells(j, C_CONTENT_LIST), _
                                Address:="", _
                                SubAddress:="'" & Worksheets(strSheet).Name & "'!" & Worksheets(strSheet).Cells(i, lngCol).Address, _
                                TextToDisplay:=WS.Cells(j, C_CONTENT_LIST).value
                        End If
                        
                        j = j + 1
                        
                    End If
                End If
            
            Next
            lngPage = lngPage + k
            ActiveWindow.View = varView
        
        End If
    Next
    
    If optNew.value Then
        WS.Columns(C_CONTENT_LIST).ColumnWidth = 70
        WS.Columns(C_CONTENT_PAGE).ColumnWidth = 7
    End If
    
    WS.Activate
    Set WS = Nothing
    
    Application.ScreenUpdating = True
    Unload Me
    
End Sub


Private Function getSectionCol(ByRef WS As Worksheet) As Long
                
    Dim blnFind As Boolean
    Dim strBuf As String
    Dim i As Long
    Dim j As Long
    
    For j = 1 To WS.UsedRange.Item(WS.UsedRange.count).Column
    
        For i = 1 To WS.UsedRange.Item(WS.UsedRange.count).row
        
            strBuf = WS.Cells(i, j).value
                        
            '�i���ԍ����x���P�`�Q�����݂���ꍇ
            If rlxHasSectionNo(strBuf, 0) Or rlxHasSectionNo(strBuf, 1) Then
                blnFind = True
                GoTo pass
            End If
        
        Next
    Next
pass:
    If blnFind Then
        getSectionCol = j
    Else
        getSectionCol = 0
    End If
End Function

Private Sub lstSheets_MouseMove(ByVal Button As Integer, ByVal Shift As Integer, ByVal X As Single, ByVal Y As Single)
    Set MW.obj = lstSheets
End Sub

Private Sub optEmb_Click()
    Call setEnebled
End Sub

Private Sub optNew_Click()
    Call setEnebled
End Sub

Private Sub spnDanraku_SpinDown()
    txtDanrakuCell.Text = spinColDown(txtDanrakuCell.Text)
End Sub

Private Sub spnDanraku_SpinUp()
    txtDanrakuCell.Text = spinColUp(txtDanrakuCell.Text)
End Sub

Private Sub spnLevel_SpinDown()
    txtLevel.Text = spinDown(txtLevel.Text)
End Sub

Private Sub spnLevel_SpinUp()
    txtLevel.Text = spinUp(txtLevel.Text)
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
    If lngValue < 1 Then
        lngValue = 1
    End If
    spinDown = lngValue

End Function

Private Function spinColUp(ByVal vntValue As Variant) As Variant

    Dim lngValue As Long
    
    lngValue = getAto1(vntValue)
    lngValue = lngValue + 1
    If lngValue > ActiveSheet.Columns.count Then
        lngValue = ActiveSheet.Columns.count
    End If
    spinColUp = get1toA(lngValue)

End Function

Private Function spinColDown(ByVal vntValue As Variant) As Variant

    Dim lngValue As Long
    
    lngValue = getAto1(vntValue)
    lngValue = lngValue - 1
    If lngValue < 1 Then
        lngValue = 1
    End If
    spinColDown = get1toA(lngValue)

End Function

Private Sub spnPage_SpinDown()
    txtPageCell.Text = spinColDown(txtPageCell.Text)
End Sub

Private Sub spnPage_SpinUp()
    txtPageCell.Text = spinColUp(txtPageCell.Text)
End Sub

Private Sub spnRow_SpinDown()
    
    txtRow.Text = spinDown(txtRow.Text)

End Sub

Private Sub spnRow_SpinUp()

    txtRow.Text = spinUp(txtRow.Text)

End Sub

Private Sub UserForm_Initialize()

    Dim WS As Worksheet
    Dim i As Long
    Dim j As Long
    j = 1
    For i = 1 To Worksheets.count
    
        If Worksheets(i).visible = xlSheetVisible Then
            cboSheet.AddItem Worksheets(i).Name
            lstSheets.AddItem ""
            lstSheets.List(j - 1, 0) = j
            lstSheets.List(j - 1, 1) = Worksheets(i).Name
            If ActiveSheet.Index = Worksheets(i).Index Then
                lstSheets.Selected(j - 1) = True
            End If
            j = j + 1
        End If
        
    Next
    txtLevel.Text = 3
    
    j = 0
    For i = 0 To cboSheet.ListCount - 1
        If cboSheet.List(i) = C_NAME Then
            j = i
            Exit For
        End If
    Next
    cboSheet.ListIndex = j
    
    optNew.value = True

    txtDanrakuCell.Text = get1toA(C_COLUMN_LIST)
    txtPageCell.Text = get1toA(C_COLUMN_PAGE)
    txtRow.Text = C_START_ROW
    
    Set MW = basMouseWheel.GetInstance
    MW.Install
End Sub
Private Function getAto1(ByVal strCol As String) As Long

    Dim lngCnt As Long
    Dim strBuf As String
    Dim lngret As Long
    Dim i As Long
    
    strCol = UCase(strCol)
    lngCnt = Len(strCol)
    lngret = 0
    
    For i = 0 To lngCnt - 1
        strBuf = Mid$(strCol, lngCnt - i, 1)
        lngret = lngret + (Asc(strBuf) - Asc("A") + 1) * (26 ^ i)
    Next

    getAto1 = lngret

End Function
Private Function get1toA(ByVal lngCol As Long) As String

    Dim strRet As String
    Dim lngAns As Long

    '1�`26�̗�ԍ���0�`25�ɕϊ�
    lngCol = lngCol - 1

    Do Until lngCol < 0

        lngAns = (lngCol Mod 26)

        strRet = Chr$(Asc("A") + lngAns) & strRet

        '�E�V�t�g
        lngCol = Fix(lngCol / 26) - 1

    Loop

    get1toA = strRet

End Function
Sub setEnebled()

    cboSheet.enabled = optEmb.value
    txtDanrakuCell.enabled = optEmb.value
    txtPageCell.enabled = optEmb.value
    txtRow.enabled = optEmb.value
    spnDanraku.enabled = optEmb.value
    spnPage.enabled = optEmb.value
    spnRow.enabled = optEmb.value
    
End Sub

Private Sub UserForm_MouseMove(ByVal Button As Integer, ByVal Shift As Integer, ByVal X As Single, ByVal Y As Single)
    Set MW.obj = Nothing
End Sub

Private Sub UserForm_Terminate()
    MW.UnInstall
    Set MW = Nothing
End Sub
Private Sub MW_WheelDown(obj As Object)

    If obj.ListCount = 0 Then Exit Sub
    obj.TopIndex = obj.TopIndex + 3
    
End Sub

Private Sub MW_WheelUp(obj As Object)

    Dim lngPos As Long

    If obj.ListCount = 0 Then Exit Sub
    lngPos = obj.TopIndex - 3

    If lngPos < 0 Then
        lngPos = 0
    End If

    obj.TopIndex = lngPos

End Sub
