# LOG

## Previous story

......

## 2023-03-01

* Working on the "Harvest-Pro-Dataset-v1.12.pbix" file
  * What is the retainerID ?  client, user or invoice?
* Disable automatic relationships' detection. On this case is more harmful than helpful

## 2023-03-01

* Reviewing all the tables

* What is the weekly capacity? 35 Hours all right!

* In the Invoices modeling, it is not possible, at least not very straightforward to create relationships
between projects and invoice_line_item, because there is already a relationship between client and invoice.
So if there were a relationship between project and invoice_line_item, and we set a filter on client then we will likely
wont get all the invoice_line_item s that are part of the invoice.
The solution if we want to filter by project will be to use a virtual relationship that apply the filter over the projects to the invoice_line_item table. That can be done with a combination of CALCULATE and TREATAS

## 2023-06-19

* Adding projectID to table Tasks through the table Time_Entries that has a relationships Client->Projects->Tasks
