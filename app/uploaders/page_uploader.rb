# encoding: utf-8

class PageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include ::CarrierWave::Backgrounder::Delay
  
  # after_store :delete_empty_dirs

  def store_dir
    "uploads/#{model.issue.role.pluralize.downcase}/articles/#{model.article_id}/pages/#{model.id}"
  end

  version :large do
    resize_to_limit(1536, 2048)
  end

  version :small do
    resize_to_limit(264, 460)
  end

  version :thumb do
    process :crop
    resize_to_limit(560, 290)
  end
  
  def crop
    resize_to_limit(750, 998)
    
    manipulate! do |img|
      x = ( model.crop_x ) ? model.crop_x.to_i : 0
      y = ( model.crop_y ) ? ( model.crop_y.to_i * 2.375 ): 0
      w = ( model.crop_w ) ? model.crop_w.to_i + 433 : img[:width]
      h = ( model.crop_h ) ? model.crop_h.to_i + 240 : 415

      img.crop("#{w}x#{h}+#{x}+#{y}")
    end
  end

  def extension_white_list
    %w(jpg jpeg png pdf gif)
  end

  def delete_empty_dirs
    path = File.expand_path(store_dir, root)
    Dir.rmdir(path)
  rescue
    true
  end
end