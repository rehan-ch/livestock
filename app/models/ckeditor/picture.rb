# frozen_string_literal: true

class Ckeditor::Picture < Ckeditor::Asset
  has_one_attached :data
  # mount_uploader :data, CkeditorPictureUploader, mount_on: :data_file_name
  #
  # def url_content
  #   url(:content)
  # end
end
