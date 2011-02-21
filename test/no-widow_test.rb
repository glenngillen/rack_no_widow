$:.unshift(File.expand_path(File.dirname(__FILE__)))
require "test_helper"

class NoWidowTest < Test::Unit::TestCase

  def test_adds_non_breaking_space
    after_html = process_html("<h1>This is a heading</h1>", Rack::NoWidow)
    assert_html_equal "<h1>This is a&amp;nbsp;heading</h1>", after_html
  end

  def test_doesnt_add_if_non_breaking_space_already_exists
    after_html = process_html("<h1>This is a&nbsp;heading</h1>", Rack::NoWidow)
    assert_html_equal "<h1>This is a&nbsp;heading</h1>", after_html
  end

  def test_doesnt_add_non_breaking_space_to_short_heading
    after_html = process_html("<h1>It's a heading</h1>", Rack::NoWidow)
    assert_html_equal "<h1>It's a heading</h1>", after_html
  end

  def test_handles_nested_tags
    after_html = process_html("<h1><a href='/'>This is a heading</a></h1>", Rack::NoWidow)
    assert_html_equal "<h1><a href='/'>This is a&nbsp;heading</a></h1>", after_html
  end

  def test_handles_nested_tags_with_staggered_closings
    after_html = process_html("<h1><a href='/'>This is a </a>heading</h1>", Rack::NoWidow)
    assert_html_equal "<h1><a href='/'>This is a&nbsp;</a>heading</h1>", after_html
  end
end
