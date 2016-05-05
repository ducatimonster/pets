class DropEmployeeSkillsTable < ActiveRecord::Migration
  def up
    drop_table :employee_skills
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
