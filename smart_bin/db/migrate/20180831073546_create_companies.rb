class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, null: false, default: ""
      t.string :detail, null: false, default: ""
      t.timestamps
    end

    create_table :companies do |t|
      t.string :name, null: false, default: ""
      t.string :address1, null: false, default: ""
      t.string :address2
      t.string :phone_number1, null: false, default: ""
      t.string :phone_number2
      t.timestamps
    end
  end
end
