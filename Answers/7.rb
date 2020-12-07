arr = File.readlines('./Test_Data/7.txt').map(&:strip)

links = {}

arr.each do |line|
  parent = /\w+ \w+(?= bag)/.match(line)[0]
  children = line.scan(/([0-9]+) (\w+ \w+)(?= bag)/)
  links[parent] = {}

  children.each { |child| links[parent][child[1]] = child[0] }
end

levels = []
colours = links['shiny gold']
colours.update(colours) { |key, value| value.to_i }
levels << colours

def recursive_levels(colours, levels, links)
  interim = {}

  colours.keys.each do |colour|
    link = links[colour].clone
    link.update(link) { |key, value| value.to_i * colours[colour].to_i }
    interim = interim.merge(link) { |key, value1, value2| value1 + value2  }
  end

  levels << interim && recursive_levels(interim, levels, links) if interim.keys[0]
end

recursive_levels(colours, levels, links)

pp levels.map(&:values).flatten.reduce(&:+)
