require 'test_helper'

class RailsXssTest < ActiveSupport::TestCase

  def teardown
    String.enable_rails_xss
  end

  test "ERB::Util.h should mark its return value as safe and escape it" do
    escaped = ERB::Util.h("<p>")
    assert_equal "&lt;p&gt;", escaped
    assert escaped.html_safe?
  end

  test "ERB::Util.h should leave previously safe strings alone " do
    # TODO this seems easier to compose and reason about, but
    # this should be verified
    escaped = ERB::Util.h("<p>".html_safe)
    assert_equal "<p>", escaped
    assert escaped.html_safe?
  end

  test "ERB::Util.h should not implode when passed a non-string" do
    assert_nothing_raised do
      assert_equal "1", ERB::Util.h(1)
    end
  end

  test "ERB::Util.h should always escape when rails_xss disabled" do
    String.disable_rails_xss
    escaped = ERB::Util.h("<p>")
    assert_equal "&lt;p&gt;", escaped
    assert escaped.html_safe?
  end
end
