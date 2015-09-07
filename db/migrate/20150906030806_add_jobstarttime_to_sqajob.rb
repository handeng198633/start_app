class AddJobstarttimeToSqajob < ActiveRecord::Migration
  def change
    add_column :sqajobs, :starttime, :datetime
  end
end
