module SqajobHelper
	def running?(sqajobname)
			#@sqajob = current_user.sqajobs.find_by(id: params[:id])
			#use ps -ef commend to ensure if this sqajob is running
			#use Open3 and get stdin, stdout from backend
			#stdin, stdout, stderr = Open3.popen3('ps -ef | grep ')
			#if stdout =~ //i 
			#	return true
			#end
		return false
	end

	def run_sqajob
		@sqajob = current_user.sqajobs.find_by(id: params[:id])
#		respond_to do |format|
#			format.html { redirect_to @sqajob }
#			format.js
#		end
#		require "open4"
# 		get exit status from Open4::popen4
#       status = Open4::popen4 "" 
	end

	def stop_sqajob
		@sqajob = current_user.sqajobs.find_by(id: params[:id])
#		respond_to do |format|
#			format.to { redirect_to @sqajob }
#			format.js
#		end
# =>  require"Open4" Open4::popen4
# =>  pid = ps -ef | grep sqajobname | awk 'print{$1 or $2}'
# =>  kill -9 pid
	end
end