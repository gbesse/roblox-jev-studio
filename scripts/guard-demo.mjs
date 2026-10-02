// Reject an invented Roblox Instance identity before showing a finding.
import {cleanCandidates, locationRequest, validateResponse} from './contract.mjs';
const candidates = cleanCandidates([
  {id: 'instance_1', name: 'Part', className: 'Part', path: 'Workspace.Part'},
  {id: 'instance_2', name: 'Main', className: 'Script', path: 'ServerScriptService.Main'},
]);
const request = locationRequest(candidates, [{id: 'naming', instructions: 'Is the production name ambiguous?'}]);
const fabricated = {model: 'jev-1.13.0', usage: {input_tokens: 10}, answers: {naming: {type: 'choice', choice: 'instance_99'}}};
let rejected = false;
try { validateResponse(fabricated, request.questions); }
catch (error) { rejected = /Invalid choice/.test(error.message); }
if (!rejected) throw new Error('Invented Instance was accepted');
console.log(JSON.stringify({source: 'synthetic selected Instances; no Roblox or Jev', allowedIds: candidates.map(candidate => candidate.id), inventedInstanceRejected: rejected}, null, 2));
