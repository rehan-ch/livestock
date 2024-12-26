# frozen_string_literal: true

class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_one_attached :data
end
