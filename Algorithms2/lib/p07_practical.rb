require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
  perms = string.split("").permutation.to_a
  perms.each do |perm|
    if perm == perm.reverse
      return true
    end
  end
  false
end
