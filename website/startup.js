var express = require('express')
var app = express()
app.get('/', function(req, res)
{
    console.log("Success startup");
    res.sendFile('/signup.html');

});
app.post('/signup', function(req, res)
{
    console.log("Success signup");
    const Joi = require('joi');
    const data = req.body;
    const schema = Joi.object().keys({
        const email = Joi.string().email().lowercase().required();
        const password = Joi.string().min(7).alphanum().required();
    res.sendFile('/index.html');
});
app.post('/login', function(req, res, next)=>
{
    console.log("Success login");
    const Joi = require('joi');
    const data = req.body;
    const schema = Joi.object().keys({
        email: Joi.string().email().required();
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
