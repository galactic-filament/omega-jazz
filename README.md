# omega-jazz

[![Build Status](https://travis-ci.org/galactic-filament/omega-jazz.svg?branch=master)](https://travis-ci.org/galactic-filament/omega-jazz)
[![Coverage Status](https://coveralls.io/repos/github/galactic-filament/omega-jazz/badge.svg?branch=master)](https://coveralls.io/github/galactic-filament/omega-jazz?branch=master)

## Libraries

Kind | Name
--- | ---
Web Framework | [Sinatra](http://sinatrarb.com/)
SQL ORM | [ActiveRecord](www.rubydoc.info/gems/activerecord)
Logging | stdlib
Test Framework | [Minitest](http://docs.seattlerb.org/minitest/)
Test Coverage | [Simplecov](https://github.com/colszowka/simplecov)
Password encryption | [bcrypt-ruby](https://github.com/codahale/bcrypt-ruby)
User authentication | [Warden](https://github.com/hassox/warden)

## Features Implemented

- [x] Hello world routes
- [x] CRUD routes for persisting posts
- [x] Database access
- [x] Request logging to /srv/app/log/app.log
- [x] Unit tests
- [x] Unit test coverage reporting
- [x] Automated testing using TravisCI
- [x] Automated coverage reporting using Coveralls
- [x] CRUD routes for user management
- [x] Password encryption using bcrypt
- [x] Routes protected by cookie session
- [x] Entities linked to logged in user
- [ ] Routes protected via HTTP authentication
- [ ] [Linting](https://github.com/bbatsov/rubocop)
- [ ] Logging to file
- [ ] Logging to Telegraf
- [ ] Routes protected via ACLs
- [ ] Migrations
- [ ] [GraphQL endpoint](https://medium.com/@awin/graphql-server-with-sinatra-ruby-part-1-fdd664170715)
- [x] Validates environment (env vars, database host and port are accessible)
