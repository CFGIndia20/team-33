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

function addTask() {
    var userSelect = document.querySelector(".user");
    var userName = userSelect.options[userSelect.selectedIndex].text;
    db.collection("tasks").doc().set({
        name: document.querySelector(".title").value,
        product: document.querySelector(".product").value,
        user: userSelect.value,
        description: document.querySelector(".description").value,
        username: userName,
        quantity: document.querySelector(".quantity").value,
        assigned_date: document.querySelector(".assignedDate").innerHTML,
        deadline_date: document.querySelector(".deadline").innerHTML,
        completed_quantity: 0
    })
        .then(function () {
            console.log("Task successfully written!");
        })
        .catch(function (error) {
            console.error("Error writing document: ", error);
        });
}

db.collection("tasks")
    .get()
    .then(function (querySnapshot) {
        querySnapshot.forEach(function (doc) {
            let template = document.querySelector("#tasktemplate").innerHTML;
            let rowData = template;
            let data = doc.data();

            rowData = rowData.replace("$user$", data.username);
            rowData = rowData.replace("$task$", data.name);
            rowData = rowData.replace("$product$", data.product);
            rowData = rowData.replace("$quantity$", data.quantity);
            rowData = rowData.replace("$assignedate$", data.assigned_date);
            rowData = rowData.replace("$deadline$", data.deadline_date);
            document.querySelector(".taskData").innerHTML = document.querySelector(".taskData").innerHTML + (rowData);
        });
    })
    .catch(function (error) {
        console.log("Error getting documents: ", error);
    });
