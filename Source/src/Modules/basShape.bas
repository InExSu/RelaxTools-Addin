Attribute VB_Name = "basShape"
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


'�P�}�X�̃T�C�Y�i9.75�~12�j
Public Const C_RECT_X  As Single = 9.75
Public Const C_RECT_Y  As Single = 12

'���̑��̍\���i�S�~�R�}�X�j
Public Const C_NORMAL_WIDTH As Long = 7
Public Const C_NORMAL_HEIGHT As Long = 3

'
' ����^�������ɂ���
'
Sub straightLine()

    Dim s As Object

    On Error GoTo e
        
    For Each s In Selection.ShapeRange
    
        Dim w As Long
        Dim h As Long
        
        w = s.Width
        h = s.Height
        
        If w > h Then
            If s.VerticalFlip Then
                s.Top = s.Top + s.Height
                s.Height = 0
            Else
                s.Height = 0
            End If
        Else
            If s.HorizontalFlip Then
                s.Left = s.Left + s.Width
                s.Width = 0
            Else
                s.Width = 0
            End If
        End If
    Next
e:

End Sub
Sub largeShape()

    On Error Resume Next
    Selection.ShapeRange.ScaleHeight 1.1, msoFalse, msoScaleFromTopLeft
    Selection.ShapeRange.ScaleWidth 1.1, msoFalse, msoScaleFromTopLeft
End Sub
Sub smallShape()
    On Error Resume Next
    Selection.ShapeRange.ScaleHeight 0.9, msoFalse, msoScaleFromTopLeft
    Selection.ShapeRange.ScaleWidth 0.9, msoFalse, msoScaleFromTopLeft
End Sub
'
' �L���f�[�^�i�V�F�C�v�j�`��
'
Sub drawFlowchartStoredData()

    Dim objDataSet As Shape
    Dim r As Range

    For Each r In Selection
        
        '�f�[�^�L���V�F�C�v�̍쐬
        Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeFlowchartStoredData, r.Left + r.Width, r.Top, C_RECT_X * C_NORMAL_WIDTH, C_RECT_Y * C_NORMAL_HEIGHT)
    
        With objDataSet.TextFrame
            .Characters.Text = r.value
            .HorizontalAlignment = xlCenter
            .VerticalAlignment = xlCenter
        End With
        
        Set objDataSet = Nothing
    Next

End Sub
'
' �e�L�X�g�{�b�N�X�i�V�F�C�v�j�`��
'
Sub drawTextbox1()

    Dim objDataSet As Shape
    Dim r As Range
    Dim strBuf As String
    Dim lngCnt As Long
    

    For Each r In Selection
        
        strBuf = r.value
        
        lngCnt = InStr(strBuf, vbCrLf) + 3
        
        '�f�[�^�L���V�F�C�v�̍쐬
        Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeRectangle, r.Left + r.Width, r.Top, C_RECT_X * 10, C_RECT_Y * lngCnt)
    
        With objDataSet.TextFrame
            .Characters.Text = r.value
        End With
            

        Set objDataSet = Nothing
    Next

End Sub
'
' �e�L�X�g�{�b�N�X�i�V�F�C�v�j�`��
'
Sub drawTextbox2()

    Dim objDataSet As Shape
    Dim r As Range
    Dim strBuf As String
    Dim lngCnt As Long
    

    For Each r In Selection
        
        strBuf = r.value
        
        lngCnt = InStr(strBuf, vbCrLf) + 3
        
        '�f�[�^�L���V�F�C�v�̍쐬
        Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeRectangle, r.Left + r.Width, r.Top, C_RECT_X * 10, C_RECT_Y * lngCnt)
    
        With objDataSet.TextFrame
            .Characters.Text = r.value
        End With
            
        '�g�Ȃ��̏ꍇ
        objDataSet.Line.visible = msoFalse
            
        Set objDataSet = Nothing
    Next

End Sub
'
' �l�p�`�����o���i�V�F�C�v�j�`��
'
Sub drawShapeRectangularCallout()

    Dim objDataSet As Shape
    Dim r As Range
    
    Dim strBuf As String
    Dim lngCnt As Long

    For Each r In Selection
        
        strBuf = r.value
        
        lngCnt = InStr(strBuf, vbCrLf) + 3
        
        '�f�[�^�L���V�F�C�v�̍쐬
        Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeRectangularCallout, r.Left + r.Width, r.Top, C_RECT_X * 10, C_RECT_Y * lngCnt)
    
        With objDataSet.TextFrame
            .Characters.Text = r.value
        End With
        
        Set objDataSet = Nothing
    Next

End Sub
'
' �p�ێl�p�`�����o���i�V�F�C�v�j�`��
'
Sub drawShapeRoundedRectangularCallout()

    Dim objDataSet As Shape
    Dim r As Range
    
    Dim strBuf As String
    Dim lngCnt As Long

    For Each r In Selection
        
        strBuf = r.value
        
        lngCnt = InStr(strBuf, vbCrLf) + 3
        
        '�f�[�^�L���V�F�C�v�̍쐬
        Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeRoundedRectangularCallout, r.Left + r.Width, r.Top, C_RECT_X * 10, C_RECT_Y * lngCnt)
    
        With objDataSet.TextFrame
            .Characters.Text = r.value
        End With
        
        Set objDataSet = Nothing
    Next

End Sub
'
' �ی`�����o���i�V�F�C�v�j�`��
'
Sub drawShapeOvalCallout()

    Dim objDataSet As Shape
    Dim r As Range
    
    Dim strBuf As String
    Dim lngCnt As Long

    For Each r In Selection
        
        strBuf = r.value
        
        lngCnt = InStr(strBuf, vbCrLf) + 3
        
        '�f�[�^�L���V�F�C�v�̍쐬
        Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeOvalCallout, r.Left + r.Width, r.Top, C_RECT_X * 10, C_RECT_Y * lngCnt)
    
        With objDataSet.TextFrame
            .Characters.Text = r.value
        End With
        
        Set objDataSet = Nothing
    Next

End Sub
'
' �_�`�����o���i�V�F�C�v�j�`��
'
Sub drawShapeCloudCallout()

    Dim objDataSet As Shape
    Dim r As Range
    
    Dim strBuf As String
    Dim lngCnt As Long

    For Each r In Selection
        
        strBuf = r.value
        
        lngCnt = InStr(strBuf, vbCrLf) + 3
        
        '�f�[�^�L���V�F�C�v�̍쐬
        Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeCloudCallout, r.Left + r.Width, r.Top, C_RECT_X * 10, C_RECT_Y * lngCnt)
    
        With objDataSet.TextFrame
            .Characters.Text = r.value
        End With
        
        Set objDataSet = Nothing
    Next

End Sub
'
' �ی`�i�V�F�C�v�j�ϊ�
'
Sub convShapeOval()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeOval
    Next

End Sub
'
' �l�p�`�i�V�F�C�v�j�ϊ�
'
Sub convShapeRectangle()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeRectangle
    Next

End Sub
'
' �l�p�`�����o���i�V�F�C�v�j�ϊ�
'
Sub convShapeRectangularCallout()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeRectangularCallout
    Next

End Sub
'
' �p�ێl�p�`�����o���i�V�F�C�v�j�ϊ�
'
Sub convShapeRoundedRectangularCallout()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeRoundedRectangularCallout
    Next

End Sub
'
' �ی`�����o���i�V�F�C�v�j�ϊ�
'
Sub convShapeOvalCallout()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeOvalCallout
    Next

End Sub
'
' �_�`�����o���i�V�F�C�v�j�ϊ�
'
Sub convShapeCloudCallout()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeCloudCallout
    Next

End Sub
'
' �t���[�`���[�g�F�����i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartProcess()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartProcess
    Next

End Sub
'
' �t���[�`���[�g�F��֏����i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartAlternateProcess()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartAlternateProcess
    Next

End Sub
'
' �t���[�`���[�g�F���f�i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartDecision()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartDecision
    Next

End Sub
'
' �t���[�`���[�g�F�f�[�^�i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartData()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartData
    Next

End Sub
'
' �t���[�`���[�g�F��`�ςݏ����i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartPredefinedProcess()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartPredefinedProcess
    Next

End Sub
'
' �t���[�`���[�g�F�����L���i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartInternalStorage()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartInternalStorage
    Next

End Sub
'
' �t���[�`���[�g�F���ށi�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartDocument()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartDocument
    Next

End Sub
'
' �t���[�`���[�g�F�������ށi�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartMultidocument()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartMultidocument
    Next

End Sub
'
' �t���[�`���[�g�F�[�q�i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartTerminator()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartTerminator
    Next

End Sub
'
' �t���[�`���[�g�F�����i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartPreparation()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartPreparation
    Next

End Sub
'
' �t���[�`���[�g�F�葀����́i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartManualInput()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartManualInput
    Next

End Sub
'
' �t���[�`���[�g�F���Ɓi�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartManualOperation()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartManualOperation
    Next

End Sub
'
' �t���[�`���[�g�F�J�[�h�i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartCard()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartCard
    Next

End Sub
'
' �t���[�`���[�g�F����E�e�[�v�i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartPunchedTape()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartPunchedTape
    Next

End Sub
'
' �t���[�`���[�g�F�L���f�[�^�i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartStoredData()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartStoredData
    Next

End Sub
'
' �t���[�`���[�g�F�����A�N�Z�X�L���i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartSequentialAccessStorage()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartSequentialAccessStorage
    Next

End Sub
'
' �t���[�`���[�g�F���ڃA�N�Z�X�L���i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartDirectAccessStorage()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartDirectAccessStorage
    Next

End Sub
'
' �t���[�`���[�g�F���C�f�B�X�N�i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartMagneticDisk()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartMagneticDisk
    Next

End Sub
'
' �t���[�`���[�g�F�\���i�V�F�C�v�j�ϊ�
'
Sub convShapeFlowchartDisplay()

    Dim r As Shape
    
    For Each r In Selection.ShapeRange
        r.AutoShapeType = msoShapeFlowchartDisplay
    Next

End Sub

'
' �G�r�f���X�p�l�p�i�V�F�C�v�j�`��
'
Sub drawEvidenceTextbox()

    Dim objDataSet As Shape
    Dim z As Single
    Dim r As Long
    Dim c As Long
    Dim a As Boolean
    
    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    a = Application.ScreenUpdating
    Application.ScreenUpdating = False
        
    z = ActiveWindow.Zoom
    c = ActiveWindow.ScrollColumn
    r = ActiveWindow.ScrollRow
    ActiveWindow.Zoom = 100
        
    Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeRectangle, Selection.Left + (Selection.Width - C_RECT_X * C_NORMAL_WIDTH * 3) / 2, Selection.Top + (Selection.Height - C_RECT_Y * C_NORMAL_HEIGHT) / 2, C_RECT_X * C_NORMAL_WIDTH * 3, C_RECT_Y * C_NORMAL_HEIGHT)
    
    '��{�̃X�^�C�����Z�b�g
    objDataSet.ShapeStyle = msoShapeStylePreset1
    
    With objDataSet.Fill
        .Solid
        .visible = msoTrue
        .Transparency = 1
        .ForeColor.RGB = RGB(255, 255, 255)
    End With
    With objDataSet.Line
        .Weight = 2.25
        .DashStyle = msoLineSingle
        .Style = msoLineSingle
        .Transparency = 0#
        .visible = msoTrue
        .ForeColor.SchemeColor = 10
        .BackColor.RGB = RGB(255, 255, 255)
    End With
        
    objDataSet.Select
    objDataSet.Placement = xlMove
    
    Set objDataSet = Nothing

    ActiveWindow.Zoom = z
    ActiveWindow.ScrollColumn = c
    ActiveWindow.ScrollRow = r
    
    Application.ScreenUpdating = a
        
End Sub
'
' �G�r�f���X�p�ȉ~�i�V�F�C�v�j�`��
'
Sub drawEvidenceOval()

    Dim objDataSet As Shape
    Dim z As Single
    Dim r As Long
    Dim c As Long
    Dim a As Boolean

    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    a = Application.ScreenUpdating
    Application.ScreenUpdating = False
        
    z = ActiveWindow.Zoom
    c = ActiveWindow.ScrollColumn
    r = ActiveWindow.ScrollRow
    ActiveWindow.Zoom = 100
        
        
    Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeOval, Selection.Left + (Selection.Width - C_RECT_X * C_NORMAL_WIDTH * 1.5) / 2, Selection.Top + (Selection.Height - C_RECT_Y * C_NORMAL_HEIGHT) / 2, C_RECT_X * C_NORMAL_WIDTH * 1.5, C_RECT_Y * C_NORMAL_HEIGHT)
    
    '��{�̃X�^�C�����Z�b�g
    objDataSet.ShapeStyle = msoShapeStylePreset1
    
    With objDataSet.Fill
        .Solid
        .visible = msoTrue
        .Transparency = 1
        .ForeColor.RGB = RGB(255, 255, 255)
    End With
    With objDataSet.Line
        .Weight = 2.25
        .DashStyle = msoLineSingle
        .Style = msoLineSingle
        .Transparency = 0#
        .visible = msoTrue
        .ForeColor.SchemeColor = 10
        .BackColor.RGB = RGB(255, 255, 255)
    End With
        
    objDataSet.Select
    objDataSet.Placement = xlMove
    Set objDataSet = Nothing

    ActiveWindow.Zoom = z
    ActiveWindow.ScrollColumn = c
    ActiveWindow.ScrollRow = r
    
    Application.ScreenUpdating = a
        
End Sub
'
' �G�r�f���X�p�ӂ������`��
'
Sub drawEvidenceCallout()

    Dim objDataSet As Shape
    Dim z As Single
    Dim r As Long
    Dim c As Long
    Dim a As Boolean

    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    a = Application.ScreenUpdating
    Application.ScreenUpdating = False
        
    z = ActiveWindow.Zoom
    c = ActiveWindow.ScrollColumn
    r = ActiveWindow.ScrollRow
    ActiveWindow.Zoom = 100
        
        
    Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeRectangularCallout, Selection.Left + (Selection.Width - C_RECT_X * C_NORMAL_WIDTH * 3) / 2, Selection.Top + (Selection.Height - C_RECT_Y * C_NORMAL_HEIGHT) / 2, C_RECT_X * C_NORMAL_WIDTH * 3, C_RECT_Y * C_NORMAL_HEIGHT)
    
    '��{�̃X�^�C�����Z�b�g
    objDataSet.ShapeStyle = msoShapeStylePreset1
    
    With objDataSet.Fill
        .Solid
        .Transparency = 0#
        .visible = msoTrue
        .ForeColor.RGB = RGB(255, 255, 255)
    End With
    With objDataSet.Line
        .Weight = 2.25
        .DashStyle = msoLineSingle
        .Style = msoLineSingle
        .Transparency = 0#
        .visible = msoTrue
        .ForeColor.SchemeColor = 10
        .BackColor.RGB = RGB(255, 255, 255)
    End With
    With objDataSet.TextFrame2.TextRange.Characters.Font
        .Fill.ForeColor.RGB = RGB(0, 0, 0)
    End With
        
    objDataSet.Select
    objDataSet.Placement = xlMove
    Set objDataSet = Nothing

    ActiveWindow.Zoom = z
    ActiveWindow.ScrollColumn = c
    ActiveWindow.ScrollRow = r
    
    Application.ScreenUpdating = a

End Sub
'
' �G�r�f���X�p���ӂ������`��
'
Sub drawEvidenceLineCallout()

    Dim objDataSet As Shape
    Dim z As Single
    Dim r As Long
    Dim c As Long
    Dim a As Boolean

    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    a = Application.ScreenUpdating
    Application.ScreenUpdating = False
        
    z = ActiveWindow.Zoom
    c = ActiveWindow.ScrollColumn
    r = ActiveWindow.ScrollRow
    ActiveWindow.Zoom = 100
        
        
    Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeLineCallout1, Selection.Left + (Selection.Width - C_RECT_X * C_NORMAL_WIDTH * 3) / 2, Selection.Top + (Selection.Height - C_RECT_Y * C_NORMAL_HEIGHT) / 2, C_RECT_X * C_NORMAL_WIDTH * 3, C_RECT_Y * C_NORMAL_HEIGHT)
    
    '��{�̃X�^�C�����Z�b�g
    objDataSet.ShapeStyle = msoShapeStylePreset1
    
    With objDataSet.Fill
        .Solid
        .Transparency = 0#
        .visible = msoTrue
        .ForeColor.RGB = RGB(255, 255, 255)
    End With
    With objDataSet.Line
        .Weight = 2.25
        .DashStyle = msoLineSingle
        .Style = msoLineSingle
        .Transparency = 0#
        .visible = msoTrue
        .ForeColor.SchemeColor = 10
        .BackColor.RGB = RGB(255, 255, 255)
    End With
    With objDataSet.TextFrame2.TextRange.Characters.Font
        .Fill.ForeColor.RGB = RGB(0, 0, 0)
    End With
        
    objDataSet.Select
    objDataSet.Placement = xlMove
    Set objDataSet = Nothing

    ActiveWindow.Zoom = z
    ActiveWindow.ScrollColumn = c
    ActiveWindow.ScrollRow = r
    
    Application.ScreenUpdating = a

End Sub
'
' �G�r�f���X�p���`��
'
Sub drawEvidenceArrow()

    Dim objDataSet As Shape
    Dim z As Single
    Dim r As Long
    Dim c As Long
    Dim a As Boolean

    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    a = Application.ScreenUpdating
    Application.ScreenUpdating = False
        
    z = ActiveWindow.Zoom
    c = ActiveWindow.ScrollColumn
    r = ActiveWindow.ScrollRow
    ActiveWindow.Zoom = 100
        
        
    Set objDataSet = ActiveSheet.Shapes.AddConnector(msoConnectorStraight, Selection.Left + (Selection.Width / 2), Selection.Top + Selection.Height - (C_NORMAL_HEIGHT * 25), Selection.Left + (Selection.Width / 2), Selection.Top + Selection.Height)
    
    With objDataSet.Line
        .Weight = 2.25
        .DashStyle = msoLineSingle
        .Style = msoLineSingle
        .Transparency = 0#
        .visible = msoTrue
        .ForeColor.SchemeColor = 10
        .BackColor.RGB = RGB(255, 255, 255)
        .EndArrowheadStyle = msoArrowheadOpen
        .EndArrowheadLength = msoArrowheadLong
        .EndArrowheadWidth = msoArrowheadWide
    End With
        
    objDataSet.Select
    objDataSet.Placement = xlMove
    Set objDataSet = Nothing

    ActiveWindow.Zoom = z
    ActiveWindow.ScrollColumn = c
    ActiveWindow.ScrollRow = r
    
    Application.ScreenUpdating = a
    

End Sub
'
' �G�r�f���X�p�l�p�i�V�F�C�v�j�`��
'
Sub drawEvidenceTextbox2()

    Dim objDataSet As Shape
    Dim z As Single
    Dim r As Long
    Dim c As Long
    Dim a As Boolean

    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    a = Application.ScreenUpdating
    Application.ScreenUpdating = False
        
    z = ActiveWindow.Zoom
    c = ActiveWindow.ScrollColumn
    r = ActiveWindow.ScrollRow
    ActiveWindow.Zoom = 100
        

    Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeRectangle, Selection.Left + (Selection.Width - C_RECT_X * C_NORMAL_WIDTH * 3) / 2, Selection.Top + (Selection.Height - C_RECT_Y * C_NORMAL_HEIGHT) / 2, C_RECT_X * C_NORMAL_WIDTH * 3, C_RECT_Y * C_NORMAL_HEIGHT)
    
    '��{�̃X�^�C�����Z�b�g
    objDataSet.ShapeStyle = msoShapeStylePreset1
    
    With objDataSet.Fill
        .Solid
        .visible = msoTrue
        .Transparency = 1
        .ForeColor.RGB = RGB(255, 255, 255)
    End With
    With objDataSet.Line
        .Weight = 2.25
        .DashStyle = msoLineDash
        .Style = msoLineSingle
        .Transparency = 0#
        .visible = msoTrue
        .ForeColor.SchemeColor = 10
        .BackColor.RGB = RGB(255, 255, 255)
    End With
        
    objDataSet.Select
    objDataSet.Placement = xlMove
    Set objDataSet = Nothing

    ActiveWindow.Zoom = z
    ActiveWindow.ScrollColumn = c
    ActiveWindow.ScrollRow = r
    
    Application.ScreenUpdating = a

End Sub
'
' �G�r�f���X�p�ȉ~�i�V�F�C�v�j�`��
'
Sub drawEvidenceOval2()

    Dim objDataSet As Shape
    Dim z As Single
    Dim r As Long
    Dim c As Long
    Dim a As Boolean

    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    a = Application.ScreenUpdating
    Application.ScreenUpdating = False
        
    z = ActiveWindow.Zoom
    c = ActiveWindow.ScrollColumn
    r = ActiveWindow.ScrollRow
    ActiveWindow.Zoom = 100
        
        
    Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeOval, Selection.Left + (Selection.Width - C_RECT_X * C_NORMAL_WIDTH * 1.5) / 2, Selection.Top + (Selection.Height - C_RECT_Y * C_NORMAL_HEIGHT) / 2, C_RECT_X * C_NORMAL_WIDTH * 1.5, C_RECT_Y * C_NORMAL_HEIGHT)
    
    '��{�̃X�^�C�����Z�b�g
    objDataSet.ShapeStyle = msoShapeStylePreset1
    
    With objDataSet.Fill
        .Solid
        .visible = msoTrue
        .Transparency = 1
        .ForeColor.RGB = RGB(255, 255, 255)
    End With
    With objDataSet.Line
        .Weight = 2.25
        .DashStyle = msoLineDash
        .Style = msoLineSingle
        .Transparency = 0#
        .visible = msoTrue
        .ForeColor.SchemeColor = 10
        .BackColor.RGB = RGB(255, 255, 255)
    End With
        
    objDataSet.Select
    objDataSet.Placement = xlMove
    Set objDataSet = Nothing

    ActiveWindow.Zoom = z
    ActiveWindow.ScrollColumn = c
    ActiveWindow.ScrollRow = r
    
    Application.ScreenUpdating = a

End Sub
'
' �G�r�f���X�p�ӂ������`��2
'
Sub drawEvidenceCallout2()

    Dim objDataSet As Shape
    Dim z As Single
    Dim r As Long
    Dim c As Long
    Dim a As Boolean

    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    a = Application.ScreenUpdating
    Application.ScreenUpdating = False
        
    z = ActiveWindow.Zoom
    c = ActiveWindow.ScrollColumn
    r = ActiveWindow.ScrollRow
    ActiveWindow.Zoom = 100
        
        
    Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeRectangularCallout, Selection.Left + (Selection.Width - C_RECT_X * C_NORMAL_WIDTH * 3) / 2, Selection.Top + (Selection.Height - C_RECT_Y * C_NORMAL_HEIGHT) / 2, C_RECT_X * C_NORMAL_WIDTH * 3, C_RECT_Y * C_NORMAL_HEIGHT)
    
    '��{�̃X�^�C�����Z�b�g
    objDataSet.ShapeStyle = msoShapeStylePreset1
    
    With objDataSet.Fill
        .Solid
        .Transparency = 0#
        .visible = msoTrue
        .ForeColor.RGB = RGB(255, 255, 255)
    End With
    With objDataSet.Line
        .Weight = 2.25
        .DashStyle = msoLineDash
        .Style = msoLineSingle
        .Transparency = 0#
        .visible = msoTrue
        .ForeColor.SchemeColor = 10
        .BackColor.RGB = RGB(255, 255, 255)
    End With
    
    With objDataSet.TextFrame2.TextRange.Characters.Font
        .Fill.ForeColor.RGB = RGB(0, 0, 0)
    End With
        
    objDataSet.Select
    objDataSet.Placement = xlMove
    Set objDataSet = Nothing
    
    ActiveWindow.Zoom = z
    ActiveWindow.ScrollColumn = c
    ActiveWindow.ScrollRow = r
    
    Application.ScreenUpdating = a

End Sub
'
' �G�r�f���X�p���ӂ������`��2
'
Sub drawEvidenceLineCallout2()

    Dim objDataSet As Shape
    Dim z As Single
    Dim r As Long
    Dim c As Long
    Dim a As Boolean

    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    a = Application.ScreenUpdating
    Application.ScreenUpdating = False
        
    z = ActiveWindow.Zoom
    c = ActiveWindow.ScrollColumn
    r = ActiveWindow.ScrollRow
    ActiveWindow.Zoom = 100
        
        
    Set objDataSet = ActiveSheet.Shapes.AddShape(msoShapeLineCallout1, Selection.Left + (Selection.Width - C_RECT_X * C_NORMAL_WIDTH * 3) / 2, Selection.Top + (Selection.Height - C_RECT_Y * C_NORMAL_HEIGHT) / 2, C_RECT_X * C_NORMAL_WIDTH * 3, C_RECT_Y * C_NORMAL_HEIGHT)
    
    '��{�̃X�^�C�����Z�b�g
    objDataSet.ShapeStyle = msoShapeStylePreset1
    
    With objDataSet.Fill
        .Solid
        .Transparency = 0#
        .visible = msoTrue
        .ForeColor.RGB = RGB(255, 255, 255)
    End With
    With objDataSet.Line
        .Weight = 2.25
        .DashStyle = msoLineDash
        .Style = msoLineSingle
        .Transparency = 0#
        .visible = msoTrue
        .ForeColor.SchemeColor = 10
        .BackColor.RGB = RGB(255, 255, 255)
    End With
    
    With objDataSet.TextFrame2.TextRange.Characters.Font
        .Fill.ForeColor.RGB = RGB(0, 0, 0)
    End With
        
    objDataSet.Select
    objDataSet.Placement = xlMove
    Set objDataSet = Nothing
    
    ActiveWindow.Zoom = z
    ActiveWindow.ScrollColumn = c
    ActiveWindow.ScrollRow = r
    
    Application.ScreenUpdating = a

End Sub
'
' �G�r�f���X�p���`��
'
Sub drawEvidenceArrow2()

    Dim objDataSet As Shape
    Dim z As Single
    Dim r As Long
    Dim c As Long
    Dim a As Boolean

    If ActiveWorkbook Is Nothing Then
        MsgBox "�A�N�e�B�u�ȃu�b�N��������܂���B", vbCritical, C_TITLE
        Exit Sub
    End If
    
    a = Application.ScreenUpdating
    Application.ScreenUpdating = False
        
    z = ActiveWindow.Zoom
    c = ActiveWindow.ScrollColumn
    r = ActiveWindow.ScrollRow
    ActiveWindow.Zoom = 100
        
        
    Set objDataSet = ActiveSheet.Shapes.AddConnector(msoConnectorStraight, Selection.Left + (Selection.Width / 2), Selection.Top + Selection.Height - (C_NORMAL_HEIGHT * 25), Selection.Left + (Selection.Width / 2), Selection.Top + Selection.Height)
    
    With objDataSet.Line
        .Weight = 2.25
        .DashStyle = msoLineDash
        .Style = msoLineSingle
        .Transparency = 0#
        .visible = msoTrue
        .ForeColor.SchemeColor = 10
        .BackColor.RGB = RGB(255, 255, 255)
        .EndArrowheadStyle = msoArrowheadOpen
        .EndArrowheadLength = msoArrowheadLong
        .EndArrowheadWidth = msoArrowheadWide
    End With
        
    objDataSet.Select
    objDataSet.Placement = xlMove
    Set objDataSet = Nothing
    
    ActiveWindow.Zoom = z
    ActiveWindow.ScrollColumn = c
    ActiveWindow.ScrollRow = r
    
    Application.ScreenUpdating = a

End Sub

Sub shapeAllSelect()
    ActiveSheet.Shapes.SelectAll
End Sub
Sub shapeAllDelete()

    On Error Resume Next
    
    Dim WS As Worksheet
    
    Set WS = ActiveSheet
    If MsgBox("�A�N�e�B�u�V�[�g�̃V�F�C�v�^�摜�����ׂč폜���܂��B��낵���ł����H", vbYesNo + vbQuestion, C_TITLE) <> vbYes Then
        Exit Sub
    End If
    WS.Shapes.SelectAll
    Selection.Delete
    Set WS = Nothing
End Sub
