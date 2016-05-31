puts ARGV

person = Hash.new

person[:name] = ARGV[0]
person[:age] = ARGV[1].to_i
person[:status] = ARGV[2]

puts person