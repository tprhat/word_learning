class CreateStats < ActiveRecord::Migration[8.0]
  def change
    create_table :stats do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :round
      t.integer :guess_id
      t.integer :correct_id
      t.string :game_id
      t.integer :current_points

      t.timestamps
    end
  end
end
