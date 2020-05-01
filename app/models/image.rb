class Image < ActiveRecord::Base
  attr_accessor :file_file_name
  attr_accessor :file_content_type
  mount_uploader :file, ImageUploader
end
