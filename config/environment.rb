# Load the Rails application.
require_relative 'application'

app_env_vars = File.join(Rails.root, '.env')
load(app_env_vars) if File.exists?(app_env_vars)

# Initialize the Rails application.
Rails.application.initialize!
