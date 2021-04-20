PROJECT := health-tracker

default: usage
usage:
	bin/makefile/usage

rubocop_fix_all:
	bundle exec rubocop -A .

prettier_ruby:
	bin/makefile/prettier-ruby

.PHONY: build
build:
	bin/makefile/full-build

# .PHONY: pg_init
# pg_init:
#	initdb tmp/postgres -E utf8

# .PHONY: pg_start
# pg_start:
# 	pg_ctl -D tmp/postgres -l tmp/postgres/logfile start

# .PHONY: pg_stop
# pg_stop:
# 	pg_ctl -D tmp/postgres stop -s -m fast

d.PHONY: deploy
deploy:
	RAILS_MASTER_KEY=`cat config/master.key` \
		HEROKU_APP_NAME=stg-health-tracker \
		SCHEME=http \
		HOST=stg-health-tracker.herokuapp.com \
		PORT=80 \
		bin/makefile/heroku-create
