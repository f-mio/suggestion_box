class CreateUserDepartmentsRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_departments_relations do |t|
      t.references :user,         null: false, foreign_key: true
      t.references :department,   null: false, foreign_key: true
      t.boolean    :is_manager,   null: false
      t.boolean    :is_root_user, null: false

      t.timestamps
    end
  end
end
