class AddJobIdToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :job_id, :integer
    add_index :candidates, :job_id
  end
end
