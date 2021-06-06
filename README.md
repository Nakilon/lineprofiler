# Ruby line profiler

I'll publish it as a gem. Maybe. Later.

## Usage

```bash
ruby -r lineprofiler my_slow_program.rb
```

On exit it will print something like this:

```none
...
        best = nil
        prev_time = nil
88.97%  loop do
84.14%    combinations.each do |f, set|
48.97%      t = all.size.times.map do |i|
              [
                all[i].cls,
43.92%          all.values_at(*set-[i]).min_by{ |e| Math.s
              ]
            end
          end
 1.97%    combinations = pcbr.table.sort_by{ |_, _, score|
 1.97%      set.size.times.map do |i|
 1.31%        next if set.size < 3
 0.65%        next if pcbr.set.include? [f, key]
              [f, key]
            end
 2.60%    end.drop_while(&:empty?).first
          break if Time.now - prev_time > 10
...
```

If you pass a path to another source file (for example, some lib) in `LINEPROFILER` env var it will profile that file too:

```none
$ LINEPROFILER=lib/rasel.rb ruby -r../lineprofiler/lib/lineprofiler.rb constants_print.rb
...
constants_print.rb
  ...
lib/rasel.rb
  ...
```
