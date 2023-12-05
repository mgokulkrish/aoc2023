from utils.vector import DynamicVector
from utils.static_tuple import StaticTuple
from math import max

fn decode_color(str: String) -> StaticTuple[3, Int]:
    var value = 0
    var fact = 1
    var num = DynamicVector[Int]()
    let n = len(str)

    for i in range(n):
        if(isdigit(ord(str[i]))):
            num.push_back(ord(str[i])-48)

    for i in range(len(num)):
        value += fact * num[len(num)-1-i]
        fact = fact * 10

    if(str[n-3:] == "red"):
        return StaticTuple[3, Int](value, -1, -1)
    if(str[n-4:] == "blue"):
        return StaticTuple[3, Int](-1, -1, value)
    if(str[n-5:] == "green"):
        return StaticTuple[3, Int](-1, value, -1)
    
    return StaticTuple[3, Int](-1, -1, -1)

fn main () raises:
    var f = open("in", "r")
    let str = f.read(); 
    f.close()

    # rgb
    let limit = StaticTuple[3](12, 13, 14)
    var balls = StaticTuple[3](-1, -1, -1)

    var color_coding : String = ""
    var prev_index = 0
    var sum = 0 

    for i in range(len(str)):
        if str[i] == ":":
            prev_index = i + 1
        elif str[i] == "," or str[i] == ";" or str[i] == "\n":
            let color_val = decode_color(str[prev_index: i])

            if(color_val[0] != -1):
                balls[0] = max(balls[0], color_val[0])
            elif(color_val[1] != -1):
                balls[1] = max(balls[1], color_val[1])
            else:
                balls[2] = max(balls[2], color_val[2])

            if(str[i] == "\n"):
                sum += (balls[0]*balls[1]*balls[2])
                balls = StaticTuple[3](-1, -1, -1)
            prev_index = i + 1
        else:
            color_coding = color_coding + str[i]

    print(sum)