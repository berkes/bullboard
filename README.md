# bullboard

Bullboard is used to explain Event Sourcing.

## Product and domain

A simple investment porfolio checker.

Invsteing is a well-known domain, one that we can find a lot of
expertise for online. It is also not too familiar: we don't want yet
another Event Sourcing explained with a shopping-cart or order-shipping.
Let's explore a new domain! Lets solve some real world constraints and
practical issues too.

## The Tutorial

* [ ] Introduction
* [ ] Hello World: Event Sourcing is simple
* [ ] No framework: Tools, and structure
* [ ] Storing events: All state is derived from these stored events
* [ ] [sidestep] a CLI interface
* [ ] [sidestep] TDD and BDD
* [ ] Aggregates: modeling our domain
* [ ] DDD: structuring the code
* [ ] [sidestep] hexagonal
* [ ] Projections
* [ ] Workflows or Reactors
* [ ] Event sourced, event driven and event state transfer https://martinfowler.com/articles/201701-event-driven.html
* [ ] CQRS and eventual consistency
* [ ] Snapshots: Performance

## Features

Porfolio tracker for long term investors: stocks, crypto, real-estate.

* Dashboard shows market value, returns montly, year and -total, purchasing value, dividend, amount
    of positions.
* Diversification shows companies, industries, types and geography.
* Positions shows market value, returns montly, year and -total, purchasing value, dividend of each individual position.
* Dividend shows yield and total and yearly contribution per position.

* Online data from APIs and exchanges can be fetched.

## Tech

Uses Ruby, because of the expressiveness, accessability and Object
Orientation.
But Event Sourcing can be applied in any language, and in many
paradigms, even functional programming. We just don't want to "muddy the
water" by explaining unrelated toolchains, languages, paradigms.

### No frameworks

We focus on paradigms and want to learn the basics, not how to use a
framework. I tried to make it even language-independent, but that makes
it too vague, so there *is* a depedency on Ruby and there are libraries
(called gems, in Ruby) used.

Or, as [Dave Farley puts it](https://youtu.be/X99Be8wJBMI?t=243)

> Be Cautious of frameworks[...]
> By definition a framework imposes structure on our code. That tends to
> lock you in.[...]
> [...] to keep the core of your code free of any framework-dependencies.
