arr, current_jolt = File.readlines('./Test_Data/10.txt').map(&:strip).map(&:to_i).sort, 0
refresh_arr = arr.clone

jolt_range = (1..3).to_a

device_joltage_rating = arr.max + 3

JOLT_DIFF = {
  1 => 0,
  2 => 0,
  3 => 1
}

while arr[0]
  next_jolt = arr.shift
  JOLT_DIFF[next_jolt - current_jolt] += 1
  current_jolt = next_jolt
end

pp JOLT_DIFF[1] * JOLT_DIFF[3]

# PART 2

all_adapters = refresh_arr.concat([0, device_joltage_rating]).sort
adapters_length = all_adapters.length
combos = [1] + [0] * (adapters_length - 1)

(1...adapters_length).each do |i|
  total = 0

  ((i - 3)...i).each do |j|
    if all_adapters[i] <= (all_adapters[j] + 3)
      total += combos[j]
    end
  end

  combos[i] = total
end

pp combos[-1]
