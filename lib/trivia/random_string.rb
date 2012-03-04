# -*- coding: UTF-8 -*-

class RandomString

  ALPHABET = [('a'..'z').to_a, ('A'..'Z').to_a, 'ąćęłńóśżźĄĆĘŁŃÓŚŻŹ'.split].flatten

  def self.generate(size = 6)
    (1..size).inject("") { |s, x| s << ALPHABET[rand(ALPHABET.size)] }
  end

end
