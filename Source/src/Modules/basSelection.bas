Attribute VB_Name = "basSelection"
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


Sub SelectionUndo()

    Selection.value = pvarSelectionBuffer

End Sub
'--------------------------------------------------------------
' �w��͈͑I��(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowSelect()
    
    Dim obj As SelectionRowSelect
    
    Set obj = New SelectionRowSelect
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' SQL���`(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionFormatSql()
    
    Dim obj As SelectionFormatSql
    
    Set obj = New SelectionFormatSql
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���̍Đݒ�(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToFormula()
    
    Dim obj As SelectionToFormula
    
    Set obj = New SelectionToFormula
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' ��̃}�[�W(SelectionRowFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowMergeCol()
    
    Dim obj As SelectionRowMergeCol
    
    Set obj = New SelectionRowMergeCol
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' INSERT������(SelectionRowFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowMakeSQLInsert()
    
    Dim obj As SelectionRowMakeSQLInsert
    
    Set obj = New SelectionRowMakeSQLInsert
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' CRLF�폜(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRemoveCrLf()
    
    Dim obj As SelectionRemoveCrLf
    
    Set obj = New SelectionRemoveCrLf
    
    obj.Run
    
    Set obj = Nothing
    
End Sub

'--------------------------------------------------------------
' �w��͈͑I��(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowSelectCell()
    
    Dim obj As SelectionRowSelectCell
    
    Set obj = New SelectionRowSelectCell
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' �w��͈̓V�t�g(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowShiftSelect()
    
    Dim obj As SelectionRowShiftSelect
    
    Set obj = New SelectionRowShiftSelect
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' �󔒏���(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionTrimCell()

    Dim obj As SelectionTrimCell
    
    Set obj = New SelectionTrimCell
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' ���w�蕶�����폜(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRemoveLeftString()
    
    Dim obj As SelectionRemoveLeftString
    
    Set obj = New SelectionRemoveLeftString
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' �w�蕶�����ȍ~�폜(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRemoveLeftToString()
    
    Dim obj As SelectionRemoveLeftToString
    
    Set obj = New SelectionRemoveLeftToString
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' �w�蕶���ȑO�~�폜(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRemoveRightToString()
    
    Dim obj As SelectionRemoveRightToString
    
    Set obj = New SelectionRemoveRightToString
    
    obj.Run
    
    Set obj = Nothing
    
End Sub '--------------------------------------------------------------
' �E�w�蕶�����폜(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRemoveRightString()

    Dim obj As SelectionRemoveRightString
    
    Set obj = New SelectionRemoveRightString
    
    obj.Run
    
    Set obj = Nothing
    

End Sub
'--------------------------------------------------------------
' �s�������ǉ�(SelectionAllFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionAllInsertHead()

    Dim obj As SelectionInsertHead
    
    Set obj = New SelectionInsertHead
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' �s�������ǉ�(SelectionAllFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionAllInsertBottom()

    Dim obj As SelectionInsertBottom
    
    Set obj = New SelectionInsertBottom
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' �s�������ǉ�(SelectionAllFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionAllInsertMiddle()

    Dim obj As SelectionInsertMiddle
    
    Set obj = New SelectionInsertMiddle
    
    obj.Run
    
    Set obj = Nothing
    
End Sub '--------------------------------------------------------------
' �����N���A(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionInitialize()

    Dim obj As SelectionInitialize
    
    Set obj = New SelectionInitialize
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' �������ϊ�(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToLower()

    Dim obj As SelectionToLower
    
    Set obj = New SelectionToLower
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �啶���ϊ�(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToUpper()

    Dim obj As SelectionToUpper
    
    Set obj = New SelectionToUpper
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���p�ϊ�(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToHankaku()

    Dim obj As SelectionToHankaku
    
    Set obj = New SelectionToHankaku
    
    obj.Run
    
    Set obj = Nothing


End Sub
'--------------------------------------------------------------
' �S�p�ϊ�(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToZenkaku()

    Dim obj As SelectionToZenkaku
    
    Set obj = New SelectionToZenkaku
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �S�p�Ђ炪�ȕϊ�(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToHiragana()

    Dim obj As SelectionToHiragana
    
    Set obj = New SelectionToHiragana
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �S�p�J�^�J�i�ϊ�(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToKatakana()

    Dim obj As SelectionToKatakana
    
    Set obj = New SelectionToKatakana
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �d�q�[�i�ϊ�(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToElectoric()

    Dim obj As SelectionToElectoric
    
    Set obj = New SelectionToElectoric
    
    obj.Run
    
    Set obj = Nothing

End Sub '--------------------------------------------------------------
' �P��̐擪�̂ݑ啶��(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToPropercase()
  
    Dim obj As SelectionToPropercase
    
    Set obj = New SelectionToPropercase
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' 8�P�^��������t�ɕϊ�(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToDate8()

    Dim obj As SelectionToDate8
    
    Set obj = New SelectionToDate8
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' 6�P�^����(YYMMDD)����t�ɕϊ�(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToDate6()

    Dim obj As SelectionToDate6
    
    Set obj = New SelectionToDate6
    
    obj.Run
    
    Set obj = Nothing


End Sub
'--------------------------------------------------------------
' 6�P�^����(MMDDYY)����t�ɕϊ�(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToDate6mdy()

    Dim obj As SelectionToDate6mdy
    
    Set obj = New SelectionToDate6mdy
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' 6�P�^����(DDMMYY)����t�ɕϊ�(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToDate6dmy()

    Dim obj As SelectionToDate6dmy
    
    Set obj = New SelectionToDate6dmy
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �I�����Ă��镶����Ńt�H���_�쐬(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCreateFolder()

    Dim obj As SelectionCreateFolder
    
    Set obj = New SelectionCreateFolder
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �t�@�C�����݂̂ɂ���(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRemovePath()

    Dim obj As SelectionRemovePath
    
    Set obj = New SelectionRemovePath
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �g���q���폜(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRemoveExt()

    Dim obj As SelectionRemoveExt
    
    Set obj = New SelectionRemoveExt
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �t�H���_���݂̂ɂ���(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRemoveFilename()

    Dim obj As SelectionRemoveFilename
    
    Set obj = New SelectionRemoveFilename
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �Z���̔w�i�F���q�f�a�Ŏ擾(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckCellColor()

    Dim obj As SelectionCheckCellColor
    
    Set obj = New SelectionCheckCellColor
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ��Ӄ`�F�b�N(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckUniq()

    Dim obj As SelectionCheckUniq
    
    Set obj = New SelectionCheckUniq
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ��Ӄ`�F�b�N�i�s�Ή��j(SelectionRowFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowCheckUniq()

    Dim obj As SelectionRowCheckUniq
    
    Set obj = New SelectionRowCheckUniq
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ��Ӄ`�F�b�N�i�͈́j(SelectionRowFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowCheckFromTo()

    Dim obj As SelectionRowCheckFromTo
    
    Set obj = New SelectionRowCheckFromTo
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �d���������ڂ��폜(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionSetUniq()
    
    Dim obj As SelectionSetUniq
    
    Set obj = New SelectionSetUniq
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �d���������ڂ��폜�s�Ή�(SelectionFrameWorkBox�g�p)
'--------------------------------------------------------------
Sub execSelectionRowSetUniq()
    
    Dim obj As SelectionRowSetUniq
    
    Set obj = New SelectionRowSetUniq
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' DB�t�B�[���h������JAVA��(get)(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToJavaStringGet()

    'Java�������
    Dim obj As SelectionToJavaString
    
    Set obj = New SelectionToJavaString
    
    obj.setType = "get"
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' DB�t�B�[���h������JAVA��(set)(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToJavaStringSet()

    'Java�������
    Dim obj As SelectionToJavaString
    
    Set obj = New SelectionToJavaString
    
    obj.setType = "set"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' DB�t�B�[���h������JAVA��(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToJavaString()

    'Java�������
    Dim obj As SelectionToJavaString
    
    Set obj = New SelectionToJavaString
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' DB�t�B�[���h������JAVA��(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToJavaStringU()

    'Java�������
    Dim obj As SelectionToJavaStringU
    
    Set obj = New SelectionToJavaStringU
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' JAVA������DB�t�B�[���h��(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToDBString()

    'Java�������
    Dim obj As SelectionToDBString
    
    Set obj = New SelectionToDBString
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���񂽂�\�i���ᎆ�p�j(SelectionRowFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowDrawGridHogan()

    Dim obj As SelectionRowDrawGrid
    
    Set obj = New SelectionRowDrawGrid
    obj.HeadColor = 16764057
    obj.EvenColor = -1
    obj.Custom = False
    
    obj.HoganMode = True
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���񂽂�\�i�V���v���j(SelectionRowFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowDrawGrid()

    Dim obj As SelectionRowDrawGrid
    
    Set obj = New SelectionRowDrawGrid
    obj.HeadColor = 16764057
    obj.EvenColor = -1
    obj.Custom = False
    
'    obj.HoganMode = True
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���񂽂�\�i�V���v���j�s�P��P(SelectionRowFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowDrawGrid1And1()

    Dim obj As SelectionRowDrawGrid

    Set obj = New SelectionRowDrawGrid
    obj.HeadColor = 16764057
    obj.EvenColor = -1
    obj.Custom = False

    obj.HeadLine = 1
    obj.ColLine = 1

'    obj.HoganMode = True

    obj.Run

    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���񂽂�\�i�W���E�w�b�_�Q�s�j(SelectionRowFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowDrawGrid2()

    Dim obj As SelectionRowDrawGrid
    
    Set obj = New SelectionRowDrawGrid
    obj.HeadColor = 16764057
    obj.EvenColor = -1
    obj.Custom = False
    obj.HeadLine = 2
    
'    obj.HoganMode = True
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���񂽂�\�i�W���E�w�b�_�R�s�j(SelectionRowFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowDrawGrid3()

    Dim obj As SelectionRowDrawGrid
    
    Set obj = New SelectionRowDrawGrid
    obj.HeadColor = 16764057
    obj.EvenColor = -1
    obj.Custom = False
    obj.HeadLine = 3
    
'    obj.HoganMode = True
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���񂽂�\�i���܂��܃u���[�j(SelectionRowFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowDrawGridBlue()

    Dim obj As SelectionRowDrawGrid
    
    Set obj = New SelectionRowDrawGrid
    
    obj.HeadColor = 16764057
    obj.EvenColor = 16777164
    obj.Custom = False
    
'    obj.HoganMode = True
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���񂽂�\�i���܂��܃x�[�W���j(SelectionRowFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowDrawGridBeige()

    Dim obj As SelectionRowDrawGrid
    
    Set obj = New SelectionRowDrawGrid
    
    obj.HeadColor = 10079487
    obj.EvenColor = 10092543
    obj.Custom = False
    
'    obj.HoganMode = True
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���񂽂�\�i�J�X�^���j(SelectionRowFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowDrawGridCustom()

    Dim obj As SelectionRowDrawGrid
    
    Set obj = New SelectionRowDrawGrid
    
    obj.HeadColor = 16764057
    obj.EvenColor = 16777164
    obj.Custom = True
    
'    obj.HoganMode = True
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �I���i��s�j(SelectionRowFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRowSelectOdd()

    Dim obj As SelectionRowSelectOdd
    
    Set obj = New SelectionRowSelectOdd
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �I���i���j(SelectionColFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionColSelectOdd()

    Dim obj As SelectionColSelectOdd
    
    Set obj = New SelectionColSelectOdd
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �n�C�p�[�����N�̍폜(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionRemoveHyperlink()

    Dim obj As SelectionRemoveHyperlink
    
    Set obj = New SelectionRemoveHyperlink
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �I�����Ă���Z���̐�(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckCount()

    Dim obj As SelectionCheckCount
    
    Set obj = New SelectionCheckCount
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �I�����Ă���Z���̕�����(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckSize()

    Dim obj As SelectionCheckSize
    
    Set obj = New SelectionCheckSize
    
    obj.CountType = SelectionCheckSizeConstants.CountTypeSJIS
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �I�����Ă���Z���̕�����(SelectionFrameWork�g�p)UTF8
'--------------------------------------------------------------
Sub execSelectionCheckSizeUTF8()

    Dim obj As SelectionCheckSize
    
    Set obj = New SelectionCheckSize
    
    obj.CountType = SelectionCheckSizeConstants.CountTypeUTF8
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �I��͈͂Œl�̂���Z����I��(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionSelectValueCell()

    Dim obj As SelectionSelectValueCell
    
    Set obj = New SelectionSelectValueCell
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �I��͈͂Œl�̂Ȃ��Z����I��(SelectionAllFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionAllSelectEmptyCell()

    Dim obj As SelectionAllSelectEmptyCell
    
    Set obj = New SelectionAllSelectEmptyCell
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �l�ōX�V(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToValue()

    Dim obj As SelectionToValue
    
    Set obj = New SelectionToValue
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �w���\�L�𕶎���ɕϊ�(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionStringFormura()

    Dim obj As SelectionStringFormura
    
    Set obj = New SelectionStringFormura
    
    obj.Run
    
    Set obj = Nothing

End Sub

'--------------------------------------------------------------
' �[������(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionStringZeroPadding()

    Dim obj As SelectionStringZeroPadding
    
    Set obj = New SelectionStringZeroPadding
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' Luhn�`�F�b�N(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckLuhn()

    Dim obj As SelectionCheckLuhn
    
    Set obj = New SelectionCheckLuhn
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���W�����X�P�O�`�F�b�N(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckModulus10()

    Dim obj As SelectionCheckModulus10
    
    Set obj = New SelectionCheckModulus10
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���W�����X�P�P�`�F�b�N(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckModulus11_10_2()

    Dim obj As SelectionCheckModulus11_10_2
    
    Set obj = New SelectionCheckModulus11_10_2
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���W�����X�P�P�`�F�b�N(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckModulus11_2_7()

    Dim obj As SelectionCheckModulus11_2_7
    
    Set obj = New SelectionCheckModulus11_2_7
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���W�����X�P�P�`�F�b�N(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckModulus11_Pref()

    Dim obj As SelectionCheckModulus11_Pref
    
    Set obj = New SelectionCheckModulus11_Pref
    
    obj.Run
    
    Set obj = Nothing

End Sub

'--------------------------------------------------------------
' �����`�F�b�N(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckNumber()

    Dim obj As SelectionCheckNumber
    
    Set obj = New SelectionCheckNumber
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �p���`�F�b�N(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckAlphabet()

    Dim obj As SelectionCheckAlphabet
    
    Set obj = New SelectionCheckAlphabet
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �p�����`�F�b�N(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckAlphaAndNum()

    Dim obj As SelectionCheckAlphaAndNum
    
    Set obj = New SelectionCheckAlphaAndNum
    
    obj.Run
    
    Set obj = Nothing

End Sub

'--------------------------------------------------------------
' ���l�Ó����`�F�b�N(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckNumeric()

    Dim obj As SelectionCheckNumeric
    
    Set obj = New SelectionCheckNumeric
    
    obj.Run
    
    Set obj = Nothing

End Sub

'--------------------------------------------------------------
' ���t�Ó����`�F�b�N(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckDate()

    Dim obj As SelectionCheckDate
    
    Set obj = New SelectionCheckDate
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���p�����񑶍݃`�F�b�N(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckAsc()

    Dim obj As SelectionCheckAsc
    
    Set obj = New SelectionCheckAsc
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �S�p�����񑶍݃`�F�b�N(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionCheckSJIS()

    Dim obj As SelectionCheckSJIS
    
    Set obj = New SelectionCheckSJIS
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �l�b�g���[�N�h���C�u��UNC(SelectionFrameWork�g�p)
'--------------------------------------------------------------
Sub execSelectionToUNC()

    Dim obj As SelectionToUNC
    
    Set obj = New SelectionToUNC
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �c�����Ƀ}�[�W
'--------------------------------------------------------------
Sub execSelectionColMerge()

    Dim obj As SelectionColMerge
    
    Set obj = New SelectionColMerge
    
    obj.Run
    
    Set obj = Nothing

End Sub

'--------------------------------------------------------------
' �Z���̍Ō�ɂP�s���s��t������B
'--------------------------------------------------------------
Sub execSelectionLineFeedInsert()

    Dim obj As SelectionLineFeedInsert
    
    Set obj = New SelectionLineFeedInsert
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �Z���̍Ō�ɂP�s���s���폜����B
'--------------------------------------------------------------
Sub execSelectionLineFeedDelete()

    Dim obj As SelectionLineFeedDelete
    
    Set obj = New SelectionLineFeedDelete
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �Z���Ƀn�C�t����ݒ肷��B
'--------------------------------------------------------------
Sub execSelectionInsertHyphen()

    Dim obj As SelectionInsertStrInCell
    
    Set obj = New SelectionInsertStrInCell
    
    obj.InsertStr = "-"
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �Z���Ƀn�C�t����ݒ肷��B
'--------------------------------------------------------------
Sub execSelectionInsertHyphenZen()

    Dim obj As SelectionInsertStrInCell
    
    Set obj = New SelectionInsertStrInCell
    
    obj.InsertStr = "�|"
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �i���ԍ���U��
'--------------------------------------------------------------
Sub execSelectionSectionNumber()

    Dim obj As SelectionSectionNumber
    
    Set obj = New SelectionSectionNumber
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �i���ԍ���U��(���C���f���g)
'--------------------------------------------------------------
Sub execSelectionSectionNumberIndentL()

    Dim obj As SelectionSectionNumber
    
    Set obj = New SelectionSectionNumber
    
    obj.Indent = -1
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �i���ԍ���U��(�E�C���f���g)
'--------------------------------------------------------------
Sub execSelectionSectionNumberIndentR()

    Dim obj As SelectionSectionNumber
    
    Set obj = New SelectionSectionNumber
    
    obj.Indent = 1
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �E�C���f���g
'--------------------------------------------------------------
Sub execSelectionAllIndentR()

    Dim obj As SelectionAllIndent
    
    Set obj = New SelectionAllIndent
    
    obj.Indent = 1
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���C���f���g
'--------------------------------------------------------------
Sub execSelectionAllIndentL()

    Dim obj As SelectionAllIndent
    
    Set obj = New SelectionAllIndent
    
    obj.Indent = -1
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���オ��r��
'--------------------------------------------------------------
Sub execSelectionAllDiagonalUp()

'    Dim obj As SelectionAllDiagonalUp
'
'    Set obj = New SelectionAllDiagonalUp
'
'    obj.Run
'
'    Set obj = Nothing


    Dim e As SelectionFormatBoader
    
    Set e = New SelectionFormatBoader
    
    e.BoadersIndex = xlDiagonalUp
    e.LineStyle = xlContinuous
    e.Weight = xlThin
    
    e.Run
    
    Set e = Nothing

End Sub
'--------------------------------------------------------------
' �E�オ��r��
'--------------------------------------------------------------
Sub execSelectionAllDiagonalDown()

'    Dim obj As SelectionAllDiagonalDown
'
'    Set obj = New SelectionAllDiagonalDown
'
'    obj.Run
'
'    Set obj = Nothing

    Dim e As SelectionFormatBoader
    
    Set e = New SelectionFormatBoader
    
    e.BoadersIndex = xlDiagonalDown
    e.LineStyle = xlContinuous
    e.Weight = xlThin
    
    e.Run
    
    Set e = Nothing

End Sub
'--------------------------------------------------------------
' ���P���폜
'--------------------------------------------------------------
Sub execSelectionDelete1Char()

    Dim obj As SelectionDelete1Char
    
    Set obj = New SelectionDelete1Char
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �E�P���폜
'--------------------------------------------------------------
Sub execSelectionDelete1RightChar()

    Dim obj As SelectionDelete1RightChar
    
    Set obj = New SelectionDelete1RightChar
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �ӂ艼���N���A
'--------------------------------------------------------------
Sub execSelectionClearPhonetic()

    Dim obj As SelectionClearPhonetic
    
    Set obj = New SelectionClearPhonetic
    
    obj.Run
    
    Set obj = Nothing

End Sub

'--------------------------------------------------------------
' �i���ԍ��폜
'--------------------------------------------------------------
Sub execSelectionDelSectionNo()

    Dim obj As SelectionDelSectionNo
    
    Set obj = New SelectionDelSectionNo
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �i���ԍ��ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddSectionNo()

    Dim obj As SelectionAddSectionNo
    
    Set obj = New SelectionAddSectionNo
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �i���ԍ��R�s�[
'--------------------------------------------------------------
Sub execSelectionCopySectionNo()

    Dim obj As SelectionCopySectionNo
    
    Set obj = New SelectionCopySectionNo
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �ӏ������폜
'--------------------------------------------------------------
Sub execSelectionDelItemNo()

    Dim obj As SelectionDelItemNo
    
    Set obj = New SelectionDelItemNo
    
    obj.Run
    
    Set obj = Nothing

End Sub '--------------------------------------------------------------
' �u�E�v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemPoint()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemPoint"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u���v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemCircleB()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemCircleB"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u���v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemCircleW()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemCircleW"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u���v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemDiaB()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemDiaB"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u���v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemDiaW()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemDiaW"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u���v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemRevTriB()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemRevTriB"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u���v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemRevTriW()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemRevTriW"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u���v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemSquareB()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemSquareB"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u���v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemSquareW()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemSquareW"
    
    obj.Run
    
    Set obj = Nothing

End Sub

'--------------------------------------------------------------
' �u1)�v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemNum1()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemNum1"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u(a)�v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemNumA2()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemNumA2"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u�@�v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemNumC()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemNumC"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �ua)�v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemNumA()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemNumA"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u��P)�v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemNumExp()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemNumExp"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u1.�v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemNumPoint2()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemNumPoint2"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u���v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemNumImp()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemImp"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u���v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemNumDouble()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemDouble"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u���v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemNumStarB()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemStarB"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u���v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemNumStarW()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemStarW"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u�Y�v�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemNumSime()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemSime"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �u�ˁv�ǉ�
'--------------------------------------------------------------
Sub execSelectionAllAddItemNumDblR()

    Dim obj As SelectionAddItemNo
    
    Set obj = New SelectionAddItemNo
    
    obj.ItemName = "itemDblR"
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���Ȃ��l���}�[�W
'--------------------------------------------------------------
Sub execSelectionMerge()

    Dim obj As SelectionMerge
    
    Set obj = New SelectionMerge
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���Ȃ��l���}�[�W
'--------------------------------------------------------------
Sub execSelectionMergeLine()

    Dim obj As SelectionMergeLine
    
    Set obj = New SelectionMergeLine
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �}�[�W�̋t
'--------------------------------------------------------------
Sub execSelectionNoMerge()

    Dim obj As SelectionNoMerge
    
    Set obj = New SelectionNoMerge
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �N���b�v�{�[�h�t�@�C���R�s�[
'--------------------------------------------------------------
Sub execSelectionSetClipboardCopy()

    Dim obj As SelectionSetClipboardCopy
    
    Set obj = New SelectionSetClipboardCopy
    
    obj.Run
    
    Set obj = Nothing

End Sub

'--------------------------------------------------------------
' ���镶�����獶�����폜
'--------------------------------------------------------------
Sub execSelectionRemoveLeftToChar()

    Dim obj As SelectionRemoveLeftToChar
    
    Set obj = New SelectionRemoveLeftToChar
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���镶������E�����폜
'--------------------------------------------------------------
Sub execSelectionRemoveRightToChar()

    Dim obj As SelectionRemoveRightToChar
    
    Set obj = New SelectionRemoveRightToChar
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ��ΎQ�ƕϊ�
'--------------------------------------------------------------
Sub execSelectionToAbsolute()

    Dim obj As SelectionToAbsolute
    
    Set obj = New SelectionToAbsolute
    
    obj.RefType = xlAbsolute
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���ΎQ�ƕϊ�
'--------------------------------------------------------------
Sub execSelectionToRelative()

    Dim obj As SelectionToAbsolute
    
    Set obj = New SelectionToAbsolute
    
    obj.RefType = xlRelative
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ��ΎQ�ƕϊ�(��)
'--------------------------------------------------------------
Sub execSelectionToRelRowAbsColumn()

    Dim obj As SelectionToAbsolute
    
    Set obj = New SelectionToAbsolute
    
    obj.RefType = xlRelRowAbsColumn
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ��ΎQ�ƕϊ�(�s)
'--------------------------------------------------------------
Sub execSelectionToAbsRowRelColumn()

    Dim obj As SelectionToAbsolute
    
    Set obj = New SelectionToAbsolute
    
    obj.RefType = xlAbsRowRelColumn
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �����l��
'--------------------------------------------------------------
Sub execSelectionAlignTopLeft()

    Dim obj As SelectionFormatAlign
    
    Set obj = New SelectionFormatAlign
    
    obj.VerticalAlignment = xlTop
    obj.HorizontalAlignment = xlLeft
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �����l��
'--------------------------------------------------------------
Sub execSelectionAlignTopCenter()

    Dim obj As SelectionFormatAlign
    
    Set obj = New SelectionFormatAlign
    
    obj.VerticalAlignment = xlTop
    obj.HorizontalAlignment = xlCenter
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �����l��
'--------------------------------------------------------------
Sub execSelectionAlignTopRight()

    Dim obj As SelectionFormatAlign
    
    Set obj = New SelectionFormatAlign
    
    obj.VerticalAlignment = xlTop
    obj.HorizontalAlignment = xlRight
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �����l��
'--------------------------------------------------------------
Sub execSelectionAlignCenterLeft()

    Dim obj As SelectionFormatAlign
    
    Set obj = New SelectionFormatAlign
    
    obj.VerticalAlignment = xlCenter
    obj.HorizontalAlignment = xlLeft
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �����l��
'--------------------------------------------------------------
Sub execSelectionAlignCenterCenter()

    Dim obj As SelectionFormatAlign
    
    Set obj = New SelectionFormatAlign
    
    obj.VerticalAlignment = xlCenter
    obj.HorizontalAlignment = xlCenter
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �����l��
'--------------------------------------------------------------
Sub execSelectionAlignCenterRight()

    Dim obj As SelectionFormatAlign
    
    Set obj = New SelectionFormatAlign
    
    obj.VerticalAlignment = xlCenter
    obj.HorizontalAlignment = xlRight
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �����l��
'--------------------------------------------------------------
Sub execSelectionAlignBottomLeft()

    Dim obj As SelectionFormatAlign
    
    Set obj = New SelectionFormatAlign
    
    obj.VerticalAlignment = xlBottom
    obj.HorizontalAlignment = xlLeft
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �����l��
'--------------------------------------------------------------
Sub execSelectionAlignBottomCenter()

    Dim obj As SelectionFormatAlign
    
    Set obj = New SelectionFormatAlign
    
    obj.VerticalAlignment = xlBottom
    obj.HorizontalAlignment = xlCenter
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �����l��
'--------------------------------------------------------------
Sub execSelectionAlignBottomRight()

    Dim obj As SelectionFormatAlign
    
    Set obj = New SelectionFormatAlign
    
    obj.VerticalAlignment = xlBottom
    obj.HorizontalAlignment = xlRight
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' �C���f���g�N���A
'--------------------------------------------------------------
Sub execSelectionSectionIndentClear()

    Dim obj As SelectionAllIndentClear
    
    Set obj = New SelectionAllIndentClear
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' ���ԍ�
'--------------------------------------------------------------
Sub getNextNumber()
    
    Dim obj As SelectionAllNextNo
    
    Set obj = New SelectionAllNextNo
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' ���ԍ�(��)
'--------------------------------------------------------------
Sub getNextNumberLeft()
    
    Dim obj As SelectionAllLeftNo
    
    Set obj = New SelectionAllLeftNo
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' Relax�t�B��(�{�P)
'--------------------------------------------------------------
Sub execSelectionAllPlus()
    
    Dim obj As SelectionAllPlus
    
    Set obj = New SelectionAllPlus
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' Relax�t�B��(�|�P)
'--------------------------------------------------------------
Sub execSelectionAllMinus()
    
    Dim obj As SelectionAllMinus
    
    Set obj = New SelectionAllMinus
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' �}�C�i���o�[�i�l�j�`�F�b�N�f�W�b�g
'--------------------------------------------------------------
Sub execSelectionCheckMyNumber()
    
    Dim obj As SelectionCheckMyNumber
    
    Set obj = New SelectionCheckMyNumber
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' �}�C�i���o�[�i��Ɓj�`�F�b�N�f�W�b�g
'--------------------------------------------------------------
Sub execSelectionCheckCorpNumber()
    
    Dim obj As SelectionCheckCorpNumber
    
    Set obj = New SelectionCheckCorpNumber
    
    obj.Run
    
    Set obj = Nothing
    
End Sub
'--------------------------------------------------------------
' 2003�݊��F(�����F)
'--------------------------------------------------------------
Sub execSelectionFormatFontColor()
    
    Dim obj As SelectionFormatFontColor
    
    Set obj = New SelectionFormatFontColor
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' 2003�݊��F(�w�i�F)
'--------------------------------------------------------------
Sub execSelectionFormatBackColor()
    
    Dim obj As SelectionFormatBackColor
    
    Set obj = New SelectionFormatBackColor
    
    obj.Run
    
    Set obj = Nothing

End Sub
'--------------------------------------------------------------
' 2003�݊��F(�g���F)
'--------------------------------------------------------------
Sub execSelectionFormatLineColor()
    
    Dim obj As SelectionFormatLineColor
    
    Set obj = New SelectionFormatLineColor
    
    obj.Run
    
    Set obj = Nothing

End Sub

