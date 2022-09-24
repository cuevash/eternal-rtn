# LOG

## 2022/09/07

* The microservices thing could be done with an stock app . The main architecture would go something like this:

Client (next.js) -> microservices (next.js) -> ORM (prisma.io) -> Database Postgresql

If you want to use a full rest api server such as nest.js check how to do it serverless -> maybe in google cloud functions // Netlify functions // Vercel function

This can be deployed in a vercel enviroment.

Now:

* Can we use prisma.io in vercel? Yes!
* Does it make sense to use graphql? Maybe not yet
  
* So after researching a bit I settle on the next architecture to build a DB base APP.
  * Client (Next.js)
  * Rest backend (Next.js)
  * Prisma client for the DB
  * DB (PlanetScale) connection through the Prisma interface.
  * This at least for simple apps. If it gets more complex, it will be reevaluated.
  * Three environments, dev, staging, prod with GitHub actions for deployment.
    * This is actually the most difficult part of the project. The plumbing!! 

* So now we create the different elements.
  * Sort of following these instructions -> https://davidparks.dev/blog/planetscale-deployment-with-prisma/
  * Planetscale login
  * Create DB -> stock-dashboard-mini
  * Install PlanetScale CLI
  * Activate some migration prisma flag
  * Create connection -> save user & password
  * Create two additional branches
    * pscale branch create stock-dashboard-mini stock-dashboard-mini-dev
  * Connect to the two branches
    * pscale connect stock-dashboard-mini stock-dashboard-mini-dev --port 3309
  * Create nextjs repo
    * Have a look to this as template -> https://github.com/prisma/prisma-examples/tree/latest/typescript/rest-nextjs-api-routes
    * Install template from mantime
    * Initialize prisma
      * npx prisma init
  * pscale deploy-request create stock-dashboard-mini stock-dashboard-mini-dev


DATABASE_URL='mysql://gmyc1dho4rqrrypy9r7t:pscale_pw_TFP2d0vyFDNhbXjRdEeYML55yT8SOJmuIZENqfYbMV5@eu-central.connect.psdb.cloud/stock-dashboard-mini?sslaccept=strict'

generator client {
  provider = "prisma-client-js"
  previewFeatures = ["referentialIntegrity"]
}

datasource db {
  provider = "mysql"
  url = env("DATABASE_URL")
  referentialIntegrity = "prisma"
}
