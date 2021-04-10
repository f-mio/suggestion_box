class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.references :evaluation,           null: false, foreign_key: true
      t.integer    :result_list_id,       null: false, foreign_key: true
      t.text       :comment,              null: false
      t.integer    :user_id,              null: false, foreign_key: true
      t.integer    :parent_department_id, null: false

      t.timestamps
    end
  end
end
