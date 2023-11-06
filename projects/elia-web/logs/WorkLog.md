# LOG

## 2022/07/28

- WeCode - Elia webpage
  - Blogs
  - Forms
  - How to move the ones already on the web? Manually? Is it possible to create script?
    - Access to the raw data? DB?
  - Can a user add a:
    - Blog Entry
    - House entry
    - Other entries..
    - Backup // Versions?

## 2022/08/02

- Webflow - Demo with

  - CMS
  - forms
  - filter for cms entries.

- Architecture
- Submit action -> (something) -> google sheets -> response (show success//error)
  - The something could be retool -> <https://retool.com/>
  - Most of the apps sass in themarket similar to Zapier are a bit expensive for what we want.
  - To call directly the google sheets API could become a bit complicated to mantain.. Is there something easier? Maybe Retool.
  - Retool is great to create internal tools.. no so great to create APIs, and thats what we need to connect to submit of a Webflow form to google sheets.
  - There two integration tools that have a reasonable pricing:
    - <https://automate.io/pricing> (600 actions per month enough ? )
    - [Pabbly](https://www.pabbly.com/connect/)
    - Pipedream seems even better and cheaper..
  - Yes pipedream is the chosen one to connect to google sheets man.!!

## 2022/08/03

- Architecture so far.
  - FrontEnd (Webflow)
  - Forms
    - Initially the ones for the site Plan cover 1000 forms per month, should be enough.
    - If the 1000/month are not enough forms then use pipedream that provides up to 10.000 actions/month
    - Use recaptcha (from google) it is integrated someway with webflow.
      - How to use it if we have to integrate without the limit of 1000 ?
  - Filters
    - This seems to be a profesional free solution -> <https://www.finsweet.com/attributes/cms-filter>
      - All explained in -> <https://www.youtube.com/watch?v=FFvIb1gQYa8>
  - Performance
    - Consider having a look to this -> <https://www.littlebigthings.dev/webflow-cms-image-optimizer>
      for images performance
    - It seems that cms images are already improved because they wont be sent till they are used on the page.

## 2022/08/04

- Discussing the budget and the doc word.
  - Budget
    - Out of this world!
    - Have a look to -> <https://boluda.com/tutorial/precio-web-wordpress/>
    - Pero vamos, yo creo que maximo podemos pedir entre 3000 - 5000, cualquier cosa fuera de este rango va a ser un no!
    - Que nos cuente Nerea lo que cobra su amigo por una web parecida a esta... Que al final
      la haran con un template de Wordpress que ya incluye por defecto la mayoria de los plugins.
      Que si, que hay que actualziarlos de ven en cuando.. Meterse en la página y dar a actualziar etc.. y corregir alguna cosa si no funciona.. Pero vamos mentalmente solo compañias mas grandes estan dispuestas a hacer ese desembolso.
      Hagasmos el ejercicio de cuando puede ser su negocio anual.. Cuanta gente son.. Y de donde le vienen los clientes... No habrá mas un boca a boca?

- Document

  -

## 2022/11/08

- Calculate the deliveries schedule. For that lets go through the pages and calculate the effort for similar pages done in Webflow. Taking into account the high level structuring that can be done , so it is easier to make next webs.

- Tasks:

  - Structure of the web (Following best principles from "Client-First" from finsweet -> <https://www.finsweet.com/client-first/docs>)
    - Create main pages
    - Create menubar
    - Create common header
    - Create common footer
    - Create main sections on pages
  - Premises
    - Create Initial Premises CMS structure
    - Create filter widget
    - Create order by widget
    - Section: List & Premise in list
    - Section: List & Premise in featured widget
    - Section: Premise in page
      - Section: Main Photo
      - Section: Carousel Photos
      - Section: Attributes
      - Section: Description
      - Section: "Instalaciones"
      - Section: Embedded Map with location?
      - Section: Similar premises
      - Section: More information Form
      - Section: Comment -> Eliminar?
  - Blog
    - Create Initial CMS Blog structure
    - Section: Blog entry in a list
    - Section: Blog entry page
    - Section: Categories
    - Section: Tags
  - GDPR
    - GDPR link
    - GDPR Page
  - Section: Accreditations
  - Section: "Colaboradores"
  - Section: "Enlaces de interes"

- WEB
  - Home
    - Section → Filter widget to search for homes to either buy or rent
    - Section → Row with featured properties
    - Section → Row with links to various services sections
    - Section → Who are we
      - Simple details
    - Section → Carousel of widgets to blogs entries
    - Section → accreditations , Partners, Links of interest
      - Simple section
    - Section footer → some links to sections
      - Simple section
  - Servicios
    - Section → Servicio Integral
      - Simple row of services provided
    - Section → Consultoria
      - Simple row of services provided as a consulting firm
    - Section → Tasaciones
      - Form widget to ask for a Valuations and ratings. Deapi should get an email with the requested information.
    - Section -> Social
      - Simple social sharing links
  - Inmuebles
    - Section -> Widget for sales and rentals, for homes and warehouses and premises. Each of one of these 4 options are navigated through main menu with some filters, but the widget is basically the same.
      - Complex widget to filter and navigate through all the properties. Has a filter widget, a list widget, a featured widget.
  - Productos especiales
    - Section -> Is the same widget that the previous page/section. The only difference are the filters applied to the type of property/premise to search through.
  - Blog
    - Typical blog, with categories, tags, cloud of tags, social sharing, pagination
  - Contacto
    - section -> Widget form to send general request. Also some contact information
  - Quienes somos?
    - section -> Simple section with some social sharing of deapi web link

## 2022/11/14

Mirando el diseño:

- Elia comentó de algun apartado donde anunciar las exposiciones. Creo que pueden ser
  entradas de blog con un tag. Y así podria haber una pagina con información de las ultimas exposiciones que simplemente filtre las entradas de Blog por ese tag.

  Y la página se puede llamar:
  \*Exposiciones

  - Ultimas exposiciones
    O algo asi.

- En la pagina de inmuebles/Productos especiales

  - Igual tiene sentido repetir los destacados en una columna a la derecha por ejemplo.
    Están en la página principal pero se pierden al no estar aqui.

- En vez de venta , no es mejor compra?
- En las páginas de busquedas:

  - En vez de Venta/ Alquiler -> Comprar/Alquilar.
  - Quitar del filtro de la página home el tab de obra nueva. Y añadirlo al desplegable de tipos de vivienda.

- Hablar con ellos, pero podría ser mejor tener un solo menú inmuebles y tener una clasificación inicial similar a la que tiene idealista ?

  - El menu "Inmuebles ..."
  - Y el filtro de busqueda una vez seleccionad el tipo de vivienda puede tener solo los tabs de comprar/alquilar.

- "Ordenar por" , lo sacaría de la parte de los filtros. Pues, realmente no es un filtro. Es más una opción de como mostrar los resultados de filtrar.

## 2022/11/17

- Creating pages and sections.
  - Adding some libs with common sections (client-first ready)

## 2022/12/13

- Create templates and symbols for all elements.
  - Do not focus on perfect styling, just in the pieces of the elements
  - Also, start with the easy sectors, in that way I may be able to have something for Nerea tomorrow.
  - Other person (Nerea should be able to start adding value)
    - Improving the elements styles
    - Breakpoints?

## 2022/12/20

- Slaving away the pages.

## 2022/12/22

- Making the maps bits

  - Checking the current state of affairs. I bet they are just setup as a pre-2018 site.
    And they can keep working because Google has some sort of relaxed policy around it. At least so far...
    But can change literally, any minute! And then the maps bit of the webpage won't be available anymore.

    - Looking inside the WordPress installation.. Nothing!
    - Let's have a look to the calls done by the website

      - Call done in website:

      ```{jav}
      https://maps.googleapis.com/maps/api/js?key=AIzaSyAdXRWq3X3-rTW2p85NZPWCPBIKlkpXSNM&libraries=weather%2Cgeometry%2Cvisualization%2Cplaces%2Cdrawing&ver=6.1.1
      ```

      - So the site uses a Google Maps API key. Do we still want to use that? Or rather we use Mapbox that has a more permissible license.
      - I would go for the Mapbox license because it offers more for free. And it seems easier to get control of for the business. To handle the Google API map seems to be overcomplicated for small business.
      - Now, shall we go for the leaflet lib or the maplibre lib.

  - In the end well go for the maplibre lib.
    - First implementation with mapbox lib, because there are more examples
      - Collect in a list the elements through a webflow collection and embed element.

## 2022/12/28

- Last steps:

  - Design for the rest of breakpoints
    - 2 more or three, by default webflow has like 3 breakpoints. 4 states
  - Testing in enough platforms
  - Check SEO
  - What to do with external services
    - Recaptcha
    - Google maps
    - Google analytics
    - Cookie consent
  - Loading of data?

- Adjusting text sizes:

| Text Size | Header | Text Class |
|-----------|--------|------------|
|           | H1     |            |
| 83        | H2     |            |
| 53/56/54  | H3     |            |
| 49        | H4     |            |
|           | H5     |            |
|           | H6     |            |
| 61        |        | xxlarge    |
| 53/52/54  |        | xlarge     |
| 48/45     |        | large      |
| 41/43     |        | medium     |
| 37        |        | regular    |
| 35/34     |        | small      |
| 27/29     |        | tiny       |

## 2022/12/30

- Missing pieces
  - The three pages from the footer
    - Aviso Legal
    - Política de Cookies
    - Política de Privacidad
  - Page certificacion-energetica-de-edificios-existentes

- Improving
  - Selecting right element in the menu.

## 2023/01/02

- Tamaño letra en inmuebles destacados mas grande.
- Selects, elemento seleccionado mas negro.

- Unlink to use..

## 2023/01/04

- Missing pieces
  - The three pages from the footer (Review content, and get it up to date.)
    - Aviso Legal
    - Política de Cookies
    - Política de Privacidad
  - Page certificacion-energetica-de-edificios-existentes - yo.

- Review information needed to be shown on:
  - 'Aviso Legal'
  - 'Política de Privacidad'
  - 'Política de Cookies'

- In the page "Política de Cookies" review the list of cookies mentioned as being used on the website. - yo

- The dots in the collection page of premise are not part of the slider size. So I have to add some manual margin. This should be improved/fixed.
This can be awkward in some edge cases where there are many dots( many images) and they overlap with the next element.

- Maps should use Google Maps instead of Mapbox. Its official that Mapbox does not have a way to prevent overuse of calls… And then they will demand some money…! :-)
- Maps should disable the gesture of panning, so the user does not get stuck on the map section and can keep going.

- In sliders, the arrow are a bit overlapped with the mask of the image, so sometimes instead of clicking the image you may
click the arrows. Could be improved. (But not that important)

- Simple SEO
  - Review all the simple things so that the web is for the simple things SEO compliant - tu/yo
  
- Connect to the 360º view service they have and add it to the detail page of a premise.

- Bring some data from the original web. Certify that all the needed fields are there.

- I think we need to add some search field to the blog collection page.

- Add cookie consent.

- Google Analytics

- Test:
  - Test all pages and all cases of filtering and searching.
  - Test pages on different sizes and devices and browsers.
    - Browserstack
  - Test that the forms work.
    - They are received properly.
    - They have the right format
    - The column names are consistent.

- Add type of premise on the summary of premises
- Add published date on the detail of the premise

## 2023/01/09

- Doing the finishing touches of the web
  - Translating the cookie consent. Using (<https://www.deepl.com/en/translator>)
  - Put something 25/30 in the sliders instead of the dots

- Reviewing the web. What is missing?..
  - General
    - Set some animations on the buttons?
    - Set some animations on the pictures?
    - Show something on the picture to clarify that they can be zoomed in .. no se
    -
  - Home
    - Make titles excerpt on the sliders? or make the text size smaller..
    - The space of images should always be used.
    - Put something 25/30 in the sliders instead of the dots? Pues si!
    - What to do when there is no picture on the sliders?
    - What to show when there is no location identified?
      - "Sin localización" ?
      - ...

  - Detail premise
    - What to do with the 360ª view?

## 2023/01/19

- Recollecting cookies used by using the free account of cookieyes
  - Using the next list of pages for doing a scan:

````{text}
https://deapi-project-v1-0.webflow.io, https://deapi-project-v1-0.webflow.io/quienes-somos, https://deapi-project-v1-0.webflow.io/inmuebles?compra-o-alquiler=compra, https://deapi-project-v1-0.webflow.io/blog, https://deapi-project-v1-0.webflow.io/exposiciones, https://deapi-project-v1-0.webflow.io/contacto, https://deapi-project-v1-0.webflow.io/inmuebles/deapi-vende-vivienda-de-tres-dormitorios-en-palacio-b, https://deapi-project-v1-0.webflow.io/certificacion-energetica-de-edificios-existentes
````

- Investigate mode editor in webflow.
- Cookies are very complex thing keep improving by the day.
  - Handle fonts used. Download them instead of loading them by google.

- Hace falta actualizar las páginas de avisos legales?

  - Aviso Legal web -> <https://protecciondatos-lopd.com/empresas/wp-content/uploads/2016/09/modelo-de-aviso-legal-en-pdf.pdf>>

## 2023/01/21

- reCaaptcha has lots of problems to complain with the GDPR law. There are a few alternatives. Though very few are free for business.
Searching through the alternatives I think the next one is reasonable and is free up to 1.000.000 requests per website.

<https://www.mtcaptcha.com/>

We need some code on the server side to generate this captcha.

## 2023/01/31

- Recollecting cookies used by using the free account of cookieyes created by deapi, so I update the https of all the pages to the new address of the final cloned site.
  - Using the next list of pages for doing a scan:

````{text}
https://deapi-final-project-v-1-0.webflow.io, https://deapi-final-project-v-1-0.webflow.io/quienes-somos, https://deapi-final-project-v-1-0.webflow.io/inmuebles?compra-o-alquiler=compra, https://deapi-final-project-v-1-0.webflow.io/blog, https://deapi-final-project-v-1-0.webflow.io/exposiciones, https://deapi-final-project-v-1-0.webflow.io/contacto, https://deapi-final-project-v-1-0.webflow.io/inmuebles/deapi-vende-vivienda-de-tres-dormitorios-en-palacio-b, https://deapi-final-project-v-1-0.webflow.io/certificacion-energetica-de-edificios-existentes,
https://deapi-final-project-v-1-0.webflow.io/inmuebles/deapi-vende-vivienda-de-tres-dormitorios-en-palacio-b
````

## 2023/02/21

- Preparing for production

  - Tabs in project settings:
    - [x] General
    - [x] Members (Maybe remove ourselves after it is live)
    - [ ] Publishing
      - [ ] Add custom domain!!
    - [x] Plans & Billing
    - [ ] SEO
      - [x] Disable Webflow Subdomain Indexing -> ON
      - [x] Auto-generate Sitemap -> ON
      - [ ] Set title and metadata info on all pages.
        - [ ] Most of the information should be added by Deapi
        - [x] Some 301 can be added to improve discoverability
      - [x] Global Canonical Tag URL
        - Set to "https://deapi.es"
      - [] Sitemap will be automatically generated. Check it!
      - [x] Robots.txt needs to be added and update it to add to disallow directive for the template pages we don't want to be indexed
        - [ ] Check it is there with plugin
      - [x] For pages like "Licenses" and "Cookies info" consider the below information. At the moment. We do nothing.
        - [ ] For pages like "Licences" and "Cookies info" set Add -> <meta name="robots" content="noindex"> because they are not important from the seo/search indexing perspective. Also:
        - [ ] Also add "Do not add "Site search settings" for that page
        - [x] Also add In the robots.txt add ,·"disallow" for that page.
    - [ ] Form (see video)
      - [ ] Update email thingys and test them
      - [ ] Update "Forms notifications" if needed in forms tab -> <https://university.webflow.com/lesson/form-submissions-wf#how-to-set-form-notification-settings>
        - [ ] From name – the label of the sender of the email (e.g., Webflow Forms)
        - [ ] Warning! After the 1000 form then they charge 1$ per 100 forms. Watch out for that.. To see if something wrong. You will get the number of forms submitted on each form.
    - [ ] Backup
      - [ ] Maybe create a named backup before putting into production
    - [ ] Integrations
      - [x] We do all integrations by code Ids
      - [ ] Maybe we need to add some domain to the services of maps and cookie consent.
            Check that!
    - [ ] Google Analytics needs to be updated as well
- Other things
  - [x]] Do not publish pages that are only helper for design.
    - [x] Make them in draft state, and they won't be published
    - [x] The template files cannot be set in draft state then, simply set them to no be indexed.
      - [x] Also add "Do not add "Site search settings"
      - [x] Add -> <meta name="robots" content="noindex"> to all those template pages that are not supposed to be seen.
      - [x] In the robots.txt add ,·"disallow" -> see <https://www.drlinkcheck.com/blog/noindex-nofollow-disallow#:~:text=Noindex%3A%20Search%20robots%20will%20look>,at%20the%20page%20at%20all.

## 2023/02/28

- Tomorrow ask Alex:
  - Try to send a form and see if you get the right answer.
  - Beware there is a limit of 1000, and then you have to pay 1 dollar for each 100th. But that should not be a problem. You can check there is no trouble by the counter form.
