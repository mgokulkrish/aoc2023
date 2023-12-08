from memory import memcpy

alias strtype = DTypePointer[DType.int8]

struct StringVector:
    var size: Int
    var capacity: Int   
    var data: Pointer[strtype]

    fn __init__(inout self):
        self.__init__(32)

    fn __init__(inout self, capacity: Int):
        self.size = 0
        self.capacity = capacity
        self.data = self.data.alloc(self.capacity)

    fn push_back(inout self, str: String):
        if self.size == self.capacity:
            self.grow()

        let str_data = strtype.alloc(len(str)+1)
        memcpy(str_data, str._as_ptr(), len(str)+1)
        self.data.store(self.size, str_data)
        self.size += 1

    fn grow(inout self):
        self.resize(2*self.capacity)

    fn resize(inout self, new_capacity: Int):
        let new_data = Pointer[strtype].alloc(new_capacity)
        memcpy(new_data, self.data, self.size)
        self.data.free()
        self.data = new_data
        self.capacity = new_capacity

    fn __getitem__(inout self, i: Int) raises -> String:
        if i >= self.size:
            let err : Error = Error("out of bounds index @ __getitem__")
            raise err
        let str: StringLiteral
        return String(self.data[i])

    fn __setitem__(inout self, i: Int, str: String) raises:
        if i >= self.size:
            let err : Error = Error("out of bounds index @ __setitem__")
            raise err

        self.data.load(i).free()
        let str_data = strtype.alloc(len(str)+1)
        memcpy(str_data, str._as_ptr(), len(str)+1)
        self.data.store(i, str_data)

    fn length(inout self) -> Int:
        return self.size

    fn clear(inout self):
        self.size = 0
        self.resize(32)

    # fn __del__(owned self):
    #     self.resize(0)

    fn __len__(self) -> Int:
        return self.size    

    fn __copyinit__(inout self, existing: Self):
        self.size = existing.size
        self.capacity = existing.capacity
        self.data = self.data.alloc(self.capacity)

        for i in range(self.size):
            let n = len(String(existing.data[i])) + 1
            let temp_data : strtype = strtype.alloc(n)
            memcpy(temp_data, existing.data[i], n)
            self.data.store(i, temp_data)


fn splitString(str: String, ch: String) raises -> StringVector:
    var temp: String = ""
    var split_list: StringVector = StringVector()

    for i in range(len(str)):
        if(str[i] == ch):
            split_list.push_back(temp)
            temp = ""
        else:
            temp += str[i]
    
    if(temp != ""):
        split_list.push_back(temp)

    return split_list
    