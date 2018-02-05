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

## Features Implemented

- [x] Hello world routes
- [x] CRUD routes for persisting posts
- [x] Database access
- [x] Request logging to /srv/app/log/app.log
- [x] Unit tests
- [x] Unit test coverage reporting
- [x] Automated testing using TravisCI
- [x] Automated coverage reporting using Coveralls
- [ ] CRUD routes for user management
- [ ] Password encryption using bcrypt
- [ ] Routes protected via HTTP authentication
- [ ] Routes protected via ACLs
- [x] Validates environment (env vars, database host and port are accessible)
