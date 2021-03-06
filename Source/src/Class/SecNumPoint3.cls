VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "SecNumPoint3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
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
Private Const C_SECTION_REGEXP As String = "^[-0-9]+[ ]"
Private Const C_SECTION_SEPARATER As String = " "
Private Const C_SECTION_NAME As String = "1, 1-1, 1-1-1 ･･･ ∞"
Private Const C_SECTION_CLASS As String = "SecNumPoint3"
Public Property Get Class() As String
    Class = C_SECTION_CLASS
End Property

Public Function SectionLevelName(ByVal lngLevel As Long) As String
    
    Dim strBuf As String
    Select Case lngLevel
        Case 1
            strBuf = " 1 ────"
        Case 2
            strBuf = " 1-1 ────"
        Case 3
            strBuf = " 1-1-1 ────"
        Case 4
            strBuf = " 1-1-1-1 ────"
        Case 5
            strBuf = " 1-1-1-1-1 ────"
        Case Else
            strBuf = " 1-1-1-1-1-1 ────"
    End Select
    
    SectionLevelName = strBuf

End Function
Public Property Get SectionName() As String
    SectionName = C_SECTION_NAME
End Property
Public Property Get SectionSeparator() As String
    SectionSeparator = C_SECTION_SEPARATER
End Property
Public Property Get SectionRegExp() As String
    SectionRegExp = C_SECTION_REGEXP
End Property
Public Property Get SectionNumber(ByVal v As String) As String

    Dim objRegx As Object
    Dim objMatch As Object
    
    Set objRegx = CreateObject("VBScript.RegExp")
        
    objRegx.Pattern = C_SECTION_REGEXP
    objRegx.IgnoreCase = False
    objRegx.Global = False

    Set objMatch = objRegx.Execute(v)
    
    If objMatch.Count > 0 Then
        SectionNumber = objMatch(0).Value
    Else
        SectionNumber = ""
    End If
    
    Set objMatch = Nothing
    Set objRegx = Nothing
    
End Property
Public Property Get NextNumber(ByVal v As String, ByVal lngFromLevel As Long, ByVal lngIndentLevel As Long) As String
       
    Dim i As Long
    Dim strNewNum As String
    Dim strNumber As String
    
    strNumber = Trim(SectionNumber(v))
    
    If strNumber = "" Then
        '番号が無い場合、レベルに応じた番号を生成する。
        For i = 0 To lngIndentLevel
            If strNewNum = "" Then
                strNewNum = "1"
            Else
                strNewNum = strNewNum & "-" & "1"
            End If
        Next
    Else
        '次の番号を付番する
        Dim num As Variant
        Dim lngNum As Long
        
        num = Split(strNumber, "-")

        For i = 0 To lngIndentLevel
        
            Select Case i
                Case Is > UBound(num)
                    lngNum = 1
                Case lngIndentLevel
                    lngNum = Val(num(i)) + 1
                Case Else
                    lngNum = Val(num(i))
            End Select
        
            If strNewNum = "" Then
                strNewNum = lngNum
            Else
                strNewNum = strNewNum & "-" & lngNum
            End If
        Next
    End If
    
    NextNumber = strNewNum & C_SECTION_SEPARATER

End Property



