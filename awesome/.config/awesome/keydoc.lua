-- Document key bindings

local awful     = require("awful")
local table     = table
local ipairs    = ipairs
local pairs     = pairs
local math      = math
local string    = string
local type      = type
local modkey    = "Mod4"
local beautiful = require("beautiful")
local naughty   = require("naughty")
local capi      = {
   root = root,
   client = client
}

module("keydoc")

local doc = { }
local currentgroup = "Misc"
local orig = awful.key.new
local dummy = { }

-- Replacement for awful.key.new
local function new(mod, key, press, release, docstring)
   -- Usually, there is no use of release, let's just use it for doc
   -- if it's a string.
   if press and release and not docstring and type(release) == "string" then
      docstring = release
      release = nil
   end
   local k = orig(mod, key, press, release)
   -- Remember documentation for this key (we take the first one)
   if k and #k > 0 and docstring then
      doc[k[1]] = { help = docstring,
		    group = currentgroup } end

   return k
end
awful.key.new = new		-- monkey patch

-- Add dummy key
function adddummy(mod, key, press, release, docstring)
    if press and release and not docstring and type(release) == "string" then
        docstring = release
        release = nil
    end
    table.insert(dummy, {key = key, modifiers = mod,
        help = docstring, group = currentgroup })
    return {}
end
    
-- Turn a key to a string
local function key2str(key)
   local sym = key.key or key.keysym
   local translate = {
      ["#14"] = "#",
      [" "] = "Space",
   }
   sym = translate[sym] or sym
   if not key.modifiers or #key.modifiers == 0 then return sym end
   local result = ""
   local translate = {
      [modkey] = "Mod",--⊞",
      Shift    = "Shift",--⇧",
      Control  = "Ctrl",
   }
   for _, mod in pairs(key.modifiers) do
      mod = translate[mod] or mod
      result = result .. mod .. " + "
   end
   return result .. sym
end

-- Unicode "aware" length function (well, UTF8 aware)
-- See: http://lua-users.org/wiki/LuaUnicode
local function unilen(str)
   local _, count = string.gsub(str, "[^\128-\193]", "")
   return count
end

-- Start a new group
function group(name)
   currentgroup = name
   return {} end

local function helptext(key, help, longest)
    local skey = key2str(key)
	return '<span font="DejaVu Sans Mono 10" color="white"> ' .. 
	    string.format("%" .. (longest - unilen(skey)) .. "s  ", "") .. skey ..
	    '</span>  <span color="gray">'..
	    help .. '</span>\n'
end

local function markup(keys)
   local result = {}
   -- Compute longest key combination
   local longest = 0
   for _, key in ipairs(keys) do
      if doc[key] then
	    longest = math.max(longest, unilen(key2str(key)))
      end
   end

   for _, key in ipairs(dummy) do
       longest = math.max(longest, unilen(key2str(key)))
   end

   local curgroup = nil
   for _, key in ipairs(keys) do
      if doc[key] then
	    local help, group = doc[key].help, doc[key].group
	    result[group] = (result[group] or "") .. helptext(key, help, longest)
      end
   end

   for _, key in ipairs(dummy) do 
       if key then
          local help, group = key.help, key.group
          result[group] = (result[group] or "") .. helptext(key, help, longest)
       end
    end

   return result
end

-- Display help in a naughty notification
local nid = nil
local nau = nil
function display()
   local strings = awful.util.table.join(
      markup(capi.root.keys()),
      capi.client.focus and markup(capi.client.focus:keys()) or {})

   local result = ""
   for group, res in pairs(strings) do
      if #result > 0 then result = result .. "\n" end
      result = result ..
	 '<span weight="bold" color="yellow">' .. --beautiful.fg_widget_value_important .. '">' ..
	 group .. "</span>\n" .. res
   end
   
   if nau ~= nil then
      naughty.destroy(nau)
      nau=nil
      nid=nil
   else
      nau = naughty.notify({ text = result,
			  replaces_id = nid,
			  hover_timeout = 0.1,
              opacity = 0.75,
			  timeout = 30 })
      nid = nau.id
   end
end
