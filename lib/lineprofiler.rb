profile = []
Thread.new do
  loop do
    profile.push Thread.main.backtrace_locations.map{ |loc| [loc.absolute_path, loc.lineno] }
    sleep 0.01
  end
end
END {
  require "io/console"
  [$0, *ENV["LINEPROFILER"]].each do |filename|
    puts filename
    File.foreach(filename).with_index do |line, i|
      v = profile.count do |bt|
        bt.include? [File.expand_path(filename), i + 1]
      end.fdiv(profile.size).round(4) * 100
      puts "%-8s%s" % [("%5.2f%%" % v unless v.zero?).to_s, line[0, IO.console.winsize[1]-10]]
    end
    puts ""
  end
  puts ""
}
