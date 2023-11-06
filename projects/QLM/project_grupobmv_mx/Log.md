# LOG

## 2023-08-29

- Small project to create some sort of Excel like report for the groupbmv, a client of QLM.
- Sort of requirements on file "ANÁLISIS CAMPOS INFORME LIQUIDEZ BMV"
- Report for a flujo de efectivo (Cashflow?)
  - In a single page if possible
  - The report shows the status of N companies.
  - It is required that the report grows automatically with the number of companies.
  - Report consists of:
    - N companies
    - The companies will be added to an Excel with companies information:
      - Company ID (KAT DB)
      - Company Alias (Name to appear on the report)
      - Account ID (Account that the reporting will be showing data about)
        - The account balance of this account is what matters
  - Data is provided from the KAT DB
  - There will be an Excel with the account balance at certain times all days.
    - Initially these times are
      - 08:00 am
      - 16:00 pm
    - Where is the excel?
    - They could be named like \*\*\*\*\_2023_08_10.xls
    - A file per day to avoid errors and to confirm that a new file has been created per day. Data on this file to be defined. It could be as simple as
      - Company_ID :: date (ex:2023-08-03) :: balance_08:00 :: balance_16:00

## 2023-08-30

- The origins of data are explained on the excel "datos_informe.xlsm"
- Some additional comments:

  - SALDO INICIAL
    - It shows the final yesterday's balance
    - value = ∑ (nm_saldo) filter by Account ID (Type instrument not 36)
  - COBRANZA
    - Missing 'concept'
  - COBRANZA INTERCOMPAÑIAS
    - To be defined by the client
  - [**ASK-01**] VTO. INVER: **TODO** (Ver "ANÁLISIS CAMPOS INFORME LIQUIDEZ BMV")

    - Calculation is in Powerbi "BMV.pbix"
    - Value = ∑

    ```dax
    SUM ( Fi_Operaciones[ImporteConRetencion] ) +  MIN( Fi_Operaciones[ImporteConRetencion] )
    ```

  But Gimena mentions that the import should be "ImporteConRetencion para 36 " for "Op Capital + intereses". So the real formula should be **TODO** Verify this:

  ```dax
  VAR "ImporteConRetencion para 36" =
  CALCULATE (
   SUM ( Fi_Operaciones[ImporteConRetencion] ),
   NOT ( Fi_Operaciones[CdInstrumento] IN { "36" } )
  )

  RETURN
  ∑[ImporteConRetencion para 36] +  MIN( Fi_Operaciones[ImporteConRetencion] )
  ```

  And finally from PowerBI from the field "Excedent" can be deduced that the real formula for VTO. INVER is:

  ```dax
  CALCULATE(
    SUM( Fi_Operaciones[ImporteConRetencion] ),
    NOT ( Fi_Operaciones[CdInstrumento] IN { "36" } )
  )
  + CALCULATE(
    SUM( Fi_Operaciones[InteConRetencion] ),
    Fi_Operaciones[CdInstrumento] IN { "36" }
  )
  ```

  Still not clear to me... In the "ANÁLISIS CAMPOS INFORME LIQUIDEZ BMV" seems to be defined in a different way. Ask **TODO**

- Calculations related to "Casa de Bolsas" are referred to yesterday values (D-1)

## 2023-09-05

- Small project to create some sort of Excel like report for the groupbmv, a client of QLM.

- Let's put all the assets we have so far on google_drive/projetcs/grupobmv_mx
- And analyze everything for this evening meeting

- Preparing meeting:
  - [**Alfonso**] Carga de datos manuales. Ex:
    - Company_ID :: date (ex:2023-08-03) :: balance_08:00 :: balance_16:00
    - De donde se cargan?
      - Excel in sharepoint?
  - [**Alfonso**] "datos informes" la columna i es el "cd_concepto" no?
  - "COBRANZA INTERCOMPAÑIAS" pendiente definir.
  - TOTAL DE INGRESOS
    - Diferentes definiciones, (cual es correcta?):
      - "ANÁLISIS CAMPOS INFORME LIQUIDEZ BMV" -> el resultado de sumar cobranzas + cobranzas Inter compañías.
      - "datos_informe" -> suma de: cobranzas+ cobranza intercompañias +vto inver (Correcto)
  - EGRESOS INTERCOMPAÑIAS
    - Pendiente de definir
  - [**Alfonso**] Fila 18 " 501,396,279 no lo ponemos de momento ¿por? Es un cálculo sencillo"
    - Que es? El total de algo? Como se llama?
  - "CASA DE BOLSA:"
    - PLAZO: FechaFin-FechaIncio
      - Es siempre 1 dia no? Pero y si no es asi? Tendría sentido el mostrar el importe_pendiente del dia anterior? Aparece siempre todos los días?
  - Sección Resumen
    - TOTAL INVERTIDO
      - D-1 ? (Todos los calculos?)
      - Todas las Casas de Bolsa aunque no se muestren en el informe no?
        - Total invertido por casa de bolsa
        - Esto no esta ya en cada bolsa? O es el total de otro rango de fechas diferentes?
    - TOTAL CERRADO
      - Que es? Cual es el calculo?
    - Verificación
      - Que es? Cual es el calculo?
  - [**Alfonso**] [**ASK-01**] Clarificar // Lo puedo ver con Alfonso primero.

### UPDATED REQUIREMENTS

- All calculations on [Today] but "SALDO INICIAL" [D-1](yesterday)
- COBRANZA INTERCOMPAÑIAS / EGRESOS INTERCOMPAÑIAS
  - Table -> Previsiones
    - ∑ (importe) where date = today and cobros/pagos = p_diariopagos and num_documento in [set de num_documentos of companies]
- Fila 18 " 501,396,279
  - Name = Formula = (EXCEDENTE(NECESIDADES) - SALDO BANCO 14 HRS)
- TOTAL INVERTIDO

  - ∑ of all totals of companies -> ∑ line 13
  - TOTAL CERRADO
    - Se omite
  - Verificación
    - SALDO BANCO 14 HRS [Bancomer Vista] - investments de [Bancomer Vista]
      - Table [Fi_operaciones]
        - day = [today] and tipo_instrumento = "Bancomer_vista" ?? Should be type or investment
  - COBRANZA
    - File Excel
      - ∑ of all of the given account
        - - -> cobro
        - - -> pago
  - EGRESOS
    - Previsiones table
    - concepto = p_diariopagos
    - For a given company and which target is none of the companies
  - VTO. INVER:

    - ∑ SELECT "ImportePendiente" FROM [KAT_BMV].[dbo].[Fi_Operaciones] where FechaInicio=[Today] and CdCuenta='19' (account of company)
    - Si el alias es un reporto normal, se suma el Importe inicial + Importe Intereses – Importe Retención; en caso de ser un reporto + “Vista” solo tomaremos el Importe Interés – Importe Retención...
      No esta claro del todo..

  - SALDO BANCO ENTRE 8 Y 9 HRS y SALDO BANCO 14 HRS
    - From file Saldos*[ISO_DATE]*[ISO_HOUR] and column disponible

## 2023-09-06

- Estimating the project
  - Management & Analysis
    - 1st meeting 30min
    - Meeting Gimena 1 hour
    - Analysis 3 hours
    - Meeting Alfonso/Mauricio 1.5 hours
    - So far -> 6 hours // Additional 3 hours
  - Modeling
    - 20 hours
  - Report
    - Design -> 4 hours
    - Build -> 10 hours

| Desc                         | Time (Hours) |
|------------------------------|-------------:|
| \* Management & Analysis     |              |
| - - 1st meeting              |          0.5 |
| - - Meeting Gimena           |            1 |
| - - Analysis                 |            3 |
| - - Meeting Alfonso/Mauricio |          1.5 |
| - - Additional               |            3 |
| \* Modeling                  |           10 |
| \* Report                    |              |
| - - Design                   |           4? |
| - - Build                    |           15 |
| Total                        |           38 |

Price = (38 _ 70) _ 0.9 = 2394€

- For harvest:
  | Desc                    | Time (Hours) |
  |-------------------------|-------------:|
  | _ Management & Analysis |            9 |
  | _ Development           |           29 |

## 2023-09-11

- Response to all emails.

## 2023-09-12

- Creating the dataflows with the data.
- Table KAT_CUENTAS
  - Marked column DS_NOMBRE_CUENTA as key to make sure that the name is unique.
- Temporary Sharepoint folder. A new one just for BMV. Should be created.
  - <https://qlm1.sharepoint.com/sites/QLM2/>

## 2023-09-14

- Styles for tables in PowerBI
  - <https://inforiver.com/wp-content/uploads/30-Elegant-Table-Designs-for-Microsoft-Power-BI-ebook.pdf>

- Could be a good idea to have a sort of normal one and then another one a bit more crazy for inspiration.
  - Respect a bit the colors, the QLM BMV icons titles.


## 2023-09-15

- When importing the balances at 08:00 and 14:00 hours, there is only a sheet on each file. It is a restriction that the name of the sheet has to be always the same. 
If not the same process that has been done for the Cobranzas will have to be used. Basically read all tabs and put them together.

- In Verificación is not clear what is "Bancomer Vista".. And where is it coming from..

## 2023-09-25

  * Fixing and updating formulas:


## 2023-10-09

* Reunion:
  * Fichero del 2023/09/21 tine columnas erroneas -> No. de movimiento esta como o. de movimiento
  * Fichero "Cobranzas_2023_09_21"  pero las operaciones son en realidad del Cobranzas_2023_09_19
  * Porque en cuentas "DS_CODIGO_CUENTA" puede estar vacio? Como es posible??
    * Para que las relaciones tengan sentido las cuentas han de tener un numero de cuenta..
    * He eliminado las cuentas sin DS_CODIGO_CUENTA -> Correcto??
  * "DS_CODIGO_CUENTA" tiene un primer cero que no aparece en cobranzas o saldos. Ha de tener el mismo formato exacto!
  * Lo he quitado de forma manual, pero debería venir bien en el fichero. 
  * Hay unas cuantas compañias que no tienen su cuenta bien puesta. Ver "Cobranzas & Egresos - Test"
  * Hay filas con importes no aceptables "
  * [Resolution]
    * Dont touch KAT_CUENTAS. Add 0 as first character in cobranzas and saldos if needed. 

  * Mirar vto inversiones later.
  * ImportePendiente esta bien? Pues no hay decimales?
  * [Resolution]
    * It is fine.

  * KAT_PREVISIONES
    * DS_DOCUMENTO no identifca al grupo inversor.
    * Weird error when reading the DS_DOCUMENTO. Cuando se hace algunas transformaciones, cambia totalmente el valor...
    * Creo que habrá que usar el "DS_DESCRIPCION" -> Importante, asegurarse de que es correcto!!
  * [Resolution]
    * It is correct, seems to ve an oversight on my part.


  * Revisar nombres grupos inversores
  * Revisar nombres bolsas
  * Revisar cuentas asociadas

  * Pasos a seguir:
    * Refinar todos los calculos
    * Refinar proceso de lectura de ficheros
    * 


## 2023-10-09

* Cobranzas come from excel file only for value > 0
* Cobranzas interconpañias/ Egresos?? (Seguro?) / Egresos intercompañias come from previsiones con concepto P_Diario_Pagos.

* The problem with the Accounts that start with 0 is that in table KAT_CUENTAS is a string but in the excell file is a Number, so when Powerbi read the file it ignores the first 0. The column "Cuenta / Alias" in the files Cobranzas_xx_xx should be trasnformed to text type.

* Review, if there can be a filter on dates to not load too much data in all the tables..


## 2023-10-25

* Respuesta a Mauricio del 2023-10-19
  * 1 -> no hace falta refrescar nada. Puede que el día de hoy se refiera al dia siguiente por la diferencia horaría. Voy a clarificar esto con Alfonso.

.nothing