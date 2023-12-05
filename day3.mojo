from mypackage import StringVector, splitString
from math import max, min

fn is_special(ch : String) -> Bool:
    return ch != "." and isdigit(ord(ch)) == False

fn main() raises:
    var f = open("id3", "r")
    let str : String = f.read(); 
    f.close()

    var split_str: StringVector = splitString(str, "\n")
    var sum : UInt64 = 0

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
                    var possible = False

                    if begin > 0 and is_special(s[begin-1]):
                        possible = True
                    if end < len(s)-1 and is_special(s[end+1]):
                        possible = True
                    if k < split_str.length()-1:
                        for j in range(max(0, begin-1), min(len(next)-1,end+1)+1):
                            if is_special(next[j]):
                                possible = True
                    if k > 0:
                        for j in range(max(0, begin-1), min(len(prev)-1,end+1)+1):
                            if is_special(prev[j]):
                                possible = True
                    
                    if(possible):
                        sum += Int(atol(numstr))
                    numstr = ""

    print(sum)



