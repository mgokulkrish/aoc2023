from utils.vector import DynamicVector

fn main () raises:
    var f = open("id1", "r")
    var str = f.read(); 
    f.close()

    var count = 0
    var first_digit = 0
    var second_digit = 0

    var sum = 0

    for i in range(len(str)):
        let c = str[i]
        if isdigit(ord(c)) and count == 0:
            first_digit = ord(str[i]) - 48
            second_digit = ord(str[i]) - 48
            count = count + 1
        
        if isdigit(ord(c)) and count != 0:
            second_digit = ord(str[i]) - 48
            count = count + 1

        if c == "\n":
            print(first_digit, second_digit)
            sum = sum + (10*first_digit) + second_digit
            count = 0


    print(sum)
