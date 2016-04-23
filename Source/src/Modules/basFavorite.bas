Attribute VB_Name = "basFavorite"
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

Public Const C_FAVORITE_ADD As Long = 1
Public Const C_FAVORITE_MOD As Long = 2
'Windows API�錾
#If VBA7 And Win64 Then
    Private Declare PtrSafe Function GetWindowLong Lib "user32" Alias "GetWindowLongPtrA" (ByVal hWnd As LongPtr, ByVal nIndex As Long) As LongPtr
    Private Declare PtrSafe Function SetWindowLong Lib "user32" Alias "SetWindowLongPtrA" (ByVal hWnd As LongPtr, ByVal nIndex As Long, ByVal dwNewLong As LongPtr) As LongPtr
    Private Declare PtrSafe Function GetActiveWindow Lib "user32" () As LongPtr
    Private Declare PtrSafe Function DrawMenuBar Lib "user32" (ByVal hWnd As LongPtr) As LongPtr
    Private Declare PtrSafe Function SetWindowPos Lib "user32" _
                                          (ByVal hWnd As LongPtr, _
                                           ByVal hWndInsertAfter As LongPtr, _
                                           ByVal X As Long, ByVal Y As Long, _
                                           ByVal cx As Long, ByVal cy As Long, _
                                           ByVal wFlags As Long) As Long
#Else
    Private Declare Function SetWindowPos Lib "user32" _
                                      (ByVal hWnd As Long, _
                                       ByVal hWndInsertAfter As Long, _
                                       ByVal X As Long, ByVal Y As Long, _
                                       ByVal cx As Long, ByVal cy As Long, _
                                       ByVal wFlags As Long) As Long
    Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long) As Long
    Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
    Private Declare Function GetActiveWindow Lib "user32" () As Long
    Private Declare Function DrawMenuBar Lib "user32" (ByVal hWnd As Long) As Long
#End If

Private Const HWND_TOPMOST As Long = -1
Private Const SWP_NOSIZE As Long = &H1&
Private Const SWP_NOMOVE As Long = &H2&
Private Const GWL_STYLE As Long = (-16)
Private Const WS_THICKFRAME As Long = &H40000
Private Const WS_SYSMENU = &H80000      '�ő剻�^�ŏ����^�����{�^���ȂǑS��
Private Const WS_MINIMIZEBOX = &H20000  '�ŏ����{�^��
Private Const WS_MAXIMIZEBOX = &H10000  '�ő剻�{�^��

'--------------------------------------------------------------
' �t�H�[�������T�C�Y�\�ɂ��邽�߂̐ݒ�
'--------------------------------------------------------------
Public Sub AllwaysOnTop()

#If VBA7 And Win64 Then
    Dim result As LongPtr
    Dim hWnd As LongPtr
    Dim Wnd_STYLE As LongPtr
#Else
    Dim result As Long
    Dim hWnd As Long
    Dim Wnd_STYLE As Long
#End If
 
    hWnd = GetActiveWindow()
'    Wnd_STYLE = GetWindowLong(hWnd, GWL_STYLE)
'    Wnd_STYLE = (Wnd_STYLE Or WS_THICKFRAME Or &H30000) - WS_MINIMIZEBOX
'
'    result = SetWindowLong(hWnd, GWL_STYLE, Wnd_STYLE)
'    result = DrawMenuBar(hWnd)
    Call SetWindowPos(hWnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE)
    
End Sub
'------------------------------------------------------------------------------------------------------------------------
' ���C�ɓ���ړ�
'------------------------------------------------------------------------------------------------------------------------
Public Sub moveList(ByVal lngMode As Long)
     Call frmFavorite.moveList(lngMode)
End Sub
'------------------------------------------------------------------------------------------------------------------------
' ���C�ɓ���ړ�
'------------------------------------------------------------------------------------------------------------------------
Public Sub moveListFirst(ByVal lngMode As Long)
     Call frmFavorite.moveListFirst(lngMode)
End Sub
'------------------------------------------------------------------------------------------------------------------------
' �J�e�S���ړ�
'------------------------------------------------------------------------------------------------------------------------
Public Sub moveListCategory(ByVal lngMode As Long)
     Call frmFavorite.moveListCategory(lngMode)
End Sub
'------------------------------------------------------------------------------------------------------------------------
' �J�e�S���ړ�(�擪)
'------------------------------------------------------------------------------------------------------------------------
Public Sub moveListCategoryFirst(ByVal lngMode As Long)
     Call frmFavorite.moveListCategoryFirst(lngMode)
End Sub
'------------------------------------------------------------------------------------------------------------------------
' �J�e�S���ǉ�
'------------------------------------------------------------------------------------------------------------------------
Sub addCategory()
    Call frmFavorite.addCategory
End Sub
'------------------------------------------------------------------------------------------------------------------------
' �J�e�S���ύX
'------------------------------------------------------------------------------------------------------------------------
Sub modCategory()
    Call frmFavorite.modCategory
End Sub
'------------------------------------------------------------------------------------------------------------------------
' �J�e�S���폜
'------------------------------------------------------------------------------------------------------------------------
Sub delCategory()
    Call frmFavorite.delCategory
End Sub
'------------------------------------------------------------------------------------------------------------------------
' �J�e�S���̈ړ�
'------------------------------------------------------------------------------------------------------------------------
Sub moveCategory(ByVal strCategory As String)
    Call frmFavorite.moveCategory(strCategory)
End Sub
'------------------------------------------------------------------------------------------------------------------------
' ���C�ɓ�����J��
'------------------------------------------------------------------------------------------------------------------------
Sub execOpen(ByVal blnFlg As Boolean)
    Call frmFavorite.execOpen(blnFlg)
End Sub
'------------------------------------------------------------------------------------------------------------------------
' ���C�ɓ���̃t�@�C���̂���t�H���_���J��
'------------------------------------------------------------------------------------------------------------------------
Sub execOpenFolder()
    Call frmFavorite.execOpenFolder
End Sub
'------------------------------------------------------------------------------------------------------------------------
' ���C�ɓ���̕ҏW
'------------------------------------------------------------------------------------------------------------------------
Sub execEdit()
    Call frmFavorite.execEdit
End Sub
'------------------------------------------------------------------------------------------------------------------------
' �A�N�e�B�u�u�b�N�̒ǉ�
'------------------------------------------------------------------------------------------------------------------------
Sub execActiveAdd()
    Call frmFavorite.execActiveAdd
End Sub
'------------------------------------------------------------------------------------------------------------------------
' ���C�ɓ���ǉ�
'------------------------------------------------------------------------------------------------------------------------
Sub execAdd()
    Call frmFavorite.execAdd
End Sub
'------------------------------------------------------------------------------------------------------------------------
' ���C�ɓ���폜
'------------------------------------------------------------------------------------------------------------------------
Sub execDel()
    Call frmFavorite.execDel
End Sub
'------------------------------------------------------------------------------------------------------------------------
' ���C�ɓ���̓\��t��
'------------------------------------------------------------------------------------------------------------------------
Sub favPaste()
    Call frmFavorite.favPaste
End Sub
'------------------------------------------------------------------------------------------------------------------------
' ���C�ɓ���̏ڍו\��
'------------------------------------------------------------------------------------------------------------------------
Sub lstFavoriteDispDetail()
    Call frmFavorite.lstFavoriteDispDetail
End Sub
