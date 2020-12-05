arr = File.readlines('./Test_Data/5.txt', chomp: true)

def split_first_half(arr)
  start = arr[0]
  last = arr[arr.length / 2 - 1]
  (start..last).to_a
end

def split_last_half(arr)
  start = arr[arr.length / 2]
  last = arr[-1]
  (start..last).to_a
end

COORDS = {
  F: method(:split_first_half),
  B: method(:split_last_half),
  L: method(:split_first_half),
  R: method(:split_last_half)
}

ids = []

arr.each do |seat|
  plane_rows = (0..127).to_a
  plane_columns = (0..7).to_a

  while seat.length > 0
    char = seat.slice!(0, 1).to_sym

    case char
    when :F, :B
      plane_rows = COORDS[char].call(plane_rows)
    else
      plane_columns = COORDS[char].call(plane_columns)
    end
  end

  id = plane_rows[0] * 8 + plane_columns[0]
  ids << id
end

ids = ids.sort
list_range = (ids[0]..ids[-1]).to_a

pp (ids - list_range | list_range - ids)[0]
