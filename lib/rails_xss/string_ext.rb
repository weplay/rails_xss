ActiveSupport::SafeBuffer.class_eval do
  def concat(value)
    if value.html_safe?
      super(value)
    else
      super(ERB::Util.h(value))
    end
  end
  alias << concat
end
