
const fs = require('fs');
const https = require('https');
const express = require('express');
const port = process.env.PORT || 5001;

const app = express();
app.use(express.static(__dirname + '/public'));

app.get('/', function(req, res) {
  return res.end('<p>Server HTTPS Inpulse</p>');
});

const options = {
  key: fs.readFileSync('key.pem', 'utf8'),
  cert: fs.readFileSync('certificate.pem', 'utf8'),
  passphrase: process.env.HTTPS_PASSPHRASE || ''
};

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

const server = https.createServer(options, app); 

server.listen(port);
console.log("App listening on port " + port);