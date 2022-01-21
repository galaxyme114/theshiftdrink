# encoding: utf-8

class ThumbnailUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
	include ::CarrierWave::Backgrounder::Delay

  	version :original do
  		process :crop
  		resize_to_limit(945, 630)
  	end

	def crop
		manipulate! do |img|
			x = img[:width] - 945
			y = img[:height] - 630
			w = 945
			h = 630

			img.crop("#{w}x#{h}+#{x}+#{y}")
		end
	end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
