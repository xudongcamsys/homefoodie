# encoding: utf-8

class BaseUploader < CarrierWave::Uploader::Base

  # Create different versions of your uploaded files:
  version :tiny do
    process :resize_to_fill => [20, 20]
  end
  version :small do
    process :resize_to_fill => [30, 30]
  end
  version :profile do
    process :resize_to_fill => [45, 45]
  end

end
