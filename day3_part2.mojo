from mypackage import StringVector, splitString
from math import max, min

alias arrptr = DTypePointer[DType.uint64]

fn is_special(ch : String) -> Bool:
    return ch != "." and isdigit(ord(ch)) == False

fn main() raises:
    var f = open("id3", "r")
    let str : String = f.read(); 
    f.close()

    var split_str: StringVector = splitString(str, "\n")
    var sum : UInt64 = 0

    let n = split_str.length()
    let m = len(split_str[0])

    let counter : Pointer[arrptr]
    let product : Pointer[arrptr]
    counter = counter.alloc(n)
    product = product.alloc(n)
    for i in range(n):
        counter.store(i, arrptr.alloc(m))
        product.store(i, arrptr.alloc(m))
    for i in range(n):
        for j in range(m):
            counter[i].store(j, 0)
            product[i].store(j, 1)

    for k in range(split_str.length()):
        let s = split_str[k]
        var prev : String = ""
        var next : String = ""

        if k > 0:
            prev = split_str[k-1]
        if k < split_str.length()-1:
            next = split_str[k+1]

        var numstr: String = ""
        var begin = 0
        var end = -1

        for i in range(len(s)):
            if(isdigit(ord(s[i]))):
                numstr += s[i]
                if i==0 or isdigit(ord(s[i-1])) == False:
                    begin = i
                if i==len(s)-1 or isdigit(ord(s[i+1])) == False:
                    end = i
                    if begin > 0 and is_special(s[begin-1]):
                        counter[k].store(begin-1, counter[k].load(begin-1)+1)
                        product[k].store(begin-1, product[k].load(begin-1)*atol(numstr))  
                    if end < len(s)-1 and is_special(s[end+1]):
                        counter[k].store(end+1, counter[k].load(end+1)+1)
                        product[k].store(end+1, product[k].load(end+1)*atol(numstr))  
                    if k < split_str.length()-1:
                        for j in range(max(0, begin-1), min(len(next)-1,end+1)+1):
                            if is_special(next[j]):
                                counter[k+1].store(j, counter[k+1].load(j)+1)
                                product[k+1].store(j, product[k+1].load(j)*atol(numstr))  
                    if k > 0:
                        for j in range(max(0, begin-1), min(len(prev)-1,end+1)+1):
                            if is_special(prev[j]):
                                counter[k-1].store(j, counter[k-1].load(j)+1)
                                product[k-1].store(j, product[k-1].load(j)*atol(numstr))  

                    numstr = ""

    for i in range(n):
        for j in range(m):
            if counter[i].load(j)[0] == 2:
                sum += product[i].load(j)[0]

    print(sum)



