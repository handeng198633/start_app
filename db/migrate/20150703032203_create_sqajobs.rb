class CreateSqajobs < ActiveRecord::Migration

  def change
    create_table :sqajobs do |t|
      t.string :jobname
      t.text :case_group
      t.string :gversion
      t.string :nversion
      t.string :gbuild
      t.string :nbuild
      t.string :gsrfile
      t.string :genv
      t.string :nenv
      t.string :case_list_file
      t.integer :slotthread
      t.integer :user_id

      t.timestamps
    end
    add_index :sqajobs, [:user_id, :created_at]
  end
end
