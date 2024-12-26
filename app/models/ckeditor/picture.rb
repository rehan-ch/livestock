# frozen_string_literal: true

class Ckeditor::Picture < Ckeditor::Asset
  has_one_attached :data
end
