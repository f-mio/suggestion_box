class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string     :name,     null: false
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
