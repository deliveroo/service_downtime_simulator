test:
	bundle exec rspec

publish:
	bundle exec gem build *.gemspec
	-bundle exec gem push *.gem
	rm *.gem

lint:
	bundle exec rubocop

.PHONY: test publish lint
