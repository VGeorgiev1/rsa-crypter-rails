class CreateRsas < ActiveRecord::Migration[5.1]
  def change
    create_table :rsas do |t|
      t.integer :d
      t.integer :e
      t.integer :n

      t.timestamps
    end
  end
end
