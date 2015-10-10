class AddJobresultToSqajob < ActiveRecord::Migration
  def change
    add_column :sqajobs, :jobresult, :string
  end
end
