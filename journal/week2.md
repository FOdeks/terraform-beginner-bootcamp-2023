## Week 2 - Launching and Connecting Terrahome to TerraTowns

### Programming Languages
- **Ruby** used for web development
- **Sinatra** is a Domain-Specific Language (DSL) for rapidly creating web applications in Ruby
- **Go** used to develop the custom Terraform Provider
___

## Deploying To TerraTowns

![architecture_diagram_week2](https://github.com/FOdeks/terraform-beginner-bootcamp-2023/assets/99102643/f4d09ca2-d091-41f6-92ae-0c4d0f1569c1)

## Table of Contents

- [Working with Ruby](#working-with-ruby)
  - [Bundler](#bundler)
    - [Installing Gems](#installing-gems)
    - [Executing Ruby scripts in the context of Bundler](#executing-ruby-scripts-in-the-context-of-bundler)
  - [Sinatra](#sinatra)
- [Custom Provider](#custom-provider)
  - [CRUD](#crud)
  - [HTTP Requests](#http-requests)
    - [Anatomy of HTTP Request](#anatomy-of-http-request)
    - [Bearer Authentication](#bearer-authentication)
    - [HTTP error codes](#http-error-codes)
- [Terratowns Mock Server](#terratowns-mock-server)
  - [Running the Web Server](#running-the-web-server)
- [More Terraform](#more-terraform)
  - [Terraform CLI Config File](#terraform-cli-config-file)
  - [Debugging Terraform](#debugging-terraform)


## Working with Ruby

### Bundler

Bundler is a package manager for **Ruby**. It is the primary way to install Ruby packages (known as gems) for Ruby.

#### Installing Gems

You need to create a **Gemfile** and define your **gems** in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command.

This will install the **gems** on the system globally (unlike .nodejs which install packages in place in a folder called node_modules).

A **Gemfile.lock** will be created to lock down the gem versions used in the project.

#### Executing Ruby scripts in the context of Bundler

We have to use `bundle exec` to tell future Ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra

Sinatra is a micro web-framework for ruby to build web-apps.

- It is designed to be lightweight and easy to use, making it an ideal choice for small to medium-sized projects.

- It is great for mock or development servers or for very simple projects.

- You can create a web-server in a single file. 

[Sinatra](https://sinatrarb.com/)

## Custom Provider
**Custom provider** named **terraform-provider-terratowns**. 

**Provider Physical Diagram**
![provider_physical_diagram](https://github.com/FOdeks/terraform-beginner-bootcamp-2023/assets/99102643/7fd68fef-97f0-43ad-8ad0-dbb60d21e663)

### CRUD

The Terraform Custom Provider has a resource called **Home**. This resource has four actions known as **CRUD** associated with it.

CRUD stands for:
- Create
- Read
- Update
- Delete

[CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)

We have two servers:

1.  `TerraTowns` : `Development (Mock) Server` : `sinatra` server :  `localhost:4567`

2.  `TerraTowns.cloud` : `Production Server` : `rails`

> Sinatra : light-weight web server

> Rails : heavy-duty production server

We will use **bash scripts** under the path `/bin/terratowns/` to mock each of the four HTTP requests : 

i)   `create` 

ii)  `read`

iii) `update`

iv)  `delete`

|   	| TF Resource Action 	| HTTP Request Type 	|          API endpoint         	|
|---	|:------------------:	|:-----------------:	|:-----------------------------:	|
| 1 	| Create             	| POST              	| /api/u/:user_uuid/homes       	|
| 2 	| Read               	| GET               	| /api/u/:user_uuid/:uuid       	|
| 3 	| Update             	| PUT               	| /api/u/:user_uuid/homes/:uuid 	|
| 4 	| Delete             	| DELETE            	| /api/u/:user_uuid/homes/:uuid 	|



### HTTP Requests

#### Anatomy of HTTP Request
![anatomy_request](https://github.com/FOdeks/terraform-beginner-bootcamp-2023/assets/99102643/dc0435fb-982a-449c-a28c-d53b4b21d04a)

#### Bearer Authentication

Bearer authentication (also called token authentication) is an HTTP authentication scheme that involves security tokens called bearer tokens. 

The name “Bearer authentication” can be understood as "give access to the bearer of this token."

The bearer token is a cryptic string, usually generated by the server in response to a login request. 

The client must send this token in the Authorization header when making requests to protected resources: `Authorization: Bearer <token>`

[Bearer Authentication](https://swagger.io/docs/specification/authentication/bearer-authentication/)



#### HTTP error codes
https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#client_error_responses

Our error codes:
custom aXXXX codes will help us isolate in our troubleshooting where an error may have occured. These are unique to this project and not something normally included. You want error codes to be kind of obfuscated in production environments to not give away to much information about what was wrong. Because we are learning here, these codes were implemented.

a1001 - token/code/access-code does not match

a1002 - user_uuid not passed in HTTP header

a1003 - token/code/acess-code and user_uuid

## Terratowns Mock Server

### Running the Web Server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for the web server is stored in the `terratowns_mock_server/server.rb` file.

## More Terraform

### Terraform CLI Config File
`.terraformrc` or `terraform.rc` file
- configures per-user settings for CLI behaviors, which apply across all Terraform working directories.

- In our project, this file tells TF the location of the code of our custom TF provider. 
[Config File}(https://developer.hashicorp.com/terraform/cli/config/config-file)

### Debugging Terraform
Terraform has detailed logs that you can enable by setting the `TF_LOG` environment variable to any value. Enabling this setting causes detailed logs to appear on `stderr`.

```bash
TF_LOG=DEBUG terraform init
```
[Debugging](https://developer.hashicorp.com/terraform/internals/debugging)
