# Create a graph table
class CreateGraphTable < ActiveRecord::Migration[7.0]
  def change
    create_table :graphs do |t|
      t.string :name, null: false
      t.string :original_file, null: false
      t.datetime :generated_at, null: false

      t.timestamps
    end
  end
end
