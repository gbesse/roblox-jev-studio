local Core = require("../src/Core")
local candidates = {
 {id="one", name="Part", className="Part", path="Workspace.Part"},
 {id="two", name="Part", className="Part", path="Workspace.Part"},
}
local selected = Core.cleanCandidates(candidates)
assert(#selected == 2)
local request = Core.locationRequest(selected, {{id="naming",label="Naming",instructions="Ambiguous?",markAbove=0.8}})
assert(request.questions.naming.criteria.one ~= nil and request.questions.naming.criteria.two ~= nil)
local duplicate = {{id="same",name="A",className="Part",path="A"},{id="same",name="B",className="Part",path="B"}}
assert(not pcall(Core.cleanCandidates, duplicate))
local many = {}
for index=1,256 do table.insert(many,{id=tostring(index),name="Part",className="Part",path="Workspace.Part"}) end
assert(not pcall(Core.cleanCandidates,many))
assert(not pcall(Core.cleanCandidates,{}))
print("FR : identité native vérifiée. EN: native identity verified. ES: identidad nativa verificada.")
