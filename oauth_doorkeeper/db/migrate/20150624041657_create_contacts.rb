class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
