install:
	bundle install

test:
	bundle exec rspec

publish:
	bundle exec gem build *.gemspec
	-bundle exec gem push *.gem
	rm *.gem

lint:
	bundle exec rubocop

.PHONY: install test publish lint
