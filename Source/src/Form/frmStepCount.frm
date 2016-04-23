VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmStepCount 
   Caption         =   "VBA�X�e�b�v�J�E���g"
   ClientHeight    =   8520
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7620
   OleObjectBlob   =   "frmStepCount.frx":0000
   ShowModal       =   0   'False
   StartUpPosition =   2  '��ʂ̒���
End
Attribute VB_Name = "frmStepCount"
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
Private Const C_START_ROW As Long = 8

Private Const C_NO As Long = 1
Private Const C_MODULE As Long = 2
Private Const C_TYPE As Long = 3
Private Const C_CODE As Long = 4
Private Const C_COMMENT As Long = 5
Private Const C_BLANK As Long = 6
Private Const C_ALL As Long = 7
Private Const C_SORT As Long = 8


Private Sub cmdCancel_Click()
    Unload Me
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
    
End Sub


Private Sub cmdOk_Click()

    Dim Target As Workbook
    Dim i As Integer
    Dim strBuf As String
    Dim o As Object
    
    Dim lngAllCount As Long
    Dim lngBlankCount As Long
    Dim lngCodeCount As Long
    Dim lngCommentCount As Long
    Dim WB As Workbook
    
    On Error GoTo ErrHandle
    
    Dim lngCnt As Long
    
    If cboSrcBook.ListIndex = -1 Then
        MsgBox "VBA�v���W�F�N�g�̂���u�b�N������͂��Ă��������B", vbOKOnly + vbExclamation, C_TITLE
        Exit Sub
    End If
        
    Application.ScreenUpdating = False
        
    Set Target = Workbooks(cboSrcBook.Text)
    
    Set WB = Workbooks.Add
    
    lngCnt = 2
    WB.Worksheets(1).Cells(lngCnt, C_NO).value = "No."
    WB.Worksheets(1).Cells(lngCnt, C_MODULE).value = "�I�u�W�F�N�g"
    WB.Worksheets(1).Cells(lngCnt, C_TYPE).value = "���"
    WB.Worksheets(1).Cells(lngCnt, C_CODE).value = "���s"
    WB.Worksheets(1).Cells(lngCnt, C_COMMENT).value = "����"
    WB.Worksheets(1).Cells(lngCnt, C_BLANK).value = "��"
    WB.Worksheets(1).Cells(lngCnt, C_ALL).value = "�S�s"
    lngCnt = 3
    
    For Each o In Target.VBProject.VBComponents
    
        lngAllCount = 0
        lngBlankCount = 0
        lngCodeCount = 0
        lngCommentCount = 0
        
        WB.Worksheets(1).Cells(lngCnt, C_MODULE).value = o.Name
        
        Select Case o.Type
            Case 1
                WB.Worksheets(1).Cells(lngCnt, C_TYPE).value = "�W�����W���[��"
                WB.Worksheets(1).Cells(lngCnt, C_SORT).value = 4
            Case 2
                WB.Worksheets(1).Cells(lngCnt, C_TYPE).value = "�N���X���W���[��"
                WB.Worksheets(1).Cells(lngCnt, C_SORT).value = 5
            Case 3
                WB.Worksheets(1).Cells(lngCnt, C_TYPE).value = "�t�H�[��"
                WB.Worksheets(1).Cells(lngCnt, C_SORT).value = 3
            Case Else
                If o.Name = "ThisWorkbook" Then
                    WB.Worksheets(1).Cells(lngCnt, C_TYPE).value = "Excel Objects"
                    WB.Worksheets(1).Cells(lngCnt, C_SORT).value = 2
                Else
                    WB.Worksheets(1).Cells(lngCnt, C_TYPE).value = "Excel Objects"
                    WB.Worksheets(1).Cells(lngCnt, C_SORT).value = 1
                End If
        End Select
        
        With o.CodeModule
    
            For i = 1 To .CountOfLines
            
                strBuf = .Lines(i, 1)
            
                If Left(Trim(strBuf), 1) = "'" Then
                    lngCommentCount = lngCommentCount + 1
                End If
                
                If Len(Trim(strBuf)) = 0 Then
                    lngBlankCount = lngBlankCount + 1
                End If
                
                lngAllCount = lngAllCount + 1
            
            Next i
        
        End With

        lngCodeCount = lngAllCount - lngCommentCount - lngBlankCount
        
        WB.Worksheets(1).Cells(lngCnt, C_NO).value = lngCnt - 2
        WB.Worksheets(1).Cells(lngCnt, C_CODE).value = lngCodeCount
        WB.Worksheets(1).Cells(lngCnt, C_COMMENT).value = lngCommentCount
        WB.Worksheets(1).Cells(lngCnt, C_BLANK).value = lngBlankCount
        WB.Worksheets(1).Cells(lngCnt, C_ALL).value = lngAllCount
        
        lngCnt = lngCnt + 1
    
    Next
    
    WB.Worksheets(1).Columns("A:G").EntireColumn.AutoFit
    
    WB.Worksheets(1).Sort.SortFields.Clear
    WB.Worksheets(1).Sort.SortFields.Add KEY:=Range(WB.Worksheets(1).Cells(2, C_SORT), WB.Worksheets(1).Cells(lngCnt, C_SORT)), _
        SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
    WB.Worksheets(1).Sort.SortFields.Add KEY:=Range(WB.Worksheets(1).Cells(2, C_MODULE), WB.Worksheets(1).Cells(lngCnt, C_MODULE)), _
        SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
    With WB.Worksheets(1).Sort
        .SetRange Range(WB.Worksheets(1).Cells(2, C_MODULE), WB.Worksheets(1).Cells(lngCnt, C_SORT))
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    
    WB.Worksheets(1).Columns("H:H").ClearContents
    WB.Worksheets(1).Range("A2").CurrentRegion.Select
    execSelectionRowDrawGrid
    
    WB.Worksheets(1).Cells(1, C_NO).value = Target.Name & " �X�e�b�v�J�E���g"
    WB.Worksheets(1).Cells(lngCnt, C_TYPE).value = "���v"
    WB.Worksheets(1).Cells(lngCnt, C_CODE).Formula = "=sum(D3:D" & lngCnt - 1 & ")"
    WB.Worksheets(1).Cells(lngCnt, C_COMMENT).Formula = "=sum(E3:E" & lngCnt - 1 & ")"
    WB.Worksheets(1).Cells(lngCnt, C_BLANK).Formula = "=sum(F3:F" & lngCnt - 1 & ")"
    WB.Worksheets(1).Cells(lngCnt, C_ALL).Formula = "=sum(G3:G" & lngCnt - 1 & ")"
    Unload Me
    
    Application.ScreenUpdating = True
    
    Exit Sub
ErrHandle:
    Application.ScreenUpdating = True
    MsgBox "�G���[���������܂����B", vbOKOnly, C_TITLE
End Sub


