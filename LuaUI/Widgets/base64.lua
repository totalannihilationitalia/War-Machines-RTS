-- Base64 encoding and decoding in Lua.
-- Copyright (c) 2009, Jeffrey Friedl
-- <http://regex.info/blog/lua/base64>
-- For use with Lua 5.1 and later.
--
-- Example use:
--    local b64 = require "base64" -- or whatever you name this file
--    local encoded = b64.encode("string to encode")
--    local decoded = b64.decode(encoded)
--
-- More advanced use allows the specification of the 64 characters used in
-- the encoding. The default is the standard set:
--    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
--
-- The C module is faster, of course, but this is pure Lua.
-- It's also ridiculously long because of the bit-fiddling.
--
local M = {} -- This will be the module.

local C = {} -- Will be a table of characters used in the encoding.

function M.encode(s, charset)
    charset = charset or "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    if #charset ~= 64 then error("charset must contain 64 characters") end

    for i = 1, 64 do C[i-1] = charset:sub(i,i) end

    local len = #s
    local t = {} -- Will be the table of encoded bytes.

    for i = 1, len, 3 do
        local c1 = s:byte(i)
        local c2 = s:byte(i+1)
        local c3 = s:byte(i+2)

        t[#t+1] = C[ math.floor(c1 / 4) ]
        t[#t+1] = C[ (c1 % 4) * 16 + (c2 and math.floor(c2 / 16) or 0) ]

        if c2 then
            t[#t+1] = C[ (c2 % 16) * 4 + (c3 and math.floor(c3 / 64) or 0) ]
        else
            t[#t+1] = "=" -- padding
        end

        if c3 then
            t[#t+1] = C[ c3 % 64 ]
        else
            t[#t+1] = "=" -- padding
        end
    end
    return table.concat(t)
end


local D = {} -- Will be a table of character values used in the decoding.

function M.decode(s, charset)
    charset = charset or "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    if #charset ~= 64 then error("charset must contain 64 characters") end

    for i = 1, 64 do D[ charset:sub(i,i) ] = i - 1 end

    local len = #s
    local t = {} -- Will be the table of decoded bytes.

    -- We must ignore any characters not in the charset
    local clean_s = {}
    for i = 1, len do
        if D[s:sub(i,i)] then
            clean_s[#clean_s+1] = s:sub(i,i)
        elseif s:sub(i,i) == "=" then
            clean_s[#clean_s+1] = "=" -- keep padding
        end
    end
    s = table.concat(clean_s)
    len = #s

    -- Now for the decoding.
    for i = 1, len, 4 do
        local c1, c2, c3, c4 = D[s:sub(i,i)], D[s:sub(i+1,i+1)], D[s:sub(i+2,i+2)], D[s:sub(i+3,i+3)]

        t[#t+1] = string.char( c1 * 4 + math.floor(c2 / 16) )

        if c3 then
            t[#t+1] = string.char( (c2 % 16) * 16 + math.floor(c3 / 4) )
        end

        if c4 then
            t[#t+1] = string.char( (c3 % 4) * 64 + c4 )
        end
    end

    return table.concat(t)
end

return M -- Return the module table