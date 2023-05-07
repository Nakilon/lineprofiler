profile = []
Thread.new do
  loop do
    profile.push Thread.main.backtrace_locations.map{ |loc| [loc.absolute_path, loc.lineno] }
    sleep 0.01
  end
end
END {
  require "io/console"
  ([File.expand_path($0), *ENV["LINEPROFILER"]] - %w{-e}).each do |filename|
    puts filename
    report = File.foreach(filename).map{ |line| [line, 0] }
    profile.each do |bt|
      bt.each do |path, lineno|
        report[lineno - 1][1] += 1 if File.expand_path(filename) == path
      end
    end
    report.each do |line, v|
      v = v.fdiv(profile.size).round(4) * 100
      puts "%-8s%s" % [("%5.2f%%" % v unless v.zero?).to_s, line[0, IO.console.winsize[1]-10]]
    end
    puts ""
  end
  puts ""
}
