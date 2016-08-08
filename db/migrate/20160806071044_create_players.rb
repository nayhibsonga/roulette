class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :last_name
      t.integer :age
      t.integer :money

      t.timestamps
    end
  end
end
