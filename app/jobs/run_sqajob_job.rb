require 'open3'
class RunSqajobJob < ActiveJob::Base
  queue_as :specialqa_job

#  before_perform do |sqajob|
#    @sqajob = sqajob
#    @sqajob.jobstate = 'running'
#    @sqajob.save
#  end

#  after_perform do |sqajob|
#    @sqajob = sqajob
    #After perform, need do: 1.get unitQA web link 2.if it timeout? 3.update database for this job(rundone or timeout)
#    if true
#       @sqajob.jobstate = 'rundone'
#       @sqajob.jobresult = 'http://sjorhqa128-1.ansys.com:8000/file:///projs00/qa/unitQA/qa_web_fix_total/index.html'
#       @sqajob.save
#    else
#       @sqajob.jobstate = 'timeout'
#       @sqajob.save
#    end
#  end

  rescue_from(ActiveRecord::RecordNotFound) do |exception|
   # do something with the exception
  end

  def perform(sqajob)
    # Do something later
    @sqajob = sqajob

    @sqajob.updatejobstate('running')

#   Open3.popen3('/nfs/sjorhqa128-1.data/qa/WEB_BIN/SQA/bin/build_CMD -n ' + @sqajob.jobname + ' -v ' + @sqajob.nversion + ' -a ' + @sqajob.gversion + ' -g ' + @sqajob.case_group.join(",") + ' -s ' + @sqajob.slotthread.to_s + ' -b ' + @sqajob.nbuild + ' -c ' + @sqajob.gbuild)
    sleep 30
    Open3.popen3('/nfs/sjorhqa128-1.data/qa/WEB_BIN/SQA/JOBS/' + @sqajob.jobname)

    while not File.exist?("/data/qa/WEB_BIN/SQA/DONE/#{@sqajob.jobname}") do
        if Sqajob.where(id: @sqajob.id).take.jobstate == 'stopped'
            break #also can use Kernel.exit!
        else
            sleep 60
        end
    end

    if Sqajob.where(id: @sqajob.id).take.jobstate == 'stopped'
           #maybe some operations 
    elsif true
           @sqajob.jobstate = 'rundone'
           @sqajob.jobresult = "http://sjorhqa128-1.ansys.com:8000/file:///nfs/sjorhqa128-1.data/qa/WEB_BIN/SQA/WEBS/#{@sqajob.nversion}.#{@sqajob.jobname}/qa_web_fix_total/index.html"
           @sqajob.save
    elsif false
           @sqajob.jobstate = 'timeout'
           @sqajob.save
    end
  end
end