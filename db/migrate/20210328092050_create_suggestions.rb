class CreateSuggestions < ActiveRecord::Migration[6.0]
  def change
    create_table :suggestions do |t|
      t.string     :title,        null: false
      t.text       :issue,        null: false
      t.text       :ideal,        null: false
      t.integer    :category_id,  null: false, foreign_key: true
      t.integer    :location_id,  null: false, foreign_key: true
      t.integer    :place_id,     null: false, foreign_key: true
      t.string     :target,       null: false
      t.text       :effect,       null: false
      t.references :user,         null: false, foreign_key: true
      t.references :department,   null: false, foreign_key: true
      t.boolean    :writable,     null: false

      t.timestamps
    end
  end
end
