class CreateEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :evaluations do |t|
      t.references :suggestion,        null: false, foreign_key: true
      t.integer    :evaluation_score,  null: false
      t.text       :comment,           null: false
      t.integer    :user_id,           null: false
      t.references :parent_department, null: false

      t.timestamps
    end
  end
end
