arr = File.readlines('./Test_Data/13.txt').map(&:strip)

# PART 1
earliest = arr[0].to_i
ids = arr[1].split(',').map { |id| id != 'x' ? id.to_i : nil }

times = ids.map do |id|
  if id
    time = 0
    id = id.to_i
    departures = []
    while time < earliest
      time += id
      departures << time
    end
    departures.max
  else
    []
  end
end

earliest_bus_time = times.flatten.min
min_index = times.find_index(earliest_bus_time)
earliest_bus_id = ids[min_index].to_i

pp earliest_bus_id * (earliest_bus_time - earliest)

# PART 2

buses_and_offsets = []
ids.each_with_index { |id, offset| buses_and_offsets << { id: id, offset: offset } if id }
buses_and_offsets.map! { |obj| { obj[:id] => obj[:offset] % obj[:id] } }

prod = buses_and_offsets.reduce(1) { |sum, obj| sum * obj.keys[0]  }

divs = buses_and_offsets.map { |obj| prod / obj.keys[0]  }

inverse = buses_and_offsets.each_with_index.map do |obj, i|
  total = 1
  total += 1 while ((total * divs[i] % obj.keys[0]) != 1)
  total
end

total = buses_and_offsets.each_with_index.reduce(0) do |sum, (obj, i)|
  times = (obj.keys[0] - obj.values[0]) * inverse[i]
  while times > 0
    sum = (sum + divs[i]) % prod
    times -= 1
  end
  sum
end

pp total
