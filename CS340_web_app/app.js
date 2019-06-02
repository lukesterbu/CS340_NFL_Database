var express = require('express');
var mysql = require('./dbcon.js');

var app = express();
var handlebars = require('express-handlebars').create({defaultLayout:'main'});

const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }));

app.use(express.static('client'));
app.use(bodyParser.json());

app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', process.argv[2]);

app.get('/',function(req,res,next){
    res.render('home');
});

app.post('/teams', function(req, res, next) {
  if(req.body.type === "delete") {
    mysql.pool.query("DELETE FROM team WHERE teamID=?", [req.body.rowId],
    function(err, result) {
      if(err) {
        next(err);
        return;
      }
    });
  }
  else if(req.body.type === "edit") {
    mysql.pool.query("UPDATE team SET " + [req.body.attribute] + "=? WHERE teamID=?", 
    [req.body.data, req.body.rowId],
    function(err, result) {
      if(err) {
        next(err);
        return;
      }
    });
  }
});

app.get('/teams', function(req, res, next) {
  var context = {};
  mysql.pool.query("SELECT * \
  FROM team;",
  function(err, rows, fields) {
    if(err) {
      next(err);
      return;
    }
    context.results = rows;
    res.render('teams', context);
  });
});

app.get('/teams-new',function(req,res,next){
  res.render('teams-new');
});

app.post('/teams-new',function(req,res,next){
  mysql.pool.query("INSERT INTO team (name, location, year_founded, majority_owner, conference, division) \
  VALUES (?, ?, ?, ?, ?, ?)", [req.body.teamName, req.body.location, req.body.year_founded, req.body.majority_owner, req.body.conference, req.body.division],
  function(err, results) {
    if(err) {
      next(err);
      return;
    }
    var context = {};
    mysql.pool.query("SELECT * \
    FROM team;",
    function(err, rows, fields) {
      if(err) {
        next(err);
        return;
      }
      context.results = rows;
      res.render('teams', context);
    });
  });
});

app.get('/players',function(req,res,next) {
  var context = {"teams": "{}"};
  mysql.pool.query("SELECT p.playerID, p.firstName, p.lastName, p.position, p.height, p.weight, t.teamID, CONCAT (t.location, ' ', t.name) AS teamName \
  FROM player p \
  LEFT JOIN team t \
  ON p.teamID = t.teamID;",
  function(err, rows, fields) {
    if(err) {
      next(err);
      return;
    }
    context.results = rows;
    mysql.pool.query("SELECT teamID AS tID, CONCAT(location, ' ', name) AS tName \
    FROM team;",
    function(err, rows, fields) {
      if(err) {
        next(err);
        return;
      }
      context.teams = rows;
      res.render('players', context);
    });
  });
});

app.post('/players', function(req, res, next) {
  // Handles free agent
  if (req.body.data === "-1") {
    req.body.data = null;
  }
  if(req.body.type === "delete") {
    mysql.pool.query("DELETE FROM player WHERE playerID=?", [req.body.rowId],
    function(err, result) {
      if(err) {
        next(err);
        return;
      }
    });
  }
  else if(req.body.type === "edit") {
    mysql.pool.query("UPDATE player SET " + [req.body.attribute] + "=? WHERE playerID=?", 
    [req.body.data, req.body.rowId],
    function(err, result) {
      if(err) {
        next(err);
        return;
      }
    });
  }
});

app.get('/players-new',function(req,res,next){
  var context = {};
  mysql.pool.query("SELECT teamID, CONCAT(location, ' ', name) AS teamName \
  FROM team;",
  function(err, rows, fields) {
    if(err) {
      next(err);
      return;
    }
    context.results = rows;
    res.render('players-new', context);
  });
});

app.post('/players-new',function(req,res,next){
  // Handles free agent
  if (req.body.team === "-1") {
    req.body.team = null;
  }
  mysql.pool.query("INSERT INTO player (firstName, lastName, position, height, weight, teamID) \
  VALUES (?, ?, ?, ?, ?, ?)", [req.body.firstName, req.body.lastName, req.body.position, req.body.height, req.body.weight, req.body.team],
  function(err, results) {
    if(err) {
      next(err);
      return;
    }
    var context = {};
    mysql.pool.query("SELECT p.playerID, CONCAT (p.firstName, ' ', p.lastName) AS playerName, p.position, p.height, p.weight, CONCAT (t.location, ' ', t.name) AS teamName \
    FROM player p \
    LEFT JOIN team t \
    ON p.teamID = t.teamID;",
    function(err, rows, fields) {
      if(err) {
        next(err);
        return;
      }
      context.results = rows;
      res.render('players', context);
    });
  });
});

app.get('/players-search',function(req,res,next){
  var lastNameSearchTerm = req.query.lastNameSearchTerm;
  var firstNameSearchTerm = req.query.firstNameSearchTerm;

  // only search by first or last name if they aren't blank, unless both are blank,
  // then search by both
  var isSearchByFirstName = false;
  var isSearchByLastName = false;

  if(lastNameSearchTerm !== "")
    isSearchByLastName = true;
  if(firstNameSearchTerm !== "")
    isSearchByFirstName = true;
  if(!firstNameSearchTerm && !lastNameSearchTerm){
    var isSearchByFirstName = true;
    var isSearchByLastName = true;
  }

  var query = mysql.pool.query("SELECT playerid, \
  CONCAT (p.firstname, ' ', p.lastname) AS playerName, \
  t.name AS team \
  FROM   player p \
  left join team t ON p.teamid = t.teamid \
  WHERE ((" + mysql.pool.escape(isSearchByFirstName) + " = false) OR (" + mysql.pool.escape(isSearchByFirstName) + " = true AND firstName LIKE CONCAT ('%', " + mysql.pool.escape(firstNameSearchTerm) + ", '%'))) \
        AND ((" + mysql.pool.escape(isSearchByLastName) + " = false) OR (" + mysql.pool.escape(isSearchByLastName) + " = true AND lastName LIKE CONCAT ('%', " + mysql.pool.escape(lastNameSearchTerm) + ", '%')));", [], 
  function(err, result){

    if(err){
      next(err);
      return;
    }
    res.json(result);
  });
});

app.get('/coaches',function(req,res,next){
  var context = {};
  mysql.pool.query("SELECT c.coachID, c.firstName, c.lastName, c.title, CONCAT(t.location, ' ', t.name) AS teamName \
  FROM coach c \
  LEFT JOIN team t \
  ON c.teamID = t.teamID;",
  function(err, rows, fields) {
    if(err) {
      next(err);
      return;
    }
    context.results = rows;
    mysql.pool.query("SELECT teamID AS tID, CONCAT(location, ' ', name) AS tName \
    FROM team;",
    function(err, rows, fields) {
      if(err) {
        next(err);
        return;
      }
      context.teams = rows;
      res.render('coaches', context);
    });
  });
});

// Needs to be updated
app.post('/coaches',function(req,res,next){
  // Handles free agent
  if (req.body.data === "-1") {
    req.body.data = null;
  }
  if(req.body.type === "delete") {
    mysql.pool.query("DELETE FROM coach WHERE coachID=?", [req.body.rowId],
    function(err, result) {
      if(err) {
        next(err);
        return;
      }
    });
  }
  else if(req.body.type === "edit") {
    mysql.pool.query("UPDATE coach SET " + [req.body.attribute] + "=? WHERE coachID=?", 
    [req.body.data, req.body.rowId],
    function(err, result) {
      if(err) {
        next(err);
        return;
      }
    });
  }
});

app.get('/coaches-new',function(req,res,next){
  var context = {};
  mysql.pool.query("SELECT teamID, CONCAT(location, ' ', name) AS teamName \
  FROM team;",
  function(err, rows, fields) {
    if(err) {
      next(err);
      return;
    }
    context.results = rows;
    res.render('coaches-new', context);
  });
});

app.post('/coaches-new',function(req,res,next){
  if (req.body.team === "-1") {
    req.body.team = null;
  }
  mysql.pool.query("INSERT INTO coach (firstName, lastName, title, teamID) \
  VALUES (?, ?, ?, ?)", [req.body.firstName, req.body.lastName, req.body.title, req.body.team],
  function(err, results) {
    if(err) {
      next(err);
      return;
    }
    var context = {};
    mysql.pool.query("SELECT c.coachID, CONCAT(c.firstName, ' ', c.lastName) AS name, c.title, CONCAT(t.location, ' ', t.name) AS teamName \
    FROM coach c \
    LEFT JOIN team t \
    ON c.teamID = t.teamID;",
    function(err, rows, fields) {
      if(err) {
        next(err);
        return;
      }
      context.results = rows;
      res.render('coaches', context);
    });
  });
});

app.get('/stats',function(req,res,next){
  
    res.render('stats');
});

app.get('/stats-update/:id/:year',function(req,res,next){
  
  res.render('stats-update', {id: req.params.id, year: req.params.year});
});

app.get('/stats-get',function(req,res,next){
  
  mysql.pool.query("\
  SELECT p.playerid, \
  CONCAT (p.firstname, ' ', p.lastname) AS playerName, \
  year, \
  passingattempts, \
  passingcompletions, \
  passingyards,  \
  passingtouchdowns, \
  receptions, \
  receivingyards, \
  receivingtouchdowns, \
  rushes, \
  rushingyards, \
  rushingtouchdowns, \
  tackles, \
  sacks, \
  interceptions \
  FROM   seasonStatistics ss \
  inner join player p ON ss.playerid = p.playerid;  ", [], 
    function(err, result){
      if(err){
        next(err);
        return;
      }
      res.json(result);
    });


});

app.get('/stats-get/:id/:year',function(req,res,next){
  
  mysql.pool.query("\
  SELECT p.playerid, \
  CONCAT (p.firstname, ' ', p.lastname) AS playerName, \
  year, \
  passingattempts, \
  passingcompletions, \
  passingyards,  \
  passingtouchdowns, \
  receptions, \
  receivingyards, \
  receivingtouchdowns, \
  rushes, \
  rushingyards, \
  rushingtouchdowns, \
  tackles, \
  sacks, \
  interceptions \
  FROM   seasonStatistics ss \
  inner join player p ON ss.playerid = p.playerid \
  where p.playerID = " + req.params.id + " AND year = " + req.params.year + ";  ", [], 
    function(err, result){
      if(err){
        next(err);
        return;
      }
      res.json(result);
    });


});


app.post('/stats-update/:id/:year',function(req,res,next){
  var query = mysql.pool.query(" \
  UPDATE seasonStatistics \
    SET         passingattempts = ?, \
                passingcompletions = ?, \
                passingyards = ?, \
                passingtouchdowns = ?, \
                receptions = ?, \
                receivingyards = ?, \
                receivingtouchdowns = ?, \
                rushes = ?, \
                rushingyards = ?, \
                rushingtouchdowns = ?, \
                tackles = ?, \
                sacks = ?, \
                interceptions = ?  \
    WHERE  playerid = ? AND year = ?; ", 
              [
                req.body.passingAttempts, 
                req.body.passingCompletions, 
                req.body.passingYards, 
                req.body.passingTouchdowns, 
                req.body.receptions, 
                req.body.receivingYards, 
                req.body.receivingTouchdowns, 
                req.body.rushes, 
                req.body.rushingYards, 
                req.body.rushingTouchdowns, 
                req.body.tackles, 
                req.body.sacks, 
                req.body.interceptions,
                req.body.playerID, 
                req.body.year, ], 
  function(err, result){

    if(err){
      next(err);
      return;
    }
    res.render('stats');
  });
});




app.get('/stats-new',function(req,res,next){
  
    res.render('stats-new');
});




app.post('/stats-new',function(req,res,next){
  var query = mysql.pool.query(" \
  INSERT INTO seasonStatistics \
            (playerid, \
             year,  \
             passingattempts, \
             passingcompletions, \
             passingyards, \
             passingtouchdowns, \
             receptions, \
             receivingyards, \
             receivingtouchdowns, \
             rushes, \
             rushingyards, \
             rushingtouchdowns, \
             tackles, \
             sacks, \
             interceptions) \
              VALUES      (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  ?,  ?, ?, ?, ?); ", 
              [req.body.playerID, 
                req.body.year, 
                req.body.passingAttempts, 
                req.body.passingCompletions, 
                req.body.passingYards, 
                req.body.passingTouchdowns, 
                req.body.receptions, 
                req.body.receivingYards, 
                req.body.receivingTouchdowns, 
                req.body.rushes, 
                req.body.rushingYards, 
                req.body.rushingTouchdowns, 
                req.body.tackles, 
                req.body.sacks, 
                req.body.interceptions], 
  function(err, result){

    if(err){
      next(err);
      return;
    }
    res.render('stats');
  });
});

app.post('/stats-delete/:playerID/:year',function(req,res,next){
  var query = mysql.pool.query(" \
                            DELETE FROM seasonStatistics \
                          WHERE playerid = ? AND year = ? ;", 
                          [req.params.playerID, req.params.year], function(err, result){
                          console.log(query.sql)
    if(err){
      next(err);
      return;
    }
    res.render('stats');
  });
});

app.post('/stats-new',function(req,res,next){
  
    res.render('stats');
});

app.get('/sponsors',function(req,res,next){
  
    res.render('sponsors');
});

app.get('/sponsors-new',function(req,res,next){
  
    res.render('sponsors-new');
});

app.get('/sponsors-update/:id',function(req,res,next){
  
  res.render('sponsors-update', {id: req.params.id});
});

app.post('/sponsors-update/:id',function(req,res,next){
  var query = mysql.pool.query(" \
                                UPDATE corporateSponsor \
                                SET name = ?, \
                                    producttype = ? \
                              WHERE sponsorID = ?;", 
                              [req.body.name, req.body.productType, req.params.id], function(err, result){

  if(err){
    next(err);
    return;
  }
  res.render('sponsors');
});
});

app.post('/sponsors-new',function(req,res,next){
  var query = mysql.pool.query(" \
                  INSERT INTO corporateSponsor (name, productType) VALUES      (?, ?);", 
                  [req.body.name, req.body.productType], function(err, result){

    if(err){
      next(err);
      return;
    }
    res.render('sponsors');
  });
});

app.post('/sponsors-delete',function(req,res,next){
  
    res.render('sponsors');
});

app.get('/sponsors-get',function(req,res,next){
  mysql.pool.query("SELECT * FROM   corporateSponsor; ", [], 
    function(err, result){
      if(err){
        next(err);
        return;
      }
      res.json(result);
    });
});

app.get('/sponsors-get/:id',function(req,res,next){
  var query = mysql.pool.query("SELECT * FROM   corporateSponsor  where sponsorid = " + req.params.id + ";", [], 
    function(err, result){

      // console.log(query)

      if(err){
        next(err);
        return;
      }
      res.json(result);
    });
});

app.post('/sponsors-delete/:sponsorID',function(req,res,next){
  var query = mysql.pool.query(" \
                            DELETE FROM corporateSponsor \
                          WHERE sponsorid = ? ;", 
                          [req.params.sponsorID], function(err, result){
                          console.log(query.sql)
    if(err){
      next(err);
      return;
    }
    res.render('sponsors');
  });
});

app.get('/sponsorships',function(req,res,next){
  
    res.render('sponsorships');
});

app.get('/sponsorships-get',function(req,res,next){
  mysql.pool.query("SELECT p.playerid, \
                    CONCAT (p.firstname, ' ', p.lastname) AS playerName, \
                    cs.name                      AS sponsorName, \
                    cs.sponsorid AS sponsorID \
                    FROM   sponsoredPlayers sp \
                          inner join player p \
                                  ON sp.playerid = p.playerid \
                          inner join corporateSponsor cs \
                                  ON sp.sponsorid = cs.sponsorid;", [], 
    function(err, result){
      if(err){
        next(err);
        return;
      }
      res.json(result);
    });
});

app.get('/sponsorships-get/:playerID/:sponsorID',function(req,res,next){
  var query = mysql.pool.query("SELECT p.playerid, \
                    CONCAT (p.firstname, ' ', p.lastname) AS playerName, \
                    cs.name                      AS sponsorName, \
                    cs.sponsorid AS sponsorID \
                    FROM   sponsoredPlayers sp \
                          inner join player p \
                                  ON sp.playerid = p.playerid \
                          inner join corporateSponsor cs \
                                  ON sp.sponsorid = cs.sponsorid \
                                  WHERE p.playerid = ? and sp.sponsorid = ?;", [req.params.playerID, req.params.sponsorID], 
    function(err, result){

      // console.log(req.body)

      // console.log(query.sql)

      if(err){
        next(err);
        return;
      }
      res.json(result);
    });
});

app.get('/sponsorships-new',function(req,res,next){
  
    res.render('sponsorships-new');
});

app.post('/sponsorships-new',function(req,res,next){
    var query = mysql.pool.query(" \
                    INSERT INTO sponsoredPlayers (playerID, sponsorID) \
                    VALUES      (?, ?);", [req.body.playerID, req.body.sponsorID], function(err, result){

    // console.log(query.sql)

    if(err){
      next(err);
      return;
    }
    res.render('sponsorships');
  });
});


app.get('/sponsorships-update/:playerID/:sponsorID',function(req,res,next){
  
  res.render('sponsorships-update', {playerID: req.params.playerID, sponsorID: req.params.sponsorID});
});

app.post('/sponsorships-update/:playerID/:sponsorID',function(req,res,next){
  var query = mysql.pool.query(" \
                            UPDATE sponsoredPlayers \
                            SET \
                            sponsorid = ? \
                          WHERE playerid = ? AND sponsorid = ? ;", 
                          [req.body.sponsorID, req.body.playerID, req.params.sponsorID], function(err, result){

                            console.log(query.sql)
  if(err){
    next(err);
    return;
  }
  res.render('sponsorships');
});
});

app.post('/sponsorships-delete/:playerID/:sponsorID',function(req,res,next){
  var query = mysql.pool.query(" \
                            DELETE FROM sponsoredPlayers \
                          WHERE playerid = ? AND sponsorid = ? ;", 
                          [req.params.playerID, req.params.sponsorID], function(err, result){
                          console.log(query.sql)
    if(err){
      next(err);
      return;
    }
    res.render('sponsorships');
  });
});


app.use(function(req,res){
  res.status(404);
  res.render('404');
});

app.use(function(err, req, res, next){
  console.error(err.stack);
  res.status(500);
  res.render('500');
});

app.listen(app.get('port'), function(){
  console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});
