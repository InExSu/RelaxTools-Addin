Attribute VB_Name = "basRibbon"
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
Option Private Module

Private Const C_START_ROW As Long = 25 '13
Private Const C_COL_NO As Long = 1
Private Const C_COL_CATEGORY As Long = 2
Private Const C_COL_MACRO As Long = 3
Private Const C_COL_LABEL As Long = 4
Private Const C_COL_DIVISION As Long = 5
Private Const C_COL_HELP As Long = 6
Private Const C_COL_DESCRIPTION As Long = 7

Private Const C_COLOR_OTHER As String = "99"

Private mIR As IRibbonUI

Private mSecTog01 As Boolean
Private mSecTog02 As Boolean
Private mSecTog03 As Boolean
Private mSecTog04 As Boolean
Private mSecTog05 As Boolean
Private mSecTog06 As Boolean

'�`�P�ۑ��̃p�u���b�N�ϐ�
Public pblnA1SaveCheck As Boolean

Public mLineEnable As Boolean
Public mScrollEnable As Boolean
Public mScreenEnable As Boolean

'--------------------------------------------------------------------
' �}�N�����擾
'--------------------------------------------------------------------
Private Function getMacroName(control As IRibbonControl) As String
    
    Dim lngPos As Long
    
    '�����}�N���𕡐��o�^�\�Ƃ��邽�߂Ƀh�b�g�ȍ~�̕������폜
    lngPos = InStr(control.id, ".")

    If lngPos = 0 Then
        getMacroName = control.id
    Else
        getMacroName = Mid$(control.id, 1, lngPos - 1)
    End If

End Function
'--------------------------------------------------------------------
' �V�[�g����w�荀�ڂ��擾����
'--------------------------------------------------------------------
Private Function getSheetItem(control As IRibbonControl, lngItem As Long) As String

    Dim lngPos As Long
    Dim strBuf As String
    Dim i As Long
    
    getSheetItem = ""
    
    strBuf = getMacroName(control)
    
    i = C_START_ROW
    
    Do Until ThisWorkbook.Worksheets("HELP").Cells(i, C_COL_NO).value = ""
        If strBuf = ThisWorkbook.Worksheets("HELP").Cells(i, C_COL_MACRO).value Then
            getSheetItem = ThisWorkbook.Worksheets("HELP").Cells(i, lngItem).value
            Exit Do
        End If
        i = i + 1
    Loop

End Function
'--------------------------------------------------------------------
' ���{���\���ݒ�擾
'--------------------------------------------------------------------
Sub tabGetVisible(control As IRibbonControl, ByRef visible)

    visible = GetSetting(C_TITLE, "Ribbon", Replace(control.id, "Tab", ""), True)

End Sub
'--------------------------------------------------------------------
' ���{��������Ԏ擾
'--------------------------------------------------------------------
Sub tabGetPressed(control As IRibbonControl, ByRef returnValue)
    
    returnValue = GetSetting(C_TITLE, "Ribbon", control.id, True)

End Sub
'--------------------------------------------------------------------
' ���{���\���ݒ�
'--------------------------------------------------------------------
Sub tabOnAction(control As IRibbonControl, pressed As Boolean)
    
    SaveSetting C_TITLE, "Ribbon", control.id, pressed
    
    Call RefreshRibbon
    
End Sub
'--------------------------------------------------------------------
'���{�����󂯎����ID�����̂܂܃}�N�����Ƃ��Ď��s���郉�b�p�[�֐�
'--------------------------------------------------------------------
Public Sub RibbonOnAction(control As IRibbonControl)

    Dim lngPos As Long
    Dim strBuf As String
    
    On Error GoTo e
    
    strBuf = getMacroName(control)
    
    '�J�n���O
    Logger.LogBegin strBuf
    
    '������̃}�N���������s����B
    Application.Run strBuf
    
    
    Call RefreshRibbon(control)

    '�J��Ԃ����L���̏ꍇ
    If CBool(GetSetting(C_TITLE, "Option", "OnRepeat", True)) Then
        Dim strLabel As String
        strLabel = getSheetItem(control, C_COL_LABEL)
        Application.OnRepeat strLabel, strBuf
    End If
    
    '�I�����O
    Logger.LogFinish strBuf
    
    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
'�`�F�b�N�{�b�N�X�ݒ�擾
'--------------------------------------------------------------------
Public Sub CheckGetPressed(control As IRibbonControl, ByRef returnValue)
    
    On Error GoTo e
    
    returnValue = GetSetting(C_TITLE, "Backup", "Check", False)
    
    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
'�`�F�b�N�{�b�N�X�ݒ�
'--------------------------------------------------------------------
Public Sub CheckOnAction(control As IRibbonControl, pressed As Boolean)
    
    On Error GoTo e
    
    SaveSetting C_TITLE, "Backup", "Check", pressed
    
    Call RefreshRibbon(control)
        
    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
'�`�F�b�N�{�b�N�XEnable/Disable
'--------------------------------------------------------------------
Sub CheckSetEnabled(control As IRibbonControl, ByRef enabled)

    On Error GoTo e
    
    If Val(Application.Version) > C_EXCEL_VERSION_2007 Then
        
'        enabled = CBool(GetSetting(C_TITLE, "Backup", "Check", False))
        enabled = True
        
    Else
        enabled = False
    End If

    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
' �w���v���e��\������BcustomUI����g�p
'--------------------------------------------------------------------
Public Sub GetSupertip(control As IRibbonControl, ByRef Screentip)

    On Error GoTo e
    
    Screentip = getSheetItem(control, C_COL_HELP)

    Call RefreshRibbon

    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
' ���j���[�\�����e��\������BcustomUI����g�p
'--------------------------------------------------------------------
Public Sub GetDescription(control As IRibbonControl, ByRef Screentip)

    On Error GoTo e
    
    Screentip = getSheetItem(control, C_COL_DESCRIPTION)

    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
' ���x����\������BcustomUI����g�p
'--------------------------------------------------------------------
Public Sub GetLabel(control As IRibbonControl, ByRef Screentip)

    On Error GoTo e
    
    Screentip = getSheetItem(control, C_COL_LABEL)
    
    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
' 2003�݊��F�@�w�i�F����
'--------------------------------------------------------------------
Sub legacyBackDefault()

    On Error Resume Next
    
    SaveSetting C_TITLE, "Color2003", "back", C_COLOR_OTHER
    execSelectionFormatBackColor

    Call RefreshRibbon

End Sub
'--------------------------------------------------------------------
' 2003�݊��F�@�����F����
'--------------------------------------------------------------------
Sub legacyFontDefault()

    On Error Resume Next
    
    SaveSetting C_TITLE, "Color2003", "font", C_COLOR_OTHER
    execSelectionFormatFontColor
    Call RefreshRibbon

End Sub
'--------------------------------------------------------------------
' 2003�݊��F�@���F����
'--------------------------------------------------------------------
Sub legacyLineDefault()

    On Error Resume Next
    
    SaveSetting C_TITLE, "Color2003", "line", C_COLOR_OTHER
    execSelectionFormatLineColor

    Call RefreshRibbon
    
End Sub
'--------------------------------------------------------------------
' 2003�݊��F�I�����C�x���g
'--------------------------------------------------------------------
Public Sub colorOnAction(control As IRibbonControl, selectedId As String, selectedIndex As Integer)

    On Error Resume Next
    Dim strBuf As String

    Select Case control.id
        Case "fontColorGallery"
            SaveSetting C_TITLE, "Color2003", "font", Right(selectedId, 2)
            strBuf = "execSelectionFormatFontColor"
        Case "backColorGallery"
            SaveSetting C_TITLE, "Color2003", "back", Right(selectedId, 2)
            strBuf = "execSelectionFormatBackColor"
        Case "lineColorGallery"
            SaveSetting C_TITLE, "Color2003", "line", Right(selectedId, 2)
            strBuf = "execSelectionFormatLineColor"
    End Select
    
    '�J�n���O
    Logger.LogBegin strBuf
    
    '������̃}�N���������s����B
    Application.Run strBuf
    
    Call RefreshRibbon(control)

    '�J��Ԃ����L���̏ꍇ
    If CBool(GetSetting(C_TITLE, "Option", "OnRepeat", True)) Then
        Dim strLabel As String
        strLabel = getSheetItem(control, C_COL_LABEL)
        Application.OnRepeat strLabel, strBuf
    End If
    
    '�I�����O
    Logger.LogFinish strBuf
    
    Call RefreshRibbon

End Sub
'--------------------------------------------------------------------
' Dynamic���j���[
'--------------------------------------------------------------------
Private Function ribbonDinamicMenu(control As IRibbonControl, ByRef content)

'ByRef objApp As Object, ByRef WS As Worksheet
'<menu xmlns="http://schemas.microsoft.com/office/2006/01/customui">
'  <button id="dynaButton" label="Button"
'    onAction="OnAction" imageMso="FoxPro"/>
'  <toggleButton id="dynaToggleButton" label="Toggle Button"
'    onAction="OnToggleAction" image="logo.bmp"/>
'  <menuSeparator id="div2"/>
'  <dynamicMenu id="subMenu" label="Sub Menu" getContent="GetSubContent" />
'</menu>


    'On Error Resume Next

    Dim WS As Worksheet

    Dim strNo As String
    Dim strMenu As String
    Dim strSubMenu As String
    Dim strMacro As String
    Dim strBikou As String
    Dim lngRow As Long
    
    Dim blnBeginGroup As Boolean
    Dim blnBeginGroupSub As Boolean
    Dim blnBeginSubMenu As Boolean
    
    Dim blnFirst As Boolean
    
    Dim strXML As String
    Dim lngNo As Long
    
    '�R���g���[��ID���烁�j���[�����擾
    Set WS = ThisWorkbook.Worksheets(control.id)
    
    
    Const C_START_ROW As Long = 3
    Const C_COL_NO As Long = 1
    Const C_COL_MENU As Long = 2
    Const C_COL_SUB_MENU As Long = 3
    Const C_COL_MACRO As Long = 4
    Const C_COL_BIKOU As Long = 5

    blnBeginGroup = False
    blnBeginSubMenu = False
    
    strXML = "<menu xmlns=""http://schemas.microsoft.com/office/2006/01/customui"">" & vbCrLf
    lngNo = 1
    lngRow = C_START_ROW
    strNo = WS.Cells(lngRow, C_COL_NO)
    Do Until strNo = ""
    
        '���j���[��
        strMenu = WS.Cells(lngRow, C_COL_MENU)
        
        '�T�u���j���[��
        strSubMenu = WS.Cells(lngRow, C_COL_SUB_MENU)
            
        '�}�N����
        strMacro = WS.Cells(lngRow, C_COL_MACRO)
        
        '���l
        strBikou = WS.Cells(lngRow, C_COL_BIKOU)
        
        Select Case strMenu
            Case ""
                '���j���[����̏ꍇ�ȑO�쐬�������j���[�̉�
            Case "-"
                '����쐬���郁�j���[�̑O�ɃZ�p���[�^���쐬
                blnBeginGroup = True
            Case Else
                If blnBeginSubMenu Then
                    strXML = strXML & "  </menu>" & vbCrLf
                    blnBeginSubMenu = False
                End If
                If strSubMenu <> "" Then
                    strXML = strXML & "  <menu id=""menu" & lngNo & """ label=""" & rlxHtmlSanitizing(strMenu) & """ >" & vbCrLf
                    lngNo = lngNo + 1
                    blnBeginSubMenu = True
                Else

                    If blnBeginGroup Then
                        strXML = strXML & "  <menuSeparator id=""div" & lngNo & """/>" & vbCrLf
                        lngNo = lngNo + 1
                    End If
                    
                    If strBikou = "" Then
                        strXML = strXML & "  <button id=""" & strMacro & """ label=""" & rlxHtmlSanitizing(strMenu) & """ onAction=""ribbonOnAction""/>" & vbCrLf
                    Else
                        strXML = strXML & "  <button id=""" & strMacro & """ label=""" & rlxHtmlSanitizing(strMenu) & """ onAction=""ribbonOnAction"" supertip=""" & strBikou & """/>" & vbCrLf
                    End If
                End If
                
                blnBeginGroup = False
        End Select
    
        Select Case strSubMenu
            Case ""
            Case "-"
                blnBeginGroupSub = True
            Case Else
                
                If blnBeginGroupSub Then
                    strXML = strXML & "    <menuSeparator id=""div" & lngNo & """/>" & vbCrLf
                    lngNo = lngNo + 1
                End If
            
                If strBikou = "" Then
                    strXML = strXML & "    <button id=""" & strMacro & """ label=""" & rlxHtmlSanitizing(strSubMenu) & """ onAction=""ribbonOnAction""/>" & vbCrLf
                Else
                    strXML = strXML & "    <button id=""" & strMacro & """ label=""" & rlxHtmlSanitizing(strSubMenu) & """ onAction=""ribbonOnAction"" supertip=""" & strBikou & """/>" & vbCrLf
                End If

                blnBeginGroupSub = False
        End Select
        
        lngRow = lngRow + 1
        strNo = WS.Cells(lngRow, C_COL_NO)
    Loop
    
    strXML = strXML & "</menu>" & vbCrLf
    
    Set WS = Nothing

    '�쐬����XML��߂�
    content = strXML

End Function
'--------------------------------------------------------------------
' ���{����Ԏ擾
'--------------------------------------------------------------------
Sub getRibbonEnabled(control As IRibbonControl, ByRef enabled)

    enabled = True
    
End Sub
'--------------------------------------------------------------------
' ���{�����[�h���C�x���g
'--------------------------------------------------------------------
Sub ribbonLoaded(ByRef IR As IRibbonUI)
    
    On Error GoTo e
    
    Set mIR = IR
    Call ThisWorkbook.setIRibbon(IR)
    
    '���{���n���h���̃A�h���X�����W�X�g���ɕۑ��A���s���G���[�̏ꍇ�ɕ�������B
    SaveSetting C_TITLE, "Ribbon", "Address", CStr(ObjPtr(IR))
        
    Dim strPos As String
    
    '�i���ԍ��̋K��̃{�^���������ς݂ɂ���
    strPos = GetSetting(C_TITLE, "Section", "pos", "1")
    Select Case strPos
        Case "1"
            mSecTog01 = True
        Case "2"
            mSecTog02 = True
        Case "3"
            mSecTog03 = True
        Case "4"
            mSecTog04 = True
        Case "5"
            mSecTog05 = True
        Case "6"
            mSecTog06 = True
    End Select
    
    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
' ���{���̃��t���b�V��
'--------------------------------------------------------------------
Public Sub RefreshRibbon(Optional control As IRibbonControl)

    Dim strBuf As String
    
    On Error GoTo e
    
    '�O���[�o���ϐ����N���A���ꂽ���܂����ꍇ�A���W�X�g�����畜�A
    If mIR Is Nothing Then
        
        strBuf = GetSetting(C_TITLE, "Ribbon", "Address", 0)
        Set mIR = getObjectFromAddres(strBuf)
        
    End If
    
    If mIR Is Nothing Then
    Else
        If control Is Nothing Then
            mIR.Invalidate
        Else
            mIR.InvalidateControl control.id
        End If
    End If

e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
'  �i���ԍ��g�O���{�^��
'--------------------------------------------------------------------
Sub sectionPressed(control As IRibbonControl, ByRef returnValue)
    
    On Error GoTo e
    
    Select Case control.id
        Case "sectionSetting01"
            returnValue = mSecTog01
    
        Case "sectionSetting02"
            returnValue = mSecTog02
    
        Case "sectionSetting03"
            returnValue = mSecTog03
    
        Case "sectionSetting04"
            returnValue = mSecTog04
    
        Case "sectionSetting05"
            returnValue = mSecTog05
    
        Case "sectionSetting06"
            returnValue = mSecTog06
    End Select
    
    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
'  ���݂̒i���ԍ��̐ݒ�
'--------------------------------------------------------------------
Sub sectionOnAction(control As IRibbonControl, pressed As Boolean)
  
    On Error GoTo e
    
    mSecTog01 = False
    mSecTog02 = False
    mSecTog03 = False
    mSecTog04 = False
    mSecTog05 = False
    mSecTog06 = False
  
    Select Case control.id
        Case "sectionSetting01"
            mSecTog01 = pressed
            Call SaveSetting(C_TITLE, "Section", "pos", "1")
            
        Case "sectionSetting02"
            mSecTog02 = pressed
            Call SaveSetting(C_TITLE, "Section", "pos", "2")
            
        Case "sectionSetting03"
            mSecTog03 = pressed
            Call SaveSetting(C_TITLE, "Section", "pos", "3")
            
        Case "sectionSetting04"
            mSecTog04 = pressed
            Call SaveSetting(C_TITLE, "Section", "pos", "4")
            
        Case "sectionSetting05"
            mSecTog05 = pressed
            Call SaveSetting(C_TITLE, "Section", "pos", "5")
            
        Case "sectionSetting06"
            mSecTog06 = pressed
            Call SaveSetting(C_TITLE, "Section", "pos", "6")
            
    End Select
  
    Call RefreshRibbon
    Set mColSection = rlxInitSectionSetting()
    
    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
'  �\���J�[�\���̉�����Ԃ̎擾
'--------------------------------------------------------------------
Sub linePressed(control As IRibbonControl, ByRef returnValue)
    
    returnValue = mLineEnable
    
End Sub
'--------------------------------------------------------------------
'  �\���J�[�\���̉������C�x���g
'--------------------------------------------------------------------
Sub lineOnAction(control As IRibbonControl, pressed As Boolean)
  
    On Error GoTo e
    
    mLineEnable = pressed
  
    Call RefreshRibbon

    If pressed Then
        ThisWorkbook.enableCrossLine
    Else
        ThisWorkbook.disableCrossLine
    End If

    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
'  �z�C�[����(��)�̉�����Ԏ擾
'--------------------------------------------------------------------
Sub scrollPressed(control As IRibbonControl, ByRef returnValue)
    
    returnValue = scrollPush
    
End Sub
'--------------------------------------------------------------------
'  �z�C�[����(��)�̉������C�x���g
'--------------------------------------------------------------------
Sub scrollOnAction(control As IRibbonControl, pressed As Boolean)

    On Error GoTo e

    mScrollEnable = pressed

    Call RefreshRibbon

    If pressed Then
        scrollLine1
    Else
        scrollLine3
    End If

    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
'  �X�N�V�����[�h�̉�����Ԏ擾
'--------------------------------------------------------------------
Sub screenPressed(control As IRibbonControl, ByRef returnValue)
    
    returnValue = mScreenEnable
    
End Sub
'--------------------------------------------------------------------
'  �X�N�V�����[�h�̉������C�x���g
'--------------------------------------------------------------------
Sub screenOnAction(control As IRibbonControl, pressed As Boolean)
  
    On Error GoTo e
    
    mScreenEnable = pressed
  
    Call RefreshRibbon

    If pressed Then
        frmScreenShot.Show
    Else
        Unload frmScreenShot
    End If

    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub

'--------------------------------------------------------------------
'  ���{���T�C�Y�擾(������)
'--------------------------------------------------------------------
 Sub GetSize(control As IRibbonControl, ByRef Size)
 
    If Application.UsableWidth / 0.75 < 1420 Then
    
        Size = RibbonControlSize.RibbonControlSizeRegular
    Else
    
        Size = RibbonControlSize.RibbonControlSizeLarge
    End If
 
 End Sub
'--------------------------------------------------------------------
'  ���{���T�C�Y�擾(������)
'--------------------------------------------------------------------
Public Sub GetSizeLabel(control As IRibbonControl, ByRef lbl)

    If Application.UsableWidth / 0.75 < 1420 Then
        Select Case control.id
            Case "MitomePaste.1"
                lbl = "�F�߈�"
            Case "FilePaste.1"
                lbl = "�摜�w��"
            Case "bzGallery"
                lbl = "�r�W�l�X��"
        End Select
    Else
        Select Case control.id
            Case "MitomePaste.1"
                lbl = "�F�߈�" & vbCrLf
            Case "FilePaste.1"
                lbl = "�摜�w��" & vbCrLf
            Case "bzGallery"
                lbl = "�r�W�l�X��" & vbCrLf
        End Select
    End If
 
 End Sub
'--------------------------------------------------------------------
' �f�[�^��̐����擾
'--------------------------------------------------------------------
 Sub stampGetItemCount(control As IRibbonControl, ByRef count)

    '�ݒ���擾
    Dim col As Collection
    
    Set col = getProperty()

    count = col.count

End Sub
'--------------------------------------------------------------------
' �f�[�^���ID���擾
'--------------------------------------------------------------------
Sub stampGetItemId(control As IRibbonControl, Index As Integer, ByRef id)

    id = C_STAMP_FILE_NAME & Format$(Index + 1, "000")

End Sub
'--------------------------------------------------------------------
' �f�[�^��̃C���[�W���擾
'--------------------------------------------------------------------
Sub stampGetItemImage(control As IRibbonControl, Index As Integer, ByRef image)

    Set image = getImageStamp(Index + 1)
    
End Sub
'--------------------------------------------------------------------
' �f�[�^�󉟉����C�x���g
'--------------------------------------------------------------------
Public Sub stampOnAction(control As IRibbonControl, selectedId As String, selectedIndex As Integer)

    Call pasteStamp2(selectedIndex + 1)
    Call SaveSetting(C_TITLE, "Stamp", "stampNo", selectedIndex + 1)

End Sub
'--------------------------------------------------------------------
' �F��̐����擾
'--------------------------------------------------------------------
Sub stampMitomeGetItemCount(control As IRibbonControl, ByRef count)

    '�ݒ���擾
    Dim col As Collection
    
    Set col = getPropertyMitome()

    count = col.count

End Sub
'--------------------------------------------------------------------
' �F���ID���擾
'--------------------------------------------------------------------
Sub stampMitomeGetItemId(control As IRibbonControl, Index As Integer, ByRef id)

    id = C_STAMP_FILE_NAME & Format$(Index + 1, "000")

End Sub
'--------------------------------------------------------------------
' �F��C���[�W�擾
'--------------------------------------------------------------------
Sub stampMitomeGetItemImage(control As IRibbonControl, Index As Integer, ByRef image)
    
    Set image = getImageStampMitome(Index + 1)
    
End Sub
'--------------------------------------------------------------------
' �F�󉟉����C�x���g
'--------------------------------------------------------------------
Public Sub stampMitomeOnAction(control As IRibbonControl, selectedId As String, selectedIndex As Integer)

    Call MitomePaste2(selectedIndex + 1)
    Call SaveSetting(C_TITLE, "StampMitome", "stampNo", selectedIndex + 1)

End Sub
'--------------------------------------------------------------------
'�r�W�l�X��̐����擾
'--------------------------------------------------------------------
Sub stampBzGetItemCount(control As IRibbonControl, ByRef count)

    '�ݒ���擾
    Dim col As Collection
    
    Set col = getPropertyBz()

    count = col.count

End Sub
'--------------------------------------------------------------------
' �r�W�l�X���ID���擾
'--------------------------------------------------------------------
Sub stampBzGetItemId(control As IRibbonControl, Index As Integer, ByRef id)

    id = C_STAMP_FILE_NAME & Format$(Index + 1, "000")

End Sub
'--------------------------------------------------------------------
' �r�W�l�X��C���[�W�擾
'--------------------------------------------------------------------
Sub stampBzGetItemImage(control As IRibbonControl, Index As Integer, ByRef image)

     Set image = getImageStampBz(Index + 1)
    
End Sub
'--------------------------------------------------------------------
' �r�W�l�X�󉟉����C�x���g
'--------------------------------------------------------------------
Public Sub stampBzOnAction(control As IRibbonControl, selectedId As String, selectedIndex As Integer)

    Call pasteStampBz2(selectedIndex + 1)
    Call SaveSetting(C_TITLE, "StampBz", "stampNo", selectedIndex + 1)

End Sub

Sub GetItemSuperTip(control As IRibbonControl, Index As Integer, ByRef screen)

End Sub
'--------------------------------------------------------------------
'  �������̐����擾
'--------------------------------------------------------------------
Sub sakuraGetItemCount(control As IRibbonControl, ByRef count)

    count = 3

End Sub
'--------------------------------------------------------------------
'  ��������ID���擾
'--------------------------------------------------------------------
Sub sakuraGetItemId(control As IRibbonControl, Index As Integer, ByRef id)

    id = C_STAMP_FILE_NAME & Format$(Index + 1, "000")

End Sub
'--------------------------------------------------------------------
'  �������C���[�W�擾
'--------------------------------------------------------------------
Sub sakuraGetItemImage(control As IRibbonControl, Index As Integer, ByRef image)

    Set image = getImageSakura(control.id, Index + 1)
    
End Sub
'--------------------------------------------------------------------
'  ������󉟉����C�x���g
'--------------------------------------------------------------------
Public Sub sakuraOnAction(control As IRibbonControl, selectedId As String, selectedIndex As Integer)

    Call pasteSakura(control.id, selectedIndex + 1)

End Sub

'--------------------------------------------------------------------
'  �tⳂ̐����擾
'--------------------------------------------------------------------
Sub fusenGetItemCount(control As IRibbonControl, ByRef count)

    count = 5

End Sub
'--------------------------------------------------------------------
'  �tⳂ�ID���擾
'--------------------------------------------------------------------
Sub fusenGetItemId(control As IRibbonControl, Index As Integer, ByRef id)

    id = C_STAMP_FILE_NAME & Format$(Index + 1, "000")

End Sub
'--------------------------------------------------------------------
'  �tⳃC���[�W�擾
'--------------------------------------------------------------------
Sub fusenGetItemImage(control As IRibbonControl, Index As Integer, ByRef image)

    Set image = getImageFusen(control.id, Index + 1)
    
End Sub
'--------------------------------------------------------------------
'  �tⳉ������C�x���g
'--------------------------------------------------------------------
Public Sub fusenOnAction(control As IRibbonControl, selectedId As String, selectedIndex As Integer)

    Call pasteFusen(control.id, selectedIndex + 1)

End Sub
'--------------------------------------------------------------------
'  �X�N�V�����[�h�ݒ��Enabled/Disabled
'--------------------------------------------------------------------
Sub getScreenShotEnabled(control As IRibbonControl, ByRef enabled)

    On Error GoTo e
    
    enabled = Not (mScreenEnable)

    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
'  �\���J�[�\���ݒ��Enabled/Disabled
'--------------------------------------------------------------------
Sub getCrossEnabled(control As IRibbonControl, ByRef enabled)

    On Error GoTo e
    
    enabled = Not (mLineEnable)

    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
'--------------------------------------------------------------------
'  �z�C�[���ʐݒ��Enabled/Disabled
'--------------------------------------------------------------------
Sub getScrollEnabled(control As IRibbonControl, ByRef enabled)

    On Error GoTo e
    
    enabled = Not (mScrollEnable)

    Exit Sub
e:
    Call rlxErrMsg(err)
End Sub
