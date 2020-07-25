var express = require('express')
var app = express()
app.get('/', function(req, res)
{
    console.log("Success startup");
    res.sendFile('/signup.html');

});
app.post('/', function(req, res)
{
    console.log("Success signup");
    res.sendFile('/index.html');
});
const firebaseConfig = {
    apiKey: "",
    authDomain: "team33-app.firebaseapp.com",
    databaseURL: "https://team33-app.firebaseio.com",
    projectId: "team33-app",
    storageBucket: "team33-app.appspot.com",
    messagingSenderId: "691086175931",
    appId: "1:691086175931:web:24594ab5c4a02dfb5e439e"
};


firebase.initializeApp(firebaseConfig);
var db = firebase.firestore();
app.listen(8080);
