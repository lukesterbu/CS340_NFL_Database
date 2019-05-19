var express = require('express');
var mysql = require('./dbcon.js');



var app = express();
var handlebars = require('express-handlebars').create({defaultLayout:'main'});

const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }));

app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', process.argv[2]);

app.get('/',function(req,res,next){
    res.render('home');
});

app.get('/teams',function(req,res,next){
  
    res.render('teams');
});

app.get('/teams-new',function(req,res,next){
  
    res.render('teams-new');
});

app.post('/teams-new',function(req,res,next){
  
    res.render('teams');
});

app.get('/players',function(req,res,next){
  mysql.pool.query("SELECT p.firstName + p.lastName AS Name, p.position, p.height, p.weight, t.name + "
  "FROM player p "
  "INNER JOIN team t "
  "WHERE t.teamID = p.teamID);",
  function(err, rows, fields) {
    if(err) {
      next(err);
      return;
    }
    res.render('players');
  }
});

app.post('/players-delete',function(req,res,next){
  
    res.render('players');
});

app.post('/players-update',function(req,res,next){
  
    res.render('players');
});

app.get('/players-new',function(req,res,next){
  
    res.render('players-new');
});

app.post('/players-new',function(req,res,next){
  
    res.render('players');
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
  
    res.render('coaches');
});

app.get('/coaches-new',function(req,res,next){
  
    res.render('coaches-new');
});

app.post('/coaches-new',function(req,res,next){
  
    res.render('coaches');
});

app.get('/stats',function(req,res,next){
  
    res.render('stats');
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
                req.body.passingattempts, 
                req.body.passingcompletions, 
                req.body.passingyards, 
                req.body.passingtouchdowns, 
                req.body.receptions, 
                req.body.receivingyards, 
                req.body.receivingtouchdowns, 
                req.body.rushes, 
                req.body.rushingyards, 
                req.body.rushingtouchdowns, 
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

app.post('/stats-new',function(req,res,next){
  
    res.render('stats');
});

app.get('/sponsors',function(req,res,next){
  
    res.render('sponsors');
});

app.get('/sponsors-new',function(req,res,next){
  
    res.render('sponsors-new');
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

app.get('/sponsorships',function(req,res,next){
  
    res.render('sponsorships');
});

app.get('/sponsorships-get',function(req,res,next){
  mysql.pool.query("SELECT p.playerid, \
                    CONCAT (p.firstname, ' ', p.lastname) AS playerName, \
                    cs.name                      AS sponsorName \
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

app.get('/sponsorships-new',function(req,res,next){
  
    res.render('sponsorships-new');
});

app.post('/sponsorships-new',function(req,res,next){
    var query = mysql.pool.query(" \
                    INSERT INTO sponsoredPlayers (playerid, sponsorid) \
                    VALUES      (?, ?);", [req.body.playerID, req.body.sponsorID], function(err, result){

    if(err){
      next(err);
      return;
    }
    res.render('sponsorships');
  });
});

// app.get('/insert',function(req,res,next){
//   
//   mysql.pool.query("INSERT INTO todo (`name`) VALUES (?)", [req.query.c], function(err, result){
//     if(err){
//       next(err);
//       return;
//     }
//     context.results = "Inserted id " + result.insertId;
//     res.render('home',context);
//   });
// });

// app.get('/delete',function(req,res,next){
//   
//   mysql.pool.query("DELETE FROM todo WHERE id=?", [req.query.id], function(err, result){
//     if(err){
//       next(err);
//       return;
//     }
//     context.results = "Deleted " + result.changedRows + " rows.";
//     res.render('home',context);
//   });
// });


// app.get('/simple-update',function(req,res,next){
//   
//   mysql.pool.query("UPDATE todo SET name=?, done=?, due=? WHERE id=? ",
//     [req.query.name, req.query.done, req.query.due, req.query.id],
//     function(err, result){
//     if(err){
//       next(err);
//       return;
//     }
//     context.results = "Updated " + result.changedRows + " rows.";
//     res.render('home',context);
//   });
// });

// app.get('/safe-update',function(req,res,next){
//   
//   mysql.pool.query("SELECT * FROM todo WHERE id=?", [req.query.id], function(err, result){
//     if(err){
//       next(err);
//       return;
//     }
//     if(result.length == 1){
//       var curVals = result[0];
//       mysql.pool.query("UPDATE todo SET name=?, done=?, due=? WHERE id=? ",
//         [req.query.name || curVals.name, req.query.done || curVals.done, req.query.due || curVals.due, req.query.id],
//         function(err, result){
//         if(err){
//           next(err);
//           return;
//         }
//         context.results = "Updated " + result.changedRows + " rows.";
//         res.render('home',context);
//       });
//     }
//   });
// });



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
