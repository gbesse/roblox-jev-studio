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

local questions = {issue={type="noul"}}
local function packet(probability, input, output)
 return {model=Core.MODEL,answers={issue={type="noul",noul=probability}},usage={input_tokens=input,output_tokens=output}}
end
for _, probability in {0/0,math.huge,-math.huge,-0.1,1.1} do
 assert(not pcall(Core.validateResponse,packet(probability,1,0),questions))
end
for _, probability in {0,0.5,1} do assert(pcall(Core.validateResponse,packet(probability,1,0),questions)) end
for _, count in {0/0,math.huge,-1,0.5,9007199254740992} do
 assert(not pcall(Core.validateResponse,packet(0.9,count,0),questions))
 assert(not pcall(Core.validateResponse,packet(0.9,1,count),questions))
end
assert(not pcall(Core.validateResponse,packet(0.9,1,nil),questions))
print("FR : nombres natifs bornés vérifiés. EN: bounded native numbers verified. ES: números nativos limitados verificados.")
