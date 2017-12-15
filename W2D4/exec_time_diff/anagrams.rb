def first_anagram?(word1, word2)
  # 'he' => 'he', ,'eh'
  # 'hey' => 'hey', 'hye', 'ehy', 'eyh', 'yhe', 'yeh'
  # 'heck' => 'heck', 'hekc', 'hcek', hcke', 'hkec', 'hkce', etc etc
  word1_perm = word1.chars.permutation(word1.length).to_a

  first_res = word1_perm.map {|el| el.join('')}
  return true if first_res.include?(word2)
  false
end

# time complexity: O(n!)

def second_anagram?(word1, word2)
  return false if word1.length != word2.length
  word1 = word1.chars
  word2 = word2.chars
  until word1.empty?
    first_char = word1[0]
    res = word2.index(first_char)
    if res
      word1.shift
      word2.delete_at(res)
    else
      return false
    end
  end
  true
end

# O(n^2)


def third_anagram?(word1, word2)
  word1.chars.sort == word2.chars.sort
end

def fourth_anagram?(word1, word2)
  hash1 = Hash.new(0)
  hash2 = Hash.new(0)
  word1.chars.each do |ch|
    hash1[ch] += 1
  end
  word2.chars.each do |ch|
    hash2[ch] += 1
  end

  hash1.keys.each do |key|
    return false if hash2[key] != hash1[key]
  end
  true
end
