require 'test_helper'

class DisableEscapingTest < ActiveSupport::TestCase

  def teardown
    String.enable_rails_xss
  end

  test "disabling rails xss defaults html_safe? to true" do
    String.disable_rails_xss
    assert "hello".html_safe?
  end

  test "enabling rails xss has default html_safe? behavior" do
    String.enable_rails_xss
    assert !"hello".html_safe?
  end
  
  test "re-enabling rails xss has default html_safe? behavior" do
    String.disable_rails_xss
    String.enable_rails_xss
    assert !"hello".html_safe?
  end

end