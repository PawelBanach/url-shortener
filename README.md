# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## TODO

* CSV Export

* GeoLocation from request IP

* Schema of architecture

* Write Readme + Setup instructions

* Add index on `key`


## Architecture decisions

* 302 status used in order to support statistics.

* Postgres - Many read replicas, one write replica

* Base64 encoding used to generate short link, it gives 64 ** 8 possibilities, small chance of collision

* Consider expiring of links, in order to save DB space


