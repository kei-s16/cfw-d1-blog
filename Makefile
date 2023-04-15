#!/usr/bin/env make

export NO_D1_WARNING := true

DB_NAME = blog

SCHEMA_DIR = ./schema
SCHEMA_FILE_SUFFIX = .sql
SCHEMA_FILES	:= $(sort $(wildcard $(SCHEMA_DIR)/*$(SCHEMA_FILE_SUFFIX)))

SEEDER_DIR = ./seeder
SEEDER_FILE_SUFFIX = .sql
SEEDER_FILES	:= $(sort $(wildcard $(SEEDER_DIR)/*$(SEEDER_FILE_SUFFIX)))

init: npm migrate
migrate: init-db seed-db
check: check-tables check-articles

npm:
	npm ci

init-db:
	@$(foreach schema, $(SCHEMA_FILES), npx wrangler d1 execute $(DB_NAME) --file=$(schema) --local;)

check-tables:
	npx wrangler d1 execute $(DB_NAME) --command="select name from sqlite_master where type='table';" --local

seed-db:
	@$(foreach schema, $(SEEDER_FILES), npx wrangler d1 execute $(DB_NAME) --file=$(schema) --local;)

check-articles:
	npx wrangler d1 execute $(DB_NAME) --command="select * from articles;" --local
	npx wrangler d1 execute $(DB_NAME) --command="select * from tags;" --local
	npx wrangler d1 execute $(DB_NAME) --command="select * from tagging;" --local

serve:
	npx wrangler dev --local --persist
