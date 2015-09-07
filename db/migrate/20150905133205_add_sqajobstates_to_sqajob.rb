class AddSqajobstatesToSqajob < ActiveRecord::Migration
  def change
    add_column :sqajobs, :job_state, :string, default: 'notrun' # 4 states for sqajob running: notrun, running, stopped, rundone
  end
end
