class RemoveBookTitleFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :book_title, :string
    remove_column :books, :image_id, :string
    remove_column :books, :description, :text
  end
end
