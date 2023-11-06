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

    Private Class Master_QVDocuments
        Public IBAN As String
        Public DocEntry As Integer
        Public Serie As String
        Public DocNum As Integer
        Public DocDate As Date
        Public DocDueDate As Date
        Public RealDocDueDate As Date
        Public CardCode As String
        Public CardName As String
        Public GroupNum As Integer
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
        Public Spent As Double
        Public Paid As Double

        Public Sub New()
            ' simplemente nuevo sin nada
        End Sub

        Public Sub New(original As Master_QVDocuments)
            IBAN = original.IBAN
            DocEntry = original.DocEntry
            Serie = original.Serie
            DocNum = original.DocNum
            DocDate = original.DocDate
            DocDueDate = original.DocDueDate
            RealDocDueDate = original.RealDocDueDate
            CardCode = original.CardCode
            CardName = original.CardName
            GroupNum = original.GroupNum
            LineNum = original.LineNum
            ItemCode = original.ItemCode
            OcrCode = original.OcrCode
            OcrCode2 = original.OcrCode2
            OcrCode3 = original.OcrCode3
            OcrCode4 = original.OcrCode4
            OcrCode5 = original.OcrCode5
            Project = original.Project
            Year = original.Year
            Month = original.Month
            Import = original.Import
            Vat = original.Vat
            Spent = original.Spent
            Paid = original.Paid
        End Sub

    End Class

    Public Shared Function DameFechaTrimestre(fecha As Date) As Date
        Dim mesOrigen As Integer = Month(fecha)
        Dim añoOrigen As Integer = Year(fecha)
        '
        Dim mesDestino As Integer
        Dim añoDestino As Integer
        '
        If mesOrigen >= 1 AndAlso mesOrigen <= 3 Then
            mesDestino = 4
            añoDestino = añoOrigen
        ElseIf mesOrigen >= 4 AndAlso mesOrigen <= 6 Then
            mesDestino = 7
            añoDestino = añoOrigen
        ElseIf mesOrigen >= 7 AndAlso mesOrigen <= 9 Then
            mesDestino = 10
            añoDestino = añoOrigen
        Else
            mesDestino = 1
            añoDestino = añoOrigen + 1
        End If
        '
        Return New Date(añoDestino, mesDestino, 20)
    End Function

    Public Shared Function DameFechaProximoMes(fecha As Date) As Date
        fecha = fecha.AddMonths(1)
        '
        Dim mes As Integer = Month(fecha)
        Dim año As Integer = Year(fecha)
        '
        Dim dia As Integer = Date.DaysInMonth(año, mes)
        '
        Return New Date(año, mes, dia)
    End Function

    Public Shared Function DameFechaInicioTrimestre(fecha As Date) As Date
        Dim mesOrigen As Integer = Month(fecha)
        Dim añoOrigen As Integer = Year(fecha)
        '
        Dim mesDestino As Integer
        '
        If mesOrigen >= 1 AndAlso mesOrigen <= 3 Then
            mesDestino = 1
        ElseIf mesOrigen >= 4 AndAlso mesOrigen <= 6 Then
            mesDestino = 4
        ElseIf mesOrigen >= 7 AndAlso mesOrigen <= 9 Then
            mesDestino = 7
        Else
            mesDestino = 10
        End If
        '
        Return New Date(añoOrigen, mesDestino, 1)
    End Function

    Public Shared Function DameFechaInicioMes(fecha As Date) As Date
        Dim mesOrigen As Integer = Month(fecha)
        Dim añoOrigen As Integer = Year(fecha)
        '
        Return New Date(añoOrigen, mesOrigen, 1)
    End Function

    Private Const k_SQLAsientosSinDocumentos As String =
        "SELECT NULL [U_GTK_IBAN], TransId [DocEntry], SeriesName, Number [DocNum], RefDate [DocDate], DueDate [DocDueDate], DueDate [RealDocDueDate], ContraAct [CardCode], " & vbNewLine &
        vbTab & "CardName, Line_ID [LineNum], NULL [U_GTK_ARTICULO], ProfitCode [OcrCode], OcrCode2, OcrCode3, OcrCode4, OcrCode5, Project, YEAR(RefDate) [Year], MONTH(RefDate) [Month], " & vbNewLine &
        vbTab & "Neto + IVA - IRPF [Import], [IVA] [Vat], 0.0 [Spent], Pago [Paid] " & vbNewLine &
        "FROM (	SELECT T1.TransId, T2.SeriesName, T1.Number, T1.RefDate, T1.DueDate, T0.ContraAct, " & vbNewLine &
        vbTab & vbTab & "IC.CardName, T0.Line_ID, T0.ProfitCode, T0.OcrCode2, T0.OcrCode3, T0.OcrCode4, T0.OcrCode5, T0.Project, " & vbNewLine &
        vbTab & vbTab & "(T0.Debit - T0.Credit) [Neto], ISNULL(VAT.Importe, 0.0) [IVA], ISNULL(WT.Importe, 0.0) [IRPF], P.Pago " & vbNewLine &
        vbTab & "FROM [{0}]..JDT1 T0 WITH (NOLOCK) " & vbNewLine &
        vbTab & vbTab & "INNER JOIN [{0}]..OJDT T1 WITH (NOLOCK) ON T1.TransId = T0.TransId And T1.TransType = {2} " & vbNewLine &
        vbTab & vbTab & "INNER JOIN [{0}]..OCRD IC WITH (NOLOCK) ON IC.CardCode = T0.ContraAct " & vbNewLine &
        vbTab & vbTab & "LEFT JOIN (	SELECT T.TransId, (T.Debit - T.Credit) * CASE T.DebCred WHEN 'D' THEN 1 ELSE -1 END [Importe] " & vbNewLine &
        vbTab & vbTab & vbTab & "FROM [{0}]..JDT1 T WITH (NOLOCK) " & vbNewLine &
        vbTab & vbTab & vbTab & "WHERE T.VatLine = 'Y') VAT ON VAT.TransId = T0.TransId " & vbNewLine &
        vbTab & vbTab & "LEFT JOIN (	SELECT T.TransId, (T.Debit - T.Credit) * CASE T.DebCred WHEN 'D' THEN 1 ELSE -1 END [Importe] " & vbNewLine &
        vbTab & vbTab & vbTab & "FROM [{0}]..JDT1 T WITH (NOLOCK) " & vbNewLine &
        vbTab & vbTab & vbTab & "WHERE T.WTLine = 'Y') WT ON WT.TransId = T0.TransId " & vbNewLine &
        vbTab & vbTab & "LEFT JOIN [{0}]..NNM1 T2 WITH (NOLOCK) ON T2.Series = T1.Series " & vbNewLine &
        vbTab & vbTab & "LEFT JOIN ({4}) P ON P.DocEntry = T0.TransId " & vbNewLine &
        vbTab & "WHERE T0.Account LIKE '{1}%' " & vbNewLine &
        vbTab & vbTab & "AND (T1.DueDate >= CONVERT(DATE, '{3}', 103)) " & vbNewLine &
        ") R"

    Private Const k_SQLPagosDeAsiento As String =
        "SELECT T.DocEntry, SUM(T.SumApplied) [Pago], COUNT(*) [Cantidad] FROM [{0}]..VPM2 T WITH (NOLOCK) WHERE T.InvType = {1} GROUP BY T.DocEntry"

    Private Const k_SQLCobrosDeAsiento As String =
        "SELECT T.DocEntry, SUM(T.SumApplied) [Pago], COUNT(*) [Cantidad] FROM [{0}]..RCT2 T WITH (NOLOCK) WHERE T.InvType = {1} GROUP BY T.DocEntry"

    <Microsoft.SqlServer.Server.SqlFunction(DataAccess:=DataAccessKind.Read,
        FillRowMethodName:="FillRow_QV_Documents",
        TableDefinition:="IBAN nvarchar(24), DocEntry integer, Serie nvarchar(8), DocNum integer, DocDate datetime, DocDueDate datetime, RealDocDueDate datetime, " &
                        "CardCode nvarchar(15), CardName nvarchar(100), LineNum integer, ItemCode nvarchar(50), OcrCode nvarchar(8), OcrCode2 nvarchar(8), OcrCode3 nvarchar(8), OcrCode4 nvarchar(8), OcrCode5 nvarchar(8), " &
                        "Project nvarchar(20), Year integer, Month integer, Import decimal(19,6), Vat decimal(19,6), Spent decimal(19,6), QuarterDate datetime, Paid decimal(19,6)")>
    Public Shared Function fxSBO_GTK_QV_Documents(ByVal baseDatos As String, ByVal tabla As String, ByVal objType As String, ByVal tablaConsumos As String, ByVal desdeFecha As Date) As IEnumerable
        Dim resultado As New ArrayList
        '
        Dim strSQL As String = String.Empty
        '
        Dim HayControlGastado As Boolean = Not tablaConsumos.Trim.Equals(String.Empty)
        '
        If objType.Equals("30", StringComparison.CurrentCultureIgnoreCase) Then
            If tabla.Trim.Equals("P", StringComparison.CurrentCultureIgnoreCase) Then
                Dim sqlPago As String = String.Format(k_SQLPagosDeAsiento, baseDatos, objType)
                strSQL = String.Format(k_SQLAsientosSinDocumentos, baseDatos, "6", objType, desdeFecha, sqlPago)
            ElseIf tabla.Trim.Equals("C", StringComparison.CurrentCultureIgnoreCase) Then
                Dim sqlCobro As String = String.Format(k_SQLCobrosDeAsiento, baseDatos, objType)
                strSQL = String.Format(k_SQLAsientosSinDocumentos, baseDatos, "7", objType, desdeFecha, sqlCobro)
            End If
            '
            Log(strSQL)
        Else
            Dim strSelect As String = String.Empty
            '
            strSelect = "M.U_GTK_IBAN, M.DocEntry, S.SeriesName, M.DocNum, M.DocDate, " & vbNewLine &
                        vbTab & "CASE WHEN M.DocDueDate >= CONVERT(DATE, '{0}', 103) " & vbNewLine &
                        vbTab & vbTab & "THEN M.DocDueDate " & vbNewLine &
                        vbTab & vbTab & "ELSE CONVERT(DATE, '{0}', 103) " & vbNewLine &
                        vbTab & "END [DocDueDate], M.DocDueDate [RealDocDueDate], M.CardCode, M.CardName, M.GroupNum, " & vbNewLine &
                        vbTab & "D.LineNum, D.U_GTK_ARTICULO, D.OcrCode, D.OcrCode2, D.OcrCode3, D.OcrCode4, D.OcrCode5, D.Project, "
            '
            If HayControlGastado Then
                strSelect &= vbNewLine & "P.U_GTK_YEAR [Year], P.U_GTK_MONTH [Month], P.U_GTK_VALUE + P.IVA - ISNULL(RETENCION.Importe, 0.0) [Import], P.IVA [Vat], ISNULL(F.Spent, 0.0) [Spent], M.PaidToDate [Paid] "
            Else
                strSelect &= vbNewLine & "YEAR(M.DocDueDate) [Year], MONTH(M.DocDueDate) [Month], D.LineTotal + CASE D.IsAqcuistn WHEN 'N' THEN D.VatSum ELSE 0.0 END - ISNULL(RETENCION.Importe, 0.0) [Import], CASE D.IsAqcuistn WHEN 'N' THEN D.VatSum ELSE 0.0 END [Vat], 0.0 [Spent], M.PaidToDate [Paid] "
            End If
            '
            strSelect = String.Format(strSelect, desdeFecha)
            '
            Dim strFrom As String = String.Empty
            '
            strFrom = "[{0}]..{1}1 D WITH (NOLOCK) " & vbNewLine &
                    vbTab & "INNER JOIN [{0}]..O{1} M WITH (NOLOCK) ON M.DocEntry = D.DocEntry " & vbNewLine &
                    vbTab & "INNER JOIN [{0}]..NNM1 S WITH (NOLOCK) ON S.Series = M.Series " & vbNewLine &
                    vbTab & "LEFT JOIN [{0}]..ORCP R WITH (NOLOCK) ON R.DocObjType = M.ObjType AND R.DraftEntry = M.DocEntry AND '{1}' = 'DRF' " & vbNewLine &
                    vbTab & "LEFT JOIN (    SELECT T0.DocEntry, T0.LineNum, SUM(T0.LineTotal) * T1.WTAmnt / NULLIF(T1.TaxbleAmnt, 0) [Importe] " & vbNewLine &
                    vbTab & vbTab & "FROM [{0}]..{1}1 T0 WITH (NOLOCK) " & vbNewLine &
                    vbTab & vbTab & vbTab & "INNER JOIN [{0}]..{1}5 T1 WITH (NOLOCK) ON T1.AbsEntry = T0.DocEntry " & vbNewLine &
                    vbTab & vbTab & vbTab & "INNER JOIN [{0}]..ODRF T2 WITH (NOLOCK) ON T2.DocEntry = T0.DocEntry " & vbNewLine &
                    vbTab & vbTab & "WHERE T0.WtLiable = 'Y' " & vbNewLine &
                    vbTab & vbTab & vbTab & "AND (T0.LineStatus = 'O') " & vbNewLine &
                    vbTab & vbTab & vbTab & "AND (T2.DocStatus = 'O') " & vbNewLine &
                    vbTab & vbTab & vbTab & "AND (T2.DocDueDate >= CONVERT(DATE, '{2}', 103))" & vbNewLine &
                    vbTab & vbTab & "GROUP BY T0.DocEntry, T0.LineNum, T1.TaxbleAmnt, T1.WTAmnt " & vbNewLine &
                    vbTab & vbTab & ") RETENCION ON RETENCION.DocEntry = D.DocEntry And RETENCION.LineNum = D.LineNum "
            '
            strFrom = String.Format(strFrom, baseDatos, tabla, desdeFecha)
            '
            Dim strLeftJoin As String = String.Empty
            '
            If HayControlGastado Then
                strLeftJoin = vbTab & "INNER JOIN (SELECT DocEntry, LineNum, U_GTK_YEAR, VatPrcnt, " & vbNewLine &
                                   vbTab & vbTab & "CASE RIGHT(U_GTK_MONTH, 3)	" & vbNewLine &
                                       vbTab & vbTab & vbTab & "WHEN 'JAN' THEN 1 " & vbNewLine &
                                       vbTab & vbTab & vbTab & "WHEN 'FEB' THEN 2 " & vbNewLine &
                                       vbTab & vbTab & vbTab & "WHEN 'MAR' THEN 3 " & vbNewLine &
                                       vbTab & vbTab & vbTab & "WHEN 'APR' THEN 4 " & vbNewLine &
                                       vbTab & vbTab & vbTab & "WHEN 'MAY' THEN 5 " & vbNewLine &
                                       vbTab & vbTab & vbTab & "WHEN 'JUN' THEN 6 " & vbNewLine &
                                       vbTab & vbTab & vbTab & "WHEN 'JUL' THEN 7 " & vbNewLine &
                                       vbTab & vbTab & vbTab & "WHEN 'AUG' THEN 8 " & vbNewLine &
                                       vbTab & vbTab & vbTab & "WHEN 'SEP' THEN 9 " & vbNewLine &
                                       vbTab & vbTab & vbTab & "WHEN 'OCT' THEN 10 " & vbNewLine &
                                       vbTab & vbTab & vbTab & "WHEN 'NOV' THEN 11 " & vbNewLine &
                                       vbTab & vbTab & vbTab & "WHEN 'DEC' THEN 12 " & vbNewLine &
                                   vbTab & vbTab & "END [U_GTK_MONTH], U_GTK_VALUE, CASE IsAqcuistn WHEN 'Y' THEN 0.0 ELSE CAST((U_GTK_VALUE * VatPrcnt / 100.0) AS NUMERIC(19, 6)) END [IVA] " & vbNewLine &
                                vbTab & vbTab & "FROM [{0}]..{1}1 T0 WITH (NOLOCK) " & vbNewLine &
                                    vbTab & vbTab & "UNPIVOT (U_GTK_VALUE FOR U_GTK_MONTH IN (T0.U_GTK_JAN, T0.U_GTK_FEB, T0.U_GTK_MAR, T0.U_GTK_APR, T0.U_GTK_MAY, T0.U_GTK_JUN, " & vbNewLine &
                                                                            vbTab & vbTab & vbTab & "T0.U_GTK_JUL, T0.U_GTK_AUG, T0.U_GTK_SEP, T0.U_GTK_OCT, T0.U_GTK_NOV, T0.U_GTK_DEC ) ) PIV " & vbNewLine &
                                vbTab & vbTab & "WHERE (LineStatus = 'O') " & vbNewLine &
                                vbTab & vbTab & vbTab & "AND (ISNULL(U_GTK_VALUE, 0.0) != 0.0)) P ON P.DocEntry = D.DocEntry AND P.LineNum = D.LineNum "
                '
                strLeftJoin &= vbNewLine & vbTab & "LEFT JOIN (SELECT D.BaseEntry, D.BaseLine, Year(M.TaxDate) [Ejercicio], Month(M.TaxDate) [Mes], D.U_GTK_ARTICULO, SUM(D.GTotal) [Spent] " & vbNewLine &
                                    vbTab & vbTab & "FROM [{0}]..{2}1 D WITH (NOLOCK) " & vbNewLine &
                                        vbTab & vbTab & vbTab & "INNER JOIN [{0}]..O{2} M WITH (NOLOCK) ON M.DocEntry = D.DocEntry " & vbNewLine &
                                    vbTab & vbTab & "WHERE D.BaseType = {3} " & vbNewLine &
                                    vbTab & vbTab & "GROUP BY D.BaseEntry, D.BaseLine, Year(M.TaxDate), Month(M.TaxDate), D.U_GTK_ARTICULO " & vbNewLine &
                                    vbTab & vbTab & ") F ON F.BaseEntry = D.DocEntry " & vbNewLine &
                                        vbTab & vbTab & vbTab & "AND F.BaseLine = D.LineNum " & vbNewLine &
                                        vbTab & vbTab & vbTab & "AND F.Ejercicio = P.U_GTK_YEAR " & vbNewLine &
                                        vbTab & vbTab & vbTab & "AND F.Mes = P.U_GTK_MONTH " & vbNewLine &
                                        vbTab & vbTab & vbTab & "AND F.U_GTK_ARTICULO = D.U_GTK_ARTICULO"
                '
                strLeftJoin = String.Format(strLeftJoin, baseDatos, tabla, tablaConsumos, objType)
            End If
            '
            strSQL = "SELECT {0} " & vbNewLine &
                "FROM {1} " & vbNewLine &
                    vbTab & "{2} " & vbNewLine &
                "WHERE (R.AbsEntry IS NULL) " & vbNewLine &
                    vbTab & " AND (((D.LineStatus = 'O') AND (M.DocStatus = 'O') "
            '
            If HayControlGastado Then
                strSQL &= "AND (EOMONTH(DATEFROMPARTS(P.U_GTK_YEAR, U_GTK_MONTH, 1)) >= CONVERT(DATE, '{3}', 103))"
            Else
                strSQL &= "AND (M.DocDueDate >= CONVERT(DATE, '{3}', 103))"
            End If
            '
            strSQL &= ")" & vbNewLine
            '
            If Not HayControlGastado Then
                strSQL &= " OR ((M.DocStatus = 'O') AND (M.PaidToDate != M.DocTotal))"
            End If
            '
            strSQL &= ")" & vbNewLine
            '
            strSQL = String.Format(strSQL, strSelect, strFrom, strLeftJoin, desdeFecha)
            '
            If Not HayControlGastado Then
                If Not objType.Trim.Equals(String.Empty) Then
                    strSQL &= " AND (M.ObjType = '" & objType & "')"
                End If
            End If
            '
            strSQL &= " AND (M.DocDueDate IS NOT NULL)"
        End If
        '
        Log("fxSBO_GTK_QV_Documents SQL : " & vbNewLine & strSQL)
        '
        Dim conexion As New SqlConnection("context connection=true")
        conexion.Open()
        '
        Dim dt As DataTable = Nothing
        Dim dtFormasPago As DataTable = DameFormasPago(baseDatos, conexion)
        '
        Try
            dt = SQLToDataSet(strSQL, conexion).Tables(0)
            '
            If dt.Rows.Count > 0 Then
                SendData_QV_Documents(dt, dtFormasPago, resultado, HayControlGastado)
                '
                Return resultado
            Else
                Return resultado
            End If
        Catch ex As Exception
            LogSiempre("fxSBO_GTK_QV_Documents: " & ex.StackTrace)
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

    Private Shared Function DameFormasPago(ByVal baseDatos As String, ByVal conexion As SqlConnection) As DataTable
        Dim sqlFormasPago As String = String.Empty
        '
        sqlFormasPago = " SELECT T0.GroupNum, T0.PymntGroup, ExtraMonth, ExtraDays, T1.IntsNo, T1.InstMonth, T1.InstDays, T1.InstPrcnt " & vbNewLine &
                        "FROM [{0}]..OCTG T0 WITH (NOLOCK) " & vbNewLine &
                        vbTab & "LEFT JOIN [{0}]..CTG1 T1 WITH (NOLOCK) ON T1.CTGCode = T0.GroupNum " & vbNewLine &
                        "ORDER BY T0.GroupNum, T1.IntsNo "
        sqlFormasPago = String.Format(sqlFormasPago, baseDatos)
        '
        Log("Formas de pago: " & sqlFormasPago)
        '
        Dim dtFormasPago As DataTable = SQLToDataSet(sqlFormasPago, conexion).Tables(0)
        '
        Return dtFormasPago
    End Function

    Private Shared Sub SendData_QV_Documents(ByRef dr As DataTable, ByRef dtFormasPago As DataTable, ByRef resultado As ArrayList, HayControlGastado As Boolean)
        Dim listaDocumentos As New List(Of Integer)
        '
        Try
            For Each oRow As DataRow In dr.Rows
                Try
                    Dim data As New Master_QVDocuments
                    '
                    If Not oRow.IsNull("U_GTK_IBAN") Then data.IBAN = oRow("U_GTK_IBAN")
                    If Not oRow.IsNull("DocEntry") Then data.DocEntry = oRow("DocEntry")
                    If Not oRow.IsNull("SeriesName") Then data.Serie = oRow("SeriesName")
                    If Not oRow.IsNull("DocNum") Then data.DocNum = oRow("DocNum")
                    If Not oRow.IsNull("DocDate") Then data.DocDate = oRow("DocDate")
                    If Not oRow.IsNull("DocDueDate") Then data.DocDueDate = oRow("DocDueDate")
                    If Not oRow.IsNull("RealDocDueDate") Then data.RealDocDueDate = oRow("RealDocDueDate")
                    If Not oRow.IsNull("CardCode") Then data.CardCode = oRow("CardCode")
                    If Not oRow.IsNull("CardName") Then data.CardName = oRow("CardName")
                    If Not oRow.IsNull("GroupNum") Then data.GroupNum = oRow("GroupNum")
                    If Not oRow.IsNull("LineNum") Then data.LineNum = oRow("LineNum")
                    If Not oRow.IsNull("U_GTK_ARTICULO") Then data.ItemCode = oRow("U_GTK_ARTICULO")
                    If Not oRow.IsNull("OcrCode") Then data.OcrCode = oRow("OcrCode")
                    If Not oRow.IsNull("OcrCode2") Then data.OcrCode2 = oRow("OcrCode2")
                    If Not oRow.IsNull("OcrCode3") Then data.OcrCode3 = oRow("OcrCode3")
                    If Not oRow.IsNull("OcrCode4") Then data.OcrCode4 = oRow("OcrCode4")
                    If Not oRow.IsNull("OcrCode5") Then data.OcrCode5 = oRow("OcrCode5")
                    If Not oRow.IsNull("Project") Then data.Project = oRow("Project")
                    '
                    If Not oRow.IsNull("Year") Then
                        data.Year = oRow("Year")
                    Else
                        data.Year = Year(data.DocDueDate)
                    End If
                    '
                    If Not oRow.IsNull("Month") Then
                        data.Month = oRow("Month")
                    Else
                        data.Month = Month(data.DocDueDate)
                    End If
                    '
                    Dim _import As Double = oRow("Import")
                    Dim _vat As Double = oRow("Vat")
                    Dim _spent As Double = oRow("Spent")
                    '
                    If Not oRow.IsNull("Import") Then data.Import = _import
                    If Not oRow.IsNull("Vat") Then data.Vat = _vat
                    If Not oRow.IsNull("Spent") Then data.Spent = _spent
                    '
                    'Dim _paid As Double = 0.0
                    '
                    If Not listaDocumentos.Contains(data.DocEntry) Then
                        listaDocumentos.Add(data.DocEntry)
                        '
                        Dim _paid As Double = oRow("Paid")
                        If Not oRow.IsNull("Paid") Then data.Paid = _paid
                    End If
                    '
                    If HayControlGastado Then
                        Log("HayControlGastado")
                        Dim formasPago As DataRow() = dtFormasPago.Select("GroupNum=" & data.GroupNum)
                        '
                        Log("Registros Forma Pago " & data.GroupNum.ToString & " > " & formasPago.Length.ToString)
                        '
                        If formasPago.Length = 0 Then
                            Dim vencimiento As Date = New Date(data.Year, data.Month, Date.DaysInMonth(data.Year, data.Month))
                            Log("Sin plazo: " & data.DocDueDate.ToShortDateString & " -> " & vencimiento)
                            data.DocDueDate = vencimiento
                        ElseIf formasPago.Length = 1 Then
                            Dim meses As Integer = formasPago(0).Item("ExtraMonth")
                            Dim dias As Integer = formasPago(0).Item("ExtraDays")
                            '
                            Dim vencimiento As Date = DateAdd(DateInterval.Month, meses, New Date(data.Year, data.Month, Date.DaysInMonth(data.Year, data.Month)))
                            Log("Vencimiento original " & vencimiento.ToShortDateString & " ++ Meses: " & meses.ToString & " ++ Dias: " & dias.ToString)
                            '
                            vencimiento = DateAdd(DateInterval.Day, dias, vencimiento)
                            vencimiento = New Date(vencimiento.Year, vencimiento.Month, Date.DaysInMonth(vencimiento.Year, vencimiento.Month))
                            '
                            Log("1 Plazo: " & data.DocDueDate.ToShortDateString & " -> " & vencimiento)
                            '
                            data.DocDueDate = vencimiento
                        ElseIf formasPago.Length > 1 Then
                            Log("Plazos: " & formasPago.Length.ToString)
                            '
                            For Each formaPago As DataRow In formasPago
                                Dim plazo As Integer = formaPago.Item("IntsNo")
                                Dim meses As Integer = formaPago.Item("InstMonth")
                                Dim dias As Integer = formaPago.Item("InstDays")
                                Dim porcentaje As Double = formaPago.Item("InstPrcnt")
                                '
                                Dim vencimiento As Date = DateAdd(DateInterval.Month, meses, New Date(data.Year, data.Month, Date.DaysInMonth(data.Year, data.Month)))
                                Log("Vencimiento original " & vencimiento.ToShortDateString & " ++ Meses: " & meses.ToString & " ++ Dias: " & dias.ToString)
                                '
                                vencimiento = DateAdd(DateInterval.Day, dias, vencimiento)
                                vencimiento = New Date(vencimiento.Year, vencimiento.Month, Date.DaysInMonth(vencimiento.Year, vencimiento.Month))
                                '
                                Log("Plazo: " & plazo.ToString & " > " & data.DocDueDate.ToShortDateString & " -> " & vencimiento)

                                data.DocDueDate = vencimiento
                                '
                                data.Import = _import * porcentaje / 100.0
                                data.Vat = _vat * porcentaje / 100.0
                                data.Spent = _spent * porcentaje / 100.0
                                'data.Paid = _paid * porcentaje / 100.0
                                '
                                Log("Importe: " & _import.ToString("n2") & " x " & porcentaje.ToString("n2") & " > " & data.Import.ToString("n2"))
                                Log("Vat: " & _vat.ToString("n2") & " x " & porcentaje.ToString("n2") & " > " & data.Vat.ToString("n2"))
                                Log("Spent: " & _spent.ToString("n2") & " x " & porcentaje.ToString("n2") & " > " & data.Spent.ToString("n2"))
                                'Log("Paid: " & _paid.ToString("n2") & " x " & porcentaje.ToString("n2") & " > " & data.Paid.ToString("n2"))
                                '
                                resultado.Add(data)
                                '
                                data = New Master_QVDocuments(data)
                                data.Paid = 0.0 'El paid solo para el primer registro
                            Next
                            '
                            Continue For
                        End If
                    End If
                    '
                    resultado.Add(data)
                Catch ex As Exception
                    LogSiempre("ERROR: " & ex.Message)
                End Try
            Next
        Catch ex As Exception
            LogSiempre("SendData_QV_Documents: " & ex.StackTrace)
        End Try
    End Sub

    Public Shared Sub FillRow_QV_Documents(ByVal objetoResultado As Object,
                <Out()> ByRef sIBAN As SqlString, <Out()> ByRef iDocEntry As SqlInt32, <Out()> ByRef sSerie As SqlString, <Out()> ByRef iDocNum As SqlInt32,
                <Out()> ByRef fDocDate As SqlDateTime, <Out> ByRef fDocDueDate As SqlDateTime, <Out()> ByRef fRealDocDueDate As SqlDateTime, <Out()> ByRef sCardCode As SqlString, <Out()> ByRef sCardName As SqlString, <Out()> ByRef iLineNum As SqlInt32,
                <Out()> ByRef sItemCode As SqlString, <Out()> ByRef sOcrCode As SqlString, <Out()> ByRef sOcrCode2 As SqlString, <Out()> ByRef sOcrCode3 As SqlString,
                <Out()> ByRef sOcrCode4 As SqlString, <Out()> ByRef sOcrCode5 As SqlString, <Out()> ByRef sProject As SqlString, <Out()> ByRef iYear As SqlInt32, <Out> ByRef iMonth As SqlInt32,
                <Out> ByRef dImport As SqlDecimal, <Out> ByRef dVat As SqlDecimal, <Out> ByRef dSpent As SqlDecimal, <Out> ByRef fQuarterDate As SqlDateTime, <Out> ByRef dPaid As SqlDecimal)
        '
        Dim maestro As Master_QVDocuments = DirectCast(objetoResultado, Master_QVDocuments)
        '        
        sIBAN = maestro.IBAN
        iDocEntry = maestro.DocEntry
        sSerie = maestro.Serie
        iDocNum = maestro.DocNum
        fDocDate = maestro.DocDate
        fDocDueDate = maestro.DocDueDate
        fRealDocDueDate = maestro.RealDocDueDate
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
        dImport = maestro.Import
        dVat = maestro.Vat
        dSpent = maestro.Spent
        dPaid = maestro.Paid
        '
        fQuarterDate = DameFechaTrimestre(New Date(iYear, iMonth, 1))
    End Sub

End Class