class Users < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |s|
      s.string :username
      s.string :email
      s.string :password_digest
    end
  end
end
