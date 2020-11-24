"""
文件缓冲示例
"""

# 设置行缓冲
# file = open("myfile",'w',buffering=1)

# 缓冲区大小10字节 以2进制方式打开
file = open("myfile",'wb',buffering=10)

while True:
    msg = input(">>")
    file.write(msg.encode())
    # file.flush() # 人为刷新缓冲区

file.close()