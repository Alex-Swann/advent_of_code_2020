arr, total = File.readlines('./Test_Data/6.txt', chomp: true).map(&:strip).join(" ").split("  "), 0

arr.each do |group|
  group = group.split.map { |answer| answer.chars }
  common = group.shift
  common &= group.shift while group[0] && common[0]
  total += common.length
end

pp total
