arr = File.readlines('./Test_Data/9.txt').map(&:strip).map(&:to_i)
refresh_list = arr.clone

preamble = 25
preamble_numbers = arr.slice!(0, preamble)

while arr[0]
  num = arr.shift
  sums = []
  preamble_numbers.combination(2) { |x, y| sums << x + y }
  break if !sums.include? num

  preamble_numbers.shift
  preamble_numbers << num
end

invalid_number = num

refresh_list.each_with_index do |value, index|
  nums = []

  while nums.reduce(0, :+) < invalid_number
    nums << refresh_list[index]
    index += 1
  end

  if nums.reduce(0, :+) == invalid_number
    pp nums.min + nums.max
    break
  end
end
