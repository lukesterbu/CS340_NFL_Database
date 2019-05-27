// Deletes the selected row from the table and mysql databse
function deleteRow() {
	// Remove the row from the table
	var payload = {};
	var td = event.target.parentNode;
	var tr = td.parentNode;
	payload.type = "delete";
	payload.rowId = tr.id;
	tr.parentNode.removeChild(tr);
	// AJAX request
	var req = new XMLHttpRequest();
	req.open("GET", "/teams", true);
	req.setRequestHeader("Content-type", "application/json");
	req.send(JSON.stringify(payload));
}