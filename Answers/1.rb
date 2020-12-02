def find_combo(arr, combo)
  arr.combination(combo).any? do |*nums|
    arr = nums[0]
    if arr.reduce(&:+) == 2020
      pp arr.reduce(&:*)
      break
    end
  end
end

arr = File.readlines('../Test_Data/1.txt').map { |x| x.gsub('\n', '').to_i }

find_combo(arr, 3)

# O(n^2) Example
#
# require 'set'
#
# def find_combo(arr, sum)
#   arr = arr.sort()
#   arr_length = arr.length - 1
#   (0..arr_length).each do |i|
#     s = Set.new
#     curr_sum = sum - arr[i]
#     ((i + 1)..arr_length).each do |j|
#         if s.include?(curr_sum - arr[j])
#           pp arr[i] * arr[j] * (curr_sum - arr[j])
#           return true
#         end
#       s.add(arr[j])
#     end
#   end
#   false
# end
#
# arr = File.readlines('../Test_Data/1.txt').map { |x| x.gsub('\n', '').to_i }
#
# find_combo(arr, 2020)
