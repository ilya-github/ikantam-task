# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Time::DATE_FORMATS[:ru_datetime] = '%d.%m.%Y в %H:%M:%S'
Rails.application.initialize!
