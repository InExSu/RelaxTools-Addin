'-------------------------------------------------------------------------------
' �u�b�N����ύX���ĊJ���X�N���v�g
' 
' ExcelReadOnly.vbs
' 
' Copyright (c) 2018 Y.Watanabe
' 
' This software is released under the MIT License.
' http://opensource.org/licenses/mit-license.php
'-------------------------------------------------------------------------------
' ����m�F : Windows 7 + Excel 2016 / Windows 10 + Excel 2016
' �R�}���h���C��
'   /install   �F�C���X�g�[�����܂��B
'   /uninstall �F�A���C���X�g�[�����܂��B
'-------------------------------------------------------------------------------
Option Explicit

    Const C_TITLE = "RelaxTools-Addin"
    Const C_REF = "�i�Q�Ɨp�j"
    Dim strActBook
    Dim strTmpBook
    Dim strFile
    Dim FS, WB, XL, v, varExt, k

    Set FS = CreateObject("Scripting.FileSystemObject")

    For Each v In WScript.Arguments

        Select Case UCase(v)
            Case "/INSTALL"
                '�������g���Ǘ��Ҍ����Ŏ��s
                With CreateObject("Shell.Application")
                    .ShellExecute WScript.FullName, """" & WScript.ScriptFullName & """ /RUNINSTALL", "", "runas"
                End With
                WScript.Quit

            Case "/UNINSTALL"
                '�������g���Ǘ��Ҍ����Ŏ��s
                With CreateObject("Shell.Application")
                    .ShellExecute WScript.FullName, """" & WScript.ScriptFullName & """ /RUNUNINSTALL", "", "runas"
                End With
                WScript.Quit
                
            Case "/RUNINSTALL"
                On Error Resume Next
                Err.Clear
                With WScript.CreateObject("WScript.Shell")
                    '�u�b�N����ύX���ĊJ��
                    varExt = Array("Excel.Sheet.8", "Excel.Sheet.12", "Excel.SheetMacroEnabled.12")
                    For Each k In varExt
                       .RegWrite "HKCR\" & k & "\shell\rlxAliasOpen\","�u�b�N����ύX���ĊJ��(&A)", "REG_SZ"
                       .RegWrite "HKCR\" & k & "\shell\rlxAliasOpen\command\","""" & CreateObject("Scripting.FileSystemObject").GetSpecialFolder(1) & "\wscript.exe"" """ & .SpecialFolders("AppData") & "\RelaxTools-Addin\rlxAliasOpen.vbs"" ""%1""", "REG_SZ"
                    Next            
                End With
                If Err.Number = 0 Then
                    MsgBox "���W�X�g�����X�V���܂����B", vbInformation + vbOkOnly, "�u�b�N����ύX���ĊJ��"
                Else
                    MsgBox "�G���[���������܂����B", vbCritical + vbOkOnly, "�u�b�N����ύX���ĊJ��"
                End IF                
            Case "/RUNUNINSTALL"
                On Error Resume Next
                Err.Clear
                With WScript.CreateObject("WScript.Shell")
                    '�u�b�N����ύX���ĊJ��
                    varExt = Array("Excel.Sheet.8", "Excel.Sheet.12", "Excel.SheetMacroEnabled.12")
                    For Each k In varExt
                       .RegDelete "HKCR\" & k & "\shell\rlxAliasOpen\command\"
                       .RegDelete "HKCR\" & k & "\shell\rlxAliasOpen\"
                    Next            
                End With
                'MsgBox "�A���C���X�g�[�����܂����B", vbInformation + vbOkOnly, "�u�b�N����ύX���ĊJ��"
                
            Case Else
                strActBook = v
                strTmpBook = rlxGetTempFolder() & C_REF & FS.GetBaseName(v) & "_" & replace(time,":","") & "." & FS.GetExtensionName(v)
                FS.CopyFile strActBook, strTmpBook
                Err.Clear
                On Error Resume Next
                Set XL = GetObject(,"Excel.Application")
                If Err.Number = 0 Then
                    Set WB = XL.Workbooks.Open(strTmpBook,,1)
                    WB.Activate
                Else
                    MsgBox "Excel���N�����Ă��Ȃ��Ǝ��s�ł��܂���B", vbInformation + vbOkOnly, C_TITLE 
                End If
        End Select
    Next
    
    Set FS = Nothing

'--------------------------------------------------------------
'�@�e���|�����t�H���_�擾
'--------------------------------------------------------------
Public Function rlxGetTempFolder() 

    On Error Resume Next
    
    Dim strFolder
    
    rlxGetTempFolder = ""
    
    With FS
    
        strFolder = rlxGetAppDataFolder & "Temp"
        
        If .FolderExists(strFolder) Then
        Else
            .createFolder strFolder
        End If
        
        rlxGetTempFolder = .BuildPath(strFolder, "\")
        
    End With
    

End Function

'--------------------------------------------------------------
'�@�A�v���P�[�V�����t�H���_�擾
'--------------------------------------------------------------
Function rlxGetAppDataFolder() 

    On Error Resume Next
    
    Dim strFolder
    
    rlxGetAppDataFolder = ""
    
    With FS
    
        strFolder = .BuildPath(CreateObject("Wscript.Shell").SpecialFolders("AppData"), C_TITLE)
        
        If .FolderExists(strFolder) Then
        Else
            .createFolder strFolder
        End If
        
        rlxGetAppDataFolder = .BuildPath(strFolder, "\")
        
    End With

End Function

