class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = {1=>[[1]], 2=>[[1,1],[2]], 3=>[[1, 1, 1], [1, 2], [2, 1],[3]]}
    @super_frog_cache = {1=>[[1]], 2=>[[1,1],[2]], 3=>[[1, 1, 1], [1, 2], [2, 1],[3]]}
    @maze_cache = []
    @maze_max_cache = []
  end

  def blair_nums(n)
    return @blair_cache[n] unless @blair_cache[n].nil?
    ans = blair_nums(n - 1) + blair_nums(n - 2) + 2*(n-1) - 1
    @blair_cache[n] = ans
    return ans
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    cache = {1=>[[1]], 2=>[[1,1],[2]], 3=>[[1, 1, 1], [1, 2], [2, 1],[3]]}
    return cache if n <= 3
    (4..n).each do |idx|
      cache_1 = cache[idx-1].map {|arr| arr + [1] }
      cache_2 = cache[idx-2].map {|arr| arr + [2] }
      cache_3 = cache[idx-3].map {|arr| arr + [3] }
      cache[idx] = cache_1 + cache_2 + cache_3
    end
    cache
  end

  def frog_hops_top_down(n)
    frog_ans = frog_hops_top_down_helper(n)
    @frog_cache[n] = frog_ans
    return frog_ans
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]
    cache_1 = frog_hops_top_down_helper(n-1).map {|arr| arr + [1] }
    cache_2 = frog_hops_top_down_helper(n-2).map {|arr| arr + [2] }
    cache_3 = frog_hops_top_down_helper(n-3).map {|arr| arr + [3] }
    cache_1 + cache_2 + cache_3
  end

  def super_frog_hops(n, k)
    return [[1]*n] if k == 1
    k = n if k > n
    return nil if n > 999
    return @super_frog_cache[n] if @super_frog_cache[n]
    val = []
    n.downto(2) do |idx|
      unless k < (n-idx+1)
        val += super_frog_hops(idx-1,k).map {|arr| [n-idx+1] + arr }
      end
    end
    @super_frog_cache[n] = val
    @super_frog_cache[n]
  end

  def knapsack(weights, values, capacity)
    return 0 if capacity == 0
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
    row, col = start_pos
    @maze_cache << start_pos unless @maze_cache.last == start_pos
    return end_pos if start_pos == end_pos
    if [" ","F"].include?(maze[row][col+1])
      maze[row][col+1] = "S"
      maze_solver(maze,[row,col+1],end_pos)
    elsif [" ","F"].include?(maze[row][col-1])
      maze[row][col-1] = "S"
      maze_solver(maze, [row,col-1],end_pos)
    elsif [" ","F"].include?(maze[row+1][col])
      maze[row+1][col] = "S"
      maze_solver(maze, [row+1,col],end_pos)
    elsif [" ","F"].include?(maze[row-1][col])
      maze[row-1][col] = "S"
      maze_solver(maze, [row-1,col],end_pos)
    else
      @maze_cache.pop
      maze_solver(maze,@maze_cache.last,end_pos)
    end
    @maze_cache
  end
end
