class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :address
      t.string :city
      t.string :state
      t.string :postcode
      t.string :country
      t.string :phone_number
      t.string :profile_photo
      t.timestamps
    end
  end
end
