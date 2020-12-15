obj = {
  16 => [1, [1]],
  11 => [1, [2]],
  15 => [1, [3]],
  0 => [1, [4]],
  1 => [1, [5]],
  7 => [1, [6]]
}

previous_answer = obj.keys[-1]
turn = 7

while turn <= 30000000

  if obj[previous_answer][0] == 1
    obj[0][0] += 1
    obj[0][1] = [obj[0][1][-1], turn]
    previous_answer = 0
  else
    previous_turns = obj[previous_answer][1]
    diff = previous_turns[1] - previous_turns[0]

    if !obj[diff]
      obj[diff] = [1, [turn]]
    else
      obj[diff][0] += 1
      obj[diff][1] = [obj[diff][1][-1], turn]
    end
    previous_answer = diff
  end

  turn += 1
end

pp previous_answer
