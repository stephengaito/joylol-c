-- A Lua LakeFile for joyLoL/lua/specs/unit

local joyLoL = target('../../lib/joyLoL.so', '', function(t)
  lfs.chdir('../../lib')
  print('')
  print(lfs.currentdir())
  os.execute('lake')
  lfs.chdir('../specs/unit')
  print('')
  print(lfs.currentdir())
end)

target(
  'allUnitTests',
  { path.files_from_mask('*Specs.lua'), joyLoL.target},
  '../lunaTest/specs2all.lua $(TARGET) $(DEPENDS)'
)

default(target('allUnitTests.test', 'allUnitTests', './allUnitTests --verbose'))