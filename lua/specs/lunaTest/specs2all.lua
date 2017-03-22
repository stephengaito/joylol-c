#!/usr/bin/env lua

-- This Lua Script takes as arguments:
--   <allTestsFileName>
--   <specFileName>+
-- and creates the associated *<allTestsFileName>.lua LunaTest file

if #arg < 2 then
  print('usage: '..arg[0]..' <allTestsFileName> <specFileName>+')
  os.exit(-1)
end

local allTestsFileName = table.remove(arg, 1)
local luaVersion       = allTestsFileName:gsub('%/.*$','')

print('\nCreating: ['..allTestsFileName..']')
print('from:')
local theSuites = { }
for i, aFileName in ipairs(arg) do
  if aFileName:match('%.lua$') then
    print('\t['..aFileName..']')
    theSuites[#theSuites+1] = aFileName:gsub('%..*$','')
  end
end

local luaFile = io.open(allTestsFileName, 'w')
if not luaFile then
  print('Could not write to ['..allTestsFileName..']\n')
  os.exit(-3)
end

luaFile:write('#!/usr/bin/env lua')
luaFile:write(luaVersion)
luaFile:write([=[


-- DO NOT EDIT THIS FILE!
-- It is automatically generated by lake.
-- So any changes you make will be lost!

package.cpath = '../../../ansi-c/lib/]=])
luaFile:write(luaVersion)
luaFile:write([=[/?.so;'..package.cpath

lunaTest = dofile('../lunaTest/lunatest.lua') -- create as a global

]=])

for i, aSuite in ipairs(theSuites) do
  luaFile:write('lunaTest.suite("')
  luaFile:write(aSuite)
  luaFile:write('")')
end

luaFile:write([=[


lunaTest.run(true)

]=])

luaFile:close()
os.execute('chmod a+x '..allTestsFileName) -- alas an explicit UNIXism