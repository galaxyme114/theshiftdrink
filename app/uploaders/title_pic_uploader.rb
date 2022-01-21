# encoding: utf-8

class TitlePicUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
	include ::CarrierWave::Backgrounder::Delay

  version :original do
    resize_to_limit(1200, 630)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
