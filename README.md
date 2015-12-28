# Jekyll::Browserify

A browserify converter for Jekyll.

The runtime for `browserify` is installed automatically.

## Installation

Add this line to your application's Gemfile:

```ruby
group :jekyll_plugins do
  gem 'jekyll-browserify'
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jekyll-browserify

## Usage

~~~~~~~~~~~~~~~~~~~~~~~~~bash
$ cat main.js
---
---
console.log("foo");
$ jekyll build
$ cat _site/main.js
# ... conterted code ...
~~~~~~~~~~~~~~~~~~~~~~~~~

Add the below to `_config.yaml` if you want to use with [babel][]:

~~~~~~~~~~~~~~~~~~~~~~~~~~_config.yaml
# require `npm install -D browserify baberify babel-preset-es2015`

browserify:
  command: "$(npm bin)/browserify -t [ babelify --presets es2015 ]"
~~~~~~~~~~~~~~~~~~~~~~~~~~

### Confing items and Default Values

~~~~~~~~~~~~~~~~~~~~~~~~~yaml
# _config.yaml
browserify:
  exts: [".js"] # target exts to convert
  
  # set nvm properties if you want to use with nvm installed automatically
  nvm:
    
    # required modules
    modules: []
    
    # browserify option string
    option: ""
    
    # node version if you specify, or use '.nvmrc' if 'null'
    node_version: null

  # use installed 'browserify'
  command: "browserify -"
~~~~~~~~~~~~~~~~~~~~~~~~~

[babel]: https://github.com/babel/babelify

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jekyll-browserify. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

