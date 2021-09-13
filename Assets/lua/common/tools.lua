--存放所有复用数据结构

--栈结构
local Stack = class("Stack")
Stack.realStack = {}
Stack.index = 0
function Stack:push(num)
    self.index = self.index + 1
    self.realStack[self.index] = num
end

function Stack:pop()
    local tempNum = self.realStack[self.index]
    self.index = self.index - 1
    return tempNum
end

function  Stack:last()
    local tempNum = self.realStack[self.index]
    return tempNum
end

function Stack:clear()
    self.index = 0
    self.realStack = {}
end

return Stack