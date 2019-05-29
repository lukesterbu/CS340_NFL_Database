// Deletes the selected row from the table and mysql databse
function deleteTeamRow() {
	// Remove the row from the table
	var payload = {};
	var td = event.target.parentNode;
	var tr = td.parentNode;
	payload.type = "delete";
	payload.rowId = tr.id;
	tr.parentNode.removeChild(tr);
	// AJAX request
	var req = new XMLHttpRequest();
	req.open("POST", "/teams", true);
	req.setRequestHeader("Content-type", "application/json");
	req.send(JSON.stringify(payload));
}

function editTeamRow() {
	var payload = {};
	var tr = event.target.parentNode;
	payload.data = event.target.textContent;
	payload.attribute = event.target.id;
	payload.type = "edit";
	payload.rowId = tr.id;
	// AJAX request
	var req = new XMLHttpRequest();
	req.open("POST", "/teams", true);
	req.setRequestHeader("Content-type", "application/json");
	req.send(JSON.stringify(payload));
}

// Deletes the selected row from the table and mysql databse
function deletePlayerRow() {
	// Remove the row from the table
	var payload = {};
	var td = event.target.parentNode;
	var tr = td.parentNode;
	payload.type = "delete";
	payload.rowId = tr.id;
	tr.parentNode.removeChild(tr);
	// AJAX request
	var req = new XMLHttpRequest();
	req.open("POST", "/players", true);
	req.setRequestHeader("Content-type", "application/json");
	req.send(JSON.stringify(payload));
}

function editPlayerRow() {
	var payload = {};
	var tr = event.target.parentNode;
	payload.data = event.target.textContent;
	payload.attribute = event.target.id;
	payload.type = "edit";
	payload.rowId = tr.id;
	// AJAX request
	var req = new XMLHttpRequest();
	req.open("POST", "/players", true);
	req.setRequestHeader("Content-type", "application/json");
	req.send(JSON.stringify(payload));
}

// Updates position and team for the player table
function editPlayerDropdown() {
	var payload = {};
	var tr = event.target.parentNode.parentNode;
	payload.data = event.target.value;
	payload.attribute = event.target.parentNode.id;
	payload.type = "edit";
	payload.rowId = tr.id;
	// AJAX request
	var req = new XMLHttpRequest();
	req.open("POST", "/players", true);
	req.setRequestHeader("Content-type", "application/json");
	req.send(JSON.stringify(payload));
}

// Deletes the selected row from the table and mysql databse
function deleteCoachRow() {
	// Remove the row from the table
	var payload = {};
	var td = event.target.parentNode;
	var tr = td.parentNode;
	payload.type = "delete";
	payload.rowId = tr.id;
	tr.parentNode.removeChild(tr);
	// AJAX request
	var req = new XMLHttpRequest();
	req.open("POST", "/coaches", true);
	req.setRequestHeader("Content-type", "application/json");
	req.send(JSON.stringify(payload));
}

function editCoachRow() {
	var payload = {};
	var tr = event.target.parentNode;
	payload.data = event.target.textContent;
	payload.attribute = event.target.id;
	payload.type = "edit";
	payload.rowId = tr.id;
	// AJAX request
	var req = new XMLHttpRequest();
	req.open("POST", "/coaches", true);
	req.setRequestHeader("Content-type", "application/json");
	req.send(JSON.stringify(payload));
}

// Updates team for the coach table
function editCoachDropdown() {
	var payload = {};
	var tr = event.target.parentNode.parentNode;
	payload.data = event.target.value;
	payload.attribute = event.target.parentNode.id;
	payload.type = "edit";
	payload.rowId = tr.id;
	// AJAX request
	var req = new XMLHttpRequest();
	req.open("POST", "/coaches", true);
	req.setRequestHeader("Content-type", "application/json");
	req.send(JSON.stringify(payload));
}