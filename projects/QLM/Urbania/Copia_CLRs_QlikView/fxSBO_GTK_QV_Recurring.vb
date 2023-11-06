Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.SqlTypes
Imports Microsoft.SqlServer.Server
Imports System.Runtime.InteropServices
Imports System.Collections
Imports Microsoft.VisualBasic
Imports System.Collections.Generic

Partial Public Class UserDefinedFunctions

    Private Const k_TipoDocContable As String = "C"
    Private Const k_TipoDocDocumento As String = "D"

    Private Class Master_QVRecurring
        Public IBAN As String
        Public ObjType As String
        Public Code As String
        Public Description As String
        Public DocEntry As Integer
        Public Serie As String
        Public DocNum As Integer
        Public DocDate As Date
        Public DocDueDate As Date
        Public CardCode As String
        Public CardName As String
        Public LineNum As Integer
        Public ItemCode As String
        Public OcrCode As String
        Public OcrCode2 As String
        Public OcrCode3 As String
        Public OcrCode4 As String
        Public OcrCode5 As String
        Public Project As String
        Public Year As Integer
        Public Month As Integer
        Public Import As Double
        Public Vat As Double

        Public Sub New()
            ' simplemente nuevo sin nada
        End Sub

        Public Sub New(base As Master_QVRecurring)
            Me.IBAN = base.IBAN
            Me.ObjType = base.ObjType
            Me.Code = base.Code
            Me.Description = base.Description
            Me.DocEntry = base.DocEntry
            Me.Serie = base.Serie
            Me.DocNum = base.DocNum
            Me.DocDate = base.DocDate

            Me.DocDueDate = base.DocDueDate
            Me.CardCode = base.CardCode
            Me.CardName = base.CardName
            Me.LineNum = base.LineNum
            Me.ItemCode = base.ItemCode
            Me.OcrCode = base.OcrCode
            Me.OcrCode2 = base.OcrCode2
            Me.OcrCode3 = base.OcrCode3
            Me.OcrCode4 = base.OcrCode4
            Me.OcrCode5 = base.OcrCode5
            Me.Project = base.Project
            Me.Year = base.Year
            Me.Month = base.Month
            Me.Import = base.Import
            Me.Vat = base.Vat
        End Sub

    End Class

    'Private Const k_SQLTipoDocContable As String = vbNewLine &
    '    "SELECT '{1}' [ObjType], R.RcurCode [Code], R.RcurDesc [Dscription], R.Instance [DocEntry], '{2}' [SeriesName], R.NextDeu [DocDate], R.NextDeu [DocDueDate], T.OcrCode, T.OcrCode2, T.OcrCode3, T.Project, T.LineTotal, " & vbNewLine &
    '    vbTab & "R.Frequency, R.Remind, R.NextDeu [StartDate], R.LimitDate [EndDate] " & vbNewLine &
    '    "FROM [{0}]..ORCR R WITH (NOLOCK) " & vbNewLine &
    '    vbTab & "INNER JOIN (SELECT T.RcurCode, T.Instance, T.Project, T.OcrCode, T.OcrCode2, T.OcrCode3, ISNULL(SUM(T.Credit * S.Signo), 0.0) [LineTotal] " & vbNewLine &
    '    vbTab & vbTab & "FROM [{0}]..RCR1 T WITH (NOLOCK) " & vbNewLine &
    '    vbTab & vbTab & vbTab & "INNER JOIN(SELECT T.RcurCode, T.Instance, MAX(CASE LEFT(AcctCode, 1) WHEN '6' THEN -1 ELSE 1 END) [Signo] " & vbNewLine &
    '    vbTab & vbTab & vbTab & vbTab & "FROM [{0}]..RCR1 T WITH (NOLOCK) " & vbNewLine &
    '    vbTab & vbTab & vbTab & vbTab & "WHERE LEFT(T.AcctCode, 1) IN ('6', '7') " & vbNewLine &
    '    vbTab & vbTab & vbTab & vbTab & "GROUP BY T.RcurCode, T.Instance) S ON S.RcurCode = T.RcurCode AND S.Instance = T.Instance " & vbNewLine &
    '    vbTab & vbTab & "WHERE (T.AcctCode LIKE '{3}%') " & vbNewLine &
    '    vbTab & vbTab & vbTab & "AND (T.RcurCode IN (SELECT T.RcurCode FROM [{0}]..RCR1 T WITH (NOLOCK) WHERE (LEFT(T.AcctCode, 1) = '{1}'))) " & vbNewLine &
    '    vbTab & vbTab & "GROUP BY T.RcurCode, T.Instance, T.Project, T.OcrCode, T.OcrCode2, T.OcrCode3 " & vbNewLine &
    '    vbTab & vbTab & ") T ON T.RcurCode = R.RcurCode AND T.Instance = R.Instance " & vbNewLine &
    '    "WHERE (R.Frequency != 'T') " & vbNewLine &
    '    vbTab & "AND (R.NextDeu <= CONVERT(DATE, '{4}', 103)) " & vbNewLine &
    '    vbTab & "AND (ISNULL(R.LimitDate, '') = '' OR R.LimitDate >= CONVERT(DATE, '{5}', 103)) "
    ''vbTab & "--ANDd (ISNULL(R.LimitDate, '') = '' OR R.LimitDate BETWEEN CONVERT(DATE, '01/01/2018 0:00:00', 103) AND CONVERT(DATE, '31/12/2019 0:00:00', 103)) "

    Private Const k_SQLTipoDocContable As String = vbNewLine &
        "SELECT '{1}' [ObjType], T.IBAN [U_GTK_IBAN], R.RcurCode [Code], R.RcurDesc [Dscription], R.Instance [DocEntry], '{1}' [SeriesName], R.NextDeu [DocDate], R.NextDeu [DocDueDate], " & vbNewLine &
        vbTab & "T.OcrCode, T.OcrCode2, T.OcrCode3, T.OcrCode4, T.OcrCode5, T.Project, T.LineTotal, R.Frequency, R.Remind, R.NextDeu [StartDate], R.LimitDate [EndDate] " & vbNewLine &
        "FROM [{0}]..ORCR R WITH (NOLOCK) " & vbNewLine &
        vbTab & "INNER JOIN (SELECT T.RcurCode, T.Instance, B.IBAN, T.Project, T.OcrCode, T.OcrCode2, T.OcrCode3, T.OcrCode4, T.OcrCode5, ISNULL(SUM(CASE '{2}' WHEN 'P' THEN -T.Credit ELSE T.Debit END), 0.0) [LineTotal] " & vbNewLine &
        vbTab & vbTab & "FROM [{0}]..RCR1 T WITH (NOLOCK) " & vbNewLine &
        vbTab & vbTab & vbTab & "LEFT JOIN [{0}]..DSC1 B WITH (NOLOCK) ON B.GLAccount = T.AcctCode " & vbNewLine &
        vbTab & vbTab & "WHERE (T.AcctCode LIKE '{4}') " & vbNewLine &
        vbTab & vbTab & vbTab & "AND (T.RcurCode IN (SELECT T.RcurCode FROM [{0}]..RCR1 T WITH (NOLOCK) WHERE (T.AcctCode LIKE '{3}'))) " & vbNewLine &
        vbTab & vbTab & "GROUP BY T.RcurCode, T.Instance, B.IBAN, T.Project, T.OcrCode, T.OcrCode2, T.OcrCode3, T.OcrCode4, T.OcrCode5 " & vbNewLine &
        vbTab & vbTab & ") T ON T.RcurCode = R.RcurCode And T.Instance = R.Instance " & vbNewLine &
        "WHERE (R.Frequency != 'T') " & vbNewLine &
        vbTab & "AND (R.NextDeu <= CONVERT(DATE, '{5}', 103)) " & vbNewLine &
        vbTab & "AND (ISNULL(R.LimitDate, '') = '' OR R.LimitDate >= CONVERT(DATE, '{6}', 103)) "

    Private Const k_SQLTipoDocDocumento As String = vbNewLine &
        "Select D.ObjType, M.U_GTK_IBAN, R.Code, ISNULL(R.Dscription, O.Descript) [Dscription], M.DocEntry, S.SeriesName, M.DocNum, M.DocDate, R.EndDate [DocDueDate], M.CardCode, M.CardName, " & vbNewLine &
        vbTab & "D.LineNum, ISNULL(D.U_GTK_ARTICULO, O1.ItemCode) [U_GTK_ARTICULO], D.OcrCode, D.OcrCode2, D.OcrCode3, D.OcrCode4, D.OcrCode5, ISNULL(IIF(D.Project = '', NULL, D.Project), M.Project) [Project], " & vbNewLine &
        vbTab & "D.GTotal [LineTotal], D.VatSum [Vat], M.ExtraMonth, M.ExtraDays, R.Frequency, R.Remind, R.StartDate, R.EndDate " & vbNewLine &
        "FROM [{0}]..ORCP R WITH (NOLOCK) " & vbNewLine &
        vbTab & "LEFT JOIN [{0}]..ODRF M WITH (NOLOCK) ON M.ObjType = R.DocObjType And M.DocEntry = R.DraftEntry " & vbNewLine &
        vbTab & "INNER JOIN [{0}]..NNM1 S WITH (NOLOCK) ON S.Series = M.Series " & vbNewLine &
        vbTab & "INNER JOIN [{0}]..DRF1 D WITH (NOLOCK) ON D.DocEntry = M.DocEntry " & vbNewLine &
        vbTab & "LEFT JOIN [{0}]..OAT4 O4 WITH (NOLOCK) ON O4.RcpEntry = R.AbsEntry " & vbNewLine &
        vbTab & "LEFT JOIN [{0}]..OOAT O WITH (NOLOCK) ON O.AbsID = O4.AgrNo " & vbNewLine &
        vbTab & "LEFT JOIN [{0}]..OAT1 O1 WITH (NOLOCK) ON O1.AgrNo = O.AbsID " & vbNewLine &
        "WHERE (D.LineStatus = 'O') " & vbNewLine &
        vbTab & "AND R.StartDate <= CONVERT(DATE, '{1}', 103) " & vbNewLine &
        vbTab & "AND (ISNULL(R.EndDate, '') = '' OR R.EndDate >= CONVERT(DATE, '{2}', 103)) "

    <Microsoft.SqlServer.Server.SqlFunction(DataAccess:=DataAccessKind.Read,
        FillRowMethodName:="FillRow_QV_Recurring",
        TableDefinition:="IBAN nvarchar(24), ObjType nvarchar(20), Code nvarchar(8), Description nvarchar(50), DocEntry Integer, Serie nvarchar(8), DocNum Integer, DocDate datetime, DocDueDate datetime, " &
                        "CardCode nvarchar(15), CardName nvarchar(100), LineNum Integer, ItemCode nvarchar(50), OcrCode nvarchar(8), OcrCode2 nvarchar(8), OcrCode3 nvarchar(8), OcrCode4 nvarchar(8), OcrCode5 nvarchar(8), " &
                        "Project nvarchar(20), Year Integer, Month Integer, Import Decimal(19, 6), Vat Decimal(19, 6), QuarterDate datetime")>
    Public Shared Function fxSBO_GTK_QV_Recurring(ByVal baseDatos As String, docType As String, ByVal naturaleza As String, ByVal tipoObjeto As String, ByVal cuentaFiltro As String, ByVal cuentaCalculo As String, ByVal desdeFecha As Date, fechaLimite As Date) As IEnumerable
        Dim resultado As New ArrayList
        '
        Dim strSQL As String = String.Empty
        '
        If docType.Trim.Equals(k_TipoDocContable, StringComparison.CurrentCultureIgnoreCase) Then
            strSQL = String.Format(k_SQLTipoDocContable, baseDatos, tipoObjeto, naturaleza, cuentaFiltro, cuentaCalculo, fechaLimite, desdeFecha)
        ElseIf docType.Trim.Equals(k_TipoDocDocumento, StringComparison.CurrentCultureIgnoreCase) Then
            strSQL = String.Format(k_SQLTipoDocDocumento, baseDatos, fechaLimite, desdeFecha)
        End If
        '
        Log("fxSBO_GTK_QV_Recurring SQL: " & vbNewLine & strSQL)
        '
        Dim conexion As New SqlConnection("context connection=true")
        conexion.Open()
        '
        Dim dt As DataTable = Nothing
        '
        Try
            dt = SQLToDataSet(strSQL, conexion).Tables(0)
            '
            If dt.Rows.Count > 0 Then
                SendData_QV_Recurring(dt, resultado, desdeFecha, fechaLimite)
                '
                Return resultado
            Else
                Return resultado
            End If
        Catch ex As Exception
            LogSiempre("fxSBO_GTK_QV_Recurring: " & ex.StackTrace)
            '
            Return Nothing
        Finally
            LiberarObjeto(dt)
            '
            conexion.Close()
            conexion.Dispose()
            '
            LiberarObjeto(conexion)
            '
            GC.Collect()
        End Try
    End Function

    Private Shared Sub SendData_QV_Recurring(ByRef dr As DataTable, ByRef resultado As ArrayList, ByVal desdeFecha As Date, ByVal fechaLimite As Date)
        Try
            For Each oRow As DataRow In dr.Rows
                Try
                    Dim base As New Master_QVRecurring
                    '
                    base.IBAN = DameValor(oRow, "U_GTK_IBAN")
                    base.ObjType = DameValor(oRow, "ObjType")
                    base.Code = DameValor(oRow, "Code")
                    base.Description = DameValor(oRow, "Dscription")
                    base.DocEntry = CInt(DameValor(oRow, "DocEntry"))
                    base.Serie = DameValor(oRow, "SeriesName")
                    base.DocNum = CInt(DameValor(oRow, "DocNum"))
                    base.DocDate = CDate(DameValor(oRow, "DocDate"))
                    base.DocDueDate = CDate(DameValor(oRow, "DocDueDate"))
                    base.CardCode = DameValor(oRow, "CardCode")
                    base.CardName = DameValor(oRow, "CardName")
                    base.LineNum = CInt(DameValor(oRow, "LineNum"))
                    base.ItemCode = DameValor(oRow, "U_GTK_ARTICULO")
                    base.OcrCode = DameValor(oRow, "OcrCode")
                    base.OcrCode2 = DameValor(oRow, "OcrCode2")
                    base.OcrCode3 = DameValor(oRow, "OcrCode3")
                    base.OcrCode4 = DameValor(oRow, "OcrCode4")
                    base.OcrCode5 = DameValor(oRow, "OcrCode5")
                    base.Project = DameValor(oRow, "Project")
                    base.Import = CDbl(DameValor(oRow, "LineTotal"))
                    base.Vat = CDbl(DameValor(oRow, "Vat"))
                    '
                    Dim mesesVcto As Integer = 0
                    Dim diasVcto As Integer = 0
                    Dim frecuencia As String = String.Empty
                    Dim recuerdo As Integer = 0
                    Dim fInicio As Date
                    Dim fFin As Date
                    Dim sinFin As Boolean = False
                    '
                    mesesVcto = CInt(DameValor(oRow, "ExtraMonth"))
                    diasVcto = CInt(DameValor(oRow, "ExtraDays"))
                    frecuencia = DameValor(oRow, "Frequency").ToString
                    recuerdo = CInt(DameValor(oRow, "Remind"))
                    fInicio = CDate(DameValor(oRow, "StartDate"))
                    '
                    If IsNothing(DameValor(oRow, "EndDate")) Then sinFin = True
                    '
                    fFin = CDate(DameValor(oRow, "EndDate"))
                    '
                    Dim fechaInicio As Date = fInicio
                    '
                    Dim diaInicio As Integer = Day(fechaInicio)
                    Dim incremento As Integer = 0
                    Dim diaSemana As Integer = 0
                    '
                    If recuerdo > 1000 Then
                        diaInicio = recuerdo - 1000
                    ElseIf recuerdo > 100 Then
                        incremento = recuerdo - 100
                    Else
                        diaSemana = recuerdo - 1
                    End If
                    '
                    If sinFin Then
                        fFin = fechaLimite
                    Else
                        If fFin > fechaLimite Then
                            fFin = fechaLimite
                        End If
                    End If
                    '
                    Dim fecha As Date = fechaInicio
                    '
                    Log("Fecha: " & fecha.ToShortDateString & ", Fin: " & fFin.ToShortDateString)
                    While fecha <= fFin
                        Log("Fecha: " & fecha.ToShortDateString & ", frecuencia: " & frecuencia & ", recuento: " & recuerdo.ToString & ", Inicio: " & fInicio.ToShortDateString & ", Fin: " & fFin.ToShortDateString)
                        '
                        Dim ok As Boolean = False
                        '
                        If frecuencia = "D" Then
                            ok = True
                        ElseIf frecuencia = "W" Then
                            If fecha.DayOfWeek = diaSemana Then
                                ok = True
                            End If
                        ElseIf frecuencia = "M" Then
                            Dim ultimoDia As Integer = Date.DaysInMonth(Year(fecha), Month(fecha))
                            'Log("ultimoDia: " & ultimoDia.ToString & ", diaInicio: " & diaInicio.ToString)
                            '
                            If ultimoDia < diaInicio Then
                                fecha = New Date(Year(fecha), Month(fecha), ultimoDia)
                            Else
                                fecha = New Date(Year(fecha), Month(fecha), diaInicio)
                            End If
                            '
                            'Log("fecha: " & fecha.ToShortDateString)
                            '
                            ok = True
                        ElseIf frecuencia = "Q" Then
                            ok = True
                        ElseIf frecuencia = "S" Then
                            ok = True
                        ElseIf frecuencia = "A" Then
                            ok = True
                        ElseIf frecuencia = "O" Then
                            ok = True
                        ElseIf frecuencia = "N" Then
                            ok = True
                        End If
                        '
                        Log("OK: " & ok.ToString & ", Fecha: " & fecha.ToShortDateString & ", Desde Fecha: " & desdeFecha.ToShortDateString)
                        If ok AndAlso fecha >= desdeFecha Then
                            Dim registro As New Master_QVRecurring(base)
                            '
                            registro.DocDate = fecha
                            '
                            Dim fechaVcto As Date = fecha
                            '
                            If mesesVcto > 0 Then
                                fechaVcto = fechaVcto.AddMonths(mesesVcto)
                            End If
                            '
                            If diasVcto > 0 Then
                                fechaVcto = fechaVcto.AddDays(diasVcto)
                            End If
                            '
                            Select Case base.Serie
                                Case "R"
                                    fechaVcto = DameFechaTrimestre(fechaVcto)
                                Case "S"
                                    fechaVcto = DameFechaProximoMes(fechaVcto)
                            End Select
                            '
                            registro.DocDueDate = fechaVcto
                            '
                            registro.Year = Year(fecha)
                                registro.Month = Month(fecha)
                                '
                                resultado.Add(registro)
                            End If
                            '
                            If frecuencia = "D" Then
                            fecha = fecha.AddDays(incremento)
                        ElseIf frecuencia = "W" Then
                            fecha = fecha.AddDays(1)
                        ElseIf frecuencia = "M" Then
                            fecha = fecha.AddMonths(1)
                        ElseIf frecuencia = "Q" Then
                            fecha = fecha.AddMonths(3)
                        ElseIf frecuencia = "S" Then
                            fecha = fecha.AddMonths(6)
                        ElseIf frecuencia = "A" Then
                            fecha = fecha.AddYears(1)
                        ElseIf frecuencia = "O" Then
                            Exit While
                        ElseIf frecuencia = "N" Then
                            Exit While
                        End If
                    End While
                Catch ex As Exception
                    LogSiempre("ERROR: " & ex.Message)
                End Try
            Next
        Catch ex As Exception
            LogSiempre("SendData_QV_Recurring: " & ex.StackTrace)
        End Try
    End Sub

    Public Shared Sub FillRow_QV_Recurring(ByVal objetoResultado As Object,
                <Out> ByRef sIBAN As SqlString, <Out> ByRef sObjType As SqlString, <Out> ByRef sCode As SqlString, <Out> ByRef sDescription As SqlString, <Out> ByRef iDocEntry As SqlInt32,
                <Out> ByRef sSerie As SqlString, <Out> ByRef iDocNum As SqlInt32, <Out> ByRef fDocDate As SqlDateTime, <Out> ByRef fDocDueDate As SqlDateTime, <Out> ByRef sCardCode As SqlString,
                <Out> ByRef sCardName As SqlString, <Out> ByRef iLineNum As SqlInt32, <Out> ByRef sItemCode As SqlString, <Out> ByRef sOcrCode As SqlString, <Out> ByRef sOcrCode2 As SqlString,
                <Out> ByRef sOcrCode3 As SqlString, <Out> ByRef sOcrCode4 As SqlString, <Out> ByRef sOcrCode5 As SqlString, <Out> ByRef sProject As SqlString, <Out> ByRef iYear As SqlInt32,
                <Out> ByRef iMonth As SqlInt32, <Out> ByRef dImport As SqlDecimal, <Out> ByRef dVat As SqlDecimal, <Out> ByRef fQuarterDate As SqlDateTime)
        '
        Dim maestro As Master_QVRecurring = DirectCast(objetoResultado, Master_QVRecurring)
        '        
        sIBAN = maestro.IBAN
        sObjType = maestro.ObjType
        sCode = maestro.Code
        sDescription = maestro.Description
        iDocEntry = maestro.DocEntry
        sSerie = maestro.Serie
        iDocNum = maestro.DocNum
        fDocDate = maestro.DocDate
        fDocDueDate = maestro.DocDueDate
        sCardCode = maestro.CardCode
        sCardName = maestro.CardName
        iLineNum = maestro.LineNum
        sItemCode = maestro.ItemCode
        sOcrCode = maestro.OcrCode
        sOcrCode2 = maestro.OcrCode2
        sOcrCode3 = maestro.OcrCode3
        sOcrCode4 = maestro.OcrCode4
        sOcrCode5 = maestro.OcrCode5
        sProject = maestro.Project
        iYear = maestro.Year
        iMonth = maestro.Month
        dImport = CType(maestro.Import, SqlDecimal)
        dVat = CType(maestro.Vat, SqlDecimal)
        '
        fQuarterDate = DameFechaTrimestre(New Date(maestro.Year, maestro.Month, 1))
    End Sub

End Class