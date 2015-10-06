class RunSqajobJob < ActiveJob::Base
  queue_as :sqajob_queue

  around_perform do |job, block|
    # do something before perform
    block.call
    # do something after perform
    #After perform, need do: 1.get unitQA web link 2.if it timeout? 3.update database for this job(rundone or timeout)
  end

  rescue_from(ActiveRecord::RecordNotFound) do |exception|
   # do something with the exception
  end
 
  def perform(sqajob)
    # Do something later
    @sqajob.run!(sqajob)
  end
end

RunSqajobJob.perform_later record