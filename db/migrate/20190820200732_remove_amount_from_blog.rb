class RemoveAmountFromBlog < ActiveRecord::Migration[5.2]
  def change
    remove_column :blogs, :amount, :integer
  end
end
