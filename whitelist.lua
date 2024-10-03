MAP_PATH = "/path/to/ipfs.map"
PREFIX = "/ipfs/"

for l in io.lines(MAP_PATH) do
   space_pos = string.find(l, " ")  -- edge case: no whitespace
   cid = string.sub(l, 1, space_pos - 1)  
   if ngx.var.uri == PREFIX..cid then
      ngx.exit(ngx.OK)
   else
      ngx.log(ngx.WARN, ngx.var.uri)
      ngx.exit(ngx.HTTP_UNAUTHORIZED)
   end
   -- name = string.sub(line, space_pos + 1)  
end

