def bubble_sort(my_array)
  results = [false]
  until results_eval(results) == true
    i=0
    while i < my_array.length-1 do
      if my_array[i] > my_array[i+1]
        smaller=my_array[i+1]
        larger=my_array[i]

        results[i]=false
        my_array[i]=smaller
        my_array[i+1]=larger
      else
        results[i]=true
      end
      i+=1
    end
  end
  my_array
end

def bubble_sort_by(my_array)
  results = [false]
  until results_eval(results) == true
    i=0
    while i < my_array.length-1 do
      if yield(my_array[i],my_array[i+1]) > 0
        smaller=my_array[i+1]
        larger=my_array[i]

        results[i]=false
        my_array[i]=smaller
        my_array[i+1]=larger
      else
        results[i]=true
      end
      i+=1
    end
  end
  my_array
end

def results_eval(results)
  f_count = 0
  results.each{|x|
    if x== false
      f_count += 1
      break
    end
  }
  f_count==0
end

print bubble_sort([4,2,6,7,4,7,5])
print "#{bubble_sort_by(['hi','hello','hey']) do |left,right|
    left.length - right.length
  end}"
