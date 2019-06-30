class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :date_submitted

      t.timestamps
    end
  end
end
