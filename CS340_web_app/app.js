var express = require('express');
var mysql = require('./dbcon.js');

var app = express();
var handlebars = require('express-handlebars').create({defaultLayout:'main'});

app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', process.argv[2]);

app.get('/',function(req,res,next){
  var context = {};
    res.render('home', context);
});

app.get('/teams',function(req,res,next){
  var context = {};
    res.render('teams', context);
});

app.get('/teams-new',function(req,res,next){
  var context = {};
    res.render('teams-new', context);
});

app.post('/teams-new',function(req,res,next){
  var context = {};
    res.render('teams', context);
});

app.get('/players',function(req,res,next){
  var context = {};
    res.render('players', context);
});

app.post('/players-delete',function(req,res,next){
  var context = {};
    res.render('players', context);
});

app.post('/players-update',function(req,res,next){
  var context = {};
    res.render('players', context);
});

app.get('/players-new',function(req,res,next){
  var context = {};
    res.render('players-new', context);
});

app.post('/players-new',function(req,res,next){
  var context = {};
    res.render('players', context);
});

app.get('/coaches',function(req,res,next){
  var context = {};
    res.render('coaches', context);
});

app.get('/coaches-new',function(req,res,next){
  var context = {};
    res.render('coaches-new', context);
});

app.post('/coaches-new',function(req,res,next){
  var context = {};
    res.render('coaches', context);
});

app.get('/stats',function(req,res,next){
  var context = {};
    res.render('stats', context);
});

app.get('/stats-new',function(req,res,next){
  var context = {};
    res.render('stats-new', context);
});

app.post('/stats-new',function(req,res,next){
  var context = {};
    res.render('stats', context);
});

app.get('/sponsors',function(req,res,next){
  var context = {};
    res.render('sponsors', context);
});

app.get('/sponsors-new',function(req,res,next){
  var context = {};
    res.render('sponsors-new', context);
});

app.post('/sponsors-new',function(req,res,next){
  var context = {};
    res.render('sponsors', context);
});

app.post('/sponsors-delete',function(req,res,next){
  var context = {};
    res.render('sponsors', context);
});

app.get('/sponsorships',function(req,res,next){
  var context = {};
    res.render('sponsorships', context);
});

app.get('/sponsorships-new',function(req,res,next){
  var context = {};
    res.render('sponsorships-new', context);
});

app.post('/sponsorships-new',function(req,res,next){
  var context = {};
    res.render('sponsorships', context);
});

// app.get('/insert',function(req,res,next){
//   var context = {};
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
//   var context = {};
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
//   var context = {};
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
//   var context = {};
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