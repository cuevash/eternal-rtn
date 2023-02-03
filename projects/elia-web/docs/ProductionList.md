# Para poner la web en producción

Mientras creáis el site podéis verla en -> <https://deapi-project-v1-0.webflow.io/>

## Crear un sitio en webflow

- Hace falta crear un site en webflow con capacidad de CMS
  - En la página <https://webflow.com/pricing> crear el Site Plan CMS
- Nosotros clonaremos el sitio y os traspasaremos la propiedad
- Despues Singularfact se pondra como guest para poder realizar cambios.

## Lista de servicios a activar

- reCAPTCHA - Google
  - <https://www.google.com/recaptcha>
  - <https://university.webflow.com/lesson/recaptcha#enabling-recaptcha-validation-for-a-project>
  - reCAPTCHA, os proporcionará un identificador que hace falta añadir a la web
  
- Google Maps API
  - <https://blog.hubspot.com/website/google-maps-api>
  - <https://developers.google.com/maps/get-started>
  - Limitar el trafico de google maps
    - <https://help.stockist.co/article/47-limiting-google-maps-usage-with-quotas>
  - Tener en cuenta que hay un límite gratuito de unas 28000 cargas de mapas al mes. No creo que llegueis , pero
  para que no os cobren nada hay que establecer una limitación al número de llamadas/(cargas de mapa) del servicio.
  - Tendréis que darnos el Identificador que google crea para que lo añadamos a la web.

- CookieYes
  - [<https://www.google.com/recaptcha>](https://www.cookieyes.com/)
  - Estaba activada una cuenta gratuita, de momento he creado otra cuenta gratuita.
  - Hace falta que hagais una cuenta. Tened en cuenta que la web indica que la subscripción gratuita es
  solo para blogs personales y webs similares, pero no para webs de negocio.
  - Una vez creada la cuenta de CookieYes, necesitaremos que nos dejéis acceder para terminar de configurarla.
  - Igual que el resto de servicios, CookieYes proporciona una url con un identificador embebido que hace falta añadir a la web.
