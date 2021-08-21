<h1 align="center">Health Tracker</h1>

<div align="center">

[![CircleCI](https://circleci.com/gh/failure-driven/health-tracker.svg?style=svg)](https://circleci.com/gh/failure-driven/health-tracker)

</div>

Health Tracker - track all the health

# Setup

use the make file to setup and run the tests

```
brew bundle
make
make setup
make build
```

populate your database with some data

```
make demo-data
```

run the development server

```
rails server
bin/webpack-dev-server
open http://localhost:3000
```

