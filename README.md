# guru_watch

Robert Cecil Martin AKA Uncle Bob says Ruby on Rails programmers are doing the architecture wrong:

[Keynote: Architecture the Lost Years] (http://confreaks.com/videos/759-rubymidwest2011-keynote-architecture-the-lost-years)

[Screeming Architecture] (http://blog.8thlight.com/uncle-bob/2011/09/30/Screaming-Architecture.html)

[Clean Code Episode VII - Architecture, Use Cases, and High Level Design] (http://www.cleancoders.com/codecast/clean-code-episode-7/show) [12$]

This toy application is an __experiment__ on how to do it right. This is a very early stage of development.

## According to Uncle Bob

 * Architecture is __not__ about frameworks and tools
 * Architecture is about __use cases__
 * Architecture should not depend on frameworks
 * Architecture should not depend on frontend (delivery mechanism)
 * Architecture should not depend on backend (persistence mechanism)

That is, while frameworks, frontend, and backend are obviously necessary,
architecture should be isolated from them.

## Running application

__Web__ application is the only available frontend right now.

    bundle exec unicorn app/frontends/web/config.ru

## Running tests

    bundle exec rake test

## License

Released under the MIT license. Copyright (C) 2012 Piotr 'Qertoip' Włodarek.
