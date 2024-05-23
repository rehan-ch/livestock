class CreateBlogs < ActiveRecord::Migration[7.1]
  def change
    create_table :blogs, id: :uuid do |t|
      t.string   :title
      t.text     :body,              limit: 16777215
      t.integer  :status,            default: 0
      t.datetime :published_at
      t.string   :tag_keywords
      t.text     :short_description, limit: 65535
      t.string   :meta_title
      t.text     :meta_keywords,     limit: 65535
      t.text     :meta_description,  limit: 65535
      t.string   :slug,              null: false

      t.timestamps
    end

    add_index :blogs, :slug, unique: true
  end
end