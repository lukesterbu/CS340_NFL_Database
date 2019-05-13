var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_koslofse',
  password        : '4891',
  database        : 'cs340_koslofse'
});

module.exports.pool = pool;
