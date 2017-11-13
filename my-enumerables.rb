module Enumerable
  def my_each
    i=0
    while i<self.count do
      yield(self[i])
      i=i+1
    end
  end

  def my_each_with_index
    i=0
    while i<self.count do
      yield(self[i],i)
      i=i+1
    end
  end

  def my_select
    return_array = []
    self.my_each { |i| return_array << i if yield(i)}
    return_array
  end

  def my_all?
    result = true
    self.my_each do |i|
      if block_given?
        if yield(i) == false
          result = false
          break
        end
      else
        if i
        else
          result = false
          break
        end
      end
    end
    result
  end

  def my_any?
    result = false
    self.my_each do |i|
      if block_given?
        if yield(i) == true
          result = true
          break
        end
      else
        if i == i
          result = true
          break
        end
      end
    end
    result
  end

  def my_none?
    result = true
    self.my_each do |i|
      if block_given?
        if yield(i)
          result = false
          break
        end
      else
        if i
          result = false
          break
        end
      end
    end
    result
  end

  def my_count(*q)
    arg = q[0]
    counter = 0
    self.my_each do |i|
      if block_given?
        counter +=1 if yield(i)
      elsif  i == arg
        counter += 1
      elsif q == []
        counter += 1
      end
    end
    counter
  end

  def my_map
    results=[]
    self.my_each {|i|results << yield(i)}
    results
  end

  def my_inject(*initial)
    memo = 0
    if block_given?
      counter = 0
      memo = initial[0] unless initial[0] == nil
      self.my_each do |i|
        if counter == 0 && initial[0] == nil
          memo = i
        else
          memo = yield(memo,i)
        end
        counter += 1
      end
    else
      if initial[0].is_a? Symbol
        oper = initial[0]
        counter = 0
        self.my_each do |i|
          memo = counter == 0 ? i : memo.send(oper, i)
          counter += 1
        end
      else
        oper = initial[1]
        memo = initial[0]
        self.my_each do |i|
          memo = memo.send(oper, i)
        end
      end
    end
    memo
  end

end

def multiply_els(numbers)
  numbers.my_inject(:*)
end

my_array = [3,2,6]
print "each: "
my_array.each {|x| print "#{x}"}
puts ""
print "my_each: "
my_array.my_each {|x| print "#{x}"}
puts ""

my_hash = Hash.new
my_array.each_with_index {|item, index| my_hash[item]=index}
puts "each_with_index: #{my_hash}"

my_hash2 = Hash.new
my_array.my_each_with_index {|item, index| my_hash2[item]=index}
puts "my_each_with_index: #{my_hash2}"

puts "select: #{my_array.select {|x| x>2}}"
puts "my_select: #{my_array.my_select {|x| x>2}}"
puts ""

puts "all?: #{my_array.all?{|x| x>0}}"
puts "my_all?: #{my_array.my_all?{|x| x>0}}"

puts "any?: #{my_array.any?{|x| x>5}}"
puts "my_any?: #{my_array.my_any?{|x| x>5}}"

puts "none?: #{my_array.none?{|x| x>5}}"
puts "my_none?: #{my_array.my_none?{|x| x>5}}"
puts ""

puts "count (block): #{my_array.count{|x| x==2}}"
puts "my_count (block): #{my_array.my_count{|x| x==2}}"
puts "count (arg): #{my_array.count(2)}"
puts "my_count (arg): #{my_array.my_count(2)}"
puts "count (no arg): #{my_array.count}"
puts "my_count (no arg): #{my_array.my_count}"
puts ""

double = Proc.new {|x| x*2}
puts "map: (with Proc) #{my_array.map(&double)}"
puts "my_map: (with Proc) #{my_array.my_map(&double)}"
puts "map: #{my_array.map{|x| x*2}}"
puts "my_map: #{my_array.my_map{|x| x*2}}"
puts ""

puts "inject: (symbol with init) #{my_array.inject(0, :+)}"
puts "my_inject: (symbol with init) #{my_array.my_inject(0, :+)}"
puts "inject: (symbol w/o init) #{my_array.inject(:+)}"
puts "my_inject: (symbol w/o init) #{my_array.my_inject(:+)}"
puts "inject: (block with init) #{my_array.inject(1) {|prod, x| prod * x}}"
puts "my_inject: (block with init) #{my_array.my_inject(1) {|prod, x| prod * x}}"
puts "inject: (block w/o init) #{my_array.inject {|sum, x| sum + x}}"
puts "my_inject: (block w/o init) #{my_array.my_inject {|sum, x| sum + x}}"
puts ""

puts multiply_els([2,4,5])
