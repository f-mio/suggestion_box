class CreateSuggestions < ActiveRecord::Migration[6.0]
  def change
    create_table :suggestions do |t|
      t.string     :title,        null: false
      t.text       :issue,        null: false
      t.text       :ideal,        null: false
      t.references :category,     null: false
      t.integer    :location_id,  null: false
      t.integer    :place_id,     null: false
      t.string     :target,       null: false
      t.text       :effect,       null: false
      t.references :user,         null: false
      t.references :department,   null: false

      t.timestamps
    end
  end
end
