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

    Private Class Master_QVBillofExchange
        Public IBAN As String
        Public DocEntry As Integer
        Public Serie As String
        Public DocNum As Integer
        Public DocDate As Date
        Public DocDueDate As Date
        Public CardCode As String
        Public CardName As String
        Public Project As String
        Public Year As Integer
        Public Month As Integer
        Public Import As Double

        Public Sub New()
            ' simplemente nuevo sin nada
        End Sub

    End Class

    <Microsoft.SqlServer.Server.SqlFunction(DataAccess:=DataAccessKind.Read, _
        FillrowMethodName:="FillRow_QV_BillOfExchange", _
        TableDefinition:="IBAN nvarchar(24), DocEntry integer, Serie nvarchar(8), DocNum integer, DocDate datetime, DocDueDate datetime, " & _
                        "CardCode nvarchar(15), CardName nvarchar(100), Project nvarchar(20), Year integer, Month integer, Import decimal(19, 6), QuarterDate datetime")> _
    Public Shared Function fxSBO_GTK_QV_BillOfExchange(ByVal baseDatos As String, tabla As String, ByVal desdeFecha As Date) As IEnumerable
        ' OVPM PARA COMPRAS 
        ' ORCT PARA VENTAS
        Dim resultado As New ArrayList
        '
        Dim strDetalles As String = String.Empty
        '
        If tabla.Trim.Equals("VPM", StringComparison.CurrentCultureIgnoreCase) Then
            strDetalles = "SELECT T0.DocNum, T0.SumApplied, ISNULL(T2.Project, ISNULL(T3.Project, T4.Project)) [Project] " & vbNewLine & _
                            "FROM [{0}]..VPM2 T0 WITH (NOLOCK) " & vbNewLine & _
                            vbTab & "LEFT JOIN [{0}]..OPCH T2 WITH (NOLOCK) ON T2.ObjType = T0.InvType AND T2.DocEntry = T0.DocEntry " & vbNewLine & _
                            vbTab & "LEFT JOIN [{0}]..ORPC T3 WITH (NOLOCK) ON T3.ObjType = T0.InvType AND T3.DocEntry = T0.DocEntry " & vbNewLine & _
                            vbTab & "LEFT JOIN [{0}]..ODPO T4 WITH (NOLOCK) ON T4.ObjType = T0.InvType AND T4.DocEntry = T0.DocEntry "
        ElseIf tabla.Trim.Equals("RCT", StringComparison.CurrentCultureIgnoreCase) Then
            strDetalles = "SELECT T0.DocNum, T0.SumApplied, ISNULL(T2.Project, ISNULL(T3.Project, T4.Project)) [Project] " & vbNewLine & _
                            "FROM [{0}]..RCT2 T0 WITH (NOLOCK) " & vbNewLine & _
                            vbTab & "LEFT JOIN [{0}]..OINV T2 WITH (NOLOCK) ON T2.ObjType = T0.InvType AND T2.DocEntry = T0.DocEntry " & vbNewLine & _
                            vbTab & "LEFT JOIN [{0}]..OINV T3 WITH (NOLOCK) ON T3.ObjType = T0.InvType AND T3.DocEntry = T0.DocEntry " & vbNewLine & _
                            vbTab & "LEFT JOIN [{0}]..ODPI T4 WITH (NOLOCK) ON T4.ObjType = T0.InvType AND T4.DocEntry = T0.DocEntry "
        Else
            strDetalles = "SELECT NULL [DocNum], NULL [Project], NULL [SumApplied]"
        End If
        '
        Dim strSQL As String = String.Empty
        '
        strSQL = "SELECT ISNULL(T3.IBAN, T4.DflIBAN) [IBAN], T0.DocEntry, T2.SeriesName, T0.DocNum, T0.DocDate, T0.DocDueDate, T0.CardCode, T0.CardName, YEAR(T0.DocDueDate) [Year], MONTH(T0.DocDueDate) [Month], " & vbNewLine & _
                    "D.Project, ISNULL(D.SumApplied, T0.BoeSum) [Import] " & vbNewLine & _
                    "FROM [{0}]..O{1} T0 WITH (NOLOCK) " & vbNewLine & _
                    vbTab & "INNER JOIN [{0}]..OBOE T1 WITH (NOLOCK) ON T1.BoeKey = T0.BoeAbs " & vbNewLine & _
                    vbTab & "INNER JOIN [{0}]..NNM1 T2 WITH (NOLOCK) ON T2.Series = T0.Series " & vbNewLine & _
                    vbTab & "LEFT JOIN [{0}]..DSC1 T3 WITH (NOLOCK) ON T3.AbsEntry = T1.OutBnkKey " & vbNewLine & _
                    vbTab & "LEFT JOIN [{0}]..OPYM T4 WITH (NOLOCK) ON T4.PayMethCod = T1.PayMethCod " & vbNewLine & _
                    vbTab & "LEFT JOIN (" & strDetalles & ") D ON D.DocNum = T0.DocNum " & vbNewLine & _
                    "WHERE (T0.DocDueDate >= CONVERT(DATE, '{2}', 103)) "
        '
        strSQL = String.Format(strSQL, baseDatos, tabla, desdeFecha)
        '
        Log("SQL fxSBO_GTK_QV_BillOfExchange: " & vbNewLine & strSQL)
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
                SendData_QV_BillOfExchange(dt, resultado)
                '
                Return resultado
            Else
                Return resultado
            End If
        Catch ex As Exception
            LogSiempre("fxSBO_GTK_QV_BillOfExchange: " & ex.StackTrace)
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

    Private Shared Sub SendData_QV_BillOfExchange(ByRef dr As DataTable, ByRef resultado As ArrayList)
        Try
            For Each oRow As DataRow In dr.Rows
                Try
                    Dim data As New Master_QVBillofExchange
                    '
                    If Not oRow.IsNull("IBAN") Then data.IBAN = oRow("IBAN")
                    If Not oRow.IsNull("DocEntry") Then data.DocEntry = oRow("DocEntry")
                    If Not oRow.IsNull("SeriesName") Then data.Serie = oRow("SeriesName")
                    If Not oRow.IsNull("DocNum") Then data.DocNum = oRow("DocNum")
                    If Not oRow.IsNull("DocDate") Then data.DocDate = oRow("DocDate")
                    If Not oRow.IsNull("DocDueDate") Then data.DocDueDate = oRow("DocDueDate")
                    If Not oRow.IsNull("CardCode") Then data.CardCode = oRow("CardCode")
                    If Not oRow.IsNull("CardName") Then data.CardName = oRow("CardName")
                    If Not oRow.IsNull("Project") Then data.Project = oRow("Project")
                    If Not oRow.IsNull("Year") Then data.Year = oRow("Year")
                    If Not oRow.IsNull("Month") Then data.Month = oRow("Month")
                    If Not oRow.IsNull("Import") Then data.Import = oRow("Import")
                    '
                    resultado.Add(data)
                Catch ex As Exception
                    LogSiempre("ERROR: " & ex.Message)
                End Try
            Next
        Catch ex As Exception
            LogSiempre("SendData_QV_BillOfExchange: " & ex.StackTrace)
        End Try
    End Sub

    Public Shared Sub FillRow_QV_BillOfExchange(ByVal objetoResultado As Object, _
                <Out()> ByRef sIBAN As SqlString, <Out()> ByRef iDocEntry As SqlInt32, <Out()> ByRef sSerie As SqlString, <Out()> ByRef iDocNum As SqlInt32, _
                <Out()> ByRef fDocDate As SqlDateTime, <Out> ByRef fDocDueDate As SqlDateTime, <Out()> ByRef sCardCode As SqlString, <Out()> ByRef sCardName As SqlString, _
                <Out> ByRef sProject As SqlString, <Out()> ByRef iYear As SqlInt32, <Out> ByRef iMonth As SqlInt32, <Out> ByRef dImport As SqlDecimal, <Out> ByRef fQuarterDate As SqlDateTime)
        '
        Dim maestro As Master_QVBillofExchange = DirectCast(objetoResultado, Master_QVBillofExchange)
        '        
        sIBAN = maestro.IBAN
        iDocEntry = maestro.DocEntry
        sSerie = maestro.Serie
        iDocNum = maestro.DocNum
        fDocDate = maestro.DocDate
        fDocDueDate = maestro.DocDueDate
        sCardCode = maestro.CardCode
        sCardName = maestro.CardName
        sProject = maestro.Project
        iYear = maestro.Year
        iMonth = maestro.Month
        dImport = maestro.Import
        '
        fQuarterDate = DameFechaTrimestre(New Date(iYear, iMonth, 1))
    End Sub

End Class