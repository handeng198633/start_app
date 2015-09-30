class AddLognameToJoblogs < ActiveRecord::Migration
  def change
    add_column :joblogs, :jobname, :string
  end
end
