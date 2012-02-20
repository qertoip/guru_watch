# guru_watch

Robert C. Martin (Uncle Bob) says Ruby on Rails programmers are doing the architecture wrong:

[Keynote: Architecture the Lost Years] (http://confreaks.com/videos/759-rubymidwest2011-keynote-architecture-the-lost-years)

[Screeming Architecture] (http://blog.8thlight.com/uncle-bob/2011/09/30/Screaming-Architecture.html)

[Clean Code Episode VII - Architecture, Use Cases, and High Level Design] (http://www.cleancoders.com/codecast/clean-code-episode-7/show) [12$]

This toy application is an __experiment__ on how to do it inline with Ivar Jacobsons and Robert C. Martins recommendations.

## According to Uncle Bob

 * Architecture is __not__ about frameworks and tools
 * Architecture is about __use cases__
 * Architecture should not depend on frameworks
 * Architecture should not depend on a frontend (delivery mechanism)
 * Architecture should not depend on a backend (persistence mechanism)

That is, while frameworks, frontend, and backend are obviously necessary,
architecture should be isolated from them.

## Running the application

__Web__ application is the only available frontend right now.

    bundle exec unicorn app/frontends/web/config.ru

## Running tests

    bundle exec rake test

## Choosen architectural issues in the current implementation

 * Entities are not completely "web" free.
   For example they include ActiveModel::Conversions module which adds #to_param method.
   Instead, this module should probably be included on the fly by a Presenter
   into the singleton class of the data structure which represents the said
   Entity in a ResponseModel.
 * Entities leak into the controller and views.
   ResponseModel references them, pretending they are data structures.
 * Controllers depend on concrete use cases instead of use case interfaces.
   This prevents controllers from being tested in isolation from the application.
   Instead of hard coding concrete use case classes controllers should probably
   use an abstract factory.

## Choosen todos

 * Implement auto-type-casting for entity attributes so they can be initialized
   with a hash of strings. So it feels like an ActiveRecord model.
 * Implement strong typing for the memory backend.
 * Implement active record backend.

## License

Released under the MIT license. Copyright (C) 2012 Piotr 'Qertoip' Włodarek.
