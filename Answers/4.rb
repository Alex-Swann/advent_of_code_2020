arr, num = File.readlines('./Test_Data/4.txt', chomp: true).map(&:strip).join(" ").split("  "), 0

def check_range(start, finish, value)
  (start..finish).to_a.include? value.to_i
end

def check_ids(value)
  %i[amb blu brn gry grn hzl oth].include? value.to_sym
end

def check_hair(str)
  /^\#[0-9a-f]{6}$/.match? str
end

def check_passport(str)
  /^\d{9}$/.match? str
end

VALID = {
  byr: method(:check_range).curry.call(1920, 2002),
  iyr: method(:check_range).curry.call(2010, 2020),
  eyr: method(:check_range).curry.call(2020, 2030),
  hgt: {
    cm: method(:check_range).curry.call(150, 193),
    in: method(:check_range).curry.call(56, 76)
  },
  hcl: method(:check_hair),
  ecl: method(:check_ids),
  pid: method(:check_passport)
}

def validate(type, value)
  case type
  when :cid
    true
  when :hgt
    measurement = value.slice(-2, 2).to_sym
    value_m = value.slice(0, value.length - 2)
    VALID[type][measurement] && VALID[type][measurement].call(value_m)
  else
    VALID[type].call(value)
  end
end

def passes_validations(fields)
  fields.all? do |field|
    section = /(.*):(.*)/.match field
    type = section[1].to_sym
    value = section[2]

    validate(type, value)
  end
end

arr.each do |str|
  if VALID.keys.map(&:to_s).all? { |code| str.include? code }
    fields = str.split()
    num += 1 if passes_validations(fields)
  end
end

pp num
