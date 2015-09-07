class CreateSqajobstatuses < ActiveRecord::Migration
  def change
    create_table :sqajobstatuses do |t|
      t.integer :sqajob_id

      t.timestamps
    end
  end
end
