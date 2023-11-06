




WITH
  SingleRowTable
  AS
  (
    SELECT '-1' AS [One], 'Operativas' AS [Two]
  )
SELECT [CD_GRUPO_CUENTA], [DS_GRUPO_CUENTA]
FROM [dbo].[KAT_CUENTAS_GRUPOS] CROSS JOIN SingleRowTable;


// DAX Query
DEFINE
	VAR __DS0FilterTable = 
		FILTER(
			KEEPFILTERS(VALUES('Cuentas'[Grupo_Cuentas])),
			NOT('Cuentas'[Grupo_Cuentas] IN {"Inactivas"})
		)

	VAR __DS0FilterTable2 = 
		FILTER(
			KEEPFILTERS(VALUES('Grupos Empresas 1'[Linea de Negocio])),
			NOT('Grupos Empresas 1'[Linea de Negocio] IN {"TGP"})
		)

	VAR __DS0FilterTable3 = 
		FILTER(
			KEEPFILTERS(VALUES('Cuentas'[Banco])),
			NOT('Cuentas'[Banco] IN {"Desconocido"})
		)

	VAR __DS0FilterTable4 = 
		TREATAS({"en"}, 'Languages'[Language_ID])

	VAR __DS0Core = 
		SELECTCOLUMNS(
			KEEPFILTERS(
				FILTER(
					KEEPFILTERS(
						SUMMARIZECOLUMNS(
							'Cuentas_First_Step'[BKCuenta],
							'Cuentas_First_Step'[BKIdEmpresa],
							'Cuentas_First_Step'[Empresa],
							'Cuentas_First_Step'[CD_GRUPO_CUENTA],
							'KAT_CUENTAS_GRUPOS'[CD_GRUPO_CUENTA],
							'KAT_CUENTAS_GRUPOS'[Grupo_Cuentas],
							'KAT_CUENTAS_GRUPOS'[Grupo_Cuentas_en],
							__DS0FilterTable,
							__DS0FilterTable2,
							__DS0FilterTable3,
							__DS0FilterTable4,
							"CountRowsCuentas_First_Step", CALCULATE(COUNTROWS('Cuentas_First_Step'))
						)
					),
					OR(
						OR(
							OR(
								OR(
									OR(
										OR(
											NOT(ISBLANK('Cuentas_First_Step'[BKCuenta])),
											NOT(ISBLANK('Cuentas_First_Step'[BKIdEmpresa]))
										),
										NOT(ISBLANK('Cuentas_First_Step'[Empresa]))
									),
									NOT(ISBLANK('Cuentas_First_Step'[CD_GRUPO_CUENTA]))
								),
								NOT(ISBLANK('KAT_CUENTAS_GRUPOS'[CD_GRUPO_CUENTA]))
							),
							NOT(ISBLANK('KAT_CUENTAS_GRUPOS'[Grupo_Cuentas]))
						),
						NOT(ISBLANK('KAT_CUENTAS_GRUPOS'[Grupo_Cuentas_en]))
					)
				)
			),
			"'Cuentas_First_Step'[BKCuenta]", 'Cuentas_First_Step'[BKCuenta],
			"'Cuentas_First_Step'[BKIdEmpresa]", 'Cuentas_First_Step'[BKIdEmpresa],
			"'Cuentas_First_Step'[Empresa]", 'Cuentas_First_Step'[Empresa],
			"'Cuentas_First_Step'[CD_GRUPO_CUENTA]", 'Cuentas_First_Step'[CD_GRUPO_CUENTA],
			"'KAT_CUENTAS_GRUPOS'[CD_GRUPO_CUENTA]", 'KAT_CUENTAS_GRUPOS'[CD_GRUPO_CUENTA],
			"'KAT_CUENTAS_GRUPOS'[Grupo_Cuentas]", 'KAT_CUENTAS_GRUPOS'[Grupo_Cuentas],
			"'KAT_CUENTAS_GRUPOS'[Grupo_Cuentas_en]", 'KAT_CUENTAS_GRUPOS'[Grupo_Cuentas_en]
		)

	VAR __DS0PrimaryWindowed = 
		TOPN(
			501,
			__DS0Core,
			'Cuentas_First_Step'[BKCuenta],
			0,
			'Cuentas_First_Step'[BKIdEmpresa],
			1,
			'Cuentas_First_Step'[Empresa],
			1,
			'Cuentas_First_Step'[CD_GRUPO_CUENTA],
			1,
			'KAT_CUENTAS_GRUPOS'[CD_GRUPO_CUENTA],
			1,
			'KAT_CUENTAS_GRUPOS'[Grupo_Cuentas],
			1,
			'KAT_CUENTAS_GRUPOS'[Grupo_Cuentas_en],
			1
		)

EVALUATE
	__DS0PrimaryWindowed

ORDER BY
	'Cuentas_First_Step'[BKCuenta] DESC,
	'Cuentas_First_Step'[BKIdEmpresa],
	'Cuentas_First_Step'[Empresa],
	'Cuentas_First_Step'[CD_GRUPO_CUENTA],
	'KAT_CUENTAS_GRUPOS'[CD_GRUPO_CUENTA],
	'KAT_CUENTAS_GRUPOS'[Grupo_Cuentas],
	'KAT_CUENTAS_GRUPOS'[Grupo_Cuentas_en]


SELECT [CD_CUENTA] as BKCuenta#(lf)      ,[DS_NOMBRE_CUENTA] as 'Nombre Cuenta'#(lf)#(tab)  ,tip.[DS_CUENTA_TIPO] as 'Tipo Cuenta'#(lf)#(tab)  ,tip.[DS_CTA_COMPORTAMIENTO] as  'Comportamiento Cuenta'#(lf)#(tab)  #(tab),emp.DS_NOMBRE as Empresa#(lf),emp.DS_ALIAS_EMPRESA as 'Alias Empresa'#(lf),emp.DS_OBSERVACIONES as 'Observaciones'#(lf)#(tab)#(tab),TE.[ds_EMPRESA_TIPO] as 'Tipo Empresa'#(lf)  #(tab)  ,bco.DS_NOMBRE_BANCO as Banco#(lf)#(tab)  ,di.DS_ISO_DIVISA as Divisa#(lf)      ,cta.[CD_DIVISA]#(lf)      ,cta.[CD_EMPRESA] as BKIdEmpresa#(lf)#(tab)  ,[NM_SALDO]#(lf)      ,[IT_ACTIVA]#(lf)      ,[FC_INACTIVA]#(lf)      ,[CD_GRUPO_CUENTA]#(lf)  FROM [dbo].[KAT_CUENTAS] cta#(lf)  left join [dbo].[KAT_Empresas] emp on emp.CD_EMPRESA=cta.CD_EMPRESA#(lf)  left join [dbo].[KAT_EMPRESAS_TIPO] TE on TE.CD_EMPRESA_TIPO=emp.CD_EMPRESA_TIPO#(lf)  left join [dbo].[KAT_BANCOS] bco on bco.CD_BANCO=cta.CD_BANCO#(lf)  left join (SELECT  t.[CD_CUENTA_TIPO]#(lf)      ,t.[DS_CUENTA_TIPO]#(lf)       ,com.[DS_CTA_COMPORTAMIENTO]#(lf)  FROM .[dbo].[KAT_CUENTAS_TIPO] t#(lf)  left join   [dbo].[KAT_CUENTAS_COMPORTAMIENTO] com on com.[CD_CTA_COMPORTAMIENTO]=t.[CD_CTA_COMPORTAMIENTO] ) tip on tip.CD_CUENTA_TIPO=cta.CD_CUENTA_TIPO#(lf)  left join [dbo].[KAT_DIVISAS] di on di.CD_DIVISA=cta.CD_DIVISA#(lf)#(lf)  union #(lf)  #(tab)select -row_number() OVER(order by DS_ALIAS_EMPRESA) as BKCuenta#(lf)  ,'Desconocido' as 'Nombre Cuenta'#(lf)  ,'Desconocido' as 'Tipo Cuenta'#(lf),'Desconocido' as 'Comportamiento Cuenta'#(lf),DS_NOMBRE as 'Empresa'#(lf),DS_ALIAS_EMPRESA as 'Alias Empresa'#(lf),DS_OBSERVACIONES as 'Observaciones'#(lf),null as 'Tipo Empresa'#(lf),'Desconocido' as Banco#(lf),'Desconocida' as Divisa#(lf),-1 as CD_DIVISA#(lf),-1 as 'BKIdEmpresa'#(lf),0 as NM_SALDO#(lf),1 as IT_ACTIVA#(lf),null as FC_INACTIVA#(lf),-1 as CD_GRUPO_CUENTA#(lf)from [dbo].[KAT_Empresas]



SELECT 
    cta.[CD_CUENTA] as BKCuenta,
    cta.[DS_NOMBRE_CUENTA] as 'Nombre Cuenta',
    t.[DS_CUENTA_TIPO] as 'Tipo Cuenta',
    com.[DS_CTA_COMPORTAMIENTO] as 'Comportamiento Cuenta',
    emp.DS_NOMBRE as Empresa,
    emp.DS_ALIAS_EMPRESA as 'Alias Empresa',
    emp.DS_OBSERVACIONES as 'Observaciones',
    TE.[ds_EMPRESA_TIPO] as 'Tipo Empresa',
    bco.DS_NOMBRE_BANCO as Banco,
    di.DS_ISO_DIVISA as Divisa,
    cta.[CD_DIVISA],
    cta.[CD_EMPRESA] as BKIdEmpresa,
    cta.[NM_SALDO],
    cta.[IT_ACTIVA],
    cta.[FC_INACTIVA],
    cta.[CD_GRUPO_CUENTA]
FROM 
    [dbo].[KAT_CUENTAS] cta
LEFT JOIN [dbo].[KAT_Empresas] emp ON emp.CD_EMPRESA = cta.CD_EMPRESA
LEFT JOIN [dbo].[KAT_EMPRESAS_TIPO] TE ON TE.CD_EMPRESA_TIPO = emp.CD_EMPRESA_TIPO
LEFT JOIN [dbo].[KAT_BANCOS] bco ON bco.CD_BANCO = cta.CD_BANCO
LEFT JOIN [dbo].[KAT_CUENTAS_TIPO] t ON t.CD_CUENTA_TIPO = cta.CD_CUENTA_TIPO
LEFT JOIN [dbo].[KAT_CUENTAS_COMPORTAMIENTO] com ON com.[CD_CTA_COMPORTAMIENTO] = t.[CD_CTA_COMPORTAMIENTO]
LEFT JOIN [dbo].[KAT_DIVISAS] di ON di.CD_DIVISA = cta.CD_DIVISA



Let's compare the two lists. First, I will order them alphabetically, and then I will identify any differences between them:

**List 1 (from the provided M code)**:
1. ADHOC CONTROL DE GESTION SL
2. BCOME PAMPLONA SL
3. CAVA BAJA INVERSIONES, S.L.U.
4. INTERHOUSING PERE IV, S.L.
5. IRE RE URBANESCO JV S.L.U.
6. IRE-RE URBANESCO DEVELOPMENTS, S.L.
7. MOMENTUM INDUSTRIES SPAIN FUND I SL
8. THE PROTOTIPO BOX CONSTRUCCION INDUSTRIALIZADA SL
9. THE PROTOTIPO COMPANY, S.L.
10. URBANIA BCN MANAGEMENT SL
11. URBANIA CIUDAD DE BARCELONA 103 SL
12. URBANIA DIAGONAL 331 SLU
13. URBANIA FORMENTERA, S.L.U.
14. URBANIA LAMATRA III, S.L.
15. URBANIA MADRID MANAGEMENT SL
16. URBANIA PROPERTY PARTNERS SL
17. URBANIA SANTA CLARA DEVELOPMENT IV SLU
18. URBANIA SANTA CLARA DEVELOPMENT, SLU
19. WOOD & STEEL DESIGN S.L.

**List 2**:
1. ADHOC CONTROL DE GESTION SL
2. CAVA BAJA INVERSIONES, S.L.U.
3. INTERHOUSING INVESTMENTS, S.L.
4. INTERHOUSING PERE IV, S.L.
5. IRE RE URBANESCO JV S.L.U.
6. IRE-RE URBANESCO DEVELOPMENTS, S.L.
7. MOMENTUM INDUSTRIES SPAIN FUND I SL
8. URBANIA BCN MANAGEMENT SL
9. URBANIA CIUDAD DE BARCELONA 103 SL
10. URBANIA DIAGONAL 331 SLU
11. URBANIA FORMENTERA, S.L.U.
12. URBANIA LAMATRA III, S.L.
13. URBANIA MADRID MANAGEMENT SL
14. URBANIA PROPERTY PARTNERS SL
15. URBANIA SANTA CLARA DEVELOPMENT IV SLU
16. URBANIA SANTA CLARA DEVELOPMENT, SLU
17. WOOD & STEEL DESIGN S.L.

**Differences**:

*Present in List 1 but not in List 2*:
- BCOME PAMPLONA SL
- THE PROTOTIPO BOX CONSTRUCCION INDUSTRIALIZADA SL
- THE PROTOTIPO COMPANY, S.L.

*Present in List 2 but not in List 1*:
- INTERHOUSING INVESTMENTS, S.L.

The rest of the entries match between the two lists.


case 2 => "OTHER",
case 15 => "RESI",
case 21 => "INNO HUB",
case 19 => "TGP",
case 17 => "LIVING",
case 16 => "COMERCIAL",
case 18 => "HOLDING",
case 20 => "DEBT",
default => "NULL",