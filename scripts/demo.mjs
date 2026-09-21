import{cleanCandidates,locationRequest}from'./contract.mjs';const candidates=cleanCandidates([{id:'instance_1',name:'Part',className:'Part',path:'Workspace.Part'},{id:'instance_2',name:'Main',className:'Script',path:'ServerScriptService.Main'}]);console.log(JSON.stringify(locationRequest(candidates,[{id:'naming',instructions:'Does an Instance have an ambiguous production name?'}]),null,2));

