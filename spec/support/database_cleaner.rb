RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion, {:except => %w[spatial_ref_sys]}
    DatabaseCleaner.clean_with :truncation, {:except => %w[spatial_ref_sys]}
  end
end
