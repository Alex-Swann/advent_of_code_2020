arr = File.readlines('./Test_Data/12.txt').map(&:strip)

arr.map! { |coords| [coords.slice!(0,1).to_sym, coords.to_i] }

waypoint = {
  N: 1,
  E: 10,
  S: 0,
  W: 0
}

compass = {
  N: 0,
  E: 0,
  S: 0,
  W: 0
}

def rotate_point(waypoint, value)
  dirs = waypoint.keys
  values = waypoint.values
  value.abs.times { values = value > 0 ? values.unshift(values.pop) : values << values.shift }
  waypoint = Hash[dirs.zip values]
end

def move_waypoint(waypoint, dir, value)
  opp_dirs = {
    N: :S,
    E: :W,
    S: :N,
    W: :E
  }

  while value > 0
    waypoint[opp_dirs[dir]] > 0 ? waypoint[opp_dirs[dir]] -= 1 : waypoint[dir] += 1
    value -= 1
  end

  waypoint
end

arr.each do |move|
  type = move[0]
  value = move[1]

  case type
  when :L, :R
    rots = value / 90
    rots *= -1 if type == :L
    waypoint = rotate_point(waypoint, rots)
  when :F
    amount = {}
    waypoint.each { |dir, dist| amount[dir] = dist * value }
    compass = compass.merge(amount){ |k, a_value, b_value| a_value + b_value }
  else
    waypoint = move_waypoint(waypoint, type, value)
  end
end

pp (compass[:N] - compass[:S]).abs + (compass[:W] - compass[:E]).abs
