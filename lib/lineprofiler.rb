profile = []
Thread.abort_on_exception = true
Thread.new do
  loop do
    profile.push Thread.main.backtrace_locations.map{ |loc| [loc.absolute_path, loc.lineno] }
    sleep 0.01
  end
end
END {
  File.foreach($0).with_index do |line, i|
    v = profile.count do |bt|
      bt.include? [File.expand_path($0), i + 1]
    end.fdiv(profile.size).round(4) * 100
    puts "%-8s%s" % [("%5.2f%%" % v unless v.zero?).to_s, line[0,50]]
  end
}
