require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)

  thing = HashMap.new(string.length)
  string.chars.each do |ch|
    if thing[ch]
      thing[ch] = (thing[ch] + 1) % 2
    else
      thing[ch] = 1
    end
  end


  sum = 0
  thing.each do |pair|
    sum += pair[1]
  end
  if string.length.odd?
    return sum == 1
  else
    return sum == 0
  end
end
