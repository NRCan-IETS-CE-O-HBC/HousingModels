Attribute VB_Name = "ZoneSaver"
Sub ZoneSaver()
Attribute ZoneSaver.VB_Description = "Macro recorded 12-08-2009 by blomanow"
Attribute ZoneSaver.VB_ProcData.VB_Invoke_Func = "q\n14"
'
' ZoneSaver Macro
' Macro recorded 12-08-2009 by blomanow
'
' Keyboard Shortcut: Ctrl+q
'
'move AFN data out of the way

    Columns("EY:FR").Select
    Selection.Cut
    ActiveWindow.SmallScroll ToRight:=26
    Range("HR1").Select
    ActiveSheet.Paste
    Columns("EY:FR").Select
    Selection.delete Shift:=xlToLeft

'delete previous days data except for 23 hour
'delete 23 hour from sim day so that shift to
'EDT will end at midnight (end of 23 hour)
    Rows("2:277").Select
    Selection.delete Shift:=xlUp
    Rows("290:301").Select
    Selection.delete Shift:=xlUp
    
    
    
'shift capacity fraction/ret fraction/outdoor fan power/flow rate columns to the right
    Columns("EV:EX").Select
    Selection.Cut
    ActiveWindow.SmallScroll ToRight:=13
    Range("GG1").Select
    ActiveSheet.Paste
    Columns("FH:FO").Select
    Selection.Copy
    Application.CutCopyMode = False
    Selection.Cut
    Range("GJ1").Select
    ActiveSheet.Paste
    Columns("EV:EX").Select
    Selection.delete Shift:=xlToLeft
    ActiveWindow.SmallScroll ToRight:=6
    Columns("FE:FL").Select
    Selection.delete Shift:=xlToLeft
    Range("FN18").Select
    
'    Columns("FR:FX").Select
'    Selection.Cut
'    Range("GA1").Select
'    ActiveSheet.Paste
'    Columns("EV:EY").Select
'    Selection.Cut
'    Columns("GH:GH").Select
'    ActiveSheet.Paste
'    Columns("EV:EY").Select
'    Selection.delete Shift:=xlToLeft
    
    Cells.Select
    With Selection
        .HorizontalAlignment = xlGeneral
        .VerticalAlignment = xlBottom
        .WrapText = True
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
    Columns("E:E").Select
    Selection.Insert Shift:=xlToRight
    Range("E2").Select
    ActiveCell.FormulaR1C1 = "=(RC[-1]-RC[-1]+1)"
    Range("E2").Select
    Selection.AutoFill Destination:=Range("E2:E9"), Type:=xlFillDefault
    Range("E2:E9").Select
    Range("E2").Select
    ActiveCell.FormulaR1C1 = "=(RC[-1]-R2C4+1)"
    Range("E2").Select
    Selection.AutoFill Destination:=Range("E2:E15"), Type:=xlFillDefault
    Range("E2:E15").Select
    Range("E2").Select
    ActiveCell.FormulaR1C1 = "=(RC[-1]-R2C4+0.25)"
    Range("E2").Select
    Selection.AutoFill Destination:=Range("E2:E11"), Type:=xlFillDefault
    Range("E2:E11").Select
    Range("E2").Select
    ActiveCell.FormulaR1C1 = "=(RC[-1]-R2C4+1)/12"
    Range("E2").Select
    Selection.AutoFill Destination:=Range("E2:E10"), Type:=xlFillDefault
    Range("E2:E10").Select
    Selection.AutoFill Destination:=Range("E2:E433"), Type:=xlFillDefault
    Range("E2:E288").Select
    Range("E1").Select
    ActiveCell.FormulaR1C1 = "HOUR"
    With ActiveCell.Characters(Start:=1, Length:=4).Font
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
    Columns("E:E").Select
    Range("E:E,BN:BN").Select
    Range("BN1").Activate
    Range("E:E,BN:BN,CL:CL").Select
    Range("CL1").Activate
    Charts.Add
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range( _
        "E1:E433,BN1:BN433,CL1:CL433"), PlotBy:=xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart
        .HasTitle = False
        .Axes(xlCategory, xlPrimary).HasTitle = True
        .Axes(xlCategory, xlPrimary).AxisTitle.Characters.Text = "Hour"
        .Axes(xlValue, xlPrimary).HasTitle = True
        .Axes(xlValue, xlPrimary).AxisTitle.Characters.Text = "Cooling Load (W) "
    End With
    ActiveChart.PlotArea.Select
    With Selection.Border
        .ColorIndex = 16
        .Weight = xlThin
        .LineStyle = xlContinuous
    End With
    With Selection.Interior
        .ColorIndex = 2
        .PatternColorIndex = 1
        .Pattern = xlSolid
    End With
    ActiveChart.Deselect
    Sheets("out").Select
    Columns("E:E").Select
    Range("E:E,FG:FG,FH:FH,FI:FI,FK:FK,EX:EX").Select
    Range("FK1").Activate
    Charts.Add
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range( _
        "E1:E433,FG1:FI433,FK1:FK433,EX1:EX433"), PlotBy:=xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart
        .HasTitle = False
        .Axes(xlCategory, xlPrimary).HasTitle = True
        .Axes(xlCategory, xlPrimary).AxisTitle.Characters.Text = "Hour"
        .Axes(xlValue, xlPrimary).HasTitle = True
        .Axes(xlValue, xlPrimary).AxisTitle.Characters.Text = "Load (W) "
    End With
    Sheets("Chart1").Select
    Sheets("Chart1").Name = "Cooling Loads"
    Sheets("Chart2").Select
    Sheets("Chart2").Name = "ASHP"
    Sheets("out").Select
    ActiveWindow.LargeScroll ToRight:=-6
    Range("E:E,F:F").Select
    Range("F1").Activate
    Range("E:E,F:F,AE:AE").Select
    Range("AE1").Activate
    Range("E:E,F:F,AE:AE,BC:BC").Select
    Range("BC1").Activate
    Range("E:E,F:F,AE:AE,BC:BC,CA:CA").Select
    Range("CA1").Activate
    Range("E:E,G:G,AE:AE,BC:BC,CA:CA,CY:CY").Select
    Range("CY1").Activate
    Range("E:E,G:G,AE:AE,BC:BC,CA:CA,CY:CY,DW:DW").Select
    Range("DW1").Activate
    Charts.Add
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range( _
        "E1:E433,G1:G433,AE1:AE433,BC1:BC433,CA1:CA433,CY1:CY433,DW1:DW433"), PlotBy:= _
        xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart
        .HasTitle = False
        .Axes(xlCategory, xlPrimary).HasTitle = True
        .Axes(xlCategory, xlPrimary).AxisTitle.Characters.Text = "Hour"
        .Axes(xlValue, xlPrimary).HasTitle = True
        .Axes(xlValue, xlPrimary).AxisTitle.Characters.Text = _
        "Temperature (deg C) "
    End With
    Sheets("ASHP").Select
    ActiveChart.PlotArea.Select
    With Selection.Border
        .ColorIndex = 16
        .Weight = xlThin
        .LineStyle = xlContinuous
    End With
    With Selection.Interior
        .ColorIndex = 2
        .PatternColorIndex = 1
        .Pattern = xlSolid
    End With
    Sheets("Chart3").Select
    ActiveChart.PlotArea.Select
    With Selection.Border
        .ColorIndex = 16
        .Weight = xlThin
        .LineStyle = xlContinuous
    End With
    With Selection.Interior
        .ColorIndex = 2
        .PatternColorIndex = 1
        .Pattern = xlSolid
    End With
    Sheets("Chart3").Select
    Sheets("Chart3").Name = "Temps"
    ActiveChart.Deselect
    Sheets("out").Select
    Range("E:E,F:F").Select
    Range("F1").Activate
    Range("E:E,F:F,AD:AD").Select
    Range("AD1").Activate
    Range("E:E,F:F,AD:AD,BB:BB").Select
    Range("BB1").Activate
    Range("E:E,F:F,AD:AD,BB:BB,BZ:BZ").Select
    Range("BZ1").Activate
    Range("E:E,F:F,AD:AD,BB:BB,BZ:BZ,CX:CX").Select
    Range("CX1").Activate
    Range("E:E,F:F,AD:AD,BB:BB,BZ:BZ,CX:CX,DV:DV").Select
    Range("DV1").Activate
    Charts.Add
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range( _
        "E1:F433,AD1:AD433,BB1:BB433,BZ1:BZ433,CX1:CX433,DV1:DV433"), PlotBy:= _
        xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart
        .HasTitle = False
        .Axes(xlCategory, xlPrimary).HasTitle = True
        .Axes(xlCategory, xlPrimary).AxisTitle.Characters.Text = "Hour"
        .Axes(xlValue, xlPrimary).HasTitle = True
        .Axes(xlValue, xlPrimary).AxisTitle.Characters.Text = "%RH"
    End With
    Sheets("Chart4").Select
    Sheets("Chart4").Name = "RH"
    Sheets("RH").Select
    
    Sheets("out").Select
    Range("FO1").Select
    ActiveCell.FormulaR1C1 = "Total cooling power (compressor + circ fan) (W)"
    With ActiveCell.Characters(Start:=1, Length:=47).Font
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
    Range("FO2").Select
    ActiveCell.FormulaR1C1 = "=RC[-4]+RC[-17]+RC[+12]"
    Range("FO2").Select
    Selection.AutoFill Destination:=Range("FO2:FO433"), Type:=xlFillDefault
    Range("FO2:FO433").Select
    Range("FP2").Select
    Sheets("ASHP").Select
    Sheets("ASHP").Copy Before:=Sheets(5)
    Sheets("ASHP (2)").Select
    Sheets("ASHP (2)").Name = "Power"
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range( _
        "E1:E433,EX1:EX433,FG1:FI433,FK1:FK433"), PlotBy:=xlColumns
    ActiveChart.SeriesCollection(2).delete
    ActiveChart.SeriesCollection(2).delete
    ActiveChart.SeriesCollection(2).delete
    ActiveChart.SeriesCollection(2).delete
    ActiveChart.SeriesCollection(1).Values = "=out!R2C171:R433C171"
    ActiveChart.SeriesCollection(1).Name = "=out!R1C171"
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart
        .HasTitle = True
        .ChartTitle.Characters.Text = _
        "Total cooling power (compressor + circ fan) (W)"
        .Axes(xlCategory, xlPrimary).HasTitle = True
        .Axes(xlCategory, xlPrimary).AxisTitle.Characters.Text = "Hour"
        .Axes(xlValue, xlPrimary).HasTitle = True
        .Axes(xlValue, xlPrimary).AxisTitle.Characters.Text = "Power (W) "
    End With
    ActiveChart.Deselect
    Sheets("out").Select
    Sheets("Power").Select
    Sheets("Power").Copy Before:=Sheets(6)
    Sheets("Power (2)").Select
    Sheets("Power (2)").Name = "PLR"
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range("E1:E433,FO1:FO433"), _
        PlotBy:=xlColumns
    ActiveChart.SeriesCollection(1).Values = "=out!R2C169:R433C169"
    ActiveChart.SeriesCollection(1).Name = "=out!R1C169"
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart
        .HasTitle = True
        .ChartTitle.Characters.Text = _
        " plant:ideal hvac models:component 02 air source heat pump:part load ratio:cooling (-)"
        .Axes(xlCategory, xlPrimary).HasTitle = True
        .Axes(xlCategory, xlPrimary).AxisTitle.Characters.Text = "Hour"
        .Axes(xlValue, xlPrimary).HasTitle = True
        .Axes(xlValue, xlPrimary).AxisTitle.Characters.Text = " "
    End With
    ActiveChart.Deselect

    Sheets("out").Select
    Range("FP1").Select
    ActiveCell.FormulaR1C1 = "Hourly Average Power (W)"
    With ActiveCell.Characters(Start:=1, Length:=24).Font
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
    Range("FP7").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-5]C[-1]:RC[-1]:RC[+19])/6"
    Range("FP7").Select
    Selection.AutoFill Destination:=Range("FP7:FP433"), Type:=xlFillDefault
    
'calculate hourly average power
    Range("FP13").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP25").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP26").Select
    ActiveWindow.SmallScroll Down:=12
    Range("FP37").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP38").Select
    ActiveWindow.SmallScroll Down:=6
    Range("FP49").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP50").Select
    ActiveWindow.SmallScroll Down:=12
    Range("FP61").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP62").Select
    ActiveWindow.SmallScroll Down:=12
    Range("FP73").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP74").Select
    ActiveWindow.SmallScroll Down:=9
    Range("FP85").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP86").Select
    ActiveWindow.SmallScroll Down:=15
    Range("FP97").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP98").Select
    ActiveWindow.SmallScroll Down:=12
    Range("FP109").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP110").Select
    ActiveWindow.SmallScroll Down:=15
    Range("FP121").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP122").Select
    ActiveWindow.SmallScroll Down:=12
    Range("FP133").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP134").Select
    ActiveWindow.SmallScroll Down:=9
    Range("FP145").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP146").Select
    ActiveWindow.SmallScroll Down:=9
    Range("FP157").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP158").Select
    ActiveWindow.SmallScroll Down:=21
    Range("FP169").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP170").Select
    ActiveWindow.SmallScroll Down:=12
    Range("FP181").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP182").Select
    ActiveWindow.SmallScroll Down:=12
    Range("FP193").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP194").Select
    ActiveWindow.SmallScroll Down:=15
    Range("FP205").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP206").Select
    ActiveWindow.SmallScroll Down:=15
    Range("FP217").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP218").Select
    ActiveWindow.SmallScroll Down:=9
    Range("FP229").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP230").Select
    ActiveWindow.SmallScroll Down:=12
    Range("FP241").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP242").Select
    ActiveWindow.SmallScroll Down:=9
    Range("FP253").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP254").Select
    ActiveWindow.SmallScroll Down:=12
    Range("FP265").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP266").Select
    ActiveWindow.SmallScroll Down:=12
    Range("FP277").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP289").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-11]C[-1]:RC[-1])/12"
    Range("FP290").Select
    Range("FQ1").Select
    ActiveCell.FormulaR1C1 = "Hour"
    With ActiveCell.Characters(Start:=1, Length:=4).Font
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
    Range("FQ2").Select
    ActiveCell.FormulaR1C1 = "0"
    Range("FQ3").Select
    ActiveCell.FormulaR1C1 = "=R[-1]C+1"
    Range("FQ3").Select
    Selection.AutoFill Destination:=Range("FQ3:FQ16"), Type:=xlFillDefault
    Range("FQ3:FQ16").Select
    Selection.AutoFill Destination:=Range("FQ3:FQ22"), Type:=xlFillDefault
    Range("FQ3:FQ22").Select
    Selection.AutoFill Destination:=Range("FQ3:FQ26"), Type:=xlFillDefault
    Range("FQ3:FQ26").Select
    Range("FR1").Select
    ActiveCell.FormulaR1C1 = "Hourly Average Power (W)"
    With ActiveCell.Characters(Start:=1, Length:=24).Font
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
    Range("FP13").Select
    Selection.Copy
    Range("FR2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FP25").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("FR3").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    ActiveWindow.SmallScroll Down:=9
    Range("FP37").Select
    Application.CutCopyMode = False
    Selection.Copy
    ActiveWindow.SmallScroll Down:=-12
    Range("FR4").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FQ2").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "1"
    Range("FQ3").Select
    ActiveWindow.SmallScroll Down:=12
    Range("FP49").Select
    Selection.Copy
    ActiveWindow.SmallScroll Down:=-18
    Range("FR5").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    ActiveWindow.SmallScroll Down:=18
    Range("FP61").Select
    Application.CutCopyMode = False
    Selection.Copy
    ActiveWindow.SmallScroll Down:=-21
    Range("FR6").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    ActiveWindow.SmallScroll Down:=36
    Range("FP73").Select
    Application.CutCopyMode = False
    Selection.Copy
    ActiveWindow.SmallScroll Down:=-39
    Range("FR7").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    ActiveWindow.SmallScroll Down:=54
    Range("FP85").Select
    Application.CutCopyMode = False
    Selection.Copy
    ActiveWindow.SmallScroll Down:=-51
    Range("FR8").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    ActiveWindow.SmallScroll Down:=63
    Range("FP97").Select
    Application.CutCopyMode = False
    Selection.Copy
    ActiveWindow.SmallScroll Down:=-66
    Range("FR9").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    ActiveWindow.SmallScroll Down:=78
    Range("FP109").Select
    Application.CutCopyMode = False
    Selection.Copy
    ActiveWindow.SmallScroll Down:=-78
    Range("FR10").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    ActiveWindow.SmallScroll Down:=87
    Range("FP121").Select
    Application.CutCopyMode = False
    Selection.Copy
    ActiveWindow.SmallScroll Down:=-90
    Range("FR11").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    ActiveWindow.SmallScroll Down:=96
    Range("FP133").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("FR12").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FP145").Select
    Application.CutCopyMode = False
    Selection.Copy

    Range("FR13").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FP157").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("FR14").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FP169").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("FR15").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FP181").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("FR16").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FP193").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("FR17").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FP205").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("FR18").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FP217").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("FR19").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FP229").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("FR20").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FP241").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("FR21").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FP253").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("FR22").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FP265").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("FR23").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FP277").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("FR24").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FP289").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("FR25").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("FQ26").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "Tot"
    With ActiveCell.Characters(Start:=1, Length:=3).Font
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
    Range("FR26").Select
    ActiveCell.FormulaR1C1 = "=SUM(R[-24]C:R[-1]C)"
    Range("FS26").Select
    ActiveCell.FormulaR1C1 = "Wh"
    With ActiveCell.Characters(Start:=1, Length:=2).Font
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
    Range("FS27").Select

   
    
    
    
    
    
   


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    Sheets("out").Select
     Range("FQ2:FR73").Select
    Charts.Add
    ActiveChart.ChartType = xlColumnClustered
    ActiveChart.SetSourceData Source:=Sheets("out").Range("FQ2:FR73"), PlotBy:= _
        xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart
        .HasTitle = False
        .Axes(xlCategory, xlPrimary).HasTitle = True
        .Axes(xlCategory, xlPrimary).AxisTitle.Characters.Text = "Time (hr)"
        .Axes(xlValue, xlPrimary).HasTitle = True
        .Axes(xlValue, xlPrimary).AxisTitle.Characters.Text = _
        "Hourly Average Power (W)"
    End With
    Sheets("Chart5").Select
    Sheets("Chart5").Name = "Avg Power"
    ActiveChart.ChartType = xlColumnClustered
    ActiveChart.SetSourceData Source:=Sheets("out").Range("FQ2:FR73"), PlotBy:= _
        xlColumns
    ActiveChart.SeriesCollection(1).delete
    ActiveChart.Location Where:=xlLocationAsNewSheet
    ActiveChart.SeriesCollection(1).Select
    With ActiveChart.ChartGroups(1)
        .Overlap = 0
        .GapWidth = 0
        .HasSeriesLines = False
        .VaryByCategories = False
    End With
    ActiveChart.Deselect
   
' Sheets("out").Select
' Range("FR2:FR74").Select
'    Range("FR74").Activate
'    ActiveCell.FormulaR1C1 = "=SUM(R[-72]C:R[-1]C)"
'    Range("FR2:FR74").Select
'    Range("FR74").Select
    
    
'     Columns("FY:GA").Select
'    Range("FY:GA,E:E").Select
'    Range("E1").Activate'
'    Charts.Add
'    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
'    ActiveChart.SetSourceData Source:=Sheets("out").Range("E1:E434,FY1:GA434"), _
'        PlotBy:=xlColumns
'    ActiveChart.Location Where:=xlLocationAsNewSheet
'    With ActiveChart
'        .HasTitle = False
'        .Axes(xlCategory, xlPrimary).HasTitle = False
'        .Axes(xlValue, xlPrimary).HasTitle = False
'    End With
'    Sheets("Chart6").Select
'    Sheets("Chart6").Name = "RetAirFrac"
'    Sheets("out").Select
'    ActiveWindow.SmallScroll ToRight:=12
'    Columns("GC:GE").Select
'    Range("GC:GE,E:E").Select
'    Range("E1").Activate
'    Charts.Add
'    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
'    ActiveChart.SetSourceData Source:=Sheets("out").Range("E1:E434,GC1:GE434"), _
'        PlotBy:=xlColumns
'    ActiveChart.Location Where:=xlLocationAsNewSheet
'    With ActiveChart
'        .HasTitle = False
'        .Axes(xlCategory, xlPrimary).HasTitle = False
'        .Axes(xlValue, xlPrimary).HasTitle = False
'    End With
'    Sheets("Chart7").Select
'    Sheets("Chart7").Name = "ZoneCapFrac"
'    Sheets("out").Select
'    Columns("GF:GH").Select
'    Range("GF:GH,E:E").Select
'    Range("E1").Activate
'    Charts.Add
'    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
'    ActiveChart.SetSourceData Source:=Sheets("out").Range("E1:E434,GF1:GH434"), _
'        PlotBy:=xlColumns
'    ActiveChart.Location Where:=xlLocationAsNewSheet
'    With ActiveChart
'        .HasTitle = False
'        .Axes(xlCategory, xlPrimary).HasTitle = False
'        .Axes(xlValue, xlPrimary).HasTitle = False
'    End With
'    Sheets("Chart8").Select
'    Sheets("Chart8").Name = "InterZoneFlows"
    Sheets("out").Select
    Range("FR74").Select
    With Selection.Interior
        .ColorIndex = 6
        .Pattern = xlSolid
    End With
    Range("FS74").Select
    ActiveCell.FormulaR1C1 = "Wh"
    With ActiveCell.Characters(Start:=1, Length:=2).Font
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
    Range("FR74").Select
   
        Sheets("Cooling Loads").Select
    ActiveChart.Axes(xlCategory).Select
    Application.CutCopyMode = False
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 0
        .MaximumScale = 24
        .MinorUnitIsAuto = True
        .MajorUnitIsAuto = True
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    Sheets("ASHP").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 0
        .MaximumScale = 24
        .MinorUnitIsAuto = True
        .MajorUnitIsAuto = True
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    Sheets("Temps").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 0
        .MaximumScale = 24
        .MinorUnitIsAuto = True
        .MajorUnitIsAuto = True
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    Sheets("RH").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 0
        .MaximumScale = 24
        .MinorUnitIsAuto = True
        .MajorUnitIsAuto = True
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    Sheets("Power").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 0
        .MaximumScale = 24
        .MinorUnitIsAuto = True
        .MajorUnitIsAuto = True
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    Sheets("PLR").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 0
        .MaximumScale = 24
        .MinorUnitIsAuto = True
        .MajorUnitIsAuto = True
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    Sheets("Avg Power").Select
    ActiveChart.Axes(xlCategory).Select
    Sheets("out").Select
    Range("FQ26:FR73").Select
    Selection.ClearContents
    ActiveWindow.SmallScroll Down:=36
    Range("FR74:FS74").Select
    Selection.ClearContents
    Selection.Interior.ColorIndex = xlNone
    ActiveWindow.SmallScroll Down:=-48
    Range("FR2:FR26").Select
    Range("FR26").Activate
    ActiveCell.FormulaR1C1 = "=SUM(R[-24]C:R[-1]C)"
    Range("FS26").Select
    ActiveCell.FormulaR1C1 = "Wh"
    With ActiveCell.Characters(Start:=1, Length:=2).Font
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
    Range("FR26").Select
    Selection.Interior.ColorIndex = xlNone
    With Selection.Interior
        .ColorIndex = 6
        .Pattern = xlSolid
    End With
    Sheets("Avg Power").Select
    ActiveChart.ChartType = xlColumnClustered
    ActiveChart.SetSourceData Source:=Sheets("out").Range("FR2:FR73"), PlotBy:= _
        xlColumns
    ActiveChart.SeriesCollection(1).Values = "=out!R2C174:R25C174"
    ActiveChart.Location Where:=xlLocationAsNewSheet
    ActiveChart.Legend.Select
    Selection.delete
    ActiveChart.PlotArea.Select
    Selection.Width = 411
'    Sheets("RetAirFrac").Select
'    ActiveChart.Axes(xlCategory).Select
'    With ActiveChart.Axes(xlCategory)
'        .MinimumScale = 0
'        .MaximumScale = 24
'        .MinorUnitIsAuto = True
'        .MajorUnitIsAuto = True
'        .Crosses = xlAutomatic
'        .ReversePlotOrder = False
'        .ScaleType = xlLinear
'        .DisplayUnit = xlNone
'    End With
'    Sheets("ZoneCapFrac").Select
'    ActiveChart.Axes(xlCategory).Select
'    With ActiveChart.Axes(xlCategory)
'        .MinimumScale = 0
'        .MaximumScale = 24
'        .MinorUnitIsAuto = True
'        .MajorUnitIsAuto = True
'        .Crosses = xlAutomatic
'        .ReversePlotOrder = False
'        .ScaleType = xlLinear
'        .DisplayUnit = xlNone
'    End With
'    Sheets("InterZoneFlows").Select
'    ActiveChart.Axes(xlCategory).Select
'    With ActiveChart.Axes(xlCategory)
'        .MinimumScale = 0
'        .MaximumScale = 24
'        .MinorUnitIsAuto = True
'        .MajorUnitIsAuto = True
'        .Crosses = xlAutomatic
'        .ReversePlotOrder = False
'        .ScaleType = xlLinear
'        .DisplayUnit = xlNone
'    End With

' human readable headings




'pretty graph
    Sheets("Cooling Loads").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 1
        .MaximumScale = 25
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    ActiveChart.SeriesCollection(2).Select
    With Selection.Border
        .ColorIndex = 57
        .Weight = xlMedium
        .LineStyle = xlContinuous
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
        .ColorIndex = 57
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range( _
        "E1:E433,BN1:BN433,CL1:CL433"), PlotBy:=xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart.Axes(xlCategory)
        .HasMajorGridlines = True
        .HasMinorGridlines = False
    End With
    With ActiveChart.Axes(xlValue)
        .HasMajorGridlines = True
        .HasMinorGridlines = False
    End With
    Sheets("ASHP").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 1
        .MaximumScale = 25
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range( _
        "E1:E433,EX1:EX433,FG1:FI433,FK1:FK433"), PlotBy:=xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart.Axes(xlCategory)
        .HasMajorGridlines = True
        .HasMinorGridlines = False
    End With
    With ActiveChart.Axes(xlValue)
        .HasMajorGridlines = True
        .HasMinorGridlines = False
    End With
    ActiveChart.SeriesCollection(4).Select
    With Selection.Border
        .ColorIndex = 57
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    ActiveChart.SeriesCollection(3).Select
    With Selection.Border
        .ColorIndex = 57
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    ActiveChart.SeriesCollection(5).Select
    With Selection.Border
        .ColorIndex = 57
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    ActiveChart.SeriesCollection(2).Select
    With Selection.Border
        .ColorIndex = 57
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    Sheets("Temps").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 1
        .MaximumScale = 25
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 1
        .MaximumScale = 25
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    ActiveChart.SeriesCollection(2).Select
    Selection.delete
    ActiveChart.SeriesCollection(4).Select
    Selection.delete
    ActiveChart.Axes(xlValue).Select
    With ActiveChart.Axes(xlValue)
        .MinimumScale = 10
        .MaximumScale = 50
        .MinorUnitIsAuto = True
        .MajorUnitIsAuto = True
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range( _
        "E1:E433,G1:G433,BC1:BC433,CA1:CA433,DW1:DW433"), PlotBy:=xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart
        .HasTitle = False
        .Axes(xlCategory, xlPrimary).HasTitle = True
        .Axes(xlCategory, xlPrimary).AxisTitle.Characters.Text = "Time (hr)"
        .Axes(xlValue, xlPrimary).HasTitle = True
        .Axes(xlValue, xlPrimary).AxisTitle.Characters.Text = _
        "Temperature (deg C) "
    End With
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range( _
        "E1:E433,G1:G433,BC1:BC433,CA1:CA433,DW1:DW433"), PlotBy:=xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart.Axes(xlCategory)
        .HasMajorGridlines = True
        .HasMinorGridlines = False
    End With
    With ActiveChart.Axes(xlValue)
        .HasMajorGridlines = True
        .HasMinorGridlines = False
    End With
    ActiveChart.SeriesCollection(4).Select
    With Selection.Border
        .ColorIndex = 57
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    Sheets("Temps").Select
    ActiveChart.SeriesCollection(2).Select
    With Selection.Border
        .ColorIndex = 11
        .Weight = xlThin
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    With Selection.Border
        .ColorIndex = 11
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    ActiveChart.SeriesCollection(3).Select
    With Selection.Border
        .ColorIndex = 7
        .Weight = xlMedium
        .LineStyle = xlContinuous
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
        .ColorIndex = 4
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    Sheets("RH").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 1
        .MaximumScale = 25
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range( _
        "E1:F433,AD1:AD433,BB1:BB433,BZ1:BZ433,CX1:CX433,DV1:DV433"), PlotBy:= _
        xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart.Axes(xlCategory)
        .HasMajorGridlines = True
        .HasMinorGridlines = False
    End With
    With ActiveChart.Axes(xlValue)
        .HasMajorGridlines = True
        .HasMinorGridlines = False
    End With
    ActiveChart.PlotArea.Select
    With Selection.Border
        .ColorIndex = 16
        .Weight = xlThin
        .LineStyle = xlContinuous
    End With
    With Selection.Interior
        .ColorIndex = 2
        .PatternColorIndex = 1
        .Pattern = xlSolid
    End With
    ActiveChart.SeriesCollection(1).Select
    With Selection.Border
        .ColorIndex = 4
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    ActiveChart.SeriesCollection(3).Select
    With Selection.Border
        .ColorIndex = 5
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    ActiveChart.SeriesCollection(4).Select
    With Selection.Border
        .ColorIndex = 7
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    Sheets("Power").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 1
        .MaximumScale = 25
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range("E1:E433,FO1:FO433"), _
        PlotBy:=xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart.Axes(xlCategory)
        .HasMajorGridlines = True
        .HasMinorGridlines = False
    End With
    With ActiveChart.Axes(xlValue)
        .HasMajorGridlines = True
        .HasMinorGridlines = False
    End With
    ActiveChart.SeriesCollection(1).Select
    With Selection.Border
        .ColorIndex = 1
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    Sheets("PLR").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 1
        .MaximumScale = 25
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range("E1:E433,FM1:FM433"), _
        PlotBy:=xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart.Axes(xlCategory)
        .HasMajorGridlines = True
        .HasMinorGridlines = False
    End With
    With ActiveChart.Axes(xlValue)
        .HasMajorGridlines = True
        .HasMinorGridlines = False
    End With
    ActiveChart.SeriesCollection(1).Select
    With Selection.Border
        .ColorIndex = 1
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
'    Sheets("Sheet1").Select
'    ActiveWindow.SelectedSheets.delete
'    Sheets("RetAirFrac").Select
'    ActiveWindow.SelectedSheets.delete
'    Sheets("ZoneCapFrac").Select
'    ActiveWindow.SelectedSheets.delete
'    Sheets("InterZoneFlows").Select
'    ActiveWindow.SelectedSheets.delete
    
    Sheets("Power").Select
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range("E1:E433,FO1:FO433"), _
        PlotBy:=xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart
        .HasTitle = True
        .ChartTitle.Characters.Text = _
        "Total cooling power (compressor + circ fan + cond fan) (W)"
        .Axes(xlCategory, xlPrimary).HasTitle = True
        .Axes(xlCategory, xlPrimary).AxisTitle.Characters.Text = "Hour"
        .Axes(xlValue, xlPrimary).HasTitle = True
        .Axes(xlValue, xlPrimary).AxisTitle.Characters.Text = "Power (W) "
    End With
    Sheets("Cooling Loads").Select
    Sheets("Cooling Loads").Name = "ZoneSuppliedCooling"
    Sheets("Temps").Select
    Sheets("Temps").Name = "ZoneTemps"
    Sheets("RH").Select
    Sheets("RH").Name = "ZoneRH"
    Sheets("Power").Select
    Sheets("Power").Name = "ACPower"
    Sheets("PLR").Select
    Sheets("PLR").Move After:=Sheets(7)
    Sheets("ZoneTemps").Select
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range( _
        "E1:E433,G1:G433,BC1:BC433,CA1:CA433,DW1:DW433"), PlotBy:=xlColumns
    ActiveChart.SeriesCollection.NewSeries
    ActiveChart.SeriesCollection(5).XValues = "=out!R2C5:R289C5"
    ActiveChart.SeriesCollection(5).Values = "=out!R2C150:R289C150"
    ActiveChart.SeriesCollection(5).Name = "=out!R1C150"
    ActiveChart.Location Where:=xlLocationAsNewSheet
    ActiveChart.SeriesCollection(5).Select
    With Selection.Border
        .ColorIndex = 1
        .Weight = xlThick
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    ActiveChart.ChartArea.Select
    
    ActiveChart.Legend.Select
    Selection.Left = 66
    Selection.Top = 30
    With ActiveChart.PageSetup
        .LeftHeader = ""
        .CenterHeader = ""
        .RightHeader = ""
        .LeftFooter = ""
        .CenterFooter = ""
        .RightFooter = ""
        .LeftMargin = Application.InchesToPoints(0.748031496062992)
        .RightMargin = Application.InchesToPoints(4.13385826771654)
        .TopMargin = Application.InchesToPoints(0.984251968503937)
        .BottomMargin = Application.InchesToPoints(0.984251968503937)
        .HeaderMargin = Application.InchesToPoints(0.511811023622047)
        .FooterMargin = Application.InchesToPoints(0.511811023622047)
        .ChartSize = xlFullPage
        .PrintQuality = 600
        .CenterHorizontally = False
        .CenterVertically = False
        .Orientation = xlLandscape
        .Draft = False
        .PaperSize = xlPaperLetter
        .FirstPageNumber = xlAutomatic
        .BlackAndWhite = False
        .Zoom = 100
    End With
    ActiveChart.PlotArea.Select
    Selection.Width = 393
    ActiveChart.Axes(xlCategory).Select
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
    Selection.TickLabels.AutoScaleFont = True
    With Selection.TickLabels.Font
        .Name = "Arial"
        .Size = 12
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
        .Background = xlAutomatic
    End With
    Selection.TickLabels.AutoScaleFont = True
    With Selection.TickLabels.Font
        .Name = "Arial"
        .Size = 10
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
        .Background = xlAutomatic
    End With
    ActiveChart.Axes(xlCategory).AxisTitle.Select
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
    Selection.Left = 194
    Selection.Top = 424
    ActiveChart.Axes(xlValue).AxisTitle.Select
    Selection.AutoScaleFont = True
    With Selection.Font
        .Name = "Arial"
        .Size = 15.5
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
        .Background = xlAutomatic
    End With
    ActiveChart.Axes(xlValue).Select
    Selection.TickLabels.AutoScaleFont = True
    With Selection.TickLabels.Font
        .Name = "Arial"
        .Size = 12
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
        .Background = xlAutomatic
    End With
    Selection.TickLabels.Font.Bold = True
    ActiveChart.Legend.Select
    Selection.Left = 60
    Selection.Top = 26
    ActiveChart.SeriesCollection(2).Select
    With Selection.Border
        .ColorIndex = 41
        .Weight = xlMedium
        .LineStyle = xlContinuous
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
    ActiveChart.Legend.Select
    Selection.AutoScaleFont = True
    With Selection.Font
        .Name = "Arial"
        .Size = 10
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
        .Background = xlAutomatic
    End With
    Selection.Width = 166
    Selection.Height = 93
    Selection.Top = 47
    Selection.Height = 83
    Selection.Left = 203
    Selection.Top = 313
    Selection.Top = 303
    Selection.Height = 93
    ActiveChart.ChartArea.Select
    ActiveChart.SeriesCollection(4).Select
    Selection.delete
    ActiveChart.Axes(xlValue).Select
    With ActiveChart.Axes(xlValue)
        .MinimumScale = 10
        .MaximumScale = 35
        .MinorUnitIsAuto = True
        .MajorUnitIsAuto = True
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    ActiveChart.Legend.Select
    Selection.Width = 184
    ActiveChart.Axes(xlValue).Select
    With ActiveChart.Axes(xlValue)
        .MinimumScale = 10
        .MaximumScale = 35
        .MinorUnitIsAuto = True
        .MajorUnit = 2
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    With ActiveChart.Axes(xlValue)
        .MinimumScale = 10
        .MaximumScale = 36
        .MinorUnitIsAuto = True
        .MajorUnit = 2
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    ActiveChart.Legend.Select
    Selection.Left = 215
    Selection.Top = 317

    ActiveChart.SeriesCollection(1).Select
    With Selection.Border
        .ColorIndex = 3
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    ActiveChart.ChartArea.Select
    ActiveChart.Deselect

'rename headings
    Sheets("out").Select
    Range("F1").Select
    ActiveCell.FormulaR1C1 = "Basement RH"
    With ActiveCell.Characters(Start:=1, Length:=11).Font
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
    Range("G1").Select
    ActiveCell.FormulaR1C1 = "Basement"
    With ActiveCell.Characters(Start:=1, Length:=8).Font
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
    Range("G2").Select
    Range("BC1").Select
    ActiveCell.FormulaR1C1 = "Main Zone T"
    With ActiveCell.Characters(Start:=1, Length:=11).Font
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
    Range("BB1").Select
    ActiveCell.FormulaR1C1 = "Main Zone RH"
    With ActiveCell.Characters(Start:=1, Length:=12).Font
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
    Range("BB2").Select
    Range("G1").Select
    ActiveCell.FormulaR1C1 = "Basement T"
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
    Range("CA1").Select
    ActiveCell.FormulaR1C1 = "Upper Zone T"
    With ActiveCell.Characters(Start:=1, Length:=12).Font
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
    Range("BZ1").Select
    ActiveCell.FormulaR1C1 = "Upper Zone RH"
    With ActiveCell.Characters(Start:=1, Length:=13).Font
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
    Range("BZ2").Select
    Range("EU1").Select
    ActiveCell.FormulaR1C1 = "Outdoor RH"
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
    Range("ET1").Select
    ActiveCell.FormulaR1C1 = "Outdoor T"
    With ActiveCell.Characters(Start:=1, Length:=9).Font
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
    Range("FO1").Select
    ActiveCell.FormulaR1C1 = "Total Cooling Power (compressor + circ. fan + cond. fan) (W)"
    With ActiveCell.Characters(Start:=1, Length:=9).Font
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

'rename axes
    Sheets("ZoneSuppliedCooling").Select
    ActiveChart.Axes(xlCategory).AxisTitle.Select
    Selection.Characters.Text = "Time (hr EDT)"
    Selection.AutoScaleFont = False
    With Selection.Characters(Start:=1, Length:=13).Font
        .Name = "Arial"
        .FontStyle = "Bold"
        .Size = 10
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
    End With
    ActiveChart.ChartArea.Select
    Sheets("ASHP").Select
    ActiveChart.Axes(xlCategory).AxisTitle.Select
    Selection.Characters.Text = "Time (hr EDT)"
    Selection.AutoScaleFont = False
    With Selection.Characters(Start:=1, Length:=13).Font
        .Name = "Arial"
        .FontStyle = "Bold"
        .Size = 10
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
    End With
    ActiveChart.ChartArea.Select
    Sheets("ZoneTemps").Select
    ActiveChart.Axes(xlCategory).AxisTitle.Select
    Selection.Characters.Text = "Time (hr EDT)"
    Selection.AutoScaleFont = False
    With Selection.Characters(Start:=1, Length:=13).Font
        .Name = "Arial"
        .FontStyle = "Bold"
        .Size = 14
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
    End With
    ActiveChart.ChartArea.Select
    ActiveChart.Legend.Select
    Selection.Left = 187
    Selection.Top = 248
    Selection.AutoScaleFont = False
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
    ActiveChart.Axes(xlCategory).MajorGridlines.Select
    ActiveChart.PlotArea.Select
    Selection.Height = 402
    ActiveChart.Axes(xlCategory).AxisTitle.Select
    Selection.Left = 185
    Selection.Top = 410
    ActiveChart.Axes(xlCategory).Select
    Selection.TickLabels.Font.Bold = True
    Sheets("ZoneRH").Select
    ActiveChart.Axes(xlCategory).AxisTitle.Select
    Selection.Characters.Text = "Time (hr EDT)"
    Selection.AutoScaleFont = False
    With Selection.Characters(Start:=1, Length:=13).Font
        .Name = "Arial"
        .FontStyle = "Bold"
        .Size = 10
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
    End With
    ActiveChart.ChartArea.Select
    Sheets("ACPower").Select
    ActiveChart.Axes(xlCategory).AxisTitle.Select
    Selection.Characters.Text = "Time (hr EDT)"
    Selection.AutoScaleFont = False
    With Selection.Characters(Start:=1, Length:=13).Font
        .Name = "Arial"
        .FontStyle = "Bold"
        .Size = 10
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
    End With
    ActiveChart.ChartArea.Select
    Sheets("Avg Power").Select
    ActiveChart.Axes(xlCategory).AxisTitle.Select
    Selection.Characters.Text = "Time (hr EDT)"
    Selection.AutoScaleFont = False
    With Selection.Characters(Start:=1, Length:=13).Font
        .Name = "Arial"
        .FontStyle = "Bold"
        .Size = 8
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
    End With
    ActiveChart.ChartArea.Select
    ActiveChart.Axes(xlCategory).Select
    Selection.TickLabels.Font.Bold = True
    Sheets("PLR").Select
    ActiveChart.Axes(xlCategory).AxisTitle.Select
    Selection.Characters.Text = "Time (hr EDT)"
    Selection.AutoScaleFont = False
    With Selection.Characters(Start:=1, Length:=13).Font
        .Name = "Arial"
        .FontStyle = "Bold"
        .Size = 10
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
    End With
    ActiveChart.ChartArea.Select
    ActiveChart.Axes(xlValue).Select
    With ActiveChart.Axes(xlValue)
        .MinimumScale = 0
        .MaximumScale = 1
        .MinorUnitIsAuto = True
        .MajorUnitIsAuto = True
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    Sheets("ZoneTemps").Select

'delete clutter graph labels
    Sheets("ZoneRH").Select
    ActiveChart.Legend.Select
    ActiveChart.Legend.LegendEntries(2).Select
    Selection.delete
    ActiveChart.Legend.Select
    ActiveChart.Legend.LegendEntries(4).Select
    Selection.delete
    ActiveChart.Legend.Select
    ActiveChart.Legend.LegendEntries(4).Select
    Selection.delete

'add weather
    Sheets("out").Select
    Columns("ET:EV").Select
    Range("ET:EV,E:E").Select
    Range("E1").Activate
    Charts.Add
    ActiveChart.ChartType = xlXYScatterLinesNoMarkers
    ActiveChart.SetSourceData Source:=Sheets("out").Range("E1:E578,ET1:EV578"), _
        PlotBy:=xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart.Axes(xlCategory)
        .HasMajorGridlines = True
        .HasMinorGridlines = False
    End With
    With ActiveChart.Axes(xlValue)
        .HasMajorGridlines = True
        .HasMinorGridlines = False
    End With
    Sheets("Chart6").Select
    Sheets("Chart6").Name = "Weather"
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 0
        .MaximumScale = 25
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    ActiveChart.SeriesCollection(3).Select
    ActiveChart.SeriesCollection(3).AxisGroup = 2
    With Selection.Border
        .Weight = xlThin
        .LineStyle = xlAutomatic
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlAutomatic
        .MarkerForegroundColorIndex = xlAutomatic
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 5
        .Shadow = False
    End With
    ActiveChart.PlotArea.Select
    With Selection.Border
        .ColorIndex = 16
        .Weight = xlThin
        .LineStyle = xlContinuous
    End With
    With Selection.Interior
        .ColorIndex = 2
        .PatternColorIndex = 1
        .Pattern = xlSolid
    End With
    ActiveChart.SeriesCollection(3).Select
    With Selection.Border
        .ColorIndex = 45
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 5
        .Shadow = False
    End With
    ActiveChart.SeriesCollection(1).Select
    With Selection.Border
        .ColorIndex = 1
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    ActiveChart.SeriesCollection(2).Select
    With Selection.Border
        .ColorIndex = 42
        .Weight = xlMedium
        .LineStyle = xlContinuous
    End With
    With Selection
        .MarkerBackgroundColorIndex = xlNone
        .MarkerForegroundColorIndex = xlNone
        .MarkerStyle = xlNone
        .Smooth = False
        .MarkerSize = 3
        .Shadow = False
    End With
    ActiveChart.SetSourceData Source:=Sheets("out").Range("E1:E578,ET1:EV578"), _
        PlotBy:=xlColumns
    ActiveChart.Location Where:=xlLocationAsNewSheet
    With ActiveChart
        .HasTitle = False
        .Axes(xlCategory, xlPrimary).HasTitle = True
        .Axes(xlCategory, xlPrimary).AxisTitle.Characters.Text = "Time (hr EDT)"
        .Axes(xlValue, xlPrimary).HasTitle = True
        .Axes(xlValue, xlPrimary).AxisTitle.Characters.Text = _
        "Temp (deg C) / RH (%)"
        .Axes(xlCategory, xlSecondary).HasTitle = False
        .Axes(xlValue, xlSecondary).HasTitle = True
        .Axes(xlValue, xlSecondary).AxisTitle.Characters.Text = _
        "Solar Radiation (W/m2)"
    End With
    Sheets("ZoneTemps").Select

    Sheets("ZoneSuppliedCooling").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 0
        .MaximumScale = 24
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    Sheets("ASHP").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 0
        .MaximumScale = 24
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    Sheets("ZoneTemps").Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 0
        .MaximumScale = 24
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    Sheets("ZoneRH").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 0
        .MaximumScale = 24
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    Sheets("ACPower").Select
    Sheets("ACPower").Name = "ACPower"
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 0
        .MaximumScale = 24
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    Sheets("PLR").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 0
        .MaximumScale = 24
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    Sheets("Weather").Select
    ActiveChart.Axes(xlCategory).Select
    With ActiveChart.Axes(xlCategory)
        .MinimumScale = 0
        .MaximumScale = 24
        .MinorUnitIsAuto = True
        .MajorUnit = 1
        .Crosses = xlAutomatic
        .ReversePlotOrder = False
        .ScaleType = xlLinear
        .DisplayUnit = xlNone
    End With
    Sheets("out").Select
    Range("E290:E462").Select
    Selection.ClearContents
    Sheets("ZoneTemps").Select



End Sub
