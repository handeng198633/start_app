require 'open3'
class RunSqajobJob < ActiveJob::Base
  queue_as :specialqa_job

  before_perform do |sqajob|
    @sqajob = sqajob
    @sqajob.updatejobstate('running')
  end

  after_perform do |sqajob|
    @sqajob = sqajob
    #After perform, need do: 1.get unitQA web link 2.if it timeout? 3.update database for this job(rundone or timeout)
#    if 
#      @sqajob.updatejobstate('rundone')
#      @sqajob.jobresult = 'web link'
#    else
#      @sqajob.updatejobstate('timeout')
#    end
  end

  around_perform do |sqajob, block|
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
    @sqajob = sqajob
#    Open3.popen3('/nfs/sjorhqa128-1.data/qa/WEB_BIN/SQA/bin/build_CMD' + @sqajob.jobname)
    sleep 10
#    Open3.popen3('/nfs/sjorhqa128-1.data/qa/WEB_BIN/SQA/JOBS/SQJ_peter_20150924115930')
  end
end

#RunSqajobJob.perform_later record