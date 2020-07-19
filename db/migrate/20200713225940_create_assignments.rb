class CreateAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments do |t|
      t.integer :course_id
      t.string :title
      t.text :description
      t.datetime :due_date

      t.timestamps
    end
  end
end
