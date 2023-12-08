from mypackage import StringVector, splitString

fn main() raises:
    var f = open("in", "r")
    let str = f.read(); 
    f.close()

    var maps = Pointer[Pointer[StaticTuple[3, Int]]]()
    maps = maps.alloc(7)
    var mapidx = -1
    var map_size = DynamicVector[Int]()

    var split_str = splitString(str, "\n")

    var seeds = DynamicVector[Int]()
    var str_seed_list = splitString(split_str[0][7:], " ")
    for i in range(str_seed_list.length()):
        seeds.push_back(atol(str_seed_list[i]))

    var numidx = 0
    for i in range(2, split_str.length()):
        if split_str[i] == "":
            continue
        elif isdigit(ord(split_str[i][0])) == False:
            mapidx += 1
            var length = 0
            for j in range(i+1, split_str.length()):
                if split_str[j] == "":
                    break
                length += 1
            numidx = 0
            maps[mapidx] = maps[mapidx].alloc(length)
            map_size.push_back(length)
        elif split_str[i] != "":
            var numsters = splitString(split_str[i], " ")
            var nums = DynamicVector[Int]()
            for j in range(numsters.length()):
                nums.push_back(atol(numsters[j]))
            maps[mapidx][numidx] = StaticTuple[3, Int](nums[1], nums[1] + nums[2] - 1, nums[0])
            numidx += 1

    # range optimization to be done
    # current implementation takes 2mins

    var ans : Int = 2147483647
    for i in range((len(seeds)/2).to_int()):
        for k in range(seeds[2*i], seeds[2*i]+seeds[2*i+1]):
            var pointer = k
            for j in range(7):
                for k in range(map_size[j]):
                    if(pointer >= maps[j][k][0] and pointer <= maps[j][k][1]):
                        pointer = maps[j][k][2] + (pointer - maps[j][k][0])
                        break
            if (pointer < ans):
                ans = pointer

    print(ans)

    for i in range(7):
        maps[i].free()

    

    
        
