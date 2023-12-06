from mypackage import StringVector, splitString

fn get_winners(str: String) raises -> DynamicVector[Int]:
    var ans = DynamicVector[Int]()
    var start = 0
    var end = 0
    for i in range(len(str)):
        if(str[i]==":"):
            start = i
        if(str[i]=="|"):
            end = i
            break
    
    var numstrs : StringVector = splitString(str[start+2: end-1], " ")
    for i in range(numstrs.length()):
        if(numstrs[i] != ""):
            ans.push_back(atol(numstrs[i]))

    return ans

fn get_numbers(str: String) raises -> DynamicVector[Int]:
    var ans = DynamicVector[Int]()
    var start = 0
    var end = len(str)-1

    for i in range(len(str)):
        if(str[i]=="|"):
            start = i
        
    var numstrs : StringVector = splitString(str[start+2: end+1], " ")
    for i in range(numstrs.length()):
        if(numstrs[i] != ""):
            ans.push_back(atol(numstrs[i]))

    return ans
    



fn main() raises:
    var f = open("id4", "r")
    let str = f.read(); 
    f.close()

    var split_str: StringVector = splitString(str, "\n")
    let n = split_str.length()
    var points = DynamicVector[Int](n)
    for i in range(n):
        points[i] = 1

    var sum = 0

    for i in range(n):
        var winners = get_winners(split_str[i])
        var numbers = get_numbers(split_str[i])

        var count = 0
        for j in range(len(numbers)):
            let num = numbers[j]
            for k in range(len(winners)):
                if(winners[k] == num):
                    count += 1

        for j in range(count):
            points[i+j+1] += (points[i])
    
    for i in range(n):
        sum += points[i]
        

    print(sum)