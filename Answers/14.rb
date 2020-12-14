arr = File.readlines('./Test_Data/14.txt').map(&:strip)
mask_mems = []

mask_obj = {}

arr.each_with_index do |line, index|
  mask = /^mask/.match(line)
  if mask
    mask_mems << mask_obj if mask_obj.keys[0]

    mask_obj = { key_values: [] }
    mask_value = /(.){36}$/.match(arr[index])[0]
    mask_obj[:mask] = mask_value
  else
    nums = line.scan(/\d+/)
    mask_obj[:key_values] << { nums[0] => nums[1] }
    mask_mems << mask_obj if !arr[index + 1]
  end
end

values = ''
36.times { values << '0' }

memory_values = []

mask_mems.each do |mask_mems_obj|
  mask_chars = mask_mems_obj[:mask].clone.chars
  key_values = mask_mems_obj[:key_values].clone

  key_values.each do |obj|
    bit_num = obj.keys[0].to_i.to_s(2).rjust(36, ?0)

    bit_num = bit_num.chars.map.with_index do |bit_char, bit_index|
      case mask_chars[bit_index]
      when '1'
        '1'
      when '0'
        bit_char
      else
        'X'
      end
    end.join

    floating_indices = bit_num.chars.each_index.select { |i| bit_num[i] == 'X' }

    [0, 1].repeated_permutation(floating_indices.size).each do |bits|
      adjusted_bit_num = bit_num.clone
      bits.zip(floating_indices) { |bit, i| adjusted_bit_num[i] = bit.to_s }
      memory_values << { adjusted_bit_num.to_i(2) => obj.values[0].to_i }
    end
  end
end

memory_values = memory_values.flat_map(&:entries)
  .group_by(&:first)
  .map{|k,v| Hash[k, v.map(&:last)[-1]]}

pp memory_values.map { |obj| obj.values[0] }.reduce(:+)
