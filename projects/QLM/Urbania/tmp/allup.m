// DAX Query
DEFINE
	VAR __DS0FilterTable = 
		TREATAS({"Active"}, 'Creditos_Flags'[Description (en)])

	VAR __DS0FilterTable2 = 
		FILTER(
			KEEPFILTERS(VALUES('Tiempo'[Fecha])),
			AND('Tiempo'[Fecha] >= DATE(2023, 10, 14), 'Tiempo'[Fecha] < DATE(2023, 10, 15))
		)

	VAR __DS0FilterTable3 = 
		TREATAS(
			{"'Medidas'[Credito Fecha Inicio (Single Value/Lowest Level)]",
				"'Medidas'[Credito Fecha Vencimiento (Single Value/Lowest Level)]",
				"'Medidas'[Credito Limite/Importe Inicial (SUM)]",
				"'Medidas'[Credito Dispuesto/Pendiente]",
				"'Medidas'[Credito Tipo Interes/Diferencial (Single Value/Lowest Level)]",
				"'Medidas'[Credito Amortizacion]",
				"'Medidas'[Credito Disponible]"},
			'Credit Fields Basic'[Credit Fields Fields]
		)

	VAR __DS0FilterTable4 = 
		FILTER(
			KEEPFILTERS(VALUES('Cuentas'[DS_GRUPO_CUENTA])),
			NOT('Cuentas'[DS_GRUPO_CUENTA] IN {"Inactivas"})
		)

	VAR __DS0FilterTable5 = 
		TREATAS({"en"}, 'Languages'[Language_ID])

	VAR __DS0FilterTable6 = 
		FILTER(
			KEEPFILTERS(VALUES('Empresas'[Linea de Negocio])),
			NOT('Empresas'[Linea de Negocio] IN {"TGP"})
		)

	VAR __DS0FilterTable7 = 
		FILTER(
			KEEPFILTERS(VALUES('Empresas'[CD_EMPRESA])),
			NOT('Empresas'[CD_EMPRESA] IN {BLANK()})
		)

	VAR __ValueFilterDM7 = 
		FILTER(
			KEEPFILTERS(
				SUMMARIZECOLUMNS(
					'Creditos'[Tipo de Producto],
					'Empresas'[Compañia Alias],
					'Empresas'[Linea de Negocio],
					'Bancos'[Banco],
					'Cuentas'[Cuenta],
					'Creditos'[Credito Descripcion],
					__DS0FilterTable,
					__DS0FilterTable2,
					__DS0FilterTable3,
					__DS0FilterTable4,
					__DS0FilterTable5,
					__DS0FilterTable6,
					__DS0FilterTable7,
					"Credito_Status__Single_Value_Lowest_Level_", 'Medidas'[Credito Status (Single Value/Lowest Level)],
					"Credito_Fecha_Inicio__Single_Value_Lowest_Level_", 'Medidas'[Credito Fecha Inicio (Single Value/Lowest Level)],
					"Credito_Fecha_Vencimiento__Single_Value_Lowest_Level_", 'Medidas'[Credito Fecha Vencimiento (Single Value/Lowest Level)],
					"Credito_Limite_Importe_Inicial__SUM_", 'Medidas'[Credito Limite/Importe Inicial (SUM)],
					"Credito_Dispuesto_Pendiente", 'Medidas'[Credito Dispuesto/Pendiente],
					"Credito_Tipo_Interes_Diferencial__Single_Value_Lowest_Level_", 'Medidas'[Credito Tipo Interes/Diferencial (Single Value/Lowest Level)],
					"Credito_Amortizacion", 'Medidas'[Credito Amortizacion],
					"Credito_Disponible", 'Medidas'[Credito Disponible],
					"Es_Credito_Filtered_by_Status_Single_Value_Lowest_Level_", IGNORE('Medidas'[Es Credito Filtered by Status(Single Value/Lowest Level)])
				)
			),
			[Es_Credito_Filtered_by_Status_Single_Value_Lowest_Level_] = 1
		)

	VAR __DS0Core = 
		SUMMARIZECOLUMNS(
			ROLLUPADDISSUBTOTAL('Creditos'[Tipo de Producto], "IsGrandTotalRowTotal"),
			__DS0FilterTable,
			__DS0FilterTable2,
			__DS0FilterTable3,
			__DS0FilterTable4,
			__DS0FilterTable5,
			__DS0FilterTable6,
			__DS0FilterTable7,
			__ValueFilterDM7,
			"Credito_Status__Single_Value_Lowest_Level_", 'Medidas'[Credito Status (Single Value/Lowest Level)],
			"Credito_Fecha_Inicio__Single_Value_Lowest_Level_", 'Medidas'[Credito Fecha Inicio (Single Value/Lowest Level)],
			"Credito_Fecha_Vencimiento__Single_Value_Lowest_Level_", 'Medidas'[Credito Fecha Vencimiento (Single Value/Lowest Level)],
			"Credito_Limite_Importe_Inicial__SUM_", 'Medidas'[Credito Limite/Importe Inicial (SUM)],
			"Credito_Dispuesto_Pendiente", 'Medidas'[Credito Dispuesto/Pendiente],
			"Credito_Tipo_Interes_Diferencial__Single_Value_Lowest_Level_", 'Medidas'[Credito Tipo Interes/Diferencial (Single Value/Lowest Level)],
			"Credito_Amortizacion", 'Medidas'[Credito Amortizacion],
			"Credito_Disponible", 'Medidas'[Credito Disponible]
		)

	VAR __DS0PrimaryWindowed = 
		TOPN(502, __DS0Core, [IsGrandTotalRowTotal], 0, 'Creditos'[Tipo de Producto], 0)

EVALUATE
	SUMMARIZECOLUMNS(
		__DS0FilterTable,
		__DS0FilterTable2,
		__DS0FilterTable3,
		__DS0FilterTable4,
		__DS0FilterTable5,
		__DS0FilterTable6,
		__DS0FilterTable7,
		__ValueFilterDM7,
		"Credits_Label", IGNORE('Translated Localized Labels'[Credits Label]),
		"DumpFilters", IGNORE('Medidas'[DumpFilters])
	)

EVALUATE
	__DS0PrimaryWindowed

ORDER BY
	[IsGrandTotalRowTotal] DESC, 'Creditos'[Tipo de Producto] DESC
