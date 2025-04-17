class CreateWords < ActiveRecord::Migration[8.0]
  def change
    create_table :words do |t|
      t.string :word
      t.string :definition

      t.timestamps
    end
  end
end
