require 'test_helper'

class Jekyll::BrowserifyTest < Minitest::Test

  system "npm install"

  def test_that_it_has_a_version_number
    refute_nil ::Jekyll::Browserify::VERSION
  end

  def test_it_matches_js_files
    b = Jekyll::Converters::Browserify.new(
      "browserify" => {
        "exts" => [".js"],
      }
    )
    assert b.matches(".js")
    assert b.matches(".JS")
    refute b.matches(".md")
  end

  def test_it_convert_js_source
    code = "console.log('foo');"
    b = Jekyll::Converters::Browserify.new(
      "browserify" => {
        "command" => "$(npm bin)/browserify -"
      }
    )

    result = b.convert(code)

    assert_match code, result
    refute_equal code, result
  end

  def test_it_convert_js_source_with_nvm
    code = "console.log('foo');"
    b = Jekyll::Converters::Browserify.new(
      "browserify" => {
        "nvm" => {
          "node_version" => "stable",
        }
      }
    )

    result = b.convert(code)

    assert_match code, result
    refute_equal code, result
  end

  def test_it_convert_js_source_with_modules_and_nvm
    code_fragment = "console.log('foo');"
    code = "() => #{code_fragment}"
    b = Jekyll::Converters::Browserify.new(
      "browserify" => {
        "nvm" => {
          "modules" => ["babelify", "babel-preset-es2015"],
          "option" => "-t [ babelify --presets es2015 ]",
          "node_version" => "stable",
        }
      }
    )

    result = b.convert(code)

    assert_match code_fragment, result
    refute_match code, result
  end
end
