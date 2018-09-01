class CreateDustbins < ActiveRecord::Migration[5.2]
  def change

    create_table :group_dustbin_relations do |t|
      t.references :group, index: true
      t.references :dustbin, index: true
      t.timestamps
    end

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
      t.timestamps
    end

    create_table :binlevels do |t|
      t.integer :level
      t.timestamps
    end

    create_table :dustbins do |t|
      t.string :code, null: false, default: ""
      t.string :name, null: false, default: ""
      t.string :address, null: false, default: ""
      t.decimal :longitude
      t.decimal :latitude
      t.references :binlevel, index: true
      t.references :area, index: true
      t.references :city, index: true
      t.references :state, index: true
      t.references :raspberrypi, index: true
      t.timestamps
    end
  end
end
