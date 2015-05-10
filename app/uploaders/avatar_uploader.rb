# encoding: utf-8

class AvatarUploader < BaseUploader

  process :resize_to_fill => [200, 300]

end