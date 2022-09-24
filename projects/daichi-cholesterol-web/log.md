# LOG

## 2022/09/15

* Making small integrations on Webflow of Echarts.js.
  * First small integration works.
  * Making some graphs in different pages.

* How to use typescript and use it in webflow.
  * Using visual studio code to develop and make a package
  * Using jsdeliver for a CDN for your code package
  * Alternatively you could deploy the file to netlify etc.. But previous arrangement seems to be better.
  * https://www.youtube.com/watch?v=gq0jw3_d5Ig
  * https://github.com/finsweet/developer-starter

* As part of the process I used netlify as server to deliver data.

* Types of deployment:
  * Simple graph
  * Graph with data from external file (netlify + cors enabled)
  * Login with firebase
    * https://www.youtube.com/watch?v=30AIpEnsEaQ
    * Do a good research because you need to restrict access to most of the firebase services so there's no way a hacker can access to the datastore.
  * Login with supertokens, seems not to have the problems that firebase has..  
    * But it needs to have a front in react and a back api.. netlify connected to the supertoken server.. So it seems that a next.app is needed and to make a login component to make all the work.
  * Login with NextAuth  
    * In the end we go with nextauth and using our own database .. maybe upstash version free..
    * Creating google project daichi-cholesterol-web 
      * Adding Oauth keys for thr nextapp project..

## 2022/09/19

* Review and get doubts.
  * PP -> Pacientes
  * DM ??
  * Una linea 1 médico? Son datos sobre todos los pacientes que ha atendido en un periodo de tiempo. A veces
  como cantidades absolutas, a veces como cantidades porcentuales?
  * Parece que la pestaña "Summary of answers" es por médico y las otras por paciente?
  * Medico -> Grupo de pacientes? Como se relaciona esto?
  * Cuantas areas distintas hay?
  * Mapas? Solo un mapa con un icono mas información de la unidad?
  * Me salen unos 8 - 12 graficos en total con texto.. y quizas en diferentes páginas eso si..



* Budget:
  * 

(estimando un número de secciones y gráficos)

Procesado de datos
Conexión de datos con la galería gráfica
Integración de gráficos en webflow  


* After analyzing authentication and webflow:
  * Password protected some pages (Webflow native)
  * Netlify Identity (user // email free up to 1000 MAU)
  * Firebase -> (user // Email free up to 50000) 
    * But.. Is it secure? Because the key of firebase is mde public.. at least in the example ..
      * https://www.hackages.io/blogs/add-firebase-authentication-to-your-webflow-website
  * Supabase (free up to.. and cheap 25$ per project)
  * AWS cognito (cheap up to thousands..) Maybe a bit complex to setup 











* Review and get doubts.
  * PP -> Pacientes
  * DM ??
  * Una linea 1 médico? Son datos sobre todos los pacientes que ha atendido en un periodo de tiempo. A veces
  como cantidades absolutas, a veces como cantidades porcentuales?
  * Parece que la pestaña "Summary of answers" es por médico y las otras por paciente?
  * Medico -> Grupo de pacientes? Como se relaciona esto?
  * Cuantas areas distintas hay?
  * Mapas? Solo un mapa con un icono mas información de la unidad?
  * Me salen unos 8 - 12 graficos en total con texto.. y quizas en diferentes páginas eso si..
