# guru_watch

This application aims to be example of __Entity-Control-Boundary__ architecture
also known as __Use Case Driven__ approach,
as explained by Robert C. Martin (Uncle Bob) in his famous keynote
[Architecture the Lost Years] (http://confreaks.com/videos/759-rubymidwest2011-keynote-architecture-the-lost-years)

## The story

 * Architecture is not about frameworks and tools
 * Architecture is about __use cases__
 * Architecture should be isolated from frameworks
 * Architecture should be isolated from a frontend (delivery mechanism)
 * Architecture should be isolated from a backend (persistence mechanism)

That is, while frameworks, frontend, and backend are obviously necessary,
architecture should be isolated from them.

## Running the application

__Web__ application is the only available frontend right now.

    bundle exec unicorn app/frontends/web/config.ru

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

 * The web app itself.

## License

Released under the MIT license. Copyright (C) 2012 Piotr 'Qertoip' Włodarek.
