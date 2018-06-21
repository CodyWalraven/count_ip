

#using method manually for now instead of from class
def valid_v4?(addr)
  if /\A(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\Z/ =~ addr
    return $~.captures.all? {|i| i.to_i < 256}
  end
  return false
end


file_path = ARGV[0] || "file.log"
WORDS_COUNT = {}
file = File.open(file_path, "r") 

puts "Indexing #{file_path}"

file.each_line do |line|
  words = line.split 
    for i in 0...words.length do
      string = words[i]
      if string.length > 7
        string = string[0...-6]
      end
      words[i] = string
    end
  
  words.each do |word|
    word = word.gsub(/[,()'"]/,'')
    if valid_v4?(word)
      word = word
    else
      word = ""
    end
    if WORDS_COUNT[word]
      WORDS_COUNT[word] += 1
    else
      WORDS_COUNT[word] = 1
    end
  end
end
#
puts "Indexed #{file_path}"

puts "Words count: "

WORDS_COUNT.sort {|a,b| a[1] <=> b[1]}.each do |key,value|
  puts "#{key} => #{value}"
end

puts "The end. "