class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.string     :name,              null: false
      # 管理職
      t.integer    :user_id,           null: false, foreign_key: true
      t.references :parent_department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
