DB_NAME = blog
SCHEMA_DIR = ./schema
SCHEMA_FILE_SUFFIX = .sql
SCHEMA_FILES	:= $(wildcard $(SCHEMA_DIR)/*$(SCHEMA_FILE_SUFFIX))

seed:
	@$(foreach schema, $(SCHEMA_FILES), npx wrangler d1 execute $(DB_NAME) --file=$(schema) --local;)
	npx wrangler d1 execute $(DB_NAME) --command="select name from sqlite_master where type='table';" --local
