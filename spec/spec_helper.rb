# frozen_string_literal: true

require "money"
require "rspec"
require "faker"
require "factory_bot"
require_relative "../config/config"

require "require_all"
require_all "lib/models/"
require_all "lib/presenters/"
require_all "lib/pricing_rules/"
require_all "lib/repositories/"
require_all "lib/services/"

# Load support files and factories
Dir["./spec/support/**/*.rb"].each { |f| require f }
Dir["./spec/factories/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryBot::Syntax::Methods
end
