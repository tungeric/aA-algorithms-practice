def well_formed?(str)
  char_hash = { "[" => "]", "{" => "}", "(" => ")", }
  open_array = []
  str_array = str.split("")
  until str_array.length == 0
    el = str_array.shift
    if char_hash.keys.includes?(el)
      open_array.push(el)
    else
      if char_hash
        return false
      else
        open_array.pop
      end
    end
  end
  true
end

puts well_formed?("{[]}({})")