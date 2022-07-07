# PowerBI Modelization Notes

## Naming system
Rules to naming things in a PowerBI semantic model. 

The way we model things in PowerBI is a bit different to the naming system we choose in the dimensional modeling system. In the dimensional modelling we names tables and attributes in a bit more system-criptic oriented.
For instance, we call the tables "[Transactions]Fact" and "[Product]Dim", while in general in the PowerBI semantic model we will get rid of the Fact,Dim suffixes.

### Rules
  As a general rule is better to choose English as the main language and on the first modelization phase name everything in English. 
  As advantages of following this method we have:
    - Clear standarization naming of everything
    - Clear priority of concepts when nameing.. for instance: AccountTransactions ..

  Then, it is not difficult to translate everything using TabularEditor. But this protocol will increase the speed of choosing names, as it is much easier to find on the internet the naming of a business concept.

  Based on:
    - https://blog.crossjoin.co.uk/2020/06/28/naming-tables-columns-and-measures-in-power-bi/
    - https://exceleratorbi.com.au/best-practices-power-pivot-power-query-power-bi/

* Tables
  * Pascal Case, don't use spaces between words. If you use spaces in table names you will be forced to add single quotes around the table name each time you refer to it in a formula

* Attributes/Measures
  * Capital words, separated by spaces. Consistent naming in all concepts.. like..
    First the concept, then ...
    * Price Avg.
    * Price Sum Total
    * Price YTD
    * Price

* Measure Table
The creation of a separate measure table called like "Measures", it will appear at the top of the tables because it only contains measures, and it is identified in a special manner by the PowerBI engine.
Or..
Creation of Measures folder on each fact table and a table "Report Measures" for all the measures that are not associated to a single fact table.
When using composite models the second approach seems to be more scalable. Then we will need probably  have three levels of measures grouping:
  - Fact table measure group
  - Report level measure group
  - Composite report measure group.
