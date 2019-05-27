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
	console.log(event.target.id);
	payload.attribute = event.target.id;
	payload.type = "edit";
	payload.rowId = tr.id;
	// AJAX request
	var req = new XMLHttpRequest();
	req.open("POST", "/teams", true);
	req.setRequestHeader("Content-type", "application/json");
	req.send(JSON.stringify(payload));
}

// Needs to be Updated
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

// Needs to be Updated
function editPlayerRow() {
	var payload = {};
	var tr = event.target.parentNode;
	payload.data = event.target.textContent;
	console.log(event.target.id);
	payload.attribute = event.target.id;
	payload.type = "edit";
	payload.rowId = tr.id;
	// AJAX request
	var req = new XMLHttpRequest();
	req.open("POST", "/players", true);
	req.setRequestHeader("Content-type", "application/json");
	req.send(JSON.stringify(payload));
}