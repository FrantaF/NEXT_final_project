class CreateDustbinStats < ActiveRecord::Migration[5.2]
  def change
    create_table :dustbin_stats do |t|
      t.references :dustbin, index: true
      t.references :fill_level, index: true
      t.timestamps
    end

    create_table :user_dustbin_assignments do |t|
      t.references :user, index: true
      t.references :dustbin, index: true
      t.timestamps
    end

  end
end
