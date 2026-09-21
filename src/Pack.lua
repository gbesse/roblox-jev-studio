--!strict
-- Purpose: Declare visible, finite Studio selection-review criteria.
return {
	id = "studio-hygiene",
	issues = {
		{ id = "naming", label = "Ambiguous name", instructions = "Does any selected Instance have a default, vague, or inconsistent production name?", markAbove = 0.62 },
		{ id = "hierarchy", label = "Hierarchy ambiguity", instructions = "Does any selected Instance's name, class, and path suggest confusing or fragile hierarchy organization?", markAbove = 0.7 },
		{ id = "responsibility", label = "Unclear responsibility", instructions = "Does any selected script or container appear to have an unclear responsibility from its name, class, and path?", markAbove = 0.72 },
	},
}

