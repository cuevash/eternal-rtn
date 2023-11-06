# KnowledgeDB

## Credits, Credit Cards, Credit Line

Credits and Credit Card are treated similarly. Not clear what's that similar way. But they are represented with the same columns in the KAT DB.

* Tables
  * Fi_OperacionAmortizacion (Loan, leasing, renting,..)
    * [CdOperacion]
      * DB identifier
    * [CdOperacionAmortizacion]
      * Id that identify an operation in "Fi_Operaciones".
    * [Orden]
      * Payment order. Start at 2. The loading of the loan in the KAT system is considered the payment 1.
    * [Fecha]
      * Payment's date
    * [Principal]
      * Quantity of the principal that is paid.
    * [Intereses]
      * Quantity that is paid in interests.
    * [Retencion]
      * Sort of taxes.
    * [Impuestos]
      * Quantity paid for taxes (if it is a leasing)  
    * [Cuota]
      * Total amount to be paid by all the previous concepts
    * [CapitalVivo]
      * What remains to be paid of the principal.
  * Fi_Operaciones
    * [CdOperacion]
      * DB identifier
    * [CdInstrumento]
      * Operation's type.
    * [Descripcion]
      * Description
    * [Alias]
      * Unique's description
    * [ImportePendiente]
      * Quantity yet to be paid when the credit is loaded in KAT
    * [FechaInicio]
      * When the Loan is signed
    * [FechaImportePendiente]
      * Date when the loan is loaded in KAT
    * [FechaFin]
      * When the loan finish
    * [TipoInteresInicial]
      * Initial interest rate when the loan was signed.
    * [TipoInteresActual]
      * Interest rate when the loan is loaded in KAT
    * [TipoRetencion]
      * Can be ignored at the moment
    * [BaseCalculo]
      * How the interest is calculated, ignore by the time being.
    * [CdFrecuenciaIntereses]
      * How often interest is charged? In months.  
    * [FechaPrimerInteres]
      * First date that interest payments are due
    * [ImporteInicial]
      * Quantity already paid from the principal when the loan is loaded in KAT??
      * I think is total amount of the debt, so the total amount of the principal.
    * [CdTipoOperacion]
      * Active/Passive
    * [ImporteIntereses]
      * Quantity that will be paid / remain to be paid in interests
    * [ImporteTotal]
      * Total amount that remain to be paid adding interest and left principal to be paid.
    * [Duracion]
      * Payment periods that remain for the loan from load's time in KAT.
    * [NmValorImpuesto]
      * Taxes (IVA) that is applied to some instruments like the leasing ones.
  * KAT_Condiciones (Polizas de Credito)
    * This instrument is associated to a Bank Account. It is always in sort of red number that is the amount that is being loaned.
    * [FC_INICIO]
      * Initial time
    * [FC_FIN]
      * Final date
    * [NM_LIMITE]
      * Limit amount that can be used
    * [CD_PERIODO_LIQUIDACION]
      * How often is the credit paid. The number corresponds to a period type that is defined in another table. (Periods table?)
    * [CD_PERIODO_REVISION]
      * How often is the interest recalculated/reviewed ? (Months?)
    * [FC_REVISION]
      * Date of the first interest recalculation after the creation of the  (Poliza de Credito)
    * [NM_SALDO_MINIMO]
      * Quantity that can be used without being charged any interest.
    * [CD_TIPO_REFERENCIA]
      * Interest type.
    * [NM_COMISION_NO_DISPONIBLE]
      * Interest charged on the amount that has not being used.
  * KAT_Condiciones_Tramos (Polizas de Credito) (Interest intervals)

  * Conceptos de "Endeudamiento" in different tables in PowerBI
    * Dispuesto
      * Amount that has been used so far.
      * Disponible
        * Amount left?
      * Imorte contratado
        * Limit

* Type of credits:
  * Cuenta de Crédito
    * It is a line of credit. The position of the line of credit is given by the balance in the associated account.
    * Information relevant:
      * Limite
      * Tipo Interes (Calculation complex... Talk with gimena)
      * Dispuesto/pendiente
      * Disponible
  * Imposición a Plazo Fijo
    * Information relevant:
      * Limite
      * Dispuesto = -Limite
  * Préstamo Cuota Constante
    * Works as a normal credit
    * Information relevant:
      * Limite
      * Tipo Interes
      * Dispuesto/Pendiente
      * Amortizado
  * Prestamo Capital Constante
    * Works as a normal credit
    * Information relevant:
      * Limite
      * Tipo Interes
      * Dispuesto/Pendiente
      * Amortizado
  * Aval
    * Sort of aval that is required in certain circumstances
    * Information relevant:
      * Limite
      * Dispuesto = -Limite
  * Leasing
    * Works as a normal credit
    * Information relevant:
      * Limite
      * Dispuesto/Pendiente
      * Amortizado
  * Renting
    * Works as a normal credit
    * Information relevant:
      * Limite
      * Tipo Interes
      * Dispuesto/Pendiente
      * Amortizado
  * Préstamo Promotor/Línea de Avales
    * It is similar to a line of credit, but with a single hard limit.
    * Information relevant:
      * Limite
      * Tipo Interes
      * Dispuesto/Pendiente = Principal = Capital vivo (in table Endeudamiento_Amortizacion)
  * Confirming
    * It works a bit like a credit line. An account is open in a bank and money is used from this account to pay bills from providers.
    Then the client has some period (90 days, others..) to refund the money to the bank.
    This instrument has a hard limit as well. The bank will only put up to certain amount.
    * The way to know the dispuesto es sort of complicated. There are three possible ways to get this information:
      * Through the KAT_Previsiones table where you could through the bank account associated see which bill were paid and not yet being repaid by the client. The bills that have been repaid by the client are removed from this table. Because the bills repaid are removed it is not possible to get a snapshot picture of the state of a Confirming instrument at any time.
      * Through the movements of the account associated it is possible to get the exact picture of the confirming instrument.
      * Another possible way is to use a table with all the bills and the status of them
    * At the moment we will not show information about this instrument. It will appear in PowerBI as Blank.
    * Maybe it could be calculated similar as Prestamo Promotor.. Talk with Gimena.
  * Créditos concedidos
    * Credits that provide Urbania. They work as normal credits, the only difference is that the positions have opposite signs as the money flows the other direction
    * Information relevant:
      * Limite
      * Tipo Interes
      * Dispuesto/Pendiente
      * Amortizado
        * If is matured then we show the last "Endeudamiento Amortizaciom[Principal]". If not Blank.
GHCN  [bigquery-public-data:ghcn_d.ghcnd_stations] AS stn
JOIN
  [bigquery-public-data:ghcn_d.ghcnd_2016] AS wx
ON
  wx.id = stn.id
WHERE
  wx.element = 'TMIN'
  AND wx.qflag IS NULL
  AND STRING(wx.date) = '2016-08-15'
This returns:
