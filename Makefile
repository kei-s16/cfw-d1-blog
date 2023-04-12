DB_NAME = blog
SCHEMA_DIR = ./schema
SCHEMA_FILE_SUFFIX = .sql
SCHEMA_FILES	:= $(wildcard $(SCHEMA_DIR)/*$(SCHEMA_FILE_SUFFIX))

seed:
	@$(foreach schema, $(SCHEMA_FILES), wrangler d1 execute $(DB_NAME) --file=$(schema) --local;)
	wrangler d1 execute $(DB_NAME) --command="select name from sqlite_master where type='table';" --local
