fn str_to_digit(s: String) -> Int:
    if s[0:4] == "zero":
        return 0
    elif s[0:3] == "one":
        return 1
    elif s[0:3] == "two":
        return 2
    elif s[0:5] == "three":
        return 3
    elif s[0:4] == "four":
        return 4
    elif s[0:4] == "five":
        return 5
    elif s[0:3] == "six":
        return 6
    elif s[0:5] == "seven":
        return 7
    elif s[0:5] == "eight":
        return 8
    elif s[0:4] == "nine":
        return 9
    else:
        return -1


fn main () raises:
    var f = open("id1b", "r")
    let str = f.read(); 
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
        elif str_to_digit(str[i:]) >= 0 and count == 0:
            first_digit = str_to_digit(str[i:])
            second_digit = first_digit
            count = count + 1

        
        if isdigit(ord(c)) and count != 0:
            second_digit = ord(str[i]) - 48
            count = count + 1
        elif str_to_digit(str[i:]) >= 0 and count != 0:
            second_digit = str_to_digit(str[i:])
            count = count + 1

        if c == "\n":
            # print(first_digit, second_digit)
            sum = sum + (10*first_digit) + second_digit
            count = 0


    print(sum)