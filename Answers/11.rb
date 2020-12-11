arr, changes = File.readlines('./Test_Data/11.txt').map(&:strip).map(&:chars), true

def deep_clone(arr)
  Marshal.load(Marshal.dump(arr))
end

def count_items(arr)
  counts = Hash.new(0)
  arr.each { |seat| counts[seat] += 1 }
  counts
end

def process_seats(arr, row_index, area_index)
  seats = []
  directions = ['tl', 't', 'tr', 'l', 'r', 'bl', 'b', 'br']

  directions.each do |direction|
    ri = row_index
    ai = area_index
    sq = '.'

    while sq == '.'
      ri -= 1 if direction.include? 't'
      ri += 1 if direction.include? 'b'
      ai -= 1 if direction.include? 'l'
      ai += 1 if direction.include? 'r'
      sq = ai >= 0 && ri >= 0 && arr[ri][ai] rescue false
    end

    seats << sq if sq
  end

  seats
end

updated_arr = deep_clone(arr)

while changes
  changes = false
  arr = deep_clone(updated_arr)

  arr.each_with_index do |row, row_index|
    row.each_with_index do |area, area_index|

      seats = process_seats(arr, row_index, area_index)

      case area
      when 'L'
        if !seats.include? '#'
          changes = true
          updated_arr[row_index][area_index] = '#'
        end
      when '#'
        too_many_occupied = count_items(seats)['#'] > 4

        if too_many_occupied
          changes = true
          updated_arr[row_index][area_index] = 'L'
        end
      else
      end
    end
  end
end

pp count_items(updated_arr.flatten)['#']
