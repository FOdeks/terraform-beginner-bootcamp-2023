# Terraform Beginner Bootcamp 2023
## Week 2 - Launching and Connection Terrahome to TerraTowns
### Programming Languages
- **Ruby** used for web development
- **Sinatra** is a Domain-Specific Language for quickly creating web applications in Ruby
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
- [Terratowns Mock Server](#terratowns-mock-server)
  - [Running the Web Server](#running-the-web-server)
- [CRUD](#crud)

## Working with Ruby

### Bundler

Bundler is a package manager for ``Ruby``. It is the primary way to install Ruby packages (known as gems) for Ruby.

#### Installing Gems

You need to create a Gemfile and define your ``gems`` in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command.

This will install the gems on the system globally (unlike .nodejs which install packages in place in a folder called node_modules).

A ``Gemfile.lock`` will be created to lock down the gem versions used in the project.

#### Executing Ruby scripts in the context of Bundler

We have to use `bundle exec` to tell future Ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra

Sinatra is a micro web-framework for Ruby to build web apps. It is great for mock or development servers or for very simple projects.

You can create a web server in a single file.

[Sinatra](https://sinatrarb.com/)

## Terratowns Mock Server

### Running the Web Server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for the web server is stored in the `server.rb` file.

## CRUD

Terraform Provider resources utilize CRUD.

CRUD stands for Create, Read, Update, and Delete.

[CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)


Provider Physical Diagram
![provider_physical_diagram](https://github.com/FOdeks/terraform-beginner-bootcamp-2023/assets/99102643/7fd68fef-97f0-43ad-8ad0-dbb60d21e663)


Anatomy of HTTP Request
![anatomy_request](https://github.com/FOdeks/terraform-beginner-bootcamp-2023/assets/99102643/dc0435fb-982a-449c-a28c-d53b4b21d04a)

