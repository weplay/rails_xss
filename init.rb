if ActionPack::VERSION::STRING == "2.3.6"
  raise "rails_xss does not support Rails 2.3.6. Please upgrade to Rails 2.3.6.1 or later."
end

unless $gems_rake_task
  require 'rails_xss/plugin'
end
