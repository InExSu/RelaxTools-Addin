Attribute VB_Name = "basShowForm"
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

'--------------------------------------------------------------
'�@�Z���̊ȈՕҏW
'--------------------------------------------------------------
Sub cellEdit()

    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    If Selection.CountLarge > 1 And Selection.CountLarge <> Selection(1, 1).MergeArea.count Then
        MsgBox "�����Z���I������Ă��܂��B�Z���͂P�̂ݑI�����Ă��������B", vbExclamation + vbOKOnly, C_TITLE
        Exit Sub
    End If
    
    frmEdit.Show
    
End Sub
'--------------------------------------------------------------
'�@�Z���̊ȈՕҏW
'--------------------------------------------------------------
Sub cellSearch()

    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    frmSearchEx.txtSearch.Text = Replace(Replace(ActiveCell.value, vbCrLf, "\n"), vbCr, "\n")
    frmSearchEx.txtSearch.SelStart = 0
    
    frmSearchEx.Show
    
    
End Sub
'--------------------------------------------------------------
'�@�u��
'--------------------------------------------------------------
Sub replaceEx()

    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    frmSearchEx.schTab.value = 1
    
    frmSearchEx.Show
    
    
End Sub
'--------------------------------------------------------------
'�@SQL�́u���v���`�ݒ���
'--------------------------------------------------------------
Sub FormatSqlSetting()

    frmFormatSql.Show
    
End Sub

'--------------------------------------------------------------
'�@�o�b�N�A�b�v�ݒ���
'--------------------------------------------------------------
Sub backupSetting()

    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    frmBackupSetting.Show
    
End Sub
'--------------------------------------------------------------
'�@�g���������
'--------------------------------------------------------------
Sub searchEx()

    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    frmSearchEx.Show
    
End Sub

'--------------------------------------------------------------
'�@�V�[�g�Ǘ�
'--------------------------------------------------------------
Sub execSheetManager()

    If ActiveWorkbook Is Nothing Then
        Exit Sub
    End If

    frmSheetManager.Show

End Sub
'--------------------------------------------------------------
'�@JAVA�p�b�P�[�W�z�u
'--------------------------------------------------------------
Sub setJavaPackage()

    frmSetPackage.Show

End Sub
'--------------------------------------------------------------
'�@�c���[�ꗗ�쐬���
'--------------------------------------------------------------
Sub createLinkTreeIn()

    If ActiveCell Is Nothing Then
        Exit Sub
    End If
    
    frmTreeList.Show
    
End Sub
'--------------------------------------------------------------
'�@�o�[�W�����\��
'--------------------------------------------------------------
Sub dispVer()
    
    frmVersion.Show
    
End Sub

'--------------------------------------------------------------
'�@�J�[�\���ʒu�Ɏw�肳�ꂽ�t�H���_�̈ꗗ��}�����܂��B
'--------------------------------------------------------------
Sub createFileListIn()

    If ActiveCell Is Nothing Then
        Exit Sub
    End If
    
    frmFileList.Show vbModeless

End Sub
'--------------------------------------------------------------
'�@���񂽂�r��
'--------------------------------------------------------------
Sub kantanLine()

    If ActiveCell Is Nothing Then
        Exit Sub
    End If

    frmGridText.Show
    
End Sub
'--------------------------------------------------------------
'�@CSV�ǂݍ���
'--------------------------------------------------------------
Sub loadCSV()

    If ActiveCell Is Nothing Then
        Exit Sub
    End If
    
    frmLoadCSV.Show
    
End Sub
'--------------------------------------------------------------
'�@html���
'--------------------------------------------------------------
Sub convertHtml()

    frmHtml.Show vbModal
    
End Sub


'--------------------------------------------------------------
'�@�Z�������ݒ���
'--------------------------------------------------------------
Sub documentSetting()

    frmDoc.Show
    
End Sub
'--------------------------------------------------------------
'�@Excel�t�@�C����Grep
'--------------------------------------------------------------
Sub excelGrep()

    frmGrep.Show
    
End Sub
'--------------------------------------------------------------
'�@Excel�t�@�C���̃y�[�W���擾
'--------------------------------------------------------------
Sub excelPage()

    frmPageList.Show
    
End Sub
'--------------------------------------------------------------
'�@�t�@�C����MessageDigest�����߂�
'--------------------------------------------------------------
Sub getMessageDigest()

    frmMessageDigest.Show
    
End Sub
Sub reSelect()
    frmReSelect.Show
End Sub
Sub showFavorite()
    frmFavorite.Show
End Sub
'--------------------------------------------------------------
'�@���[�N�V�[�g�̔�r
'--------------------------------------------------------------
Sub compWorkSheets()

    frmComp.Show
    
End Sub
Sub cellEditExtSetting()
    frmEditEx.Show
End Sub
Sub A1SettingShow()
    frmA1Setting.Show
End Sub
Sub electoricSetting()
    frmElectoric.Show
End Sub
Sub hotkey()
    frmHotKey.Show
End Sub

Sub sectionSettingShow()
    frmSectionList.Show
End Sub
Sub crossSetting()
    Dim obj As Object
    lineOnAction obj, False
    frmCrossLine.Show
End Sub
Sub showBz()
    frmStampBz.Show
End Sub
Sub createFolderShow()
    frmCreateFolder.Show
End Sub
Sub VBAStepCountShow()
    frmStepCount.Show
End Sub
Sub execScreenShotSetting()
    frmScreenSetting.Show
End Sub
Sub execSourceExport()
    frmSourceExport.Show
End Sub
Sub execComboSetting()
    frmCombo.Show
End Sub
Sub execDelStyle()
    frmStyle.Show
End Sub
Sub execCopyScreenSetting()
    frmCopyScreen.Show
End Sub

Sub execOptionSetting()
    frmCommonOption.Show
End Sub
Sub scrollSetting()
    frmScroll.Show
End Sub
Sub convertTextile()
    frmRedmine.Show
End Sub
Sub convertMarkdown()
    frmMarkdown.Show
End Sub
Sub showGrammer()
    frmGrammer.Show
End Sub
Sub showInfo()
    frmInfo.Show
End Sub
