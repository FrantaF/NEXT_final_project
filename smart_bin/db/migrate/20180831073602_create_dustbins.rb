class CreateDustbins < ActiveRecord::Migration[5.2]
  def change

    create_table :states do |t|
      t.string :name
      t.timestamps
    end

    create_table :cities do |t|
      t.string :name
      t.references :state, index: true
      t.timestamps
    end

    create_table :areas do |t|
      t.string :name
      t.references :city, index: true
      t.references :state, index: true
      t.timestamps
    end

    create_table :fill_levels do |t|
      t.integer :level
      t.string :percentage
      t.string :description
      t.timestamps
    end

    create_table :dustbins do |t|
      t.string :code, null: false, default: ""
      t.string :name, null: false, default: ""
      t.string :address, null: false, default: ""
      t.decimal :longitude
      t.decimal :latitude
      t.references :fill_level, index: true
      t.datetime :last_collected
      t.references :area, index: true
      t.references :city, index: true
      t.references :state, index: true
      t.references :raspberrypi, index: true
      t.timestamps
    end
  end
end
