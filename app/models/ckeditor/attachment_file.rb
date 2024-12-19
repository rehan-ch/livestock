# frozen_string_literal: true

class Ckeditor::AttachmentFile < Ckeditor::Asset
  # mount_uploader :data, CkeditorAttachmentFileUploader, mount_on: :data_file_name
  has_one_attached :data
  # def url_thumb
  #   @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  # end
end
