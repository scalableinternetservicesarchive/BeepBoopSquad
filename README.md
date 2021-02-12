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

Commands
```
eb init --keyname $(whoami) \
  --platform "64bit Amazon Linux 2018.03 v2.11.0 running Ruby 2.6 (Puma)" \
  --region us-west-2 BeepBoopSquad
  
eb create --envvars RAILS_SKIP_ASSET_COMPILATION=false --envvars SECRET_KEY_BASE=BADSECRET \
  -db.engine postgres -db.i db.t3.micro -db.user u \
  -i t3.micro --single BeepBoopSquad
```