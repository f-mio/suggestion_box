class CreateParentDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :parent_departments do |t|
      t.references :evaluation,           null: false, foreign_key: true
      t.string     :result,               null: false
      t.text       :comment,              null: false
      t.integer    :user_id,              null: false
      t.integer    :parent_department_id, null: false

      t.timestamps
    end
  end
end
