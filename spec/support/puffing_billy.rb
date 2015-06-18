require 'billy/rspec'

# select a driver for your chosen browser environment
Capybara.javascript_driver = :selenium_billy # Uses Firefox
# Capybara.javascript_driver = :selenium_chrome_billy
# Capybara.javascript_driver = :webkit_billy
# Capybara.javascript_driver = :poltergeist_billy

#    Configure cache to behave as required. See all available options at:
#    https://github.com/oesmith/puffing-billy#caching
Billy.configure do |c|
  c.cache = true
  c.cache_request_headers = false
  c.persist_cache = true
  c.non_successful_cache_disabled = false
  c.non_successful_error_level = :warn

  # cache_path is where responses from external URLs will be saved as YAML.
  c.cache_path = "spec/support/http_cache/billy/"  

  # Avoid having tests dependent on external URLs.
  #
  # Only set non_whitelisted_requests_disabled **temporarily**
  # to false when first recording a 3rd party interaction. After
  # the recording has been stored to cache_path, then set
  # non_whitelisted_requests_disabled back to true.
  c.non_whitelisted_requests_disabled = false
end