def count_words(filename)

  result = {}                       #create new hash table
  file = File.open(filename, "r")   #read the contain of textfile and store in file
  file.each_line do |line|          #loop through each line
    words = line.split(/\W+/)       #parse the line into words
    words.each do |word|
      word = word.gsub(/[,.;:()'"]/,'').downcase.sub(/\w/){$&.downcase} #substitutes ,()'" for a white space and convert to downcase
      if result[word]               #increment the corresponding count in hash table
        result[word] += 1
      else
        result[word] = 1
      end
    end                             #end word loop
  end                               #end line loop

#Uncomment to sort them by values
=begin
  puts "Word are sorted by values:"
  result.sort {|a,b| a[1] <=> b[1]}.each do |key,value|
    puts "#{key} => #{value}"
  end
=end

#Uncomment to sort them by most used words
=begin
  puts "Words are sorted by most frequently used:"
  result.sort {|a,b| b[1] <=> a[1]}.each do |key,value|
    puts "#{key} => #{value}"       #return hash table
  end
=end


#Uncomment to sort them by most used words and
#only print out the ones that come up more than 5 times
#=begin
  puts "The following words occurred more than 5 times in the document source:"
  result.sort {|a,b| b[1] <=> a[1]}.each do |key,value|
    puts "#{key} => #{value}" if value > 5      #return hash table
  end
#=end

#Uncomment to sort them alphabetically
=begin
  puts "Words are sorted alphabetically:"
  result.sort_by {|key, value| key}.each do |key,value|
    puts "#{key} => #{value}"       #return hash table
  end
=end

end

#use longer test
count_words('testLonger.txt')

#Uncomment to use short test
#count_words('test.txt')
