print("CSharpCallLua")

a = 5
b="str_b"
--local c ='str_c'
c ='str_c'

gameName={name1="神域",name2="奇兵",name3="千秋"}
gameNames={"神域","奇兵","千秋"}

gameUser={
    name ="Jack",
    age=21,

    Play =function()
        print("Jack正在玩游戏")
    end,

    Exit=function()
        print("Jack退出游戏")
    end
}

--定义单独的lua函数
function ProcMyFunc1()
    print("procMyFunc1 无参函数")
end

function ProcMyFunc2(num1,num2)
    print("procMyFunc1 两个函数 num1+num2="..num1+num2)
end

function ProcMyFunc3(num1,num2)
    print("procMyFunc1 具备多返回数值的函数")
    return num1+num2,num1,num2
end

function ProcMyFunc4(num1,num2,num3)
    print("procMyFunc4 两个函数 num1+num2+num3="..num1+num2+num3)
end