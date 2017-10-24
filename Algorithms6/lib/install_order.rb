# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to



def install_order(arr)
  max_id = arr.flatten.max
  packages = (1..max_id).to_a
  dependents = arr.transpose[0]
  in_order = packages - dependents
  until in_order.length == max_id
    arr = arr.reject { |pkg| in_order.include?(pkg[1]) }
    if arr.empty?
      in_order += packages - in_order
      break
    end
    free_to_install = packages - arr.transpose[0]
    new_in_order = free_to_install - in_order
    in_order += new_in_order
  end
  in_order
end
