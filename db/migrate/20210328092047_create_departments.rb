class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.string     :name,     null: false
      t.integer    :parent_id

      t.timestamps
    end
  end
end
