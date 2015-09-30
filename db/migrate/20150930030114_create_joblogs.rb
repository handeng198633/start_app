class CreateJoblogs < ActiveRecord::Migration
  def change
    create_table :joblogs do |t|
      t.string :content
      t.integer :sqajob_id

      t.timestamps
    end
    add_index :joblogs, [:sqajob_id, :created_at]
  end
end
