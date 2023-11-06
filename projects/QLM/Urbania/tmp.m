// Servidor
"URBANIA-VSAP2" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true]

// Base Datos
"kat_treasury" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true]

// ConnectionDB_KAT
let
    Source = Sql.Database(Servidor, #"Base Datos")
in
    Source

// Cuentas
let
  Origen = Value.NativeQuery(ConnectionDB_KAT, "SELECT [CD_CUENTA] as BKCuenta#(lf)      ,[DS_NOMBRE_CUENTA] as 'Nombre Cuenta'#(lf)#(tab)  ,tip.[DS_CUENTA_TIPO] as 'Tipo Cuenta'#(lf)#(tab)  ,tip.[DS_CTA_COMPORTAMIENTO] as  'Comportamiento Cuenta'#(lf)#(tab)  #(tab),emp.DS_NOMBRE as Empresa#(lf),emp.DS_ALIAS_EMPRESA as 'Alias Empresa'#(lf),emp.DS_OBSERVACIONES as 'Observaciones'#(lf)#(tab)#(tab),TE.[ds_EMPRESA_TIPO] as 'Tipo Empresa'#(lf)  #(tab)  ,bco.DS_NOMBRE_BANCO as Banco#(lf)#(tab)  ,di.DS_ISO_DIVISA as Divisa#(lf)      ,cta.[CD_DIVISA]#(lf)      ,cta.[CD_EMPRESA] as BKIdEmpresa#(lf)#(tab)  ,[NM_SALDO]#(lf)      ,[IT_ACTIVA]#(lf)      ,[FC_INACTIVA]#(lf)      ,[CD_GRUPO_CUENTA]#(lf)  FROM [dbo].[KAT_CUENTAS] cta#(lf)  left join [dbo].[KAT_Empresas] emp on emp.CD_EMPRESA=cta.CD_EMPRESA#(lf)  left join [dbo].[KAT_EMPRESAS_TIPO] TE on TE.CD_EMPRESA_TIPO=emp.CD_EMPRESA_TIPO#(lf)  left join [dbo].[KAT_BANCOS] bco on bco.CD_BANCO=cta.CD_BANCO#(lf)  left join (SELECT  t.[CD_CUENTA_TIPO]#(lf)      ,t.[DS_CUENTA_TIPO]#(lf)       ,com.[DS_CTA_COMPORTAMIENTO]#(lf)  FROM .[dbo].[KAT_CUENTAS_TIPO] t#(lf)  left join   [dbo].[KAT_CUENTAS_COMPORTAMIENTO] com on com.[CD_CTA_COMPORTAMIENTO]=t.[CD_CTA_COMPORTAMIENTO] ) tip on tip.CD_CUENTA_TIPO=cta.CD_CUENTA_TIPO#(lf)  left join [dbo].[KAT_DIVISAS] di on di.CD_DIVISA=cta.CD_DIVISA#(lf)#(lf)  union #(lf)  #(tab)select -row_number() OVER(order by DS_ALIAS_EMPRESA) as BKCuenta#(lf)  ,'Desconocido' as 'Nombre Cuenta'#(lf)  ,'Desconocido' as 'Tipo Cuenta'#(lf),'Desconocido' as 'Comportamiento Cuenta'#(lf),DS_NOMBRE as 'Empresa'#(lf),DS_ALIAS_EMPRESA as 'Alias Empresa'#(lf),DS_OBSERVACIONES as 'Observaciones'#(lf),null as 'Tipo Empresa'#(lf),'Desconocido' as Banco#(lf),'Desconocida' as Divisa#(lf),-1 as CD_DIVISA#(lf),-1 as 'BKIdEmpresa'#(lf),0 as NM_SALDO#(lf),1 as IT_ACTIVA#(lf),null as FC_INACTIVA#(lf),-1 as CD_GRUPO_CUENTA#(lf)from [dbo].[KAT_Empresas]"
  ), 
  #"Renamed Columns" = Table.RenameColumns(Origen, {{"Nombre Cuenta", "Cuenta"}}), 
  #"Consultas combinadas" = Table.NestedJoin(
    #"Renamed Columns", 
    {"Cuenta"}, 
    KAT_CUENTAS, 
    {"DS_NOMBRE_CUENTA"}, 
    "KAT_CUENTAS", 
    JoinKind.LeftOuter
  ), 
  #"Consultas combinadas1" = Table.NestedJoin(
    #"Consultas combinadas", 
    {"Cuenta"}, 
    KAT_CUENTAS, 
    {"DS_NOMBRE_CUENTA"}, 
    "KAT_CUENTAS.1", 
    JoinKind.LeftOuter
  ), 
  #"Filas filtradas" = Table.SelectRows(
    #"Consultas combinadas1", 
    each (
      [Empresa]
        <> "ADHOC CONTROL DE GESTION SL" and [Empresa]
        <> "CAVA BAJA INVERSIONES, S.L.U." and [Empresa]
        <> "INTERHOUSING INVESTMENTS, S.L." and [Empresa]
        <> "INTERHOUSING PERE IV, S.L." and [Empresa]
        <> "IRE RE URBANESCO JV S.L.U." and [Empresa]
        <> "IRE-RE URBANESCO DEVELOPMENTS, S.L." and [Empresa]
        <> "MOMENTUM INDUSTRIES SPAIN FUND I SL" and [Empresa]
        <> "URBANIA BCN MANAGEMENT SL" and [Empresa]
        <> "URBANIA CIUDAD DE BARCELONA 103 SL" and [Empresa]
        <> "URBANIA DIAGONAL 331 SLU" and [Empresa]
        <> "URBANIA FORMENTERA, S.L.U." and [Empresa]
        <> "URBANIA LAMATRA III, S.L." and [Empresa]
        <> "URBANIA MADRID MANAGEMENT SL" and [Empresa]
        <> "URBANIA PROPERTY PARTNERS SL" and [Empresa]
        <> "URBANIA SANTA CLARA DEVELOPMENT IV SLU" and [Empresa]
        <> "URBANIA SANTA CLARA DEVELOPMENT, SLU" and [Empresa]
        <> "WOOD & STEEL DESIGN S.L."
    )
  ), 
  #"Columna condicional agregada" = Table.AddColumn(
    #"Filas filtradas", 
    "Personalizado", 
    each 
      if [CD_GRUPO_CUENTA] = 1 then
        "Pignorada"
      else if [CD_GRUPO_CUENTA] = 2 then
        "Inactivas"
      else
        "Operativa"
  ), 
  #"Columnas con nombre cambiado" = Table.RenameColumns(
    #"Columna condicional agregada", 
    {{"Personalizado", "Grupo_Cuentas"}}
  )
in
  #"Columnas con nombre cambiado"

// KAT_CUENTAS
let
    Origen = Value.NativeQuery(ConnectionDB_KAT, "select * from kat_cuentas")
in
    Origen

// Condiciones
let
    Source = ConnectionDB_KAT,
    dbo_KAT_CONDICIONES = Source{[Schema="dbo",Item="KAT_CONDICIONES"]}[Data],
    #"Consultas combinadas" = Table.NestedJoin(dbo_KAT_CONDICIONES, {"CD_CONDICION"}, KAT_CONDICIONES_TRAMOS, {"CD_CONDICION"}, "KAT_CONDICIONES_TRAMOS.1", JoinKind.LeftOuter),
    #"Se expandió KAT_CONDICIONES_TRAMOS.1" = Table.ExpandTableColumn(#"Consultas combinadas", "KAT_CONDICIONES_TRAMOS.1", {"NM_TIPO_FIJO"}, {"KAT_CONDICIONES_TRAMOS.1.NM_TIPO_FIJO"}),
    #"Personalizada agregada" = Table.AddColumn(#"Se expandió KAT_CONDICIONES_TRAMOS.1", "KAT_TIPO_FIJO2", each [KAT_CONDICIONES_TRAMOS.1.NM_TIPO_FIJO]/100),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Personalizada agregada",{{"KAT_TIPO_FIJO2", type number}})
in
    #"Tipo cambiado"

// KAT_CONDICIONES_TRAMOS
let
    Source = ConnectionDB_KAT,
    dbo_KAT_CONDICIONES_TRAMOS = Source{[Schema="dbo",Item="KAT_CONDICIONES_TRAMOS"]}[Data],
    #"Filas filtradas" = Table.SelectRows(dbo_KAT_CONDICIONES_TRAMOS, each true),
    #"Filas en blanco eliminadas" = Table.SelectRows(#"Filas filtradas", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null}))),
    #"Filas filtradas1" = Table.SelectRows(#"Filas en blanco eliminadas", each true),
    #"Errores quitados" = Table.RemoveRowsWithErrors(#"Filas filtradas1", {"NM_TIPO_FIJO"}),
    #"Filtered Rows" = Table.SelectRows(#"Errores quitados", each ([CD_TRAMO] = 1)),
    #"Added Conditional Column" = Table.AddColumn(#"Filtered Rows", "Custom", each if [NM_DIFERENCIAL] = null then [NM_TIPO_FIJO] else [NM_DIFERENCIAL]),
    #"Reordered Columns" = Table.ReorderColumns(#"Added Conditional Column",{"CD_CONDICION_TRAMO", "CD_CONDICION", "CD_TRAMO", "NM_DESDE", "NM_HASTA", "NM_BASE", "NM_RETENCION", "IT_VARIABLE", "NM_TIPO_INICIAL", "NM_DIFERENCIAL", "NM_TIPO_FIJO", "Custom", "KAT_CONDICIONES", "KAT_TRAMOS"}),
    #"Renamed Columns" = Table.RenameColumns(#"Reordered Columns",{{"Custom", "TASAS COMPLETAS"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"TASAS COMPLETAS", type number}})
in
    #"Changed Type"

// Evolución Saldos
let
    Origen = Value.NativeQuery(ConnectionDB_KAT, "SELECT s.[CD_CUENTA]#(lf), CTA.CD_EMPRESA #(lf),emp.DS_NOMBRE as Empresa#(lf)      ,s.[FC_FECHA]#(lf)      ,s.[NM_SALDO]#(lf)      ,s.[NM_SALDO_ERP]#(lf)      ,s.[CD_MVTO_ULTIMO]#(lf)      ,s.[CD_MVTO_ERP_ULTIMO]#(lf)  FROM [dbo].[KAT_SALDO_CUENTA] s#(lf)#(tab)left join [dbo].[KAT_CUENTAS] cta on cta.CD_CUENTA=s.CD_CUENTA#(lf)    left join [dbo].[KAT_EMPRESAS] emp on emp.CD_EMPRESA=cta.CD_EMPRESA")
in
    Origen

// Nº de Años
10 meta [IsParameterQuery=true, Type="Any", IsParameterQueryRequired=true]

// Desde
2014 meta [IsParameterQuery=true, Type="Any", IsParameterQueryRequired=true]

// Tipo Movimiento
let
    Source = ConnectionDB_KAT,
    dbo_KAT_TIPO_MOVIMIENTO = Source{[Schema="dbo",Item="KAT_TIPO_MOVIMIENTO"]}[Data],
    #"Removed Columns" = Table.RemoveColumns(dbo_KAT_TIPO_MOVIMIENTO,{"KAT_MOVIMIENTOS_ERP"})
in
    #"Removed Columns"

// Divisa Sistema
let
    Origen = Value.NativeQuery(ConnectionDB_KAT, "SELECT DS_ISO_DIVISA#(lf)FROM [dbo].[KAT_DIVISAS]#(lf)WHERE CD_DIVISA = (SELECT cast([DS_VALOR] as int) as 'CD Divisa' #(lf)#(tab)#(tab)#(tab)#(tab)#(tab)FROM [dbo].[STON_CONFIGURACION] #(lf)#(tab)#(tab)#(tab)#(tab)#(tab)WHERE CD_CLAVE='DIVISA_REFERENCIA')")
in
    Origen

// Conciliación
let
    Origen = Value.NativeQuery(ConnectionDB_KAT, "SELECT #(lf)#(tab)#(tab)#(tab)mvto.CD_CUENTA#(lf)#(tab)#(tab)#(tab), 'BANCO' as Origen #(lf)#(tab)#(tab)#(tab)--, mvto.CD_MOVIMIENTO#(lf)#(tab)#(tab)#(tab), mvto.FC_OPERACION#(lf)#(tab)#(tab)#(tab),mvto.FC_CIERRE#(lf)#(tab)#(tab)#(tab), mvto.CD_VIA_COBRO_PAGO#(lf)#(tab)#(tab)#(tab),mvto.IT_PUNTEADO #(lf)#(tab)#(tab)#(tab)--, mvto.DS_COMPLEMENTARIO + ' ' + mvto.DS_REFERENCIA as DS_REFERENCIA#(lf)#(tab)#(tab)#(tab), mvto.NM_IMPORTE#(lf)#(tab)#(tab)#(tab), mvto.NM_SALDO#(lf)#(tab)#(tab)#(tab)#(lf)#(tab)#(tab)from #(lf)#(tab)#(tab)#(tab)KAT_MOVIMIENTOS_BANCO mvto#(lf)#(tab)#(tab)#(tab)--join @cuentas cta on mvto.CD_CUENTA = cta.CODIGO#(lf)#(tab)#(tab)WHERE mvto.IT_CONCILIACION =1#(lf)#(tab)#(tab)#(tab)and mvto.CD_TIPO_MOVIMIENTO <> 1#(lf)#(tab)#(tab)#(tab)#(lf)Union #(lf)SELECT#(lf)#(tab)#(tab)#(tab)mvto.CD_CUENTA #(lf)#(tab)#(tab)#(tab), case when mvto.CD_TIPO_MOVIMIENTO = 5 #(lf)#(tab)#(tab)#(tab)#(tab)then 'AJUSTE'#(lf)#(tab)#(tab)#(tab)#(tab)else 'ERP' end Origen#(lf)#(tab)#(tab)#(tab)--, mvto.CD_MOVIMIENTO#(lf)#(tab)#(tab)#(tab), mvto.FC_OPERACION#(lf)#(tab)#(tab)#(tab),mvto.FC_CIERRE#(lf)#(tab)#(tab)#(tab), mvto.CD_VIA_COBRO_PAGO#(lf)#(tab)#(tab)#(tab),mvto.IT_PUNTEADO #(lf)#(tab)#(tab)#(tab)--,mvto.DS_COMPLEMENTARIO + ' ' + mvto.DS_REFERENCIA as DS_REFERENCIA#(lf)#(tab)#(tab)#(tab), mvto.NM_IMPORTE#(lf)#(tab)#(tab)#(tab), mvto.NM_SALDO#(lf)#(tab)#(tab)#(tab)#(tab)#(lf)#(tab)#(tab)from KAT_MOVIMIENTOS_ERP mvto#(lf)#(tab)#(tab)#(tab)WHERE  mvto.CD_TIPO_MOVIMIENTO <> 1")
in
    Origen

// DIVISAS
let
    Source = ConnectionDB_KAT,
    dbo_KAT_DIVISAS = Source{[Schema="dbo",Item="KAT_DIVISAS"]}[Data],
    #"Removed Columns" = Table.RemoveColumns(dbo_KAT_DIVISAS,{"DS_NOMBRE_DIVISA", "NM_ISO_DIVISA", "DS_URL_SERVICIO", "KAT_CART_BLOQUE", "KAT_CUENTAS", "KAT_DIVISAS_MOVIMIENTOS", "KAT_MOVIMIENTOS_CARTERA", "KAT_MOVIMIENTOS_ERP", "KAT_PREVISIONES(CD_DIVISA)", "KAT_PREVISIONES(CD_DIVISA) 2"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Columns",{{"DS_ISO_DIVISA", "DIVISA"}, {"DS_SIMBOLO", "SIMBOLO"}})
in
    #"Renamed Columns"

// DivisasMov
let
    Source = Value.NativeQuery(ConnectionDB_KAT, "  SELECT d.[CD_DIVISA]#(lf)#(tab),d.[DS_NOMBRE_DIVISA]#(lf)      ,d.[DS_ISO_DIVISA]#(lf)      ,d.[NM_ISO_DIVISA]#(lf)      ,d.[DS_SIMBOLO]#(lf)       ,mov.[FC_MOVIMIENTO]#(lf)      ,mov.[NM_TIPO_CAMBIO]#(lf)  FROM  [dbo].[KAT_DIVISAS]d #(lf)    left join [dbo].[KAT_DIVISAS_MOVIMIENTOS] mov on d.[cd_Divisa]=mov.[cd_divisa]#(lf)#(tab)order by 1,6"),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"FC_MOVIMIENTO", type date}})

in
    #"Changed Type"

// Endeudamiento
let
    Source = ConnectionDB_KAT,
    dbo_BI_ENDEUDAMIENTO = Source{[Schema="dbo",Item="BI_ENDEUDAMIENTO"]}[Data]
in
    dbo_BI_ENDEUDAMIENTO

// FechasCierre
let
    Source = ConnectionDB_KAT,
    dbo_KAT_CUENTAS_CIERRE = Source{[Schema="dbo",Item="KAT_CUENTAS_CIERRE"]}[Data]
in
    dbo_KAT_CUENTAS_CIERRE

// Ingresos y Gastos
let
    Origen = Value.NativeQuery(ConnectionDB_KAT, "SELECT #(lf)#(tab)[CD_CUENTA]#(lf)      ,[NM_IMPORTE]#(lf)      ,[NM_SALDO]#(lf)      ,[FC_VALOR] #(lf)      ,[FC_OPERACION] #(lf)      ,[DS_TIPO_MOVIMIENTO] as 'Tipo Movimiento'#(lf)    -- ,[CD_VIA_COBRO_PAGO]#(lf)#(tab) , vcp.[DS_ALIAS_VIA_COBRO_PAGO] 'Vía CyP'#(lf)      ,[DS_CONCEPTO_PROPIO] 'Concepto Propio'#(lf)      --,[DS_DOCUMENTO] 'Documento'#(lf)      --,[DS_REFERENCIA]#(lf)      ,[DS_COMPLEMENTARIO]#(lf)      ,[CD_DIVISA_ORIGEN]#(lf)    --  ,[CD_CONCEPTO_COMUN]#(lf)#(tab),[DS_CONCEPTO_COMUN] 'Concepto Común'#(lf)       ,[IT_ANULADO]#(lf)      ,[FC_ANULACION]#(lf)#(lf)      ,[NM_MOVIMIENTO]#(lf)      --,[CD_CONCEPTO]#(lf)#(tab)    ,[IT_VALIDADO]#(lf)      ,[FC_VALIDACION]#(lf)#(lf)      ,[NM_TIPO_CAMBIO]#(lf)      ,[FC_VENCIMIENTO]#(lf)#(lf)  FROM [dbo].[KAT_MOVIMIENTOS_BANCO] bco#(lf)    left join [dbo].[KAT_CONCEPTOS_COMUNES] ccp on ccp.[CD_CONCEPTO_COMUN]=bco.[CD_CONCEPTO_COMUN]#(lf)  left join [dbo].[KAT_VIAS_COBRO_PAGO] vcp on vcp.CD_VIA_COBRO_PAGO=bco.CD_VIA_COBRO_PAGO#(lf)   left join [dbo].[KAT_TIPO_MOVIMIENTO] tm on tm.[CD_TIPO_MOVIMIENTO]=bco.[CD_TIPO_MOVIMIENTO]")
in
    Origen

// Previsiones
let
    Origen = Value.NativeQuery(ConnectionDB_KAT, "SELECT case when isnull([CD_CUENTA],-1)=-1 then -1 else cd_cuenta end as Cuenta#(lf),[CD_EMPRESA]#(lf),[CD_BANCO]#(lf)      ,pre.[IT_ES_PAGO] as EsPago#(lf)#(tab)  ,ccp.[DS_CONCEPTO] 'Concepto CyP'#(lf)#(tab)  ,tccp.[DS_TIPO_CONCEPTO] 'Tipo Concepto CyP'#(lf)     --,[CD_CONCEPTO]#(lf)#(tab) , [DS_ALIAS_VIA_COBRO_PAGO] 'Vía CyP'#(lf)#(tab)  --, [CD_VIA_COBRO_PAGO]#(lf)       ,[FC_VENCIMIENTO] as 'Fecha Vto'#(lf)      ,[FC_PREVISTA] as 'Fecha Prevista'#(lf)      ,[FC_EMISION_FACTURA] as 'Fecha Emisión Fra'#(lf)#(tab)     ,[FC_VALIDACION] as 'Fecha Validación'#(lf)      ,[NM_IMPORTE_INICIAL] as 'Importe Inicial'#(lf)#(tab)    --  ,[CD_DIVISA_INICIAL]#(lf)      ,[NM_IMPORTE_PREVISTO] as 'Importe Previsto'#(lf)     -- ,[CD_DIVISA_PREVISTA]#(lf)      --,[CD_ESTADO]#(lf)#(tab)   ,tep.[DS_ESTADO] as 'Estado'#(lf)        --,[CD_ORIGEN]#(lf)#(tab)#(tab),op.[DS_ORIGEN] as 'Origen'#(lf)      --,[CD_TIPO_PREVISION]#(lf)#(tab)    ,tp.[DS_TIPO_PREVISION] as 'Tipo Previsión'#(lf)      --,[CD_TIPO_DOCUMENTO]#(lf)#(tab)  ,td.[DS_TIPO_DOCUMENTO] as 'Tipo Documento'#(lf)    -- ,[CD_CERTEZA]#(lf)#(tab),crt.[DS_CERTEZA] as 'Certeza'#(lf)#(tab),crt.[NM_PORCENTAJE] as 'Porcentaje Certeza'#(lf),pre.DS_Descripcion as 'Detalle Previsión'#(lf)    --  ,[IT_FINANCIABLE]#(lf)     -- ,[IT_BORRABLE]#(lf)     -- ,[IT_FINANCIADA]#(lf)     -- ,[CD_TIPO_CRITERIO]#(lf)#(tab)  --,[CdOperacion]#(lf)      --,[CdOperacionAmortizacion]#(lf)      --,[CdSyncPrevisionTipo]#(lf)  FROM [dbo].[KAT_PREVISIONES] pre#(lf)  left join [dbo].[KAT_CONCEPTOS_COBRO_PAGO] ccp on ccp.CD_CONCEPTO=pre.CD_CONCEPTO#(lf)  left join [dbo].[KAT_VIAS_COBRO_PAGO] vcp on vcp.CD_VIA_COBRO_PAGO=pre.CD_VIA_COBRO_PAGO#(lf)  left join [dbo].[KAT_TIPO_ESTADO_PREVISION] tep on tep.CD_ESTADO=pre.CD_ESTADO#(lf)  left join [dbo].[KAT_TIPO_ORIGEN_PREVISION] op on op.CD_ORIGEN=pre.CD_ORIGEN#(lf)  left join [dbo].[KAT_TIPO_PREVISION] tp on tp.CD_TIPO_PREVISION=pre.CD_TIPO_PREVISION#(lf)  left join [dbo].[KAT_TIPO_DOCUMENTO] td on td.CD_TIPO_DOCUMENTO=pre.CD_TIPO_DOCUMENTO#(lf)  left join [dbo].[KAT_TIPO_CERTEZA] crt on crt.CD_CERTEZA=pre.CD_CERTEZA#(lf)  left join [dbo].[KAT_TIPO_CONCEPTO_COBRO_PAGO] tccp on tccp.[CD_TIPO_CONCEPTO]=ccp.CD_TIPO_CONCEPTO")
in
    Origen

// Seguridad Usuarios
let
    Origen = Value.NativeQuery(ConnectionDB_KAT, "SELECT DISTINCT T2.Email, CD_CUENTA#(lf)  FROM [dbo].[aspnet_UsersInRoles] T1#(lf)       LEFT JOIN [dbo].[aspnet_Membership] T2 ON T1.[UserId] = T2.UserId#(lf)       LEFT JOIN [dbo].[KAT_ROLES_ACCESO_CUENTAS] T3 ON T1.RoleId = T3.RoleId#(lf)")
in
    Origen

// Tiempo
let
    Origen = {0..#"Nº de Años"*365},
    #"Convertida en tabla" = Table.FromList(Origen, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Personalizada agregada" = Table.AddColumn(#"Convertida en tabla", "Fecha", each Date.AddDays(#date(Desde,1,1),[Column1])),
    #"Trimestre insertado" = Table.AddColumn(#"Personalizada agregada", "Trimestre", each Date.QuarterOfYear([Fecha])),
    #"Año insertado" = Table.AddColumn(#"Trimestre insertado", "Año", each Date.Year([Fecha]), Int64.Type),
    #"Semana del año insertada" = Table.AddColumn(#"Año insertado", "Semana del año", each Date.WeekOfYear([Fecha]), Int64.Type),
    #"Mes insertado" = Table.AddColumn(#"Semana del año insertada", "Mes", each Date.Month([Fecha]), Int64.Type),
    #"Nombre del mes insertado" = Table.AddColumn(#"Mes insertado", "Nombre del mes", each Date.MonthName([Fecha], "es-ES"), type text),
    #"Poner En Mayúsculas Cada Palabra" = Table.TransformColumns(#"Nombre del mes insertado",{{"Nombre del mes", Text.Proper, type text}}),
    #"Día de la semana insertado" = Table.AddColumn(#"Poner En Mayúsculas Cada Palabra", "Día de la semana", each Date.DayOfWeek([Fecha])+1),
    #"Nombre del día insertado" = Table.AddColumn(#"Día de la semana insertado", "Nombre del día", each Date.DayOfWeekName([Fecha], "es-ES"), type text),
    #"Poner En Mayúsculas Cada Palabra1" = Table.TransformColumns(#"Nombre del día insertado",{{"Nombre del día", Text.Proper, type text}}),
    #"Personalizada agregada1" = Table.AddColumn(#"Poner En Mayúsculas Cada Palabra1", "Periodo", each Text.From([Año])&" "&Text.Start([Nombre del mes],3)),
    #"Personalizada agregada2" = Table.AddColumn(#"Personalizada agregada1", "IdPeriodo", each [Año]*100+[Mes]),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Personalizada agregada2",{{"Column1", Int64.Type}, {"Fecha", type date}, {"Trimestre", Int64.Type}, {"Año", Int64.Type}, {"Semana del año", Int64.Type}, {"Mes", Int64.Type}, {"Nombre del mes", type text}, {"Día de la semana", Int64.Type}, {"Nombre del día", type text}, {"Periodo", type text}, {"IdPeriodo", Int64.Type}}, "es-ES"),
    #"Columnas quitadas" = Table.RemoveColumns(#"Tipo cambiado",{"Column1"})
in
    #"Columnas quitadas"

// QueryTiempo
let
    Origen = {0..#"Nº de Años"*365},
    #"Convertida en tabla" = Table.FromList(Origen, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Personalizada agregada" = Table.AddColumn(#"Convertida en tabla", "Fecha", each Date.AddDays(#date(Desde,1,1),[Column1])),
    #"Trimestre insertado" = Table.AddColumn(#"Personalizada agregada", "Trimestre", each Date.QuarterOfYear([Fecha])),
    #"Año insertado" = Table.AddColumn(#"Trimestre insertado", "Año", each Date.Year([Fecha]), Int64.Type),
    #"Semana del año insertada" = Table.AddColumn(#"Año insertado", "Semana del año", each Date.WeekOfYear([Fecha]), Int64.Type),
    #"Mes insertado" = Table.AddColumn(#"Semana del año insertada", "Mes", each Date.Month([Fecha]), Int64.Type),
    #"Nombre del mes insertado" = Table.AddColumn(#"Mes insertado", "Nombre del mes", each Date.MonthName([Fecha]), type text),
    #"Poner En Mayúsculas Cada Palabra" = Table.TransformColumns(#"Nombre del mes insertado",{{"Nombre del mes", Text.Proper, type text}}),
    #"Día de la semana insertado" = Table.AddColumn(#"Poner En Mayúsculas Cada Palabra", "Día de la semana", each Date.DayOfWeek([Fecha])+1),
    #"Nombre del día insertado" = Table.AddColumn(#"Día de la semana insertado", "Nombre del día", each Date.DayOfWeekName([Fecha]), type text),
    #"Poner En Mayúsculas Cada Palabra1" = Table.TransformColumns(#"Nombre del día insertado",{{"Nombre del día", Text.Proper, type text}}),
    #"Personalizada agregada1" = Table.AddColumn(#"Poner En Mayúsculas Cada Palabra1", "Periodo", each Text.From([Año])&" "&Text.Start([Nombre del mes],3)),
    #"Personalizada agregada2" = Table.AddColumn(#"Personalizada agregada1", "IdPeriodo", each [Año]*100+[Mes]),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Personalizada agregada2",{{"Column1", Int64.Type}, {"Fecha", type date}, {"Trimestre", Int64.Type}, {"Año", Int64.Type}, {"Semana del año", Int64.Type}, {"Mes", Int64.Type}, {"Nombre del mes", type text}, {"Día de la semana", Int64.Type}, {"Nombre del día", type text}, {"Periodo", type text}, {"IdPeriodo", Int64.Type}}),
    #"Columnas quitadas" = Table.RemoveColumns(#"Tipo cambiado",{"Column1"})
in
    #"Columnas quitadas"

// Versions
let
  TableVersions = Table.FromRecords(
    {
      [
        Version            = "1.0", 
        Revision Date_Time = "2021/07/01", 
        Developer Name     = "hector@singularfact.com", 
        Revision Notes md  = "
## Changes
  * Model moved from Original SSAS to Powerbi Dataset
          "
      ],
      [
        Version            = "1.1", 
        Revision Date_Time = "2021/07/25", 
        Developer Name     = "hector@singularfact.com", 
        Revision Notes md  = "
## Changes
  * Updated changes from latest SSAS changes
          "
      ],
      [
        Version            = "1.4", 
        Revision Date_Time = "2021/11/24", 
        Developer Name     = "hector@singularfact.com", 
        Revision Notes md  = "
## Changes
  * Make all columns no summary
          "
      ],
      [
        Version            = "1.5", 
        Revision Date_Time = "2021/11/24", 
        Developer Name     = "hector@singularfact.com", 
        Revision Notes md  = "
## Changes
  * Update Reade r Role to be able to manage users from external domains.
  * Added measures to Versions table to help analyze users. 
          "
      ],
      [
        Version            = "1.5.1", 
        Revision Date_Time = "2021/11/24", 
        Developer Name     = "hector@singularfact.com", 
        Revision Notes md  = "
## Changes
  * Update name TIPO_CUENTA to Tipo Cuenta in table Endeudamientos 
          "
      ],
      [
        Version            = "1.5.2", 
        Revision Date_Time = "2021/11/25", 
        Developer Name     = "hector@singularfact.com", 
        Revision Notes md  = "
## Changes
  * Remove users from Reader role. At the moment they need to be updated manually
  because the XMLA protocol does not handle them well. 
          "
      ],
      [
        Version            = "1.5.3", 
        Revision Date_Time = "2021/12/19", 
        Developer Name     = "hector@singularfact.com", 
        Revision Notes md  = "
## Changes
  * Added sortBy column IdPeriod to column Periodo 
  * Changed column 'Nombre del Mes' 's locale to 'es-ES' 
  * Changed column 'Nombre del Dia' 's locale to 'es-ES'
  * Transform column types from tiempo Table's locale to 'es-ES' 
  * Change Culture to 'es-ES' // May not affect anithing as it seems that it is needed to set culture before adding any object
  * Add sortBy to column 'Nombre del Mes'
          "
      ],
      [
        Version            = "1.5.4", 
        Revision Date_Time = "2022/01/11", 
        Developer Name     = "hector@singularfact.com", 
        Revision Notes md  = "
## Changes
  * Style change date format
  * Style change date format - FC_CIERRE
          "
      ]
    }, 
    type table [
      Version = Text.Type, 
      Revision Date_Time = Text.Type, 
      Developer Name = Text.Type, 
      Revision Notes md = Text.Type
    ]
  ), 
  TableRenameColumns = Table.RenameColumns(
    TableVersions, 
    {{"Revision Date_Time", "Revision Date/Time"}, {"Revision Notes md", "Revision Notes (md)"}}
  ), 
  #"Changed Type1" = Table.TransformColumnTypes(
    TableRenameColumns, 
    {{"Revision Date/Time", type datetime}}
  ), 
  #"Added Custom" = Table.AddColumn(#"Changed Type1", "Refresh Date/Time", each DateTime.LocalNow()), 
  #"Changed Type" = Table.TransformColumnTypes(
    #"Added Custom", 
    {{"Refresh Date/Time", type datetimezone}}
  )
in
  #"Changed Type"

// Condiciones full
let
    Source = Value.NativeQuery(ConnectionDB_KAT, "select * from dbo.KAT_CUENTAS cta left join dbo.KAT_CUENTAS_ASOCIADAS asoc on cta.CD_CUENTA = asoc.CD_CUENTA_ASOCIADA#(lf)left join dbo.KAT_CONDICIONES cond on cta.CD_CUENTA = cond.CD_CUENTA#(lf)or asoc.CD_CUENTA = cond.CD_CUENTA"),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"NM_COMISION_NO_DISPONIBLE", "COM. NDISP"}, {"NM_COMISION_APERTURA", "COM. APERT"}}),
    #"Filtered Rows" = Table.SelectRows(#"Renamed Columns", each true)
in
    #"Filtered Rows"

// IBAN
let
    Source = Value.NativeQuery(ConnectionDB_KAT, "Select c.CD_CUENTA, c.DS_CODIGO_INTERNACIONAL from#(lf)(Select c.CD_CUENTA, kc.DS_CODIGO_INTERNACIONAL from KAT_CUENTAS kc left join (#(lf)Select CD_CUENTA = ca.CD_CUENTA_ASOCIADA, CD_CUENTA_ORIGEN = c.CD_CUENTA from KAT_CUENTAS c left join KAT_CUENTAS_ASOCIADAS ca on c.CD_CUENTA = ca.CD_CUENTA) c#(lf)on kc.CD_CUENTA = c.CD_CUENTA_ORIGEN#(lf)Where c.CD_CUENTA is not null#(lf)Union all#(lf)Select kc.CD_CUENTA, kc.DS_CODIGO_INTERNACIONAL from KAT_CUENTAS kc left join KAT_CUENTAS_ASOCIADAS ca on kc.CD_CUENTA = ca.CD_CUENTA#(lf)Where kc.CD_CUENTA not in (Select c.CD_CUENTA from KAT_CUENTAS kc left join (#(lf)Select CD_CUENTA = ca.CD_CUENTA_ASOCIADA, CD_CUENTA_ORIGEN = c.CD_CUENTA from KAT_CUENTAS c left join KAT_CUENTAS_ASOCIADAS ca on c.CD_CUENTA = ca.CD_CUENTA) c#(lf)on kc.CD_CUENTA = c.CD_CUENTA_ORIGEN#(lf)Where c.CD_CUENTA is not null)) c#(lf)Order by c.CD_CUENTA")
in
    Source

// KAT_EMPRESAS
let
    Source = ConnectionDB_KAT,
    dbo_KAT_EMPRESAS = Source{[Schema="dbo",Item="KAT_EMPRESAS"]}[Data],
    #"Filas filtradas" = Table.SelectRows(dbo_KAT_EMPRESAS, each ([DS_NOMBRE] <> "ADHOC CONTROL DE GESTION SL" and [DS_NOMBRE] <> "BCOME PAMPLONA SL" and [DS_NOMBRE] <> "CAVA BAJA INVERSIONES, S.L.U." and [DS_NOMBRE] <> "INTERHOUSING PERE IV, S.L." and [DS_NOMBRE] <> "IRE RE URBANESCO JV S.L.U." and [DS_NOMBRE] <> "IRE-RE URBANESCO DEVELOPMENTS, S.L." and [DS_NOMBRE] <> "MOMENTUM INDUSTRIES SPAIN FUND I SL" and [DS_NOMBRE] <> "THE PROTOTIPO BOX CONSTRUCCION INDUSTRIALIZADA SL" and [DS_NOMBRE] <> "THE PROTOTIPO COMPANY, S.L." and [DS_NOMBRE] <> "URBANIA BCN MANAGEMENT SL" and [DS_NOMBRE] <> "URBANIA CIUDAD DE BARCELONA 103 SL" and [DS_NOMBRE] <> "URBANIA DIAGONAL 331 SLU" and [DS_NOMBRE] <> "URBANIA FORMENTERA, S.L.U." and [DS_NOMBRE] <> "URBANIA LAMATRA III, S.L." and [DS_NOMBRE] <> "URBANIA MADRID MANAGEMENT SL" and [DS_NOMBRE] <> "URBANIA PROPERTY PARTNERS SL" and [DS_NOMBRE] <> "URBANIA SANTA CLARA DEVELOPMENT IV SLU" and [DS_NOMBRE] <> "URBANIA SANTA CLARA DEVELOPMENT, SLU" and [DS_NOMBRE] <> "WOOD & STEEL DESIGN S.L.")),
    #"Columna condicional agregada" = Table.AddColumn(#"Filas filtradas", "DS_EMPRESA_TIPO", each if [CD_EMPRESA_TIPO] = 2 then "OTHER" else if [CD_EMPRESA_TIPO] = 15 then "RESI" else if [CD_EMPRESA_TIPO] = 21 then "INNO HUB" else if [CD_EMPRESA_TIPO] = 19 then "TGP" else if [CD_EMPRESA_TIPO] = 17 then "LIVING" else if [CD_EMPRESA_TIPO] = 16 then "COMERCIAL" else if [CD_EMPRESA_TIPO] = 18 then "HOLDING" else if [CD_EMPRESA_TIPO] = 20 then "DEBT" else "NULL"),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Columna condicional agregada",{{"DS_EMPRESA_TIPO", type text}})
in
    #"Tipo cambiado"

// Saldos sin CP
let
    Source = Value.NativeQuery(ConnectionDB_KAT, "SELECT CD_CUENTA, FC_OPERACION, SUM(NM_IMPORTE) FROM KAT_MOVIMIENTOS_BANCO #(lf)WHERE CD_CUENTA=1 AND CD_VIA_COBRO_PAGO <> 15#(lf)GROUP BY CD_CUENTA, FC_OPERACION#(lf)ORDER BY FC_OPERACION ")
in
    Source

// Previsiones_KAT
let
    Source = Value.NativeQuery(ConnectionDB_KAT, "Select ccp.DS_CONCEPTO, vcp.DS_ALIAS_VIA_COBRO_PAGO, tp.DS_TIPO_PREVISION,td.DS_TIPO_DOCUMENTO,tf.DS_FLUJO_CAJA, p.*#(lf)from KAT_PREVISIONES p#(lf)inner join KAT_CONCEPTOS_COBRO_PAGO ccp on p.CD_CONCEPTO = ccp.CD_CONCEPTO#(lf)inner join KAT_VIAS_COBRO_PAGO vcp on p.CD_VIA_COBRO_PAGO = vcp.CD_VIA_COBRO_PAGO#(lf)inner join KAT_TIPO_PREVISION tp on p.CD_TIPO_PREVISION = tp.CD_TIPO_PREVISION#(lf)inner join KAT_TIPO_DOCUMENTO td on p.CD_TIPO_DOCUMENTO= td.CD_TIPO_DOCUMENTO#(lf)inner join KAT_TIPO_FLUJO_CAJA tf on ccp.CD_FLUJO_CAJA=tf.CD_FLUJO_CAJA")
in
    Source

// Previsiones_Full
let
    Source = Previsiones_KAT,
    #"Appended Query" = Table.Combine({Source, Previsiones_Manuales}),
    #"Columna condicional agregada" = Table.AddColumn(#"Appended Query", "Personalizado", each if [IT_ES_PAGO] = true then "Pago" else "Cobro"),
    #"Columnas con nombre cambiado" = Table.RenameColumns(#"Columna condicional agregada",{{"Personalizado", "Pago/Cobro"}}),
    #"Dividir columna por delimitador" = Table.SplitColumn(#"Columnas con nombre cambiado", "DS_CAMPO_2", Splitter.SplitTextByDelimiter(";", QuoteStyle.None), {"DS_CAMPO_2.1", "DS_CAMPO_2.2", "DS_CAMPO_2.3"}),
    #"Columnas con nombre cambiado1" = Table.RenameColumns(#"Dividir columna por delimitador",{{"DS_CAMPO_2.1", "DS_PROYECTO"}, {"DS_CAMPO_2.2", "DS_PL ALLOCATION"}, {"DS_CAMPO_2.3", "DS_CCM"}}),
    #"Filtered Rows2" = Table.SelectRows(#"Appended Query", each ([DS_CONCEPTO] = "Clientes")),
    #"Sorted Rows" = Table.Sort(#"Filtered Rows2",{{"DS_TIPO_PREVISION", Order.Ascending}})
in
    #"Sorted Rows"

// Previsiones_Manuales
let
    Origen = GoogleSheets.Contents("https://docs.google.com/spreadsheets/d/1yilVuKVhuMSYvLIxdjw9YtXZY6vl4_pitiDEq6rYOro"),
    Datos_Table = Origen{[name="Datos",ItemKind="Table"]}[Data],
    #"Encabezados promovidos" = Table.PromoteHeaders(Datos_Table, [PromoteAllScalars=true]),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos",{{"Empresa", type text}, {"Banco", type text}, {"Cuenta", type text}, {"Importe", type number}, {"Divisa", type text}, {"Fecha Vencimiento", type date}, {"Complementario", type text}, {"Vía Cobro-Pago", type text}, {"Concepto", type text}, {"Número Documento", type text}, {"Tipo de Documento", type text}, {"Fecha emisión Factura", type date}, {"Fecha Prevista", type date}, {"Fecha Financiación", type date}}),
    #"Renamed Columns" = Table.RenameColumns(#"Tipo cambiado",{{"Empresa", "DS_ALIAS_EMPRESA"}, {"Banco", "DS_ALIAS_BANCO"}, {"Cuenta", "CD_CUENTA"}, {"Importe", "NM_IMPORTE_PREVISTO"}, {"Divisa", "DIVISA"}, {"Fecha Vencimiento", "FC_VENCIMIENTO"}, {"Complementario", "DS_DESCRIPCION"}, {"Vía Cobro-Pago", "DS_ALIAS_VIA_COBRO_PAGO"}, {"Concepto", "DS_CONCEPTO"}, {"Número Documento", "DS_COCUMENTO"}, {"Tipo de Documento", "DS_TIPO_DOCUMENTO"}, {"Fecha emisión Factura", "FC_EMISION_FACTURA"}, {"Fecha Prevista", "FC_PREVISTA"}, {"Fecha Financiación", "FC_FINANCIACION"}, {"Línea Financiación", "Línea Financiación_Ignored"}, {"CAMPO LIBRE 1", "DS_CAMPO_1"}, {"CAMPO LIBRE 2", "DS_CAMPO_2"}, {"CAMPO_LIBRE 3", "DS_CAMPO_3"}, {"NUMERO REMESA", "DS_REMESA"}, {"Codigo_Concepto", "CD_CONCEPTO"}}),
    #"Removed Columns" = Table.RemoveColumns(#"Renamed Columns",{"@dropdown"}),
    #"Filtered Rows" = Table.SelectRows(#"Removed Columns", each [Identificador ERP] <> null and [Identificador ERP] <> ""),
    #"Changed Type" = Table.TransformColumnTypes(#"Filtered Rows",{{"Identificador ERP", type text}}),
    #"Renamed Columns1" = Table.RenameColumns(#"Changed Type",{{"DS_COCUMENTO", "DS_DOCUMENTO"}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Renamed Columns1",{{"DS_CAMPO_1", type text}, {"DS_CAMPO_2", type text}, {"DS_CAMPO_3", type text}, {"DS_REMESA", type text}, {"CD_CONCEPTO", Int64.Type}, {"CD_CUENTA", Int64.Type}}),
    #"Merged Queries" = Table.NestedJoin(#"Changed Type1", {"DS_ALIAS_EMPRESA"}, KAT_EMPRESAS, {"DS_ALIAS_EMPRESA"}, "KAT_EMPRESAS", JoinKind.LeftOuter),
    #"Expanded KAT_EMPRESAS" = Table.ExpandTableColumn(#"Merged Queries", "KAT_EMPRESAS", {"CD_EMPRESA"}, {"CD_EMPRESA"}),
    #"Merged Queries1" = Table.NestedJoin(#"Expanded KAT_EMPRESAS", {"DS_ALIAS_BANCO"}, KAT_BANCOS, {"DS_ALIAS_BANCO"}, "KAT_BANCOS", JoinKind.LeftOuter),
    #"Expanded KAT_BANCOS" = Table.ExpandTableColumn(#"Merged Queries1", "KAT_BANCOS", {"CD_BANCO"}, {"CD_BANCO"}),
    #"Merged Queries2" = Table.NestedJoin(#"Expanded KAT_BANCOS", {"DIVISA"}, DIVISAS, {"DIVISA"}, "DIVISAS", JoinKind.LeftOuter),
    #"Expanded DIVISAS" = Table.ExpandTableColumn(#"Merged Queries2", "DIVISAS", {"CD_DIVISA"}, {"CD_DIVISA"}),
    #"Duplicated Column" = Table.DuplicateColumn(#"Expanded DIVISAS", "CD_DIVISA", "CD_DIVISA - Copy"),
    #"Renamed Columns2" = Table.RenameColumns(#"Duplicated Column",{{"CD_DIVISA", "CD_DIVISA_INICIAL"}, {"CD_DIVISA - Copy", "CD_DIVISA_PREVISTA"}}),
    #"Merged Queries3" = Table.NestedJoin(#"Renamed Columns2", {"DS_ALIAS_VIA_COBRO_PAGO"}, KAT_VIAS_COBRO_PAGO, {"DS_ALIAS_VIA_COBRO_PAGO"}, "KAT_VIAS_COBRO_PAGO", JoinKind.LeftOuter),
    #"Expanded KAT_VIAS_COBRO_PAGO" = Table.ExpandTableColumn(#"Merged Queries3", "KAT_VIAS_COBRO_PAGO", {"CD_VIA_COBRO_PAGO"}, {"CD_VIA_COBRO_PAGO"}),
    #"Added Custom" = Table.AddColumn(#"Expanded KAT_VIAS_COBRO_PAGO", "DS_TIPO_PREVISION", each "Manual"),
    #"Changed Type2" = Table.TransformColumnTypes(#"Added Custom",{{"DS_TIPO_PREVISION", type text}}),
    #"Merged Queries4" = Table.NestedJoin(#"Changed Type2", {"DS_TIPO_PREVISION"}, KAT_TIPO_PREVISION, {"DS_TIPO_PREVISION"}, "KAT_TIPO_PREVISION", JoinKind.LeftOuter),
    #"Expanded KAT_TIPO_PREVISION" = Table.ExpandTableColumn(#"Merged Queries4", "KAT_TIPO_PREVISION", {"CD_TIPO_PREVISION"}, {"CD_TIPO_PREVISION"}),
    #"Merged Queries5" = Table.NestedJoin(#"Expanded KAT_TIPO_PREVISION", {"DS_TIPO_DOCUMENTO"}, KAT_TIPO_DOCUMENTO, {"DS_TIPO_DOCUMENTO"}, "KAT_TIPO_DOCUMENTO", JoinKind.LeftOuter),
    #"Expanded KAT_TIPO_DOCUMENTO" = Table.ExpandTableColumn(#"Merged Queries5", "KAT_TIPO_DOCUMENTO", {"CD_TIPO_DOCUMENTO"}, {"CD_TIPO_DOCUMENTO"}),
    #"Merged Queries6" = Table.NestedJoin(#"Expanded KAT_TIPO_DOCUMENTO", {"DS_FLUJO_CAJA"}, KAT_TIPO_FLUJO_CAJA, {"DS_FLUJO_CAJA"}, "KAT_TIPO_FLUJO_CAJA", JoinKind.LeftOuter),
    #"Expanded KAT_TIPO_FLUJO_CAJA" = Table.ExpandTableColumn(#"Merged Queries6", "KAT_TIPO_FLUJO_CAJA", {"CD_FLUJO_CAJA"}, {"CD_FLUJO_CAJA"}),
    #"Added Conditional Column" = Table.AddColumn(#"Expanded KAT_TIPO_FLUJO_CAJA", "IT_ES_PAGO", each if [NM_IMPORTE_PREVISTO] >= 0 then true else false),
    #"Changed Type3" = Table.TransformColumnTypes(#"Added Conditional Column",{{"IT_ES_PAGO", type logical}, {"FC_VENCIMIENTO", type datetime}, {"FC_EMISION_FACTURA", type datetime}, {"FC_PREVISTA", type datetime}, {"FC_FINANCIACION", type datetime}}),
    #"Duplicated Column1" = Table.DuplicateColumn(#"Changed Type3", "NM_IMPORTE_PREVISTO", "NM_IMPORTE_PREVISTO - Copy"),
    #"Renamed Columns3" = Table.RenameColumns(#"Duplicated Column1",{{"NM_IMPORTE_PREVISTO - Copy", "NM_IMPORTE_INICIAL"}}),
    #"Removed Columns1" = Table.RemoveColumns(#"Renamed Columns3",{"Identificador ERP", "DS_ALIAS_EMPRESA", "DS_ALIAS_BANCO", "Línea Financiación_Ignored", "DIVISA"})
in
    #"Removed Columns1"

// KAT_BANCOS
let
    Source = ConnectionDB_KAT,
    dbo_KAT_BANCOS = Source{[Schema="dbo",Item="KAT_BANCOS"]}[Data]
in
    dbo_KAT_BANCOS

// KAT_VIAS_COBRO_PAGO
let
    Source = ConnectionDB_KAT,
    dbo_KAT_VIAS_COBRO_PAGO = Source{[Schema="dbo",Item="KAT_VIAS_COBRO_PAGO"]}[Data]
in
    dbo_KAT_VIAS_COBRO_PAGO

// KAT_TIPO_PREVISION
let
    Source = ConnectionDB_KAT,
    dbo_KAT_TIPO_PREVISION = Source{[Schema="dbo",Item="KAT_TIPO_PREVISION"]}[Data]
in
    dbo_KAT_TIPO_PREVISION

// KAT_TIPO_DOCUMENTO
let
    Source = ConnectionDB_KAT,
    dbo_KAT_TIPO_DOCUMENTO = Source{[Schema="dbo",Item="KAT_TIPO_DOCUMENTO"]}[Data]
in
    dbo_KAT_TIPO_DOCUMENTO

// KAT_TIPO_FLUJO_CAJA
let
    Source = ConnectionDB_KAT,
    dbo_KAT_TIPO_FLUJO_CAJA = Source{[Schema="dbo",Item="KAT_TIPO_FLUJO_CAJA"]}[Data]
in
    dbo_KAT_TIPO_FLUJO_CAJA

// Previsiones Doc:Conta
let
    Source = Value.NativeQuery(ConnectionDB_KAT, "select CD_PREVISION,NM_IMPORTE_INICIAL from KAT_PREVISIONES where CD_TIPO_DOCUMENTO=17")
in
    Source

// Previsiones Doc:Presu
let
    Source = Value.NativeQuery(ConnectionDB_KAT, "select CD_PREVISION,NM_IMPORTE_INICIAL from KAT_PREVISIONES where CD_TIPO_DOCUMENTO=16")
in
    Source

// IyGporConcepto
let
    Source = Value.NativeQuery(ConnectionDB_KAT, "select distinct#(lf)Tipo = round((SELECT TOP 1 TipoCambio = (case when (SELECT  CAST(ISNULL(LTRIM(DS_VALOR),0) AS BIT) FROM STON_CONFIGURACION WHERE CD_CLAVE='TIPO_CAMBIO_DIVISA')=0 then  #(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)NM_TIPO_CAMBIO #(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)   else #(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)   1/NM_TIPO_CAMBIO  end) #(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)   #(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)   FROM KAT_DIVISAS_MOVIMIENTOS #(lf)#(tab)#(tab)WHERE CD_DIVISA= cue. CD_DIVISA AND FC_MOVIMIENTO<=FC_OPERACION ORDER BY FC_MOVIMIENTO DESC),2)#(lf)#(lf)#(lf),Concepto = con.DS_CONCEPTO,#(lf)* #(lf)#(lf)from KAT_MOVIMIENTOS_BANCO mov#(lf)inner join KAT_CUENTAS cue on cue.CD_CUENTA = mov.CD_CUENTA#(lf)left  join KAT_CONCEPTOS_COBRO_PAGO con on con.CD_CONCEPTO = mov.CD_CONCEPTO#(lf)"),
    #"Filtered Rows" = Table.SelectRows(Source, each true),
    #"Added Conditional Column" = Table.AddColumn(#"Filtered Rows", "IMPORTE", each if [CD_DIVISA_ORIGEN] = 9 then [NM_IMPORTE] else if [CD_DIVISA_ORIGEN] <> 9 then ([Tipo] * [NM_IMPORTE]) else null),
    #"Columnas con nombre cambiado" = Table.RenameColumns(#"Added Conditional Column",{{"CD_TIPO_CONCEPTO", "DS_TIPO_CONCEPTO"}})
in
    #"Columnas con nombre cambiado"

// Endeudamientos - Datos origen
let
    Source = ConnectionDB_KAT,
    dbo_KAT_EMPRESAS = Source{[Schema="dbo",Item="Fi_Operaciones"]}[Data],
    #"Tipo cambiado" = Table.TransformColumnTypes(dbo_KAT_EMPRESAS,{{"CdInstrumento", type text}, {"CdOperacion", type text}, {"CdEmpresa", type text}, {"CdBanco", type text}, {"CdCuenta", type text}})
in
    #"Tipo cambiado"

// Grupos Empresas 1
let
    Origen = SharePoint.Files("https://qlm1.sharepoint.com/sites/Urbania-CuadrodeMando", [ApiVersion = 15]),
    #"Archivos ocultos filtrados1" = Table.SelectRows(Origen, each [Attributes]?[Hidden]? <> true),
    #"Invocar función personalizada1" = Table.AddColumn(#"Archivos ocultos filtrados1", "Transformar archivo", each #"Transformar archivo"([Content])),
    #"Columnas con nombre cambiado1" = Table.RenameColumns(#"Invocar función personalizada1", {"Name", "Source.Name"}),
    #"Otras columnas quitadas1" = Table.SelectColumns(#"Columnas con nombre cambiado1", {"Source.Name", "Transformar archivo"}),
    #"Filas filtradas" = Table.SelectRows(#"Otras columnas quitadas1", each ([Source.Name] = "GrupoEmpresasUrbania.xlsx")),
    #"Columna de tabla expandida1" = Table.ExpandTableColumn(#"Filas filtradas", "Transformar archivo", Table.ColumnNames(#"Transformar archivo"(#"Archivo de ejemplo")))
in
    #"Columna de tabla expandida1"

// Transformar archivo
let
    Source = (Parámetro1 as binary) => let
    Origen = Excel.Workbook(Parámetro1, null, true),
    Grupos_Empresas_Table = Origen{[Item="Grupos_Empresas",Kind="Table"]}[Data]
in
    Grupos_Empresas_Table
in
    Source

// Archivo de ejemplo
let
    Origen = SharePoint.Files("https://qlm1.sharepoint.com/sites/Urbania-CuadrodeMando", [ApiVersion = 15]),
    Navegación1 = Origen{0}[Content]
in
    Navegación1

// KAT_CONCEPTOS_COBRO_PAGO
let
    Source = ConnectionDB_KAT,
    dbo_KAT_CONCEPTOS_COBRO_PAGO = Source{[Schema="dbo",Item="KAT_CONCEPTOS_COBRO_PAGO"]}[Data]
in
    dbo_KAT_CONCEPTOS_COBRO_PAGO