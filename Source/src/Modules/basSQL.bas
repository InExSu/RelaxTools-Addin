Attribute VB_Name = "basSQL"
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

Const C_ROW_DATA As Long = 3
Const C_COL_NO As Long = 1
Const C_COL_COMMAND As Long = 2
Const C_COL_BEFORE_CRLF As Long = 3
Const C_COL_AFTER_CRLF As Long = 4
Const C_COL_FUNCTION As Long = 5
Const C_COL_RESERVED As Long = 6


Function rlxFormatSql(ByVal strSource As String) As String
Attribute rlxFormatSql.VB_Description = "���[�N�V�[�g�֐��Ƃ��Ďg�p�ł��܂���B"
Attribute rlxFormatSql.VB_ProcData.VB_Invoke_Func = " \n19"

    Dim strBuf As String
    Dim strJiku() As String
    Dim lngLen As Long
    Dim i As Long
    Dim j As Long
    Dim lngCnt As Long
    Dim strTango As String
    Dim strChar As String
    Dim strNextChar As String
    Dim strNextNChar As String
    Dim strBeforeChar As String
    Dim sw1 As Boolean
    Dim sw2 As Boolean
    Dim sw3 As Boolean
    
    On Error GoTo er
    
    '--------------------------------------------------
    ' ������
    '--------------------------------------------------
    strBuf = strSource
    lngLen = Len(strBuf)
    
    strTango = ""
    lngCnt = 0
    sw1 = False
    sw2 = False
    sw3 = False
    
    For i = 1 To lngLen
    
        '��
        strChar = Mid$(strBuf, i, 1)
        
        '�P��
        If i = lngLen Then
            strNextChar = ""
        Else
            strNextChar = Mid$(strBuf, i + 1, 1)
        End If
        
        '�Q��
        If i + 1 = lngLen Then
            strNextNChar = ""
        Else
            strNextNChar = Mid$(strBuf, i + 2, 1)
        End If
        
        '�P�O
        If i = 1 Then
            strBeforeChar = ""
        Else
            strBeforeChar = Mid$(strBuf, i - 1, 1)
        End If
        
        Select Case True
            Case sw1
                '�R�����g(/* �` */)�΍�
                Select Case True
                    Case strBeforeChar = "*" And strChar = "/"
                        setJiku strJiku(), lngCnt, strTango & strChar
                        strTango = ""
                        sw1 = False
                Case Else
                    strTango = strTango & strChar
                End Select
            Case sw2
                '�R�����g(--)�΍�
                Select Case True
                    Case strChar = vbCr Or strChar = vbLf Or strChar = vbCrLf
                        setJiku strJiku(), lngCnt, strTango
                        strTango = ""
                        sw2 = False
                Case Else
                    strTango = strTango & strChar
                End Select
            Case sw3
                '�R�[�e�[�V�������̋󔒑΍�
                Select Case True
                    Case strChar = "'"
                        setJiku strJiku(), lngCnt, strTango & strChar
                        strTango = ""
                        sw3 = False
                Case Else
                    strTango = strTango & strChar
                End Select
            Case Else
                Select Case True
                    Case strChar = "/" And strNextChar = "*"
                        setJiku strJiku(), lngCnt, strTango
                        strTango = ""
                        strTango = strTango & strChar
                        sw1 = True
                        
                    Case strChar = "-" And strNextChar = "-"
                        setJiku strJiku(), lngCnt, strTango
                        strTango = ""
                        strTango = strTango & strChar
                        sw2 = True
                        
                    Case strChar = "'"
                        setJiku strJiku(), lngCnt, strTango
                        strTango = ""
                        strTango = strTango & strChar
                        sw3 = True
                    
                    Case strChar = "(" And strNextChar = "+" And strNextNChar = ")"
                        setJiku strJiku(), lngCnt, strTango & "(+)"
                        strTango = ""
                        i = i + 2
                        
                    Case strChar = "<" And strNextChar = ">"
                        setJiku strJiku(), lngCnt, strTango
                        strTango = ""
                        setJiku strJiku(), lngCnt, "<>"
                        i = i + 1
                        
                    Case strChar = "!" And strNextChar = "="
                        setJiku strJiku(), lngCnt, strTango
                        strTango = ""
                        setJiku strJiku(), lngCnt, "!="
                        i = i + 1
                    
                    Case strChar = "^" And strNextChar = "="
                        setJiku strJiku(), lngCnt, strTango
                        strTango = ""
                        setJiku strJiku(), lngCnt, "^="
                        i = i + 1
                        
                    Case strChar = "<" And strNextChar = "="
                        setJiku strJiku(), lngCnt, strTango
                        strTango = ""
                        setJiku strJiku(), lngCnt, "<="
                        i = i + 1
                        
                    Case strChar = ">" And strNextChar = "="
                        setJiku strJiku(), lngCnt, strTango
                        strTango = ""
                        setJiku strJiku(), lngCnt, ">="
                        i = i + 1
                        
                    Case strChar = "|" And strNextChar = "|"
                        setJiku strJiku(), lngCnt, strTango
                        strTango = ""
                        setJiku strJiku(), lngCnt, "||"
                        i = i + 1
                    
                    Case strChar = "." And strNextChar = "*"
                        setJiku strJiku(), lngCnt, strTango & ".*"
                        strTango = ""
                        i = i + 1
                        
                    Case strChar = "(" Or strChar = ")" Or strChar = "," Or strChar = "<" Or strChar = ">" Or strChar = "=" Or strChar = "+" Or strChar = "*" Or strChar = "/" Or strChar = "-"
                        setJiku strJiku(), lngCnt, strTango
                        strTango = ""
                        setJiku strJiku(), lngCnt, strChar
                        
                    Case strChar = " " Or strChar = vbCr Or strChar = vbLf Or strChar = vbCrLf
                        setJiku strJiku(), lngCnt, strTango
                        strTango = ""
                    
                    Case Else
                        strTango = strTango & strChar
                End Select
        End Select
    Next

    setJiku strJiku(), lngCnt, strTango
    strTango = ""
    
    '--------------------------------------------------
    ' �\���������I�ɑ啶���ɕϊ�
    '--------------------------------------------------
    If GetSetting(C_TITLE, "FormatSql", "UpperCase", False) Then
        For i = 1 To UBound(strJiku)
            For j = C_COL_COMMAND To C_COL_RESERVED
                If existStr(UCase(strJiku(i)), j) Then
                    strJiku(i) = UCase(strJiku(i))
                End If
            Next
        Next
    End If
    '--------------------------------------------------
    ' �\�����
    '--------------------------------------------------
    Const C_NEST_SIZE As Long = 6
    
    '�ŏ���SQL�ƌ��݂�SQL����������
    Dim lngSqlFirst As Long
    Dim lngSqlNow As Long
    Const C_SQL_NONE As Long = 0
    Const C_SQL_SELECT As Long = 1
    Const C_SQL_UPDATE As Long = 2
    Const C_SQL_DELETE As Long = 3
    Const C_SQL_INSERT_OR_DDL As Long = 4
    
    '���s���[�h����
    Dim lngMode As Long
    Const C_MODE_SEARCH_COMMAND As Long = 1
    Const C_MODE_SEARCH_COMMA As Long = 2
    Const C_MODE_ADD_STR As Long = 4
    Const C_MODE_ADD_FIRST_STR As Long = 5
    Const C_MODE_FUNCTION As Long = 6
    Const C_MODE_ADD_BEFORE_CRLF As Long = 7
    Const C_MODE_ADD_AFTER_CRLF As Long = 8
    Const C_MODE_ADD_NEST As Long = 10
    Const C_MODE_DEL_NEST As Long = 11
    Const C_MODE_NEXT_CHAR As Long = 12
    Const C_MODE_ADD_COMMENT As Long = 13
    Const C_MODE_ADD_AFTER_COMMA_CRLF As Long = 14
    Const C_MODE_ADD_STR_NO_SP = 15
    Const C_MODE_ADD_BEFORE_COMMA_CRLF As Long = 16
    Const C_MODE_ADD_BEFORE_CRLF_CASE As Long = 17
    Const C_MODE_ADD_BEFORE_CRLF_END As Long = 18
    Const C_MODE_END As Long = 99
    Dim strResult As String
    Dim strBase As String

    Dim lngNest As Long
    Dim lngCurNest As Long
    
    strResult = ""
    lngMode = C_MODE_SEARCH_COMMAND
    i = 1
    lngNest = 0
    lngSqlFirst = C_SQL_NONE
    lngSqlNow = C_SQL_NONE

    Do While (True)

        Select Case lngMode
            Case C_MODE_SEARCH_COMMAND
            
                Select Case True
                    '�V�[�g�̃R�}���h������Ɉ�v
                    Case existStr(UCase(strJiku(i)), C_COL_COMMAND)
                    
                        '�ŏ��Ɉ�v����SQL�𔻒�
                        If lngSqlFirst = C_SQL_NONE Then
                            Select Case UCase(strJiku(i))
                                Case "SELECT"
                                    lngSqlFirst = C_SQL_SELECT
                                Case "DELETE"
                                    lngSqlFirst = C_SQL_DELETE
                                Case "UPDATE"
                                    lngSqlFirst = C_SQL_UPDATE
                                Case Else
                                    lngSqlFirst = C_SQL_INSERT_OR_DDL
                            End Select
                        End If
                        Select Case UCase(strJiku(i))
                            Case "SELECT"
                                lngSqlNow = C_SQL_SELECT
                            Case "DELETE"
                                lngSqlNow = C_SQL_DELETE
                            Case "UPDATE"
                                lngSqlNow = C_SQL_UPDATE
                            Case Else
                                lngSqlNow = C_SQL_INSERT_OR_DDL
                        End Select
                        
                        '�ŏ��̃N�G���[
                        If Len(strResult) = 0 Then
                            lngMode = C_MODE_ADD_FIRST_STR
                        Else
                            '�ʏ�̃T�u�N�G���[
                            If lngSqlNow = C_SQL_SELECT Then
                                If UCase(Right$(strResult, 1)) = "(" Then
                                    lngMode = C_MODE_ADD_STR
                                '���ʂ������ꍇ�iINSERT INTO �` SELECT �Ƃ� UNION ALL�̌�)
                                Else
                                    lngMode = C_MODE_ADD_BEFORE_CRLF
                                End If
                            Else
                                lngMode = C_MODE_ADD_STR
                            End If
                            
                        End If
                        
                    '�V�[�g�̑O���s������Ɉ�v
                    Case existStr(UCase(strJiku(i)), C_COL_BEFORE_CRLF)
                        'BETWEEN���݃`�F�b�N
                        If existBetween(strJiku(), i) Then
                            lngMode = C_MODE_ADD_STR
                        Else
                            lngMode = C_MODE_ADD_BEFORE_CRLF
                        End If
                        
                    '�V�[�g�̌���s������Ɉ�v
                    Case existStr(UCase(strJiku(i)), C_COL_AFTER_CRLF)
                        lngMode = C_MODE_ADD_AFTER_CRLF
                        
                    '�J���}
                    Case strJiku(i) = ","
                        If GetSetting(C_TITLE, "FormatSql", "RightComma", False) Then
                            lngMode = C_MODE_ADD_BEFORE_COMMA_CRLF
                        Else
                            lngMode = C_MODE_ADD_AFTER_COMMA_CRLF
                        End If
                        
                    '�R�����g
                    Case Left$(strJiku(i), 2) = "/*" Or Left$(strJiku(i), 2) = "--"
                        '�q���g��̏ꍇ�A���ʂ̗񈵂�
                        If Left$(strJiku(i), 3) = "/*+" Then
                            lngMode = C_MODE_ADD_AFTER_CRLF
                        Else
                            lngMode = C_MODE_ADD_COMMENT
                        End If
                    '������
                    Case strJiku(i) = "("
                        If i = 1 Then
                            lngMode = C_MODE_ADD_NEST
                        Else
                            If isFunction(strJiku(), i) Then
                                lngMode = C_MODE_FUNCTION
                            Else
                                lngMode = C_MODE_ADD_NEST
                            End If

                        End If
                    '�E����
                    Case strJiku(i) = ")"
                        lngMode = C_MODE_DEL_NEST
                    
                    'CASE��
                    Case UCase(strJiku(i)) = "CASE"
                        lngMode = C_MODE_ADD_STR

                    'CASE��
                    Case UCase(strJiku(i)) = "WHEN" Or UCase(strJiku(i)) = "THEN" Or UCase(strJiku(i)) = "ELSE"
                        If i = 1 Then
                            lngMode = C_MODE_ADD_STR
                        Else
                            If UCase(strJiku(i - 1)) = "CASE" Then
                                lngMode = C_MODE_ADD_STR
                            Else
                                lngMode = C_MODE_ADD_BEFORE_CRLF_CASE
                            End If
                        End If

                    'CASE���̍Ō�
                    Case UCase(strJiku(i)) = "END"
                        lngMode = C_MODE_ADD_BEFORE_CRLF_END
                    
                    '���̑�
                    Case Else
                        lngMode = C_MODE_ADD_STR
                        '�}�C�i�X����i�����Z���}�C�i�X���j
                        If isMinus(strJiku(), i) Then
                            lngMode = C_MODE_ADD_STR_NO_SP
                        End If
                        
                        '�擪���h�b�g�̏ꍇ
                        If Left$(strJiku(i), 1) = "." Then
                            lngMode = C_MODE_ADD_STR_NO_SP
                        End If
                        
                End Select
                
            Case C_MODE_ADD_FIRST_STR
                strResult = strResult & padStr(strJiku(i), C_NEST_SIZE)
                lngMode = C_MODE_NEXT_CHAR
                
            Case C_MODE_ADD_COMMENT
                strResult = strResult & strJiku(i) & vbCrLf
                lngMode = C_MODE_NEXT_CHAR
                
            Case C_MODE_ADD_STR
                strResult = strResult & " " & strJiku(i)
                lngMode = C_MODE_NEXT_CHAR
            
            Case C_MODE_ADD_STR_NO_SP
                strResult = strResult & strJiku(i)
                lngMode = C_MODE_NEXT_CHAR
                
            Case C_MODE_ADD_BEFORE_CRLF
                strResult = strResult & " " & vbCrLf & strBase & padStr(strJiku(i), C_NEST_SIZE)
                lngMode = C_MODE_NEXT_CHAR
                
            Case C_MODE_ADD_BEFORE_CRLF_CASE
                strResult = strResult & " " & vbCrLf & strBase & Space$(C_NEST_SIZE) & "     "
                lngMode = C_MODE_ADD_STR
                
            Case C_MODE_ADD_BEFORE_CRLF_END
                strResult = strResult & " " & vbCrLf & strBase & Space$(C_NEST_SIZE)
                lngMode = C_MODE_ADD_STR
                
            Case C_MODE_ADD_BEFORE_COMMA_CRLF
                If lngSqlNow = C_SQL_INSERT_OR_DDL Then
                    strResult = strResult & " " & vbCrLf & padStr(strJiku(i), C_NEST_SIZE)
                Else
                    strResult = strResult & " " & vbCrLf & strBase & padStr(strJiku(i), C_NEST_SIZE)
                End If
                lngMode = C_MODE_NEXT_CHAR
            
            Case C_MODE_ADD_AFTER_COMMA_CRLF
                If lngSqlNow = C_SQL_INSERT_OR_DDL Then
                    strResult = strResult & strJiku(i) & " " & vbCrLf & Space$(C_NEST_SIZE)
                Else
                    strResult = strResult & strJiku(i) & " " & vbCrLf & strBase & Space$(C_NEST_SIZE)
                End If
                lngMode = C_MODE_NEXT_CHAR
            
            Case C_MODE_ADD_AFTER_CRLF
                
                strResult = strResult & " " & strJiku(i) & " " & vbCrLf & strBase & Space$(C_NEST_SIZE)
                lngMode = C_MODE_NEXT_CHAR
                
            Case C_MODE_ADD_NEST
                strResult = strResult & " " & vbCrLf & strBase & padStr(strJiku(i), C_NEST_SIZE)
                lngNest = lngNest + 1
                strBase = Space$((C_NEST_SIZE + 1) * lngNest)
                lngMode = C_MODE_NEXT_CHAR
                
            Case C_MODE_DEL_NEST
                lngNest = lngNest - 1
                '���ʑΉ������l��
                If lngNest < 0 Then
                    lngNest = 0
                End If
                strBase = Space$((C_NEST_SIZE + 1) * lngNest)
                lngMode = C_MODE_ADD_BEFORE_CRLF
                
            Case C_MODE_NEXT_CHAR
                '���������ɐi�߂�
                i = i + 1
                If UBound(strJiku) < i Then
                    lngMode = C_MODE_END
                Else
                    lngMode = C_MODE_SEARCH_COMMAND
                End If
                
            Case C_MODE_FUNCTION
                '�֐�����
                Dim lngFuncNest As Long
                lngFuncNest = 0
                Do
                    Select Case UCase(strJiku(i))
                        Case "("
                            lngFuncNest = lngFuncNest + 1
                            '+-*/IN/WHEN/THEN/ELSE �Ȃ� �X�y�[�X���󂯂�
                            If Right$(strResult, 1) = "," Or Right$(strResult, 1) = "+" Or Right$(strResult, 1) = "-" Or Right$(strResult, 1) = "*" Or Right$(strResult, 1) = "/" Or UCase(Right$(strResult, 3)) = " IN" Or UCase(Right$(strResult, 4)) = "WHEN" Or UCase(Right$(strResult, 4)) = "THEN" Or UCase(Right$(strResult, 4)) = "ELSE" Then
                                strResult = strResult & " " & strJiku(i)
                            Else
                                strResult = strResult & strJiku(i)
                            End If
                        Case ")"
                            lngFuncNest = lngFuncNest - 1
                            strResult = strResult & strJiku(i)
                        Case ","
                            strResult = strResult & strJiku(i)
                        Case Else
                            If Right$(strResult, 1) = "(" Then
                                strResult = strResult & strJiku(i)
                            Else
                                '�}�C�i�X����i�����Z���}�C�i�X���j
                                If isMinus(strJiku(), i) Then
                                    strResult = strResult & strJiku(i)
                                Else
                                    strResult = strResult & " " & strJiku(i)
                                End If
                            End If
                    End Select
                    i = i + 1
                    If UBound(strJiku) < i Then
                        Exit Do
                    End If
                Loop Until lngFuncNest = 0
                If UBound(strJiku) < i Then
                    lngMode = C_MODE_END
                Else
                    lngMode = C_MODE_SEARCH_COMMAND
                End If
                
            Case C_MODE_END
                '�������I������
                If Len(strResult) > 0 Then
                    strResult = strResult & " "
                End If
                Exit Do
        End Select
    Loop
    
    rlxFormatSql = strResult

    Exit Function
er:

    rlxFormatSql = strSource

End Function
Private Sub setJiku(ByRef strJiku() As String, ByRef lngCnt As Long, ByVal strBuf As String)

    If Len(strBuf) = 0 Then
        Exit Sub
    End If
    lngCnt = lngCnt + 1
    ReDim Preserve strJiku(1 To lngCnt)
    strJiku(lngCnt) = strBuf

End Sub
Private Function padStr(ByVal strBuf As String, ByVal lngLen As Long) As String

    If lngLen < 0 Then
        Exit Function
    End If
    padStr = Right$(Space(lngLen) & strBuf, lngLen)

End Function
Private Function padStrL(ByVal strBuf As String, ByVal lngLen As Long) As String

    If lngLen < 0 Then
        Exit Function
    End If
    padStrL = Left$(strBuf & Space(lngLen), lngLen)

End Function 'EXCEL�\��蕶���������
Private Function existStr(ByVal strBuf As String, ByVal lngCol As Long) As Boolean

    Dim i As Long
    existStr = False

    i = C_ROW_DATA

    Do Until ThisWorkbook.Worksheets("SQL").Cells(i, lngCol).value = "" Or _
        UCase(strBuf) < ThisWorkbook.Worksheets("SQL").Cells(i, lngCol).value

        If UCase(strBuf) = ThisWorkbook.Worksheets("SQL").Cells(i, lngCol).value Then
            existStr = True
            Exit Function
        End If

        i = i + 1

    Loop

End Function
'Function�܂���IN��Ɣ��肳�ꂽ���ʂ̒���SELECT�������݂��邩�`�F�b�N
Private Function existFuncInSel(ByRef strJiku() As String, ByVal lngPos As Long) As Boolean

    Dim i As Long
    existFuncInSel = False
    
    Dim lngFuncNest As Long
    lngFuncNest = 0
    i = lngPos
    
    Do
        Select Case UCase(strJiku(i))
            Case "("
                lngFuncNest = lngFuncNest + 1
            Case ")"
                lngFuncNest = lngFuncNest - 1
            Case "SELECT" ', "CASE"
                existFuncInSel = True
                Exit Function
            Case Else
        End Select
        i = i + 1
        If UBound(strJiku) < i Then
            Exit Do
        End If
    Loop Until lngFuncNest = 0

End Function
'AND �̂Q�p���O���t�O��BETWEEN�����݂��邩�`�F�b�N
Private Function existBetween(ByRef strJiku() As String, ByVal lngPos As Long) As Boolean

    Dim i As Long
    existBetween = False
    
    Dim lngFuncNest As Long
    
    If UCase(strJiku(lngPos)) <> "AND" Then
        existBetween = False
        Exit Function
    End If
    
    lngFuncNest = 0
    
    i = lngPos - 1
    If 1 > i Then
        Exit Function
    End If
    
    '1�p���O���t��΂�
    Do
        Select Case UCase(strJiku(i))
            Case ")"
                lngFuncNest = lngFuncNest + 1
            Case "("
                lngFuncNest = lngFuncNest - 1
            Case Else
        End Select
        i = i - 1
        If 1 > i Then
            Exit Function
        End If
    Loop Until lngFuncNest = 0
    
    '�֐����������ꍇ�A����ɑO�̃p���O���t�𒲍�
    Dim j As Long
    
    j = i
    If existStr(strJiku(i), C_COL_FUNCTION) Then
        If i <> 1 Then
            j = i - 1
        End If
    End If

    If UCase(strJiku(j)) = "BETWEEN" Then
        existBetween = True
    Else
        existBetween = False
    End If

End Function
'�����񒆂́u�|�v�������Z���}�C�i�X���Z���𔻒肷��B
Private Function isMinus(ByRef strJiku() As String, ByVal i As Long) As Boolean

    isMinus = False
    
    If i <= 2 Then
        Exit Function
    End If

    '�}�C�i�X����i�����Z���}�C�i�X���j
    If strJiku(i - 1) = "-" Then
        '�n�C�t���̑O�����Z�q���r���Z�q���ł���΃}�C�i�X
        Select Case strJiku(i - 2)
            Case "+", "-", "*", "/", "(", ",", "<", ">", "=", "<=", ">=", "^=", "!=", "<>"
                isMinus = True
                Exit Function
        End Select
    End If

End Function

Private Function isFunction(ByRef strJiku() As String, ByVal i As Long) As Long

    Dim result As Boolean
    Dim lngComma As Long
    Dim lngOther As Long
    Dim lngNest As Long
    Dim j As Long
    
    lngComma = 0
    lngOther = 0
    lngNest = 0
    result = False
    
    For j = i To UBound(strJiku())
    
        Select Case strJiku(j)
            Case "("
                lngNest = lngNest + 1
            Case ")"
                lngNest = lngNest - 1
                If lngNest <= 0 Then
                    Exit For
                End If
            Case ","
                If lngNest = 1 Then
                    lngComma = lngComma + 1
                End If
            Case Else
                If lngNest = 1 Then
                    lngOther = lngOther + 1
                End If
        End Select
    Next

    '()�̏ꍇ
    If lngOther = 0 And lngComma = 0 Then
        isFunction = True
        Exit Function
    End If
    
    '�Z���e���X���P�����̏ꍇ
    If lngOther = 1 And lngComma = 0 Then
        isFunction = True
        Exit Function
    End If

    '�Z���e���X���J���}��؂�̏ꍇ
    If lngOther - 1 = lngComma Then
        isFunction = True
        Exit Function
    End If

    If existStr(strJiku(i - 1), C_COL_FUNCTION) Then
        If existFuncInSel(strJiku(), i) Then
            isFunction = False
        Else
            isFunction = True
        End If
    Else
        isFunction = False
    End If

    isFunction = result

End Function

