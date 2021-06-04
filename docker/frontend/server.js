// set up ======================================================================
var express  = require('express');
const fileUpload = require('express-fileupload');
var app      = express(); 								// create our app w/ express
var port  	 = process.env.PORT || 8080; 				// set the port

app.use(fileUpload());
app.use(express.static(__dirname + '/public')); 				// set the static files location /public/img will be /img for users


app.post('/UploadFile', function(req, res) {
    if (!req.files)
      return res.status(400).send('No files were uploaded.');
   
    // The name of the input field (i.e. "sampleFile") is used to retrieve the uploaded file
    let sampleFile = req.files.file; 
   
    // Use the mv() method to place the file somewhere on your server
    sampleFile.mv(__dirname+'/temp/'+req.body.OPERADOR+sampleFile.name, function(err) {
      if (err)
        return res.status(500).send(err);
   
      res.send('File uploaded!');
    });
  });

// listen (start app with node server.js) ======================================
app.listen(port);
console.log("App listening on port " + port);
