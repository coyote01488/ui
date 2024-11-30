local g = getinfo or debug.getinfo;

local d = false;

local h = { };

local x, y;

setthreadidentity(2);

for i, v in getgc(true) do
    if typeof(v) == "table" then
        local a = rawget(v, "Detected");

        local b = rawget(v, "Kill");
    
        if typeof(a) == "function" and not x then
            x = a;
            
            local o; o = hookfunction(x, function(c, f, n)
                return true;
            end);

            table.insert(h, x);
        end;

        if rawget(v, "Variables") and rawget(v, "Process") and typeof(b) == "function" and not y then
            y = b;

            local o;

            o = hookfunction(y, function(f) end);

            table.insert(h, y);
        end;
    end;
end;

local o;

o = hookfunction(getrenv().debug.info, newcclosure(function(...)
    local a, f = ...

    if x and a == x then
        return coroutine.yield(coroutine.running());
    end;
    
    return o(...);
end));

setthreadidentity(7);