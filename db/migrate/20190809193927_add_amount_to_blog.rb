class AddAmountToBlog < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :amount, :integer
  end
end
