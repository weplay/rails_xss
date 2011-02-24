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
    buffer = ActiveSupport::SafeBuffer.new
    autoescape do
      buffer << "<script>"
    end
    assert_equal "&lt;script&gt;", buffer
  end

  test "disabled xss protection before and after autoescape" do
    String.disable_rails_xss
    autoescape do
      "foo"
    end
    buffer = ActiveSupport::SafeBuffer.new << "<script>"
    assert_equal "<script>", buffer
  end

  test "enabled xss protection before and after autoescape" do
    autoescape do
      "foo"
    end
    buffer = ActiveSupport::SafeBuffer.new << "<script>"
    assert_equal "&lt;script&gt;", buffer
  end

  test "nesting autoescapes all unsafe strings in block" do
    String.disable_rails_xss
    buffer = ActiveSupport::SafeBuffer.new
    autoescape do
      buffer << "<script>"
      autoescape do
        buffer << "<script>"
      end
      buffer << "<script>"
    end
    assert_equal "&lt;script&gt;&lt;script&gt;&lt;script&gt;", buffer
  end
end