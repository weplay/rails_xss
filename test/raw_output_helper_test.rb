require 'test_helper'

class RawOutputHelperTest < ActionView::TestCase

  def setup
    @string = "hello"
  end

  def teardown
    String.enable_rails_xss
  end

  test "raw returns the safe string" do
    result = raw(@string)
    assert_equal @string, result
    assert result.html_safe?
  end

  test "raw handles nil values correctly" do
    assert_equal "", raw(nil)
  end

  test "autoescape escapes within block" do
    String.disable_rails_xss
    autoescape do
      buffer = ActiveSupport::SafeBuffer.new << "<script>"
      assert_equal "&lt;script&gt;", buffer
    end
  end
  test "autoescape returns to previously disabled state" do
    String.disable_rails_xss
    autoescape do
      "foo"
    end
    buffer = ActiveSupport::SafeBuffer.new << "<script>"
    assert_equal "<script>", buffer
  end
  test "autoescape returns to previously enabled state" do
    autoescape do
      "foo"
    end
    buffer = ActiveSupport::SafeBuffer.new << "<script>"
    assert_equal "&lt;script&gt;", buffer
  end
end