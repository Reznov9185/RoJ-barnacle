require 'dynamoid'

if Jets.env != 'development'
  Dynamoid.configure do |config|
  config.namespace = 'webhooks'
  config.access_key = ENV['ACCESS_KEY_ID']
  config.secret_key = ENV['SECRET_ACCESS_KEY']
  config.region = ENV['REGION']
  end
  Dynamoid.included_models.each { |m| m.create_table(sync: true) }
else
  # For dynamo in development env
  Dynamoid.configure do |config|
    config.endpoint = 'http://localhost:8000'
    config.namespace = 'webhooks'
    config.access_key = 'fakeMyKeyId'
    config.secret_key = 'fakeSecretAccessKey'
  end
  Dynamoid.included_models.each { |m| m.create_table(sync: true) }
end


