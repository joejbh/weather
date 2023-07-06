class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :address
      t.string :city, null:false
      t.string :state, null:false
      t.string :zip, null:false
      t.string :ip_address

      t.timestamps
    end
  end
end
