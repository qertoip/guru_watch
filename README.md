# guru_watch

This application aims to serve as an example of __Use Case Driven Approach__
also known as __Entity-Control-Boundary__ architecture,
as explained by Robert C. Martin in his famous keynote
[Architecture: the Lost Years] (http://confreaks.com/videos/759-rubymidwest2011-keynote-architecture-the-lost-years).
The ambitious goal of the project is to gain benefits of framework isolation and use case approach
__without sacrificing what we all love in Ruby on Rails__.

## The story

 * Architecture is not about frameworks and tools
 * Architecture is about __use cases__
 * Architecture should be isolated from frameworks
 * Architecture should be isolated from a frontend (delivery mechanism)
 * Architecture should be isolated from a backend (persistence mechanism)

That is, while frameworks, frontend, and backend are obviously necessary,
architecture should be isolated from them.

## Real world benefits

* solves models obesity problem
    * there is now obvious place to put (hundreds?!) of your User model methods:
        * the User use cases
* much faster functional and unit tests
    * isolation from ActiveRecord allows you to plug memory-based persistence backend
    * enjoy true TDD without hacky workarounds
* easier to upgrade frameworks
    * ActiveRecord 3.2 has different API than ActiveRecord 2.3
    * thanks to isolation you have to change code only in one place - the adapter
* easier to remove frameworks
    * remember searchlogic?
        * [Lament 1] (https://github.com/binarylogic/searchlogic/issues/155)
        "Please help me in searchlogic for rails 3.1.1. my whole application using searchlogic. I dont know what i do now its not working with Rails 3.1.1. can you people help us its work for rails 3.1.1 and above..."
        * [Lament 2] (https://github.com/binarylogic/searchlogic/issues/153)
        "when rails 3.1 compatibility?!"
* easier to plug frontends other than DHTML, i.e.:
      * functional tests
      * rake tasks
      * API (services)
      * CLI (command line interface)
      * GUI (fat)
      * Voice UI?
      * Thoughts UI?
* easier to migrate to the other relational database
      * MySQL <-> PostgreSQL <-> Oracle
* easier to migrate to a completely different database paradigm
      * Relational <-> Document-oriented <-> Object-oriented <-> Flat-files <-> ActiveResource? <-> ruby-git?? <-> and what not
* easier to swap MVC framework
      * since controllers are thinner than ever and use cases are encapsulated in, well, UseCases, it's easier to swap between MVC frameworks like ActionPack and Sinatra


## Running the application

Web application is the only available frontend right now.

    bundle exec unicorn app/frontends/web/config.ru

At this early stage there is only one controller allowing you to manage your gurus.

## Running tests

    bundle exec rake test

## Choosen architectural issues in the current implementation

 * Controllers depend on concrete use cases instead of use case interfaces.
   This prevents controllers from being tested in isolation from the application.
   Instead of hard coding concrete use case classes controllers should probably
   use an abstract factory.
 * Entities are not 100% "web" free.
   They include ActiveModel::Conversions module which adds #to_param method.
   Instead, this module should probably be included on the fly by a Presenter
   into the singleton class of the data structure which represents the said
   Entity in a ResponseModel.
 * Entities leak into the controller and views.
   ResponseModel references them, pretending they are data structures.

## Choosen todos

 * Implement active record backend.
 * Make log/test.log work.
 * Make RAILS_ENV work.
 * Non-rails code reloading.
 * Make rails rake tasks available.
 * Easier web app starting.

And of course...

 * Most of the web app itself.

## License

Released under the MIT license. Copyright (C) 2012 Piotr 'Qertoip' Włodarek.
