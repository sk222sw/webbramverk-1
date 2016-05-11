class AddPasswordToCreators < ActiveRecord::Migration
  def change
    add_column :creators, :password_digest, :string
  end
end
