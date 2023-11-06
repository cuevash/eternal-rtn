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

    Private Class Master_QVTaxes
        Public Fecha As Date
        Public Tipo As String
        Public Cuenta As String
        Public Importe As Double

        Public Sub New(fFecha As Date, sTipo As String, sCuenta As String, dImporte As Double)
            Fecha = fFecha
            Tipo = sTipo
            Cuenta = sCuenta
            Importe = dImporte
        End Sub

    End Class

    Private Const k_SqlSaldoInicial As String = "SELECT '{4}' [Fecha], 'I' [Tipo], Left(T0.Account, {3}) [Cuenta], SUM(T0.Debit - T0.Credit) [Importe] " & vbNewLine &
                                                "FROM [{0}]..JDT1 T0 WITH (NOLOCK) " & vbNewLine &
                                                "WHERE (T0.Account LIKE '{1}%') " & vbNewLine &
                                                vbTab & "AND (T0.RefDate < CONVERT(DATE, '{2}', 103)) " & vbNewLine &
                                                "GROUP BY Left(T0.Account, {3})"

    Private Const k_SqlSaldoPeriodo As String = "SELECT '{4}' [Fecha], 'P' [Tipo], Left(T0.Account, {3}) [Cuenta], SUM(T0.Debit - T0.Credit) [Importe] " & vbNewLine &
                                            "FROM [{0}]..JDT1 T0 WITH (NOLOCK) " & vbNewLine &
                                            "WHERE (T0.Account LIKE '{1}%') " & vbNewLine &
                                            vbTab & "AND (T0.RefDate >= CONVERT(DATE, '{2}', 103)) " & vbNewLine &
                                            "GROUP BY Left(T0.Account, {3})"

    <Microsoft.SqlServer.Server.SqlFunction(DataAccess:=DataAccessKind.Read, _
        FillrowMethodName:="FillRow_QV_Taxes", _
        TableDefinition:="Type nvarchar(1), Account nvarchar(15), Import decimal(19, 6), QuarterDate datetime")> _
    Public Shared Function fxSBO_GTK_QV_Taxes(ByVal baseDatos As String, ByVal fecha As Date) As IEnumerable
        ' OVPM PARA COMPRAS 
        ' ORCT PARA VENTAS
        Dim resultado As New ArrayList
        '
        Dim strSql As String = String.Empty
        '
        Dim cuentas As String = "4700;4720;4770;4750;4751"
        '
        For Each cuenta As String In cuentas.Split(";")
            Dim longitud As Integer = cuenta.Length
            '
            If Not strSql.Equals(String.Empty) Then
                strSql &= vbNewLine & "UNION ALL " & vbNewLine
            End If
            '
            Dim fechaInicial As Date = DameFechaInicioTrimestre(fecha)
            '
            Dim fechaTrimestre As Date = DameFechaTrimestre(fechaInicial.AddDays(-1))
            '
            strSql &= String.Format(k_SqlSaldoInicial, baseDatos, cuenta, fechaInicial, longitud, fechaTrimestre)
            '
            strSql &= vbNewLine & "UNION ALL " & vbNewLine
            '
            fechaTrimestre = DameFechaTrimestre(fecha)
            '
            strSql &= String.Format(k_SqlSaldoPeriodo, baseDatos, cuenta, fechaInicial, longitud, fechaTrimestre)
        Next
        '
        strSql &= vbNewLine & "ORDER BY Tipo"
        '
        Log("SQL fxSBO_GTK_QV_Taxes: " & vbNewLine & strSql)
        '
        Dim conexion As New SqlConnection("context connection=true")
        conexion.Open()
        '
        Dim dt As DataTable = Nothing
        '
        Try
            dt = SQLToDataSet(strSql, conexion).Tables(0)
            '
            If dt.Rows.Count > 0 Then
                SendData_QV_Taxes(dt, resultado, fecha)
                '
                Return resultado
            Else
                Return resultado
            End If
        Catch ex As Exception
            LogSiempre("fxSBO_GTK_QV_Taxes: " & ex.StackTrace)
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

    Private Shared Sub SendData_QV_Taxes(ByRef dr As DataTable, ByRef resultado As ArrayList, desdeFecha As Date)
        Dim datos As New ArrayList
        '
        Try
            For Each oRow As DataRow In dr.Rows
                Try
                    Dim fecha As Date = Nothing
                    Dim tipo As String = String.Empty
                    Dim cuenta As String = String.Empty
                    Dim importe As Double = 0.0
                    '
                    If Not oRow.IsNull("Fecha") Then fecha = oRow("Fecha")
                    If Not oRow.IsNull("Tipo") Then tipo = oRow("Tipo")
                    If Not oRow.IsNull("Cuenta") Then cuenta = oRow("Cuenta")
                    If Not oRow.IsNull("Importe") Then importe = oRow("Importe")
                    '
                    Dim newData As New Master_QVTaxes(fecha, tipo, cuenta, importe)
                    '
                    datos.Add(newData)
                Catch ex As Exception
                    LogSiempre("ERROR: " & ex.Message)
                End Try
            Next
            '
            ' Tratamiento de datos
            '
            ' IRPF
            Dim calculos As ArrayList = CalculaIRPF(datos, desdeFecha)
            '
            If Not IsNothing(calculos) Then
                resultado.AddRange(calculos)
            End If
            '
            ' IVA
            calculos = CalculaIVA(datos, desdeFecha)
            '
            If Not IsNothing(calculos) Then
                resultado.AddRange(calculos)
            End If
        Catch ex As Exception
            LogSiempre("SendData_QV_Taxes: " & ex.StackTrace)
        Finally
            LiberarObjeto(datos)
        End Try
    End Sub

    Private Shared Function CalculaIVA(datos As ArrayList, desdeFecha As Date) As ArrayList
        Dim resultados As New ArrayList
        '
        Dim liquidacionAnterior As Double = DameImporte(datos, "I", "4700")
        '
        Dim fechaInicial As Date = DameFecha(datos, "I", "4720;4770")
        Dim repercutidoInicial As Double = DameImporte(datos, "I", "4770") * -1
        Dim soportadoInicial As Double = DameImporte(datos, "I", "4720")
        '
        Dim liquidacion As Double = repercutidoInicial - soportadoInicial - liquidacionAnterior
        '
        Log("Desde Fecha: " & desdeFecha.ToShortDateString)
        '
        Log("Fecha Inicial: " & fechaInicial.ToShortDateString)
        Log("Repercutido Inicial: " & repercutidoInicial.ToString("n2") & ", Soportado: " & soportadoInicial.ToString("n2") & ", Liquidación Anterior: " & liquidacionAnterior.ToString("n2"))
        Log("Resultado Liquidación Inicial: " & liquidacion.ToString("n2"))
        '
        If liquidacion < 0.0 Then
            Log("A compensar: " & liquidacion.ToString("n2"))
            '
            If fechaInicial >= desdeFecha Then
                resultados.Add(New Master_QVTaxes(fechaInicial, "I", "4700", liquidacion))
            End If
            '
            liquidacionAnterior = liquidacion * -1
        ElseIf liquidacion > 0.0 Then
            Log("A ingresar: " & liquidacion.ToString("n2"))
            '
            If fechaInicial >= desdeFecha Then
                resultados.Add(New Master_QVTaxes(fechaInicial, "I", "4750", liquidacion))
            End If
            '
            liquidacionAnterior = 0.0
        End If
        '
        liquidacionAnterior += DameImporte(datos, "P", "4700")
        '
        Log("Compensar Periodo: " & liquidacionAnterior.ToString("n2"))
        '
        'liquidacionAnterior = compensarPeriodo * -1
        '
        Dim fechaPeriodo As Date = DameFecha(datos, "P", "4720;4770")
        Dim repercutidoPeriodo As Double = DameImporte(datos, "P", "4770") * -1
        Dim soportadoPeriodo As Double = DameImporte(datos, "P", "4720")
        '
        liquidacion = (repercutidoPeriodo - soportadoPeriodo) - liquidacionAnterior
        '
        'If liquidacion > 0 Then
        '    liquidacionAnterior = 0
        'Else
        '    liquidacionAnterior = liquidacion * -1
        'End If
        '
        If fechaPeriodo.Equals(Nothing) Then
            fechaPeriodo = DameFechaTrimestre(desdeFecha)
        End If
        '
        'Revisar el problema derivado del repercutido inicial cuando se corresponde con un periodo previo "cerrado"
        'repercutidoPeriodo = repercutidoPeriodo + repercutidoInicial
        'soportadoPeriodo = soportadoPeriodo + soportadoInicial
        ''
        Log("Fecha Periodo: " & fechaPeriodo.ToShortDateString)
        Log("Repercutido Periodo: " & repercutidoPeriodo.ToString("n2") & ", Soportado: " & soportadoPeriodo.ToString("n2") & ", Liquidación Anterior: " & liquidacionAnterior.ToString("n2"))
        Log("Resultado Liquidación Periodo: " & liquidacion.ToString("n2"))
        '
        'liquidacion = (repercutidoPeriodo - soportadoPeriodo) - liquidacionAnterior
        '
        Log("Resultado Liquidación Resultado: " & liquidacion.ToString("n2"))
        '
        If fechaPeriodo >= desdeFecha Then
            If liquidacion < 0.0 Then
                Log("A compensar: " & liquidacion.ToString("n2") & " --> No se añade a resultados.")
                '
                'resultados.Add(New Master_QVTaxes(fechaPeriodo, "P", "4700", liquidacion))
            ElseIf liquidacion > 0.0 Then
                Log("A ingresar: " & liquidacion.ToString("n2"))
                '
                resultados.Add(New Master_QVTaxes(fechaPeriodo, "P", "4750", liquidacion))
            End If
        End If
        '
        Return resultados
    End Function

    Private Shared Function CalculaIRPF(datos As ArrayList, desdeFecha As Date) As ArrayList
        Dim resultados As New ArrayList
        '
        Dim registro As Master_QVTaxes = DameRegistro(datos, "I", "4751")
        '
        Dim importe As Double = 0.0
        '
        If Not IsNothing(registro) Then
            importe = registro.Importe
            '
            Log("Saldo IRPF " & registro.Fecha.ToShortDateString & " --> " & importe.ToString("n2"))
            '
            If registro.Fecha >= desdeFecha Then
                Log("Se añade registro " & registro.Fecha.ToShortDateString)
                '
                resultados.Add(registro)
            End If
        End If
        '
        registro = DameRegistro(datos, "P", "4751")
        '
        If Not IsNothing(registro) AndAlso registro.Fecha >= desdeFecha Then
            Log("Se añade registro " & registro.Fecha.ToShortDateString)
            '
            Log("Saldo IRPF " & registro.Fecha.ToShortDateString & " --> " & registro.Importe.ToString("n2") & " > " & importe.ToString("n2"))
            '
            If registro.Importe > 0 Then
                importe = (importe + registro.Importe) * -1
            Else
                importe = registro.Importe ' + importe
            End If
            '
            registro.Importe = importe
            '
            resultados.Add(registro)
        End If
        '
        If resultados.Count > 0 Then
            Return resultados
        Else
            Return Nothing
        End If
    End Function

    Private Shared Function DameRegistro(datos As ArrayList, tipo As String, cuenta As String) As Master_QVTaxes
        Dim importe As Double = DameImporte(datos, tipo, cuenta)
        Dim fecha As Date = DameFecha(datos, tipo, cuenta)
        '
        If importe <> 0.0 Then
            Log("Registro: " & fecha.ToShortDateString & ", Tipo: " & tipo & ", Cuenta: " & cuenta & ", Importe: " & importe.ToString("n2"))
            '
            Return New Master_QVTaxes(fecha, tipo, cuenta, importe)
        End If
        '
        Return Nothing
    End Function

    Private Shared Function DameFecha(registros As ArrayList, tipo As String, cuenta As String) As Date
        cuenta = ";" & cuenta & ";"
        '
        For Each registro As Master_QVTaxes In registros
            If registro.Tipo.Equals(tipo, StringComparison.CurrentCultureIgnoreCase) AndAlso cuenta.Contains(";" & registro.Cuenta & ";") Then
                Return registro.Fecha
            End If
        Next
        '
        Return Nothing
    End Function

    Private Shared Function DameImporte(registros As ArrayList, tipo As String, cuenta As String) As Double
        Dim resultado As Double = 0.0
        '
        For Each registro As Master_QVTaxes In registros
            If registro.Tipo.Equals(tipo, StringComparison.CurrentCultureIgnoreCase) AndAlso registro.Cuenta.Equals(cuenta, StringComparison.CurrentCultureIgnoreCase) Then
                resultado += registro.Importe
            End If
        Next
        '
        Return resultado
    End Function

    Public Shared Sub FillRow_QV_Taxes(ByVal objetoResultado As Object, _
                <Out()> ByRef sType As SqlString, <Out()> ByRef sAccount As SqlString, <Out> ByRef dImport As SqlDecimal, <Out> ByRef fQuarterDate As SqlDateTime)
        '
        Dim maestro As Master_QVTaxes = DirectCast(objetoResultado, Master_QVTaxes)
        '
        Dim fecha As Date = maestro.Fecha
        '
        sType = maestro.Tipo
        sAccount = maestro.Cuenta
        dImport = maestro.Importe
        fQuarterDate = maestro.Fecha
        ''
        'If sType = "I" Then
        '    fecha = DameFechaInicioTrimestre(fecha)
        '    fecha = fecha.AddDays(-1)
        '    fecha = DameFechaTrimestre(fecha)
        'ElseIf sType = "P" Then
        '    fecha = DameFechaTrimestre(fecha)
        'End If
        ''
        'fQuarterDate = fecha
    End Sub

End Class