module JoblogHelper
	def log2html_before(line)
		line = line.gsub(/.\[\[7;31;49m/, 'RED')
		line = line.gsub(/.\[\[7;32;49m/, 'GREEN')
		line = line.gsub(/.\[\[7;36;49m/, 'CYAN')
		line = line.gsub(/.\[\[0;49m/, 'END')
		return line	
	end

	def log2html_after(line)
		line = line.gsub(/RED/, '<span style="color:red">')
		line = line.gsub(/GREEN/, '<span style="color:green">')
		line = line.gsub(/CYAN/, '<span style="color:cyan">')
		line = line.gsub(/END/, '</span>')
		return line		
	end
end