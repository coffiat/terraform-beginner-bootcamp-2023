# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

Bundler is a tool for managing Ruby application dependencies. Bundler is a package for rubby. It is the primary way to install ruby packages (known as germs) for ruby.

#### Install Gems

In your Ruby project, you create a file named Gemfile where you specify the gems your project depends on and their versions. This file serves as a manifest of your project's dependencies.
You need to create a gemfile and define your gems in that file.

```rd
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'

```

Then you need to run the `bundle install` command. Which will install the gems on the system globally ( Unlike nodejs which install packeges in folder called node_modules )

A Gemfile.lock will be created to lock down the gem versions used in the project.

#### Executing ruby scripts in the context of bundler

We have to use bundler exec to tell future ruby scripts to use the germs we installed. This is the way we set content.

#### Sinatra

Sinatra is a lightweight Web application framework for the Ruby programming language.

It is great for mock or development servers or for very simple projects. You can create a web-server in a single file.

[sinatra](https://sinatrarb.com/)

## Terratowns Mock Server

### Running the web server

We can run the web-server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.