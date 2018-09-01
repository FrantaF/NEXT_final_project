class CreateRaspberrypis < ActiveRecord::Migration[5.2]
  def change
    create_table :raspberrypis do |t|
      t.string :pi_name
      t.string :pi_type
      t.string :ip_address
      t.string :mac_address
      t.bigint :memory_size
      t.string :spec1
      t.string :spec2
      t.string :spec3
      t.timestamps
    end
  end
end
