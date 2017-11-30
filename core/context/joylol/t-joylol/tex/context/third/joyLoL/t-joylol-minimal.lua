-- A Lua file

-- from file: minJoyLoL.tex after line: 0

local function setDefs(varVal, selector, defVal)
  if not defVal then defVal = { } end
  varVal[selector] = varVal[selector] or defVal
  return varVal[selector]
end

local minJoylol     = setDefs(thirddata, 'minJoylol')

minJoylol.core = { }

minJoylol.core.context = { }

function minJoylol.core.context.setVerbose(aBool) end
function minJoylol.core.context.setDebugging(aBool) end
function minJoylol.core.context.loadFile(aBool) end
function minJoylol.core.context.gitVersion(aBool) end