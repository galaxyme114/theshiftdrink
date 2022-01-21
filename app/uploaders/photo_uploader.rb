# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include ::CarrierWave::Backgrounder::Delay

  def store_dir
    "uploads/#{model.issue.role.pluralize.downcase}/articles/#{model.article_id}/photos/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg png pdf)
  end

  def filename
    "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  protected
    def secure_token(length=16)
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
    end
end
