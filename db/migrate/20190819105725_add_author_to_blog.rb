class AddAuthorToBlog < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :author, :string
  end
end
