# LOG

## 2022/07/28

* WeCode - Elia webpage
  * Blogs
  * Forms
  * How to move the ones already on the web? Manually? Is it possible to create script?
    * Access to the raw data? DB?
  * Can a user add a:
    * Blog Entry
    * House entry
    * Other entries..
    * Backup // Versions?

## 2022/08/02

* Webflow - Demo with
  * CMS
  * forms
  * filter for cms entries.

* Architecture
* Submit action -> (something) -> google sheets -> response (show success//error)
  * The something could be retool -> <https://retool.com/>
  * Most of the apps sass in themarket similar to Zapier are a bit expensive for what we want.
  * To call directly the google sheets API could become a bit complicated to mantain.. Is there something easier? Maybe Retool.
  * Retool is great to create internal tools.. no so great to create APIs, and thats what we need to connect to submit of a Webflow form to google sheets.
  * There two integration tools that have a reasonable pricing:
    * <https://automate.io/pricing> (600 actions per month enough ? )
    * [Pabbly](https://www.pabbly.com/connect/)
    * Pipedream seems even better and cheaper..
  * Yes pipedream is the chosen one to connect to google sheets man.!! 

## 2022/08/03

* Architecture so far.
  * FrontEnd (Webflow)
  * Forms 
    * Initially the ones for the site Plan cover 1000 forms per month, should be enough.
    * If the 1000/month are not enough forms then use pipedream that provides up to 10.000 actions/month
    * Use recaptcha (from google) it is integrated someway with webflow.
      * How to use it if we have to integrate without the limit of 1000 ? 
  * Filters
    * This seems to be a profesional free solution -> https://www.finsweet.com/attributes/cms-filter 
      * All explained in -> https://www.youtube.com/watch?v=FFvIb1gQYa8
  * Performance
    * Consider having a look to this -> https://www.littlebigthings.dev/webflow-cms-image-optimizer
    for images performance
    * It seems that cms images are already improved because they wont be sent till they are used on the page. 

## 2022/08/04

* Discussing the budget and the doc word.
  * Budget
    * Out of this world!
    * Have a look to -> https://boluda.com/tutorial/precio-web-wordpress/
    * Pero vamos, yo creo que maximo podemos pedir entre 3000 - 5000, cualquier cosa fuera de este rango va a ser un no!
    * Que nos cuente Nerea lo que cobra su amigo por una web parecida a esta... Que al final
    la haran con un template de Wordpress que ya incluye por defecto la mayoria de los plugins. 
    Que si, que hay que actualziarlos de ven en cuando.. Meterse en la página y dar a actualziar etc.. y corregir alguna cosa si no funciona.. Pero vamos mentalmente solo compañias mas grandes estan dispuestas a hacer ese desembolso.
    Hagasmos el ejercicio de cuando puede ser su negocio anual.. Cuanta gente son.. Y de donde le vienen los clientes... No habrá mas un boca a boca? 
  * Document
    *  
