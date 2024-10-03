-- generate directory listing
-- redirect request to ipfs path

MAP_PATH = "/path/to/ipfs.map"
IPFS_PREFIX = "/ipfs/"
FS_PREFIX = "/fs/"

html = [[
<!DOCTYPE HTML>
<html>
 <head>
  <title>Index of /fs</title>
 </head>
 <body>
<h1>Index of /fs</h1>
<hr><pre>
]]

for l in io.lines(MAP_PATH) do
   space_pos = string.find(l, " ")  -- edge case: no whitespace
   cid = string.sub(l, 1, space_pos - 1)  
   name = string.sub(l, space_pos + 1)  
   if ngx.var.uri == FS_PREFIX..name then
      ngx.redirect(IPFS_PREFIX..cid.."?filename="..name)
   end
   html = html..string.format("<a href='%s'>%s</a>\n", name, name)
end

html = html .. [[
  </pre><hr>
</body>
</html>
]]

ngx.header.content_type = "text.html"
ngx.say(html)
