unless $gems_rake_task
  if Rails.version <= "2.3.6"
    $stderr.puts "rails_xss does not support Rails 2.3.6. Please upgrade to Rails 2.3.6.1 or later."
  else
    require 'rails_xss'
  end
end
