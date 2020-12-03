arr = File.readlines('./Test_Data/3.txt', chomp: true)

def count_trees(map, right, down)
  counter = 0
  x_pos = 0
  row_num = 0
  row_length = map[0].length

  map.each do |row|
    if row_num % down == 0
      counter += 1 if row[x_pos] == '#'
      x_pos = (x_pos + right) % row_length
    end
    row_num += 1
  end

  counter
end

matrix = [[1,1], [3,1], [5,1], [7,1], [1,2]]
matrix.map! { |coords| count_trees(arr, coords[0], coords[1]) }
pp matrix.reduce(&:*)
