# API Quick Guide

## Index

| No | Topic                                                         | No | Topic                                                       |
| :- | :------------------------------------------------------------ | :- | :---------------------------------------------------------- |
| 1  | [HTTP Verbs](#http-verbs)                                     | 11 | [API Performance](#api-performance)                         |
| 2  | [HTTP Status Codes](#http-status-codes)                       | 12 | [API Monitoring](#api-monitoring)                           |
| 3  | [Response Headers](#response-headers)                         | 13 | [API Standards](#api-standards)                             |
| 4  | [API Design](#api-design)                                     | 14 | [API Standards Organizations](#api-standards-organizations) |
| 5  | [API Architectures](#api-architectures)                       | 15 | [API Infrastructure](#api-infrastructure)                   |
| 6  | [API Design Patterns](#api-design-patterns)                   | 16 | [API Governance](#api-governance)                           |
| 7  | [API Security](#api-security)                                 | 17 | [API Documentation](#api-documentation)                     |
| 8  | [API Testing](#api-testing)                                   | 18 | [API Deployment](#api-deployment)                           |
| 9  | [API Development](#api-development)                           | 19 | [API Best Practices](#api-best-practices)                   |
| 10 | [API Implementation Platforms](#api-implementation-platforms) | 20 | [API Tools](#api-tools)                                     |

## HTTP Verbs

| No | Verb    | Description                                                                                 |
| :- | :------ | :------------------------------------------------------------------------------------------ |
| 1  | GET     | Retrieve data from the server.                                                              |
| 2  | POST    | Send data to the server to create a resource.                                               |
| 3  | PUT     | Send data to the server to update a resource.                                               |
| 4  | PATCH   | Send data to the server to update a resource partially.                                     |
| 5  | DELETE  | Delete a resource from the server.                                                          |
| 6  | PURGE   | Invalidates a cached resource.                                                              |
| 7  | TRACE   | Returns the full HTTP request received by the server for debugging and diagnostic purposes. |
| 8  | OPTIONS | Returns the HTTP methods supported by the server for the requested URL.                     |
| 9  | CONNECT | Converts the request connection to a transparent TCP/IP tunnel for secure communication.    |
| 10 | LOCK    | Locks the resource for exclusive use by the client.                                         |
| 11 | UNLOCK  | Unlocks the resource previously locked by the client.                                       |
| 12 | MKCOL   | Creates a new collection resource.                                                          |
| 13 | COPY    | Copies the resource identified by the Request URI to the destination URI.                   |

## HTTP Status Codes

| Code | Message                | Description                                                        |
| :--- | :--------------------- | :----------------------------------------------------------------- |
| 1xx  | Informational response | The request was received, continuing the process.                  |
| 2xx  | Successful             | The request was successfully received, understood, and accepted.   |
| 3xx  | Redirection            | Further action needs to be taken in order to complete the request. |
| 4xx  | Client Error           | The request contains bad syntax or cannot be fulfilled.            |
| 5xx  | Server Error           | The server failed to fulfill an apparently valid request.          |

## Response Headers

| No | Header                      | Description                                                                                              |
| :- | :-------------------------- | :------------------------------------------------------------------------------------------------------- |
| 1  | Content-Type                | Specifies the MIME type of the data in the response body.                                                |
| 2  | Content-Length              | Specifies the length of the response body in bytes.                                                      |
| 3  | Cache-Control               | Specifies the caching behavior of the response.                                                          |
| 4  | Location                    | Specifies the URI of a resource that can be used to retrieve the requested resource.                     |
| 5  | Server                      | Specifies the name and version of the server software that generated the response.                       |
| 6  | Access-Control-Allow-Origin | Specifies which origins are allowed to access the resource.                                              |
| 7  | Set-Cookie                  | Specifies a cookie that should be stored by the client and sent back to the server with future requests. |
| 8  | Expires                     | Specifies the date and time after which the response is considered stale.                                |
| 9  | Last-Modified               | Specifies the date and time the resource was last modified.                                              |

## API Design

| No | Type        | Description                                                                         |
| :- | :---------- | :---------------------------------------------------------------------------------- |
| 1  | REST        | Representational State Transfer, a design pattern for building web services.        |
| 2  | SOAP        | Simple Object Access Protocol, a messaging protocol for exchanging structured data. |
| 3  | GraphQL     | A query language and runtime for building APIs.                                     |
| 4  | API Gateway | A service that manages, protects, and scales APIs.                                  |

## API Architectures

| No | Architecture  | Description                                                                                                                            |
| :- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------- |
| 1  | Microservices | An architectural style for building complex applications as a suite of small, independent services.                                    |
| 2  | Serverless    | A cloud computing execution model where the cloud provider manages the infrastructure and automatically allocates resources as needed. |
| 3  | SOA           | Service-Oriented Architecture, an architectural style for building distributed systems.                                                |
| 4  | Event-Driven  | An architectural style where the flow of data between components is triggered by events.                                               |
| 5  | RESTful API   | An architectural style that uses HTTP requests to GET, POST, PUT, and DELETE data.                                                     |

## API Design Patterns

| No | Pattern                         | Description                                                                                                                                                       |
| :- | :------------------------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1  | Adapter Pattern                 | A pattern that converts the interface of a class into another interface that clients expect.                                                                      |
| 2  | Decorator Pattern               | A pattern that adds behavior to an individual object dynamically.                                                                                                 |
| 3  | Proxy Pattern                   | A pattern that provides a surrogate or placeholder for another object to control access to it.                                                                    |
| 5  | Observer Pattern                | A pattern that defines a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically. |
| 4  | Chain of Responsibility Pattern | A pattern that delegates commands to a chain of processing objects.                                                                                               |

## API Security

| No | Method                               | Description                                                                                                                                                                 |
| :- | :----------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1  | OAuth                                | An open standard for authorization used for protecting APIs.                                                                                                                |
| 2  | JWT                                  | JSON Web Tokens, a standard for securely transmitting information between parties as a JSON object.                                                                         |
| 3  | SSL/TLS                              | Secure Sockets Layer/Transport Layer Security, a protocol for establishing a secure connection between a client and a server.                                               |
| 4  | API Key                              | A secret token used to authenticate API requests.                                                                                                                           |
| 5  | Rate Limiting                        | A technique used to limit the number of requests that can be made to an API over a specific period of time.                                                                 |
| 6  | OpenID Connect                       | An authentication layer built on top of OAuth that allows users to be authenticated across multiple domains.                                                                |
| 7  | Cross-Origin Resource Sharing (CORS) | A mechanism that allows many resources (e.g. fonts, scripts, etc.) on a web page to be requested from another domain outside the domain from which the resource originated. |

## API Testing

| No | Tool         | Description                                                                          |
| :- | :----------- | :----------------------------------------------------------------------------------- |
| 1  | Postman      | A popular tool for testing and debugging APIs.                                       |
| 2  | SoapUI       | A tool for testing SOAP and REST web services.                                       |
| 3  | Swagger      | A tool for designing, building, and testing APIs.                                    |
| 4  | JMeter       | A tool for testing the performance of APIs.                                          |
| 5  | TestRail     | A test management tool for planning, executing, and tracking API tests.              |
| 6  | Dredd        | A command-line tool for testing API documentation against its backend implementation |
| 7  | REST Assured | A Java-based library for testing RESTful APIs.                                       |
| 8  | Karate DSL   | A testing framework for API testing using Gherkin syntax.                            |
| 9  | HttpMaster   | A tool for testing and debugging APIs                                                |
| 10 | Assertible   | A tool for testing and monitoring APIs with automated tests.                         |

## API Development

| No | Tool/Tech      | Description                                                                |
| :- | :------------- | :------------------------------------------------------------------------- |
| 1  | Node.js        | A JavaScript runtime for building server-side applications.                |
| 2  | Express        | A popular framework for building web applications and APIs with Node.js.   |
| 3  | Django         | A Python web framework for building web applications and APIs.             |
| 4  | Flask          | A lightweight Python web framework for building web applications and APIs. |
| 5  | Spring         | A Java framework for building enterprise-level web applications and APIs.  |
| 6  | Swagger Editor | A tool for designing and documenting APIs using the OpenAPI specification. |
| 7  | Postman        | A tool for testing and debugging APIs.                                     |
| 8  | Insomnia       | A tool for designing, testing, and debugging APIs.                         |
| 9  | Paw            | A tool for designing and testing APIs on Mac OS.                           |
| 10 | API Blueprint  | A high-level API description language for building RESTful APIs.           |

## API Implementation Platforms

| No | Platform           | Description                                                                                                                       |
| :- | :----------------- | :-------------------------------------------------------------------------------------------------------------------------------- |
| 1  | Firebase           | A mobile and web application development platform developed by Google.                                                            |
| 2  | Backendless        | A mobile and web application development platform that allows developers to build and deploy applications without backend coding. |
| 3  | Parse Server       | An open-source version of the Parse backend that can be deployed to any infrastructure.                                           |
| 4  | Amazon API Gateway | A fully managed service that makes it easy for developers to create, publish, maintain, monitor, and secure APIs.                 |
| 5  | Microsoft Azure    | API ManagementA fully managed service that enables users to publish, secure, transform, maintain, and monitor APIs.               |

## API Performance

| No | Platform         | Description                                                                                                                                            |
| :- | :--------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1  | Caching          | A technique for improving API performance by storing responses in a cache.                                                                             |
| 2  | Throttling       | A technique for limiting the rate of requests to an API to prevent overload.                                                                           |
| 3  | Load Balancing   | A technique for distributing traffic evenly across multiple servers to improve API performance.                                                        |
| 5  | Edge Computing   | A computing paradigm that brings computation and data storage closer to the location where it is needed to reduce latency and improve API performance. |
| 4  | Content Delivery | Network (CDN)A distributed system of servers that delivers content to users based on their geographic location to improve API performance.             |

## API Monitoring

| No | Tool       | Description                                                                          |
| :- | :--------- | :----------------------------------------------------------------------------------- |
| 1  | Pingdom    | A tool for monitoring the uptime and performance of APIs.                            |
| 2  | New Relic  | A tool for monitoring the performance of APIs and other web applications.            |
| 3  | Datadog    | A monitoring and analytics platform for cloud-scale applications and APIs.           |
| 4  | Sumo Logic | A cloud-based log management and analytics platform for APIs and other applications. |
| 5  | Loggly     | A cloud-based log management platform for monitoring APIs and other applications.    |

## API Standards

| No | Standard | Description                                                                     |
| :- | :------- | :------------------------------------------------------------------------------ |
| 1  | JSON API | A specification for building APIs that use JSON as the data format.             |
| 2  | HAL      | Hypertext Application Language, a standard for building hypermedia-driven APIs. |
| 3  | JSON-LD  | A format for representing linked data on the web.                               |
| 4  | OData    | Open Data Protocol, a standard for building and consuming RESTful APIs.         |
| 5  | AsyncAPI | A specification for building event-driven APIs.                                 |

## API Standards Organizations

| No | Organization                         | Description                                                                                                                                                                                               |
| :- | :----------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1  | W3C                                  | The World Wide Web Consortium, an international community that develops web standards.                                                                                                                    |
| 2  | IETF                                 | The Internet Engineering Task Force, an open standards organization that develops and promotes Internet standards.                                                                                        |
| 3  | OASIS                                | Organization for the Advancement of Structured Information Standards, a nonprofit consortium that drives the development, convergence, and adoption of open standards for the global information society. |
| 4  | RESTful API Modeling Language (RAML) | A YAML-based language for describing RESTful APIs developed by MuleSoft.                                                                                                                                  |
| 5  | JSON API                             | A specification for building APIs that use JSON as the data format.                                                                                                                                       |

## API Infrastructure

| No | Infrastructure | Description                                                                                           |
| :- | :------------- | :---------------------------------------------------------------------------------------------------- |
| 1  | Kubernetes     | An open-source platform for managing containerized workloads and services.                            |
| 2  | OpenShift      | A container application platform that builds on top of Kubernetes                                     |
| 3  | Docker Swarm   | A native clustering and orchestration solution for Docker                                             |
| 4  | Consul         | A service mesh solution that provides service discovery, configuration, and segmentation capabilities |
| 5  | Istio          | A service mesh solution that provides traffic management, security, and observability capabilities.   |

## API Governance

| No | Governance       | Description                                                                            |
| :- | :--------------- | :------------------------------------------------------------------------------------- |
| 1  | API Management   | The process of creating, publishing, and monitoring APIs in a secure and scalable way. |
| 2  | API Monetization | The process of generating revenue from APIs by charging developers for usage.          |
| 3  | API Versioning   | The process of managing changes to APIs over time.                                     |
| 4  | API Analytics    | The process of collecting and analyzing data on API usage and performance.             |
| 5  | API Gateway      | A service that manages, protects, and scales APIs.                                     |

## API Documentation

| No | Doc           | Description                                                                                                |
| :- | :------------ | :--------------------------------------------------------------------------------------------------------- |
| 1  | OpenAPI       | A specification for building APIs in YAML or JSON format.                                                  |
| 2  | API Blueprint | A high-level API description language for building RESTful APIs.                                           |
| 3  | RAML          | A YAML-based language for describing RESTful APIs.                                                         |
| 4  | Swagger UI    | A tool for visualizing and interacting with APIs that have been described using the OpenAPI specification. |
| 5  | Slate         | A tool for generating beautiful, responsive API documentation.                                             |

## API Deployment

| No | Provider               | Description                                                                      |
| :- | :--------------------- | :------------------------------------------------------------------------------- |
| 1  | Heroku                 | A cloud platform for deploying, managing, and scaling web applications and APIs. |
| 2  | AWS Elastic Beanstalk  | A service for deploying and scaling web applications and APIs on AWS.            |
| 3  | Azure App Service      | A service for deploying and scaling web applications and APIs on Azure.          |
| 4  | Google App Engine      | A service for deploying and scaling web applications and APIs on GCP.            |
| 5  | Docker                 | A containerization platform used for packaging and deploying applications.       |
| 6  | AWS Lambda             | A serverless compute service for running code in response to events.             |
| 7  | Azure Functions        | A serverless compute service for running code in response to events.             |
| 8  | Google Cloud Functions | A serverless compute service for running code in response to events.             |
| 9  | Netlify                | A cloud platform for deploying and managing static websites and APIs             |
| 10 | Vercel                 | A cloud platform for deploying and managing static websites and APIs.            |

## API Best Practices

| No | Practice       | Description                                                                                                                              |
| :- | :------------- | :--------------------------------------------------------------------------------------------------------------------------------------- |
| 1  | Versioning     | A technique for managing changes to APIs over time.                                                                                      |
| 2  | Pagination     | A technique for breaking up large API responses into smaller, more manageable chunks.                                                    |
| 3  | Caching        | A technique for improving API performance by storing responses in a cache.                                                               |
| 5  | HATEOAS        | Hypermedia as the Engine of Application State, a constraint of RESTful APIs that requires the API to provide links to related resources. |
| 4  | Error Handling | A technique for returning meaningful error messages to API clients.                                                                      |

## API Tools

| No | Tool                    | Description                                                                                                  |
| :- | :---------------------- | :----------------------------------------------------------------------------------------------------------- |
| 1  | API Studio              | A web-based IDE for designing and testing APIs.                                                              |
| 2  | Stoplight               | A collaborative platform for designing, documenting, and testing APIs.                                       |
| 3  | Apigee                  | A full lifecycle API management platform that allows developers to design, secure, deploy, and analyze APIs. |
| 5  | Postman Learning Center | A hub for learning how to use Postman to design, develop, and test APIs.                                     |
| 4  | Azure API Management    | A fully managed service that enables users to publish, secure, transform, maintain, and monitor APIs.        |
