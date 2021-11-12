CMD_PREFIX=bundle exec
TEST_FILES_PATTERN ?=

.PHONY: all test lint clean setup ruby packages preprocess run

all: test lint

test: export APP_ENV=test
test:
	$(CMD_PREFIX) ruby -I lib:test:. -e "Dir.glob('$(TEST_FILES_PATTERN)') { |f| require(f) }"
lint:
	$(CMD_PREFIX) rubocop
lint-fix:
	$(CMD_PREFIX) rubocop -a