# gem lineprofiler

## Usage

```bash
gem install lineprofiler
```
```bash
ruby -r lineprofiler my_slow_program.rb
```

On exit it will print something like this:

```none
...
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
...
```

or like this:

```none
...
94.58%  items.group_by{ |x,y,| (px-x).abs + (py-y).abs }...
 0.49%    puts "dist: #{d}"
          add = g.flat_map(&:last).sort
          until add.empty?
            acc.replace acc | add
93.63%      a, b = all.partition do |id, rec|
55.88%        unless (rec & add).empty?
24.51%          if (rec - acc).empty?
13.24%            (puts "#{id} = #{rec.join " + "}"; true)
                end
...
```

By default it reports only about the main file -- `$0`, but you can pass a path to another source file (for example a library dependency that your program calls often) as a `LINEPROFILER` env var so it will print it too afterwards:

```none
$ LINEPROFILER=lib/rasel.rb ruby -rlineprofiler constants_print.rb
...
constants_print.rb
  ...  
lib/rasel.rb
  ...
```
