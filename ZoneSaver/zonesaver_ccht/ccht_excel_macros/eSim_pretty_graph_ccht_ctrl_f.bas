Attribute VB_Name = "Module14"
Sub eSim()
Attribute eSim.VB_Description = "Macro recorded 03-12-2009 by blomanow"
Attribute eSim.VB_ProcData.VB_Invoke_Func = "f\n14"
'
' eSim Macro
' Macro recorded 03-12-2009 by blomanow
'
' Keyboard Shortcut: Ctrl+f
'
    ActiveChart.SeriesCollection(1).Select
    Selection.delete
    ActiveChart.PlotArea.Select
    With Selection.Border
        .ColorIndex = 1
        .Weight = xlThin
        .LineStyle = xlContinuous
    End With
    With Selection.Interior
        .ColorIndex = 2
        .PatternColorIndex = 1
        .Pattern = xlSolid
    End With
    ActiveChart.Axes(xlCategory).MajorGridlines.Select
    With Selection.Border
        .ColorIndex = 16
        .Weight = xlHairline
        .LineStyle = xlContinuous
    End With
    ActiveChart.Axes(xlValue).MajorGridlines.Select
    With Selection.Border
        .ColorIndex = 16
        .Weight = xlThin
        .LineStyle = xlContinuous
    End With
    ActiveChart.Deselect
    ActiveChart.PlotArea.Select
    Selection.Height = 172
    ActiveChart.Axes(xlValue).Select
    With ActiveChart.Axes(xlValue)
        .MinimumScale = 18
        .MaximumScale = 32
        .MinorUnitIsAuto = True
        .MajorUnit = 2
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    ActiveChart.Axes(xlCategory).AxisTitle.Select
    Selection.delete
    ActiveChart.Axes(xlCategory).Select
    Selection.delete
    ActiveChart.Axes(xlValue).Select
    Selection.TickLabels.AutoScaleFont = True
    With Selection.TickLabels.Font
        .Name = "Arial"
        .Size = 14
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
        .Background = xlAutomatic
    End With
    Selection.TickLabels.Font.Bold = False
    ActiveChart.Axes(xlValue).AxisTitle.Select
    Selection.AutoScaleFont = True
    With Selection.Font
        .Name = "Arial"
        .Size = 14
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
        .Background = xlAutomatic
    End With
    Selection.Font.Bold = False
    Selection.Font.Bold = True
    ActiveChart.ChartArea.Select
    ActiveChart.Legend.Select
    Selection.Height = 58
    Selection.Top = 284
    Selection.Width = 148
    Selection.Left = 64
    Selection.Top = 23
    Sheets("out").Select
    ActiveWindow.ScrollRow = 265
    ActiveWindow.ScrollRow = 264
    ActiveWindow.ScrollRow = 263
    ActiveWindow.ScrollRow = 262
    ActiveWindow.ScrollRow = 259
    ActiveWindow.ScrollRow = 258
    ActiveWindow.ScrollRow = 254
    ActiveWindow.ScrollRow = 249
    ActiveWindow.ScrollRow = 243
    ActiveWindow.ScrollRow = 236
    ActiveWindow.ScrollRow = 230
    ActiveWindow.ScrollRow = 222
    ActiveWindow.ScrollRow = 214
    ActiveWindow.ScrollRow = 206
    ActiveWindow.ScrollRow = 198
    ActiveWindow.ScrollRow = 190
    ActiveWindow.ScrollRow = 180
    ActiveWindow.ScrollRow = 173
    ActiveWindow.ScrollRow = 165
    ActiveWindow.ScrollRow = 155
    ActiveWindow.ScrollRow = 147
    ActiveWindow.ScrollRow = 140
    ActiveWindow.ScrollRow = 132
    ActiveWindow.ScrollRow = 124
    ActiveWindow.ScrollRow = 117
    ActiveWindow.ScrollRow = 111
    ActiveWindow.ScrollRow = 105
    ActiveWindow.ScrollRow = 99
    ActiveWindow.ScrollRow = 95
    ActiveWindow.ScrollRow = 90
    ActiveWindow.ScrollRow = 86
    ActiveWindow.ScrollRow = 81
    ActiveWindow.ScrollRow = 75
    ActiveWindow.ScrollRow = 72
    ActiveWindow.ScrollRow = 69
    ActiveWindow.ScrollRow = 66
    ActiveWindow.ScrollRow = 62
    ActiveWindow.ScrollRow = 59
    ActiveWindow.ScrollRow = 57
    ActiveWindow.ScrollRow = 55
    ActiveWindow.ScrollRow = 53
    ActiveWindow.ScrollRow = 50
    ActiveWindow.ScrollRow = 48
    ActiveWindow.ScrollRow = 45
    ActiveWindow.ScrollRow = 44
    ActiveWindow.ScrollRow = 40
    ActiveWindow.ScrollRow = 36
    ActiveWindow.ScrollRow = 34
    ActiveWindow.ScrollRow = 30
    ActiveWindow.ScrollRow = 26
    ActiveWindow.ScrollRow = 25
    ActiveWindow.ScrollRow = 21
    ActiveWindow.ScrollRow = 18
    ActiveWindow.ScrollRow = 16
    ActiveWindow.ScrollRow = 13
    ActiveWindow.ScrollRow = 11
    ActiveWindow.ScrollRow = 10
    ActiveWindow.ScrollRow = 8
    ActiveWindow.ScrollRow = 7
    ActiveWindow.ScrollRow = 6
    ActiveWindow.ScrollRow = 5
    ActiveWindow.ScrollRow = 4
    ActiveWindow.ScrollRow = 3
    ActiveWindow.ScrollRow = 2
    ActiveWindow.ScrollRow = 1
    ActiveWindow.ScrollColumn = 2
    ActiveWindow.ScrollColumn = 4
    ActiveWindow.ScrollColumn = 5
    ActiveWindow.ScrollColumn = 6
    ActiveWindow.ScrollColumn = 7
    ActiveWindow.ScrollColumn = 8
    ActiveWindow.ScrollColumn = 9
    ActiveWindow.ScrollColumn = 10
    ActiveWindow.ScrollColumn = 11
    ActiveWindow.ScrollColumn = 12
    ActiveWindow.ScrollColumn = 13
    ActiveWindow.ScrollColumn = 14
    ActiveWindow.ScrollColumn = 15
    ActiveWindow.ScrollColumn = 16
    ActiveWindow.ScrollColumn = 17
    ActiveWindow.ScrollColumn = 18
    ActiveWindow.ScrollColumn = 19
    ActiveWindow.ScrollColumn = 20
    ActiveWindow.ScrollColumn = 21
    ActiveWindow.ScrollColumn = 22
    ActiveWindow.ScrollColumn = 23
    ActiveWindow.ScrollColumn = 24
    ActiveWindow.ScrollColumn = 25
    ActiveWindow.ScrollColumn = 26
    ActiveWindow.ScrollColumn = 27
    ActiveWindow.ScrollColumn = 28
    ActiveWindow.ScrollColumn = 29
    ActiveWindow.ScrollColumn = 30
    ActiveWindow.ScrollColumn = 31
    ActiveWindow.ScrollColumn = 32
    ActiveWindow.ScrollColumn = 33
    ActiveWindow.ScrollColumn = 34
    ActiveWindow.ScrollColumn = 35
    ActiveWindow.ScrollColumn = 36
    ActiveWindow.ScrollColumn = 37
    ActiveWindow.ScrollColumn = 38
    ActiveWindow.ScrollColumn = 39
    ActiveWindow.ScrollColumn = 40
    ActiveWindow.ScrollColumn = 41
    ActiveWindow.ScrollColumn = 42
    ActiveWindow.ScrollColumn = 43
    ActiveWindow.ScrollColumn = 44
    ActiveWindow.ScrollColumn = 45
    ActiveWindow.ScrollColumn = 46
    ActiveWindow.ScrollColumn = 47
    ActiveWindow.ScrollColumn = 48
    ActiveWindow.ScrollColumn = 49
    ActiveWindow.ScrollColumn = 50
    ActiveWindow.ScrollColumn = 51
    Range("BC1").Select
    ActiveCell.FormulaR1C1 = "Main Zone "
    With ActiveCell.Characters(Start:=1, Length:=10).Font
        .Name = "Arial"
        .FontStyle = "Regular"
        .Size = 10
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
    End With
    Range("BC2").Select
    ActiveWindow.ScrollColumn = 52
    ActiveWindow.ScrollColumn = 53
    ActiveWindow.ScrollColumn = 54
    ActiveWindow.ScrollColumn = 55
    ActiveWindow.ScrollColumn = 56
    ActiveWindow.ScrollColumn = 57
    ActiveWindow.ScrollColumn = 58
    ActiveWindow.ScrollColumn = 59
    ActiveWindow.ScrollColumn = 60
    ActiveWindow.ScrollColumn = 61
    ActiveWindow.ScrollColumn = 62
    ActiveWindow.ScrollColumn = 63
    ActiveWindow.ScrollColumn = 64
    ActiveWindow.ScrollColumn = 65
    ActiveWindow.ScrollColumn = 66
    ActiveWindow.ScrollColumn = 67
    ActiveWindow.ScrollColumn = 68
    ActiveWindow.ScrollColumn = 69
    ActiveWindow.ScrollColumn = 70
    ActiveWindow.ScrollColumn = 71
    ActiveWindow.ScrollColumn = 72
    ActiveWindow.ScrollColumn = 73
    ActiveWindow.ScrollColumn = 74
    Range("CA289").Select
    ActiveWindow.ScrollRow = 264
    ActiveWindow.ScrollRow = 262
    ActiveWindow.ScrollRow = 261
    ActiveWindow.ScrollRow = 259
    ActiveWindow.ScrollRow = 256
    ActiveWindow.ScrollRow = 250
    ActiveWindow.ScrollRow = 243
    ActiveWindow.ScrollRow = 236
    ActiveWindow.ScrollRow = 224
    ActiveWindow.ScrollRow = 214
    ActiveWindow.ScrollRow = 203
    ActiveWindow.ScrollRow = 190
    ActiveWindow.ScrollRow = 169
    ActiveWindow.ScrollRow = 150
    ActiveWindow.ScrollRow = 127
    ActiveWindow.ScrollRow = 101
    ActiveWindow.ScrollRow = 76
    ActiveWindow.ScrollRow = 60
    ActiveWindow.ScrollRow = 47
    ActiveWindow.ScrollRow = 33
    ActiveWindow.ScrollRow = 21
    ActiveWindow.ScrollRow = 11
    ActiveWindow.ScrollRow = 1
    Range("CA1").Select
    ActiveCell.FormulaR1C1 = "Upper Zone"
    With ActiveCell.Characters(Start:=1, Length:=10).Font
        .Name = "Arial"
        .FontStyle = "Regular"
        .Size = 10
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
    End With
    Range("CA2").Select
    ActiveWindow.ScrollColumn = 75
    ActiveWindow.ScrollColumn = 76
    ActiveWindow.ScrollColumn = 77
    ActiveWindow.ScrollColumn = 78
    ActiveWindow.ScrollColumn = 79
    ActiveWindow.ScrollColumn = 80
    ActiveWindow.ScrollColumn = 81
    ActiveWindow.ScrollColumn = 82
    ActiveWindow.ScrollColumn = 83
    ActiveWindow.ScrollColumn = 84
    ActiveWindow.ScrollColumn = 85
    ActiveWindow.ScrollColumn = 86
    ActiveWindow.ScrollColumn = 87
    ActiveWindow.ScrollColumn = 88
    ActiveWindow.ScrollColumn = 89
    ActiveWindow.ScrollColumn = 90
    ActiveWindow.ScrollColumn = 91
    ActiveWindow.ScrollColumn = 92
    ActiveWindow.ScrollColumn = 93
    ActiveWindow.ScrollColumn = 94
    ActiveWindow.ScrollColumn = 95
    ActiveWindow.ScrollColumn = 96
    ActiveWindow.ScrollColumn = 97
    ActiveWindow.ScrollColumn = 98
    ActiveWindow.ScrollColumn = 99
    ActiveWindow.ScrollColumn = 100
    ActiveWindow.ScrollColumn = 101
    ActiveWindow.ScrollColumn = 102
    ActiveWindow.ScrollColumn = 103
    ActiveWindow.ScrollColumn = 104
    ActiveWindow.ScrollColumn = 105
    ActiveWindow.ScrollColumn = 106
    ActiveWindow.ScrollColumn = 107
    ActiveWindow.ScrollColumn = 108
    ActiveWindow.ScrollColumn = 109
    ActiveWindow.ScrollColumn = 110
    ActiveWindow.ScrollColumn = 111
    ActiveWindow.ScrollColumn = 112
    ActiveWindow.ScrollColumn = 113
    ActiveWindow.ScrollColumn = 114
    ActiveWindow.ScrollColumn = 115
    ActiveWindow.ScrollColumn = 116
    ActiveWindow.ScrollColumn = 117
    ActiveWindow.ScrollColumn = 118
    ActiveWindow.ScrollColumn = 119
    ActiveWindow.ScrollColumn = 120
    ActiveWindow.ScrollColumn = 121
    ActiveWindow.ScrollColumn = 122
    ActiveWindow.ScrollColumn = 123
    ActiveWindow.ScrollColumn = 124
    ActiveWindow.ScrollColumn = 125
    ActiveWindow.ScrollColumn = 126
    ActiveWindow.ScrollColumn = 127
    ActiveWindow.ScrollColumn = 128
    ActiveWindow.ScrollColumn = 129
    ActiveWindow.ScrollColumn = 130
    ActiveWindow.ScrollColumn = 131
    ActiveWindow.ScrollColumn = 132
    ActiveWindow.ScrollColumn = 133
    ActiveWindow.ScrollColumn = 134
    ActiveWindow.ScrollColumn = 135
    ActiveWindow.ScrollColumn = 136
    ActiveWindow.ScrollColumn = 137
    ActiveWindow.ScrollColumn = 138
    Range("ET1").Select
    ActiveCell.FormulaR1C1 = "Outdoor"
    With ActiveCell.Characters(Start:=1, Length:=7).Font
        .Name = "Arial"
        .FontStyle = "Regular"
        .Size = 10
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
    End With
    Range("ET2").Select
    Sheets("ZoneTemps").Select
    Selection.Width = 130
    Selection.Width = 122
    Selection.Width = 116
    Selection.Left = 58
    ActiveChart.Deselect
    ActiveChart.SeriesCollection(3).Select
    With Selection.Border
        .ColorIndex = 1
        .Weight = xlMedium
        .LineStyle = xlDot
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    ActiveChart.SeriesCollection(1).Select
    With Selection.Border
        .ColorIndex = 41
        .Weight = xlThick
        .LineStyle = xlDash
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    ActiveChart.Deselect
    ActiveWindow.Zoom = 200
End Sub
