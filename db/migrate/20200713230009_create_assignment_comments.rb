class CreateAssignmentComments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignment_comments do |t|
      t.integer :assignment_id
      t.text :comment

      t.timestamps
    end
  end
end
