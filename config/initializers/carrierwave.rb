CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAZABFYN2IBYO5HMWB',
    :aws_secret_access_key  => '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',
    :region                 => 'us-west-2',
  }
	config.asset_host 	 = "https://d2y1ry8g49t2dy.cloudfront.net"
  config.fog_directory = ( Rails.env.production? ) ? 'theshiftdrink' : 'theshiftdrink'
  config.fog_public    = true
end

unless Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false if Rails.env.test?
  end
else
  CarrierWave.configure do |config|
    config.storage = :fog
    config.enable_processing = true
  end
end
