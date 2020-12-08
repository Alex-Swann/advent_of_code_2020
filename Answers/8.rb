arr = File.readlines('./Test_Data/8.txt').map(&:strip).map(&:split)

arr.each_with_index do |line, line_index|
  acc = 0
  program_index = 0
  parsed_indices = []
  program = arr.clone
  run = true

  case line[0]
  when 'jmp'
    program[line_index] = ['nop', line[1]]
  when 'nop'
    program[line_index] = ['jmp', line[1]]
  else
    run = false
  end

  while run
    break if parsed_indices.include? program_index
    if !program[program_index]
      pp acc
      break
    end

    parsed_indices << program_index

    code = program[program_index]
    instruction = code[0]
    amount = code[1].to_i

    case instruction
    when 'acc'
      acc += amount
      program_index += 1
    when 'jmp'
      program_index += amount
    else
      program_index += 1
    end
  end
end
