arr, total = File.readlines('./Test_Data/6.txt').map(&:strip).join(' ').split('  '), 0

arr.each do |group|
  group = group.split.map(&:chars)
  common = group.shift
  common &= group.shift while group[0] && common[0]
  total += common.length
end

pp total
