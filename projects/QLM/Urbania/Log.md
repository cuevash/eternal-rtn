# LOG

## 2023-05-12

* Exploratory phase -> 12 hours

* First Skeleton in PowerBI
  * Connecting to SAP B1 Sql Server
  * Sql Server functions
    * Are they good to go?
    * Can we work with them?
    * Do we need to imrpove them or change them completely?

* Understanding the current model in SAP B1
* Designing the new model to be used to cover the needs of Urbania
  * Once the model is being designed then:
    * Deciding Whether to create those model's tables on the SQL Server or on
    PowerBI semantic layer.
* Implementing the model
  * Create VIEWS in SQL Server if necessary
  * Create Tables in PowerBI
  * Validate the data being imported
  * Add some tables that will provide some data validation
* Creating the reports
  * Create measures for the reports
  * Create measures for data validation
  * Create the Graphical side of the reports
  
* Introductory training for PowerBI report side.
  * Introducction to DAX
  * Introduction to Reports
  * Introduction to measures
  * etc ...

## 2023-05-16

* Examining the code of QLIK in the server
  * Where is "$(vBD)" defined? - line 35 (mapeos) man!!!
  * Naming in SQL server in SAP B1
  * [PedidosProveedor]
    * Where is "[SAP_CLR_URB_SP_Transaction]" coming from?
      * I guess that because everything has been unqualified it is enough to reference the name of the "Naming space??"
    * It is probably better to build some views instead of having to call a function each time we load the data. Or maybe it is a good idea to extract that code and add it to POwerBI? Maybe not, maybe it is better to keep it as close as possible to the DB. But in that case make the code more standarized as SQL if possible!

## 2023-05-18

* Propuesta:
  * Primera fase. Conexion, modelado y creación de reporte existente en QLIK
  * Tener un objetivo claro y no muy grande sobre el que poder construir los siguientes.
  * Conexion to the SQL server (6H)
    * Proxy gateway setup o conexion directa
      * ODBC to connect to SQL server
      * ODB OLE to connect to the excel config file?
      * Or set the excel in a global accessible place. Google drive or Google Sheets.
  * Modelado de las tablas
    * Using the embedded functions? O Creating views?
    * Añadir modelado en PowerBI para eliminar en lo posible el uso de configuración de file en excel.
    * Horas??
      * Entender (12h)
      * Modelar (20h)
  * Recreación del dashboard de QLIK. (8 - 12h) Por cada report o mas depende de la complejidad.
    * Medidas
    * Widgets
    * Filters

  * I need to:
    * Acceso a la DB.
      * Entender la configuración y los CLR's
    * Acceso a PowerBI premium
    * Acceso a Google Drive
      * Donde guardar las diferentes versiones del
        * Dataset
        * Reports

## 2023-05-22

* Reviewing SQL server
  * All
  * Functions
    * Function in VB.Net

* Installing SQL Server on the Windows Machine
  * DB Name = localhost\SQLExpress
  * Password = myPassw0rd
  * Administrator = sa

* Creating an assembly example:
  * Installing Visual studio 2022
  * When creating the VB.Net dll library an attempting to add the assembly I got the error:
  "CREATE or ALTER ASSEMBLY for assembly 'HelloTest' with the SAFE or EXTERNAL_ACCESS option failed because the 'clr strict security' option of sp_configure is set to 1. Microsoft recommends that you sign the assembly with a certificate or asymmetric key that has a corresponding login with UNSAFE ASSEMBLY permission. Alternatively, you can trust the assembly using sp_add_trusted_assembly."
    * To solve it use the stored procedure "sp_add_trusted_assembly" to trust an assemby. Use Chatgpt to get an example of how to use it: "How to use sp_add_trusted_assembly"
      * CertUtil -hashfile "C:\SQLSERVERLIBS\HelloTest.dll" SHA512
      * Hash -> 9c167ebc46e94bdbb30fbc49d34b6379938728a92d1d1397880522cc82d31bc45ff537e8f8b1909e7f61d5499639b37b5edaff29c21321fd3406dce068796edf
    * EXEC sp_add_trusted_assembly
    @hash = 0x9c167ebc46e94bdbb30fbc49d34b6379938728a92d1d1397880522cc82d31bc45ff537e8f8b1909e7f61d5499639b37b5edaff29c21321fd3406dce068796edf
    , @description = N'MyClrProject';
    * And finally deployed the assembly
      * USE SBODemoES;
CREATE ASSEMBLY MyClrProject FROM 'C:\SQLSERVERLIBS\HelloTest.dll' WITH PERMISSION_SET = SAFE;
    * Create a SQL Server function that calls your CLR function:
      * Having the DB selected run
CREATE FUNCTION SayHello(@name NVARCHAR(4000))
RETURNS NVARCHAR(4000)
AS EXTERNAL NAME MyClrProject.[HelloTest.MyClrFunctions].SayHello;

    * And finally run the function:
    * USE SBODemoES;
      SELECT dbo.SayHello('World');

  * After creating an ODBC connection to the SQL server we create an OLE DB connection from PowerBI.
    * Provider=SQLOLEDB;  and the rest with the build option

  * Download and instal gateway
    * Key -> 673452672

## 2023-05-29

* Installing a developer SQL edition. Because the express does not support Analysis services.
  * Instance = SQLSERVERMULTI
  * DB Name = localhost\SQLSERVERMULTI  
  * Named Instance = SqlServerMulti
  * Password = myPassw0rd
  * Administrator = sa

* Learning about multidimensional with :

## 2023-06-01

* Reunión Urbania:
  * Prioridades
  * Acceso a PowerBI
  * Hablar con Gimena.

* Reunión Urbania - Summary
  * Priorities
    * Points 1,2,5,3,4
  * Initial file to work on:
    * QLM_Dataset_Report_v1.0.17.4

* Progress:
  * "QLM_Dataset_Report v1.0.17.4.pbix"
    * Added credentials to access SharePoint. Same that the ones for PowerBI.
  * Making the point 1
    * Creating a Google Sheet "Provisions_Manual" in cuevash.sp/Urbania_Kat gdrive folder.
      * Give access to my other account

* Hours done so far:
* First meeting 30 min
* Second meeting 30 min
* Third meeting 30 min
* Initial study : 6 hours
* Thursday 2023-06-01 -> 8 hours.
  * Get the project,
  * Check connectivity and getting users/passwords
  * Check how to access google sheets
  * Check refresh desktop/online
  * Research how to translate reports.

## 2023-06-02

* Delayed.
* Reunión QLM - Urbania:
  * How do the Urbania dataset can be refreshed if the database is on premises and does not have remote access connected.

## 2023-06-02

* [] Send Presupuesto
* []

## 2023-06-05

* Semantic layer
* Separate an intermediate layer with a common layer to both DB

## 2023-06-07

* Meeting QLM - Urbania (12:00 am)
  * Conclusions:
    * Urbania wants to make progress in the model provided by KAT. But QLM does not
  need to make big changes to the model. So the idea is to create an architecture that allows Urbania to progress their model beyond to what KAT has to offer.
    * In order to do that the basic architecture would be to separate completely the KAT model from any changes needed by Urbania.
      * KAT models remain the same. That allow Urbania to be able to get the latest changes in KAT developed by QLM with minimum friction.
      * Urbania develops on top of KAT model some intermediate entities that are needed for their own goals. These new entities will obtain data from the KAT model and from the Urbania SAP B1 database.
    * Urbania has already changed the KAT model substantially , so an understanding of these changes are necessary in order to extract them from the original KAT model.
      * First identify the original KAT model
      * Extract the changes already in the model and create new entities that represent those changes.
      * Think about an architecture that allow for a mix of two layer models and then any layer of reports.
      * KAT model -> Urbania Model -> Report_1 ... Report_N

* Meeting Urbania (16:00)
  * Preparation:
    * Allow XMLA read/write support is enabled
    * Access to the DB
      * KAT DB
      * SAP DB
    * Creation of a gateway
    * Access to google folder
    * Versions to work on:
      * Need to think a bit about this.
      * Initially keep working with your version and then I will mix the changes
      * The idea will be to separate the model from the reports as much as possible.
    * Priorities
  * Conclusions:
    * ...

* Hours done so far:
  * Today: Meeting QLM - Urbania + organizing ideas 1 hour
  * Preparing the Urbania  meeting:

## 2023-06-08

* Creating Folder in Urbania server for the ongoing powerbi files.
* Create a PowerBI Gateway and connect to the local DB server.

* QLM_Dataset_Report v1.0.17.4_v1.0
  * Make connection to the DB (KAT-Treasury) in server URBANIA-VSAP2
    * Actualizar todas las queries para usar los paramentros de DB

* 3:30 time inverted

## 2023-06-09

* Time 4 hours:
  * Checking/Fixing connections
  * Setting up enviroment
  * Checking mapping of Previsiones Manuales

## 2023-06-012

* Meeting Urbania
  * Points 1 and 2
    * Using Google Sheet? Any problem with that?
      * It is secure, you need to give your google credentials.
      * Alternative use google link, is a link you only know to a public shared resource
  * It has refreshed ! What happened

## 2023-06-013

* ToDo
* [x] Check that refresh still works
* [] Make point 1
  * Work on QLM_Dataset_Report v1.0.17.4_v1.2
    * Update all settings related to the PowerBI Desktop.
    * What is CD_DIVISA_INICIAL in Previsiones_Full? Es la misma.
    * What is CD_DIVISA_PREVISTA in Previsiones_Full? Es la misma.
    * What is "Identificador ERP"? OLvidalo!!
    * Update all the names... to the mapping in table "Previsiones full"
    * DS_CONCEPTO does not match an unique value for CD_CONCEPTO. So at the moment we add CD_CONCEPTO
    * What is CD_PREVISION in "Previsiones_Full"
    * DS_NUM_PREVISION_ERP does it matter? Puede ser vacio.
    * DS_REMESA does it matter? Puede ser vacio
    * FC_VENCIMIENTO, does it need to be a datetime? In that case, needs to convert our manual "FC_VENCIMIENTO" to datetime
    * NM_IMPORTE_INICIAL , makes sense to have it equal to NM_IMPORTE_PREVISTO. At the moment we make them equal.  // Convendría meter los dos.
      * El previsto es el que se usa.
    * CD_REPETICION, NM_REPETICION, IT_REPETICION_CAMBIOS, do we need these for manual prevision
    * FC_VALIDACIÖN, CD_ESTADO , CD_ORIGEN, CD_CERTEZA, IT_FINANCIABLE, IT_BORRABLE, IT_FINANCIADA, CD_IMPORTACION, CD_TIPO_CRITERIO, CdOperacion, CdOperacionAmortizacion,CdSyncPrevisionTipo, whats this? Should a manual prevision has a ESTADO?
    * CD_FLUJO_CAJA is only in the "Previsiones_Manuales" , but  it may be a good idea to add it for the "Previsiones_KAT" as well , because it could be used to validate the DS_FLUJO_DE_CAJA value.. Esta bien!

    * Tabla tiempo solo tiene hasta el 30 de diciembre del 2023.. Debería tener varios años en el futuro.
    * CD_PREVISION needs some value, because is part of a relationship.
    * Time:
      * 11:30 - 14:30
      * 16:00 - 18:00
* [] Make point 2
* [] Finish all chapters in Tableau
* [] Find some BigQuery course advanced
* [] Call Carlos and ask how he is doing
* [] Call Imeq and get appointment
* [] Find something to do this week with Claudia

## 2023-06-14

* Tab "Detalle completo previsiones" Has strange cut off for dates.
* Tiempo ends on the 2023-12-30 instead of 2023-12-31 .In fact it should be years into the future.

## 2023-06-15

* Time:
  * Meeting Gimena: 1:15
  * Meeting Silvia 30m

## 2023-06-16

* Fixing "Tiempo" Y "Query Tiempo" Calendars calculations
* "QLM_Dataset_Report_v1.0.17.4_v1.5"
* "QLM_Dataset_Report_v1.0.17.4_v1.6"
  * As point 1 is going be done more manually then remove the tables related to make it automatically. As they are not needed anymore.
  * Corrected the "Detalle completo previsiones" cut off date. A button to open the filter details was missing. And once I have added "Num of Years" = 20 -- so 2014 - 2033 Then I cant set any range of dates i want.

## 2023-06-19

* Meeting Silvia:
  * Get login/passrd of Silvia to get administration level
  * Timing: 15min

## 2023-06-19

* Updating file wit changes:
  * To simplify development.
    * Separate Model from Report.
    *
  
## 2023-06-21

* Clarify:
  * Which server SAP is the active one // SQL Server associated ?
    * User
    * Passwd
  * Which server KAT is the active one // SQL Server associated ?
    * User
    * Passwd
    * At the moment the gateway is connected to the DB that was provided by Rafa
      * Server -> URBANIA-VSAP2
      * User -> PowerBI
      * Passwd -> 2Q4c83t@*%a4

* So:
  * SQL 2016 con SAP 9.3 y ahi teniamos todas las bases de datos, en el servidor URBANIA-VSAP, incluidas las bases de datos de KAT, con IP 172.25.3.5
    * So here only KAT?
  
  * Decidimos migrar SAP y montamos un servidor desde cero con SQL 2019, donde estan todas las bases de datos de las empresas de Urbania en SAP 10 en el servidor URBANIA-VSAP2
    * And here everything else? Including the SAP DB that uses KAT?

* Facturas..!

## 2023-06-23

* Sent invoices again after correcting them
* Sent email to ask for a renewal of 40 hours.

## 2023-06-26

* Downloading the file "QLM_Standard Dataset v1.0.19 Report - Ecoalf.zip" sent by Gimena.
This file contains tables related to endeudamientos. It should help to understand how those tables a used to calculate different formulas and how they are used to create visuals.

* Meeting with Silvia : 30 min
* Cleaning the information related to endedaumiento. 12:00 - ...

## 2023-06-29

* Questions for Gimena
  * In Condiciones
    * From the image of the KAT Application
      * What is the "Tipo De Producto"? Where is coming from?
      * How to calculate "Tipo Interes"?
      * How to calculate "Dispuesto/Pendiente"?
        * The table KAT_CONDICION_OPERACION is empty. So where are the operations related to Condiciones?
      * How to calculate "Amortizacion"?
        * The table KAT_CONDICION_OPERACION is empty. So where are the operations related to Condiciones?

* Questions manual Excel.
  * When entering some manual positions/amortization there could be some mistakes.
  * Would it be possible that KAT makes some checks to prevent this happening?

* Questions for Gimena:
  * In table Creditos_Full, the next credits have an account number but they no not exist in table cuentas.
    * CD_CUENTA = 128, 43, 81
  * In table Cuentas
    * What is the meaning of negative numbers in BKCuenta, well they are ignored in any case!!

  * What is capital vivo?
  * Compare Normal credits like the (133)
  * Prestamos like.. (115, 113)
    * How to calculate the amortización, pendiente/dispuesto, disponible, etc

* Meeting notes:

Cuando aplicas un tipo fijo es el tipo fijo de la tabla de condiciones.

* Las polizas de credito (KAT_CONDICION) tienen informacion del interes in KAT_CONDICIONES_TRAMOS.
  * Cuando tienen un solo limite suelen funcionar mostrando tres lineas por cada limite.
    * Desde el -limite hasta 0 se applica un interes.
    * Desde 0 hast infinito (null) se aplica un interes negativo (el banco paga al cliente)
    * Y desde - limite a - infinito se paga otro interes mucho mayor.. que el cliente suele evitar a  toda costa.
  * La interpretación del estado del prestamo se hace directamente de la cuenta asociada.
    * El balance de la cuenta indica la cantidad en ese instante que se esta pidiendo del prestamo y es de ahi de donde se calcula el estado instantaneo del prestamo. Este puede ir subiendo o bajando segun se meta o se saque dinero de la cuenta.

* Prestamo promotor (en fi_operaciones).
  * Funciona un poco como una Poliza de Credito con un solo tipo. Que se aplica al balance de la cuenta asociada.
  * En la tabla de amortizaciones, aparece
    * La cuota (lo que se paga cada mes)
    * Interes (Lo que se paga de intereses cada mes, que basicamente sera la cuota, pues no se paga nada del principal. )
    * Principal, lo que queda por pagar, que puede variar segun se incremente o decrecemente el saldo de la cuenta asociada.
    *

## 2023-07-03

* Questions for Gimena
  * The interests on the "Polizas de creditos" is siempre fijo?
  * Hay casos alternativos
  * Como sabemos que no es fijo
  * Como calculamos el interes variable aplicado a una fecha dada?
  * Hay un flag it_variable que es TRUE para algún caso, como se calcula el diferencial entonces?

## 2023-07-04

* Focusing in "Polizas de Credito"
  * Account 143 is missing!
  * Account 202 has no evolution at all! Does it make sense?
  * Account 208 has no evolution at all! Does it make sense?
  * Account 257 has no evolution at all! Does it make sense?
* Falta el instrumento 9 -> Pignoracion Aval MBU4 en table "fi_instrumentos" -> Gimena tiene que añadir.

* La cuenta 154, tiene dos prestamos promotores 130, 132, como se distingue la información de cada uno?

* Cuenta de Credito
  * Que pasa cuando se ha terminado ya?
    * Se cierra?
    * Se sigue usando?
  * La cuenta asociada es solo de la cuenta de credito?

* Prestamos promotores
  * Conparten cuenta con otras operaciones. Como se sabe cuales son del prestamo?
  * Y cuando hay varios prestamos promotores sobre la misma cuenta?

* Como funcionan todos los demas tipos de productos:
  * Cuenta de Crédito
  * Préstamo Cuota Constante
  * Prestamo Capital Constante
  * Aval
  * Leasing
  * Renting
  * Préstamo Promotor/Línea de Avales
  * Confirming
  * Créditos concedidos
  * Pignoracion Aval MBU4 en table

* Falta el confirming..!

Tipo_Producto_DS

Cuenta de Crédito
Préstamo Cuota Constante
Prestamo Capital Constante
Aval
Leasing
Renting
Préstamo Promotor/Línea de Avales
Confirming
Créditos concedidos

"Préstamo Cuota Constante",
"Prestamo Capital Constante",
"Aval",
"Leasing",
"Renting",
"Confirming",
"Créditos concedidos",
"Imposición a Plazo Fijo"

## 2023-07-06

* Is the amortizacion table real? Does it get updated with the real amortizations? Or it is fixed and created once?
* If that is so, is there any way to get the real data about amortizations?
* How is confirming working?
* Is there any way to know the real status of a any instrument?

## 2023-07-10

* How to share report with external user?
  * First need to give permissions to allow to invite external users.
    * I think the settings these days is (i say that because the keeep moving the setting...):
    * Admin Portar -> Tenant settings -> Invite external users to your organization -> Enable it!
      * See these links to understand better external users:
        * <https://learn.microsoft.com/en-us/power-bi/enterprise/service-admin-azure-ad-b2b>
        * <https://www.youtube.com/watch?v=xxQWEQ1NnlY>
        * <https://www.youtube.com/watch?v=yEWsI60mEc8>
        * <https://learn.microsoft.com/en-us/power-bi/enterprise/service-admin-azure-ad-b2b#planned-invites>
      * The external user needs a licence
      * If the external user does not have licence then your orgqnization can buy a licence for the external user.
  * User not having account:
  * User having a pro or premium account

## 2023-07-18

* Maybe it is better to use a single file, as the translation is getting a bit on the way.
  * So , ill retry to separate them later on on the future, but at the moment I will just use a single dataset. It should not be too problematic as the data is not that big.

## 2023-07-20

* There seems to be a mess with the relationships.
  * KAT_Empresas 1 -> * Grupo empresas..
    * I think it should be the other way around.. right?

  * Work:
    * Working on the model -> Cleaning inconsistencies
    * Relationship between
      * KAT_Cuentas
      * Condiciones
      * Condiciones_Full , WTF is this????

* Continue with the changes on the file: "QLM_Urbania_Dataset_Report_v1.0.17.4_v1.25"

* Preparation Meeting monday:
  * Matrix visualizations that show repeated bank and accounts for all the companies.
    * "Evolucion Saldos"
    * "Cobros Y pagos"
    * Due to not return a blank element for those combinations that should be empty.
  * Very complicated model that duplicates a lot of the informations and that is not clear:
    * Which tables are the important ones.
    * Account information is not exactly the same.
      * KAT_ACCOUNT and Cuentas table are no showing the same accounts?????
        * This should be cleaned and have a single chain of dependencies.
        * Now there are a lot of relationships, and some of them seems strange, also some of them are inactivate due to the mess of all the relationships. And they are unlikely to be used due to the poor comprenhension of the model.
  * "Creditos Concedidos"
    * If is matured then we show the last "Endeudamiento Amortizaciom[Principal]". If not Blank.
  * Translations:
    * Pages
    * Columns
    * Labels
    * Data / Slicers ..
  
## 2023-07-26

* Going page by page and translating everything.
* Create proposal of colaboration.
  * 35/40 hours per month -> hours not used will be accumulated.
  * It is better to have hours because it is quite difficult to assess what needs to be done. If i have to assess what is going to be done I will create a high estimate becuase there ar quite uncertainties of what has to be done.

## 2023-07-30

* Going page by page and translating everything.
* Created table "KAT_CONCEPTOS_COBRO_PAGO_DEV"  to translate DS_CONCEPTO in the table previsiones_full. At the moment i have only created the table and I will discuss with Silvia how what would be the best way to traslate it.
* Percentage value in cashflow page incorrect.
  * in "%Amount Forecasted by Concept" it was shown the total value as percentage. change to show the percentage of total.
* Check the previous and next pages, they dont seem to work. Though maybe we can move them as we have all the pages on the top now.

## 2023-07-31

* Going page by page and translating everything.

* Reviewing each page for last things:
  * PF
* Translations of the dates columns (Formulas and field parameters)
  * Week
  * Periodo
  * Fecha

## 2023-08-29

* [x] Update harvest.
* Send email to Silvia

## 2023-09-06

* Meeting with Silvia. Review what is left to do for the first phase.
* Comment ideas about a second phase.
  * Clean up the tables
  * Dax lessons
  * Workflow approach

* Screens
  * Forecasts
    * Bottom table concepts
      * Should they be translated?
  * Cashflow
    * Amount Forecasted by concept
      * Translate?
    * Summary headlines (Concepts)
      * Translate?
  * Collections & Payments
    * Top5

  * Summary Silvia's meeting
    * Silvia will create columns with concepts in english and she will let me know when she is done.
    * Myself will:
      * Check the details screens and see why the column's names are not picking up the already exiting translations for them.
      * Fix the issue of getting all banks for all levels of concepts in:
        * Screen Forecasts -> table - top left
        * Screen Balance evolutions -> table  Bank Balance Daily

## 2023-09-11

* We will se the changes next week. I can work on it. Tuesday night.

## 2023-09-12

* Employee <jma@byurbania.com> has a problem giving access to either other employess on the same tenant or to an external guest to the tenant account.
  * Reviewing permissions on workspaces.
    * https://learn.microsoft.com/en-us/power-bi/collaborate-share/service-how-to-collaborate-distribute-dashboards-reports
    * https://learn.microsoft.com/en-us/power-bi/collaborate-share/service-share-dashboards
    * https://learn.microsoft.com/en-us/power-bi/enterprise/service-admin-azure-ad-b2b
  * Tips
    * Click on account photo to see which licence you have.
    * Bear in mind that to access a dataset source you need permissions on the gateway of the source as well. They are independently handle to the workspace, datsets, reports, etc permissions.
    * If Workspace is not Premium capacity you need at least Pro licence. 
    * If Wokspace is PPU ??
    * Azure AD B2B Guest users, what permissions do they need? Either as their original AD user or as AD B2B Guest users (in the tenant where the workspace to be share is in)

## 2023-09-27

* Preparing meeting with Silvia.
  * Things to improve:
    * Table cuentas
      * Repeated join table KAT_CUENTAS
      * Separate 'Empresas' to filter out. Either a separate table with a clear name or a external file in google cloud , sharepoint with a clear name.
      * Usar 'KAT_CUENTAS_GRUPOS' to get the name of 'CD_GRUPO_CUENTA' instead of adding the type later on.
      * Table 'Previsiones full'
        * Instead of adding here the translations it would be better to do it on the original table with the concepts -> "Whatever table it is"
        * Same for 'DS_FLUJO_CAJA'
        * Same for 'DS_TIPO_DOCUMENTO'

  * Questions:
    * 6. Daily Bank Balance – En la información extra, dejar solo Description ??

## 2023-09-27

* 'Linea de Negocio' Viene de tres posibles sitios:
  * KAT_EMPRESAS_TIPO
  * Manually added by code:
    *  

    `````(m)
    switch typeCode
            case 2 => "OTHER",
            case 15 => "RESI",
            case 21 => "INNO HUB",
            case 19 => "TGP",
            case 17 => "LIVING",
            case 16 => "COMERCIAL",
            case 18 => "HOLDING",
            case 20 => "DEBT",
            default => "NULL",
    `````

  * And coming from file 'GrupoEmpresasUrbania.xlsx'
  
* Im going to get it for the time being from 'KAT_EMPRESAS_TIPO'

## 2023-10-03

* [TODO] Clean all names of columns, translations, even if they are not used. That clarify the use of all columns. Separate the name from the ones in the DB. (They should be almost the same, but the DB is untouchable so... Fck IT!)

## 2023-10-13

* In credits we see that there is more than 1 Poliza de crdito associated to a single bank account. How does that affect the Balance on other pages?
* Revisar filters on visual creditos.

* Cleaning the tables of credits and their relationships.
* Porque hay creditos sin cuenta asociada?
* In "TEST - Creditos - PROD" there is a filter on the visual "Creditos Matrix" why? It does not make sense.
I dont think it makes any difference , but it should not be there.
* In credits would u like to see values at upper levels when there is only on element at the lowest level or not?
* In screen "Fees & Payments" on the matrix we have the "Saldo o Disponible" measure, but on the screen thre is no way to know which one is going to be calculated..  abit confusing.

* What is the meaning of "Saldo final"?? It would depends on the interval of dates considered! Does it really make any sense?
  
* Review carefully all the dates on each screen. Do they make sense?
* Review the totals in balance screens , what do they mean? Because they are accumulated, so....

*[FUTURE] 
  * Clean all the measures, even if they are not being used now.
  * Remove all screens that are not being used now.
  * Remove some duplicated tables, prevision, prevision full,
  * Simplify sql about tipo de cambio ..


## 2023-10-16

* Beware of the calculations in Divisa (system, account, selected). Most of calculations are using the system Divisa, but the credits are using the account one. All works because everything is EUR, but it should be refactored to be more consistent.

* Screen "Balance Evolution"
  * Month Initial -> What about the other time aggregation? Week - Does it also means the beginning of the week?? Should it not be just a month (the end of the month? as the rest of time aggregations).
  If not, at least it should be more clear that the value is for the beginning of the month.

* Screen "Fees & Payments"
  * Payments -> The payments on the time interval - correct?
  * Collections -> The collections on the time interval - correct?
  * Net -> The net on the time interval - correct?
  * Matrix... Makes no sense..! Review the measures used!

 * After viewing these two screens I would change the "Mes Inicio" to simple "Mes" and then add two measures to clarify the intention: "Balance Begin" / "Balance End" that are associated to the beginning and end of the time interval active.


