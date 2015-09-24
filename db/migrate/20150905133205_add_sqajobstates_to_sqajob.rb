class AddSqajobstatesToSqajob < ActiveRecord::Migration
  def change
    add_column :sqajobs, :job_state, :string, default: 'notrun' # 6 states for sqajob running: notrun, waiting, running, stopped, rundone,timeout
  end
end
