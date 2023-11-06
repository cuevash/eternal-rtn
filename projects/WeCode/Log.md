# LOG

## 2023-05-12

### Working with templates

* Initial proposals for working with templates
  * Workflow  - 1:
    * Prechoose a series of existing webflows to show to the client
    * Cliet chooses one
    * We develop around the design structure of the template.
  * Workflow - 2:
    * Choose a few well selected families of generic templates.
      * Ones that follow the philosophy of "Client-First" -> [Client-First](https://finsweet.com/client-first)
      * Following their structure add to them some standarization about:
        * Colors
        * Menus
        * Buttons
        * "None"
        * Text styles
        * Etc...
      * Think how to keep these add-ons separated from the templates
        * On this way allow us to use it with different compatible generic template systems.
        * Allow us to update to their latest version and still being able to add our own add-ons


## 2023-09-11

* Thinking which frameworks are there and which advantages they have:
  * Webflow
    * https://pitchbook.com/profiles/company/58278-52 (800s)
    * Pros
      * Code generation
    * Cons
      * Components without variants, no variables. Only allowed properties changes
  * Framer
    * https://pitchbook.com/profiles/company/109588-24 (130)
    * Pros
      * Components with variants (styles, properties, variables)
    * Cons
      * No Code generation
  * Plasmic
    * https://pitchbook.com/profiles/company/399178-99 (12)
    * Pros
      * Code generation
      * Components with variants (styles, properties, variables)
    * Cons 
      * Not many employess (12)


## 2023-09-24

* Text styles
  * Define them in Figma. Colors are on different dimmension/POV
  * Choose some grading that makes sense for the text styles
  * Define primitive sizes and semantic sizes on top of them
    * Primitive sizes
    * H1 ... H6
    * BodyText xsmall ... xhuge
  * Define semantic text styles. For instace for small systems the next family so semmantic text styles can be defined.
    * Display (small, medium, large,...)
    * H1 ... H6 (Headings)
    * Labels?
  * For those semantic styles there is the need to attach primivitive sizes for all 4 width screen sizes. It maybe enough to choose a shrinking ratio through the width screen sizes. But it is not! 
  The biggest sizes can be reduced and they will look good on smaller screens, but the small sizes (lets say the 1rem ~16px) should not get any smaller because they will be illegible for most people.
  The small sizes may get a bit smaller if we use some fluidity on the design. So a 16px(1rem) in a 1440 width screen may get down to ~14px because of the fluidity rules. Either we decide that is fine or we may sey the text style for a 1440 screen a bit bigger than the 1rem(~16px) so that when it is displayed in a smaller screen does not get a too small font size.

## 2023-09-30

* GDPR
  * Precio de un cookie manager
  * Google Analytics simple
  * SEO simple
  * How to move from a Agency tool to your own account -> hay que pagar mas claro.
  * O cada empresa tiene el suyo.
  
 * Stack
   * Hostinger
     * Divi
       * Tiene forms with recaptcha.
       * Divi Engine
   * Translation
   * Cookie Manager
     * https://independentwp.com/blog/best-cookie-consent-plugin-wordpress/
     * https://www.elegantthemes.com/blog/wordpress/best-cookie-plugins-for-wordpress
     * Complianz?
     * GDPR Cookie Compliance?
     * Both some money per month , can be bought in bulk.
    * Idea is always the user to manage their own assets.
    * Recaptcha 

   * Webflow
     * Limitaciones version 14euros
       * No CMS
       * 1000 Forms - luego se paga.
       * El dueño, es el editor.

  * Que es mantenimiento. Clarificar muy bien. 
  * No código a medida! Permite cierto tipo de interacciones mas avanzadas:
    * Filters (Dropdowns con valores que filtran resultados)
    * Sorting
    * ...
  * Algo parecido imagino que puede hacerse con plugins for divi. La diferencia es que con los de webflow se puede añadir algo de programación para cuando la funcionalidad del plugin no llega (complementar). Mientras que los plugins de wordpress o no se puede o son bastante complicados de customizar con código.  
  * Ver por ejemplo:
    * https://diviengine.com/

https://themeisle.com/blog/best-block-plugins-for-wordpress/



## 2023-10-01

* Dudas finales para hostinger:

* Generales:
  * Solución ideal para agencias pequeñas que desarrollan webs para clientes y compran y gestionan su dominio y/o hosting y/o wordpress
  * Precio anual (sin promociones) de dominios .es y .com
  * Precio anual (sin promociones) de hosting básico y de hosting básico con Gutemberg ( Gutemberg Es Gratuito! )

  * Diferencias principales entre planes web y planes cloud?

  * Que diferencia hay entre single y premium?
  * Diferencia entre CDN y no CDN
  * En los planes web donde dice: Mayor rendimiento (hasta 5 veces). Se refiere a que se reserva mas cpus? O como es?
  * En los planes web: Existe seguridad entre cuentas? 
  * Que ventajas tiene una IP dedicada?
  * Seguridad: 
    * Entre Cuentas
    * Entre instalaciones en la misma cuenta
      * Diferencias entre planes web y cloud
  * Google Analytics integrado.
    * Que implica?
  * Acceso SSH? En la version single no tiene. Quiere decir que alguién puede entrar de forma menos segura? Es para la linea de comandos.  
  * Diferencias entre WEB: Optimizaciones SEO con IA y CLOUD: AI SEO Tools

* Carateristicas de los planes:
  * Hostinger PRO
    * Maneja instalaciones externas de clientes y instalaciones de clientes gestionadas por nosotros?
    * Como funciona? Son todos diferentes instalaciones de wordpress no? Completamente independientes no?
    * Podemos empezar en un plan y luego hacer un upgrade? Que nos costaría? Que pasaría con los descuentos?
    * Los clientes tienen que pagar su propio sitio?
    * Como acceden los clientes?
    * Hay diferentes tipos de usuarios(nuestro equipo) que puedan acceder a las funcionalidades pro?
    * Como se protegen los accesos (nuestro equipo). Como se activa 2FA.
    * Como se protegen los accesos (clientes). Como se activa 2FA para ellos. Entiendo que trabajando en este modo los clientes solo tienen acceso de edición.
    * AI SEO Tools (Que SEO tools tienen?)
    * Como funciona el modo staging?
    * Entiendo que todos los wordpress estan corriendo en la misma máquina.
      * Siendo realistas cuantos wordpress pueden correr y con que velocidad de respuesta?
      * Es una máquina dedicada? O es el calculo de la potenciá asignada (cpus)
    * El precio de los backups (25.08) es aparte del precio mencionado?
    * Como funciona el CDN? Entiendo que vuestros servidores en europa estan en Europe: France, the Netherlands, Lithuania, the United Kingdom. Y que usais cloudfare como CDN.
      * Como almacen caches para elementos dinámicos? 
    * Security. Si un sitio se compromete,, quiere decir que todos los demás sitios quedan comprometidos también?
      * Se usa algún sistema de virtualization o contenedores? Que aislen cada instalación?
    * Como se diferencia este plan de los planes web?

  * Hostinger WEB
    * Que diferencia hay entre single y premium?
    * Diferencia entre CDN y no CDN
    * Copias de seguridad diarias (valor: 25,08 €) es que se añade al precio? Al año?
    * Como se protegen los accesos (nuestro equipo). Como se activa 2FA.
    * Como se protegen los accesos (clientes). Como se activa 2FA para ellos. Entiendo que trabajando en este modo los clientes solo tienen acceso de edición.

* Todos los planes
  * Actualizaciones automáticas WordPress? El core?
  * Que plugins vienen preinstalados? Se renuevan automáticamente?
  * Protección de dominio. Esta asociado a cada dominio me figuro. (Acceso 2fa para acceder.)
  * Nos puedes explicar como funciona un poco:
    * Experiencia de navegación ultrarrápida con nuestra CDN interna, ObjectCache y el servidor web LiteSpeed.



Dominios diferentes 100, 200, etc.

Sitios pequeños unos 50 - 100. Plan de pro. Sitios separados.

Webs son compartidos. Pueden afectarse unos a otros.


Bussines -> mayor velocidad , cdn , staging, etc.

Seguridad: -> 
  - No malware en cada sitio. Seguros, cada sitio. 
  - 2FA 
  - Usuarios -> wordpress , quizas plugin.
    - Acceso a wordpress pero no hosting


- Que se actualiza solo:
  - Wordpress core
    - Themes
    - Solo algunos
  - 










Te deja mejorar de business a pro.









     
- Como funcionan los usuarios editores de Wordpress , pueden tener seguridad 2FA?
- Número de editores ilimitados?
- Que plugins vienen preinstalados en wordpress para la version Business.
- Que parte de wordpress se actualiza sola?
  - Core y algunos plugins de rendimiento?
- Hay plugins preinstalados para:
  - SEO
  - Forms
  - Seguridad en forms
- Como funciona mas en detalle el hosting de 100 webs. Entendemos que son dominios diferentes todos.
- Comparten esas 100 webs la potencia del 1 usuario hostinger? Si es asi, cuantas webs de forma realista pueden asociarse a una unica licencia de Business?
- Facil de traspasar el dueño de un site a un cliente.

- Que es hostinger pro? Vale, es mas para multisite no? Se pueden gestionar diferentes dominios? Que compatibilidades hay de plugins?
  - Que tipo de usuarios tienen acceso?
    - Se definen por cada wordpress?
    - Como se activa la seguridad de usuarios? Puede ser 2fa?
      - Plugins
        - https://northernbeacheswebsites.com.au/email-2-factor-authentication-for-wordpress/?gclid=Cj0KCQjw1OmoBhDXARIsAAAYGSFsQou8qzaElvDmNaVPJJYnyyam--AfVb5SBm9-Ake3KPoZh8ptVZ4aAlnwEALw_wcB

  - Esto pueda dar problemas. y no los puedo resolver. Mejor cada cliente el suyo.
    - https://webidextrous.com/how-to-solve-divi-issues-on-wordpress-multisites/
    - El esfuerzo para arreglar una chorrada puede ser brutal!!



Como trabajamos? Workflow.

- No hay diferencia entre hostinger simple y premium. Solo el dominio. pero lo puede comprar aparte que añade 10- 15 euros anuales.



## 2023-10-02

