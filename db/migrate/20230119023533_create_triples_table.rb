# Create a table to store triples
class CreateTriplesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :triples do |t|
      t.string :subject, index: true, null: false
      t.string :object, null: false
      t.string :predicate, null: false

      t.belongs_to :graph, index: true
    end
  end
end
