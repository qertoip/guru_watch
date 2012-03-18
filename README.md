# guru_watch

This application aims to serve as an example of __Use Case Driven Approach__
also known as __Entity-Control-Boundary__ architecture,
as explained by Robert C. Martin in his famous keynote
[Architecture: the Lost Years] (http://confreaks.com/videos/759-rubymidwest2011-keynote-architecture-the-lost-years).
The ambitious goal of the project is to gain benefits of framework isolation and use case approach
__without sacrificing what we all love in Ruby on Rails__.

## Big picture

                                                   |
                    Frontends                      | frameworks allowed (i.e. ActionPack, LimeLight GUI, Trolltop CLI)
                                                   |
     ----------------------------------------
                                                   |
          -------------      ------------          |
          | Use Cases |----->| Entities |          | frameworks outlawed
          -------------      ------------          |
                                                   |
     ----------------------------------------
                                                   |
                    Backends                       | frameworks allowed (i.e. ActiveRecord, DataMapper, redis-rb)
                                                   |

## The story

 * Architecture is not about frameworks and tools
 * Architecture is about __use cases__
 * Business logic should be isolated from frameworks
 * Business logic should be isolated from the frontend (delivery mechanism)
 * Business logic should be isolated from the backend (persistence mechanism)

That is, think in use cases, not in frameworks. Use frameworks but isolate from them.

## Real World Benefits

Don't miss the [real world benefits](https://github.com/qertoip/guru_watch/wiki/Real-World-Benefits) of this approach.

## Real World Concerns

Here I'll try to address [the concerns](https://github.com/qertoip/guru_watch/wiki/Real-World-Concerns) the proposed approach may raise.

## Example application

Guru Watch is a toy application which aims to put the theory into practice.

### Theme (what is this toy app about?)

> There are exceptional individuals who create exceptionally worthwile content.
> In such rare cases you do not want to miss any piece of wisdom they share.
> This app is dedicated to track and link whatever your gurus create.
>
> You choose your own Gurus (add, list, remove, etc). You link their Content. The benefit over using a notepad is that
> community will help you watch your guru by adding new resources you may have missed.


### Use Cases

#### Theory

Use cases encapsulate application-specific logic. Single use case represents a single meaningful action user can take in the system.

Use cases have nothing to do with the web. They are frontend agnostic.

#### Implementation

The use case is a PORO object derived from the __UseCase base class__. It has the #exec method.

The __Request__ represents input data of the use case. It's just an OpenStruct.

The __Response__ represents output data of the use case. It's also an OpenStruct.

Use cases live in __app/use\_cases/__

The base classes (UseCase, Request, Response) seem to be reusable across apps so I put them in the lib/use_case_api/ for now.

### Entities

#### Theory

Entities are business objects. They encapsulate business logic known to be reusable across all apps in the enterprise.
In practice I expect this "reusable business logic" to be mostly attributes and validations, not much more. Time will show.

Entities may or may not be persistent. Use them liberally to model your domain in an object-oriented fashion.

Entities __do not__ manage their persistence. In particular, they __do not__ derive from ActiveRecord::Base.

#### Implementation

The entity is a PORO object derived from the __Entity base class__.

The __Entity base class__ tries to give you convenience known from ActiveRecord models, like validations, mass assignment,
auto type casting and more. It does so by including ActiveModel and ActiveAttr modules.

Entities live in __app/entities/__

The __Entity base class__ seem to be reusable across apps so I put it in the lib/entities_api/ for now.

### Backends (persistence mechanisms)

#### Theory

Entity gateways implement persistence.

Use cases call entity gateways to persist and retrive objects.

You can think of entity gateways as adapters between what use cases need and what your persistence library (say ActiveRecord) has to offer.

Typically there is one gateway per entity per persistence mechanism. Don't be scared though. I'll show you how to use convention-over-configuration to avoid writing them, most of the time.

The backend groups all entity gateways for the particular persistence mechanism.

Use cases __do not__ hardcode a particular backend. Instead, backends are plugins.

#### Implementation

You certainly __do not__ want to sink in a mass of boilerplate code you never had to write before.

My present view is that we need a generic persistence API to be used in use cases.
This API should imply neither persistence framework nor database paradigm.
It could be similar to AREL minus the strictly-relational parts.
I called that "Ruby Persistence API". Remember, this is just an API, not the implementation.

Now, I work on the two implementations of this API:

 * RubyPersistenceAPI::ActiveRecord - adapter to ActiveRecord
 * RubyPersistenceAPI::ActiveMemory - in-memory ActiveRecord-like store for ultra fast tests

I started documenting [Ruby Persistence API here](https://github.com/qertoip/guru_watch/wiki/Ruby-Persistence-API).

Bear in mind the work has just began - it is nowhere near general usefulness.

(TBC)

### Frontends (delivery mechanisms)

#### Theory

Frontend translates user actions (i.e. HTTP request, keystrokes, mouse clicks, etc.) into the frontend-agnostict request.

Frontend calls the related use case passing it the request.

Fronted receives the response which can be used to deliver feedback to the user (i.e. show nice validation errors).

#### Implementation

Stock ActionPack.

## Stage of development

This is very early stage. You can barely create, list and edit your Gurus.

However:

 * the architecture is already clearly visible
 * the whole app is runnable
 * you can learn how to tear Rails apart and tie all those things together "the right way"

## Running the application

Web application is the only available frontend right now.

    ./s

At this early stage there is only one controller allowing you to manage your gurus.

## Running tests

To run all tests:

    ./t

Tu run specific tests see the list of available test tasks:

    bundle exec rake -T

### Choosen architectural issues in the current implementation

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

### Choosen todos

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
