require 'erb'

class ERB
  module Util

    def html_escape(s)
      s = s.to_s
      if s.html_safe? && String.rails_xss_enabled?
        s
      else
        s.gsub(/[&"><]/) { |special| HTML_ESCAPE[special] }.html_safe
      end
    end

    undef :h
    alias h html_escape

    module_function :html_escape
    module_function :h
    
    def h_if_xss_enabled(s)
      if String.rails_xss_enabled?
        h(s)
      else
        s
      end
    end

    module_function :h_if_xss_enabled

  end
end