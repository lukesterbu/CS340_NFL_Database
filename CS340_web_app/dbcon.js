var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_burrisl',
  password        : '5665',
  database        : 'cs340_burrisl'
});

module.exports.pool = pool;
