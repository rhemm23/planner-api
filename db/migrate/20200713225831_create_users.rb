class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, index: { unique: true }
      t.text :password_digest

      t.timestamps
    end
  end
end
