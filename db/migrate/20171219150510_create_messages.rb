class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :rsaid
      t.text :message

      t.timestamps
    end
  end
end
