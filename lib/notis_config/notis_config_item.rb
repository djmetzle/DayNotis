class NotisConfigItem
	attr_reader :hour
	attr_reader :minute

	attr_reader :title
	attr_reader :level
	attr_reader :body

	def initialize(time, obj)
		raise "No title set for #{time.to_s}" if not obj["title"]
		@title = obj["title"]

		@level = obj["level"] ? obj["level"] : "notice"
		@body = obj["body"] ? obj["body"] : ""

		parseTime(time)
	end

	private
	# use "military" style four digit 24 hour time strings
	def parseTime(time)
		str = time.to_s.rjust(4, "0")
		@hour = str[0..1].to_i
		@minute = str[2..3].to_i
	end
end
