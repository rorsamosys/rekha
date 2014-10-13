# Configure Spree Preferences
require 'spree/product_filters'
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to override the default site name.
  config.site_name = 'Cdn Online Shop'
  config.admin_interface_logo = "/assets/cdn-logo.jpg" 
  config.logo = "/assets/cdn-logo.jpg" 
  config.allow_ssl_in_development_and_test = false
end

Spree.user_class = "Spree::User"

SpreeI18n::Config.available_locales = [:en, :es,:ru, :'pt-BR'] # displayed on translation forms
SpreeI18n::Config.supported_locales = [:en, :es,:ru, :'pt-BR'] # displayed on frontend select box
