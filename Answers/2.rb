arr = File.readlines('../Test_Data/2.txt').map { |x| x.gsub(/\n/, '') }

i = 0

arr.each do |str|
  matches = str.scan(/[^\s]+/)
  ranges = matches[0].scan(/\d+/).map(&:to_i)
  letter = matches[1].gsub(':', '')
  text = matches[2]

  times_appears = text.scan(/(?=#{letter})/).count

  i += 1 if (ranges[0]..ranges[1]).include?(times_appears)
end

p i
