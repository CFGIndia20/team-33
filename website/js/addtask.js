// const firebaseConfig = {
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


db.collection("users")
    .get()
    .then(function (querySnapshot) {
        querySnapshot.forEach(function (doc) {
            // doc.data() is never undefined for query doc snapshots
            let select = document.querySelector(".user");
            let data = doc.data();
            select.innerHTML = select.innerHTML + "<option value=" + doc.id + ">" + data.username + "</option>";
        });
    })
    .catch(function (error) {
        console.log("Error getting documents: ", error);
    });

$(document).ready(function () {
    var currentDate = new Date();
    var deadline = new Date();
    deadline.setDate(deadline.getDate() + 7);
    $(".assignedDate").html((currentDate.getMonth() + 1) + "/" + currentDate.getDate() + "/" + currentDate.getFullYear());
    $(".deadline").html((deadline.getMonth() + 1) + "/" + deadline.getDate() + "/" + deadline.getFullYear());;
});

