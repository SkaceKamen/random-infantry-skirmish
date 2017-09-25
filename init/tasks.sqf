/**
 * Start or resume random side mission.
 */
RSTF_TASKS_start = {
	private _found = false;
	private _task = [];

	diag_log text("TASKS: Searching for task");

	// Reload last active task if possible
	if (RSTF_TASK_TYPE != "") then {
		{
			if (_x select 0 == RSTF_TASK_TYPE) exitWith {
				_task = _x;
			};
		} foreach RSTF_TASKS;

		if (count(_task) > 0) exitWith {
			diag_log text("TASKS: Restarting " + str(_task select 0) + ". Starting...");
			RSTF_TASK_PARAMS call (_task select RSTF_TASK_LOAD);
			diag_log text("TASKS: Task started.");
		};

		diag_log text("TASKS: Failed to load previous task. Starting new.");
	};

	// We resumed previous task, stop
	if (count(_task) != 0) exitWith {};

	// Find new random task
	while {count(RSTF_TASKS) > 0 && count(_task) == 0} do {
		// Select random task type
		_index = RSTF_TASKS call BIS_fnc_randomIndex;
		_task = RSTF_TASKS select _index;

		// Check if task is available, end loop if it is
		if (call (_task select RSTF_TASK_AVAILABLE)) exitWith {

		};

		// Remove from list if not available anymore
		RSTF_TASKS = [RSTF_TASKS, _index] call BIS_fnc_removeIndex;
		_task = [];
	};

	// Start task if found
	if (count(_task) > 0) then {
		diag_log text("TASKS: Task found: " + str(_task select 0) + ". Starting...");
		call (_task select RSTF_TASK_START);
		diag_log text("TASKS: Task started.");
	};
};

RSTF_TASKS_TASK_failed = {
	params [["_taskId", ""]];

	private _singular = true;
	if (_taskId == "") then {
		_taskId = RSTF_TASK;
		_singular = false;
	};

	[RSTF_TASK, "FAILED", true] call BIS_fnc_taskSetState;

	if (_singular) then {
		call RSTF_TASKS_clear;
	} else {
		[_taskId] call RSTF_TASKS_TASK_remove;
	};
};

RSTF_TASKS_TASK_completed = {
	params [["_task", "Task"], ["_taskId", ""]];

	private _singular = false;
	if (_taskId == "") then {
		_taskId = RSTF_TASK;
		_singular = true;
	};

	[_taskId, "Succeeded", true] call BIS_fnc_taskSetState;
	[_task, RSTF_SCORE_PER_TASK] call RSTF_fnc_addPlayerScore;

	if (_singular) then {
		call RSTF_TASKS_clear;
	} else {
		[_taskId] call RSTF_TASKS_TASK_remove;
	};
};

RSTF_TASKS_TASK_remove = {
	private _taskId = _this select 0;

	_index = RSTF_CURRENT_TASKS find _taskId;
	if (_index >= 0) then {
		RSTF_CURRENT_TASKS = [RSTF_CURRENT_TASKS, _index] call BIS_fnc_removeIndex;
	};
	publicVariable "RSTF_CURRENT_TASKS";
};

RSTF_TASKS_clear = {
	RSTF_TASK = "";
	RSTF_TASK_TYPE = "";
	RSTF_TASK_PARAMS = [];

	publicVariable "RSTF_TASK";

	// diag_log text("TASKS: Task completed. Starting new task.");
	// call RSTF_TASKS_start;
};