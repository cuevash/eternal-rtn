SELECT case
    when isnull([CD_CUENTA], -1) = -1 then -1
    else cd_cuenta
  end as Cuenta,
  [CD_EMPRESA],
  [CD_BANCO],
  pre.[IT_ES_PAGO] as EsPago,
  ccp.[DS_CONCEPTO] 'Concepto CyP',
  tccp.[DS_TIPO_CONCEPTO] 'Tipo Concepto CyP',
  [CD_CONCEPTO],
  [DS_ALIAS_VIA_COBRO_PAGO] 'Vía CyP',
  [CD_VIA_COBRO_PAGO],
  [FC_VENCIMIENTO] as 'Fecha Vto',
  [FC_PREVISTA] as 'Fecha Prevista',
  [FC_EMISION_FACTURA] as 'Fecha Emisión Fra',
  [FC_VALIDACION] as 'Fecha Validación',
  [NM_IMPORTE_INICIAL] as 'Importe Inicial',
  [CD_DIVISA_INICIAL],
  [NM_IMPORTE_PREVISTO] as 'Importe Previsto',
  [CD_DIVISA_PREVISTA],
  [CD_ESTADO],
  tep.[DS_ESTADO] as 'Estado',
  [CD_ORIGEN],
  op.[DS_ORIGEN] as 'Origen',
  [CD_TIPO_PREVISION],
  tp.[DS_TIPO_PREVISION] as 'Tipo Previsión',
  [CD_TIPO_DOCUMENTO],
  td.[DS_TIPO_DOCUMENTO] as 'Tipo Documento',
  [CD_CERTEZA],
  crt.[DS_CERTEZA] as 'Certeza',
  crt.[NM_PORCENTAJE] as 'Porcentaje Certeza',
  pre.DS_Descripcion as 'Detalle Previsión',
  [IT_FINANCIABLE],
  [IT_BORRABLE],
  [IT_FINANCIADA],
  [CD_TIPO_CRITERIO],
  [CdOperacion],
  [CdOperacionAmortizacion],
  [CdSyncPrevisionTipo]
FROM [dbo].[KAT_PREVISIONES] pre
  left join [dbo].[KAT_CONCEPTOS_COBRO_PAGO] ccp on ccp.CD_CONCEPTO = pre.CD_CONCEPTO
  left join [dbo].[KAT_VIAS_COBRO_PAGO] vcp on vcp.CD_VIA_COBRO_PAGO = pre.CD_VIA_COBRO_PAGO
  left join [dbo].[KAT_TIPO_ESTADO_PREVISION] tep on tep.CD_ESTADO = pre.CD_ESTADO
  left join [dbo].[KAT_TIPO_ORIGEN_PREVISION] op on op.CD_ORIGEN = pre.CD_ORIGEN
  left join [dbo].[KAT_TIPO_PREVISION] tp on tp.CD_TIPO_PREVISION = pre.CD_TIPO_PREVISION
  left join [dbo].[KAT_TIPO_DOCUMENTO] td on td.CD_TIPO_DOCUMENTO = pre.CD_TIPO_DOCUMENTO
  left join [dbo].[KAT_TIPO_CERTEZA] crt on crt.CD_CERTEZA = pre.CD_CERTEZA
  left join [dbo].[KAT_TIPO_CONCEPTO_COBRO_PAGO] tccp on tccp.[CD_TIPO_CONCEPTO] = ccp.CD_TIPO_CONCEPTO