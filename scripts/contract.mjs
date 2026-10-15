export const MODEL='jev-1.13.0';
export function cleanCandidates(raw){
 if(raw.length>255)throw new Error('FR : sélectionnez au plus 255 Instances. EN: Select at most 255 Instances. ES: Seleccione como máximo 255 Instances.');
 const ids=new Set(),result=[];
 for(const candidate of raw){
  if(typeof candidate.id!=='string'||!candidate.id||ids.has(candidate.id))throw new Error('FR : identifiants sélectionnés uniques requis. EN: Selected Instance IDs must be unique. ES: Los identificadores seleccionados deben ser únicos.');
  ids.add(candidate.id);
  if(candidate.name)result.push(candidate);
 }
 if(!result.length)throw new Error('FR : sélectionnez au moins une Instance. EN: Select at least one Instance. ES: Seleccione al menos una Instance.');
 return result;
}

export function locationRequest(candidates,issues){const criteria=Object.fromEntries(candidates.map(candidate=>[candidate.id,{name:candidate.name,className:candidate.className,path:candidate.path}]));return{model:MODEL,state:{selectedInstances:candidates},questions:Object.fromEntries(issues.map(issue=>[issue.id,{type:'choice',instructions:`Which exact selected Instance most strongly demonstrates this issue? ${issue.instructions}`,criteria}]))}}
export function validateResponse(response,questions){if(response?.model!==MODEL||!response.answers||!Number.isInteger(response.usage?.input_tokens))throw new Error('Invalid Jev response envelope');for(const[id,question]of Object.entries(questions)){const answer=response.answers[id];if(!answer||answer.type!==question.type)throw new Error(`Missing or mismatched answer: ${id}`);if(answer.type==='choice'&&!(answer.choice in question.criteria))throw new Error(`Invalid choice: ${id}`)}return response}
