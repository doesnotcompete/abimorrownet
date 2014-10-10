class CreateStudentRegistrations < ActiveRecord::Migration
  def change
    create_table :student_registrations do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :confirmed

      t.timestamps
    end
  end
end
