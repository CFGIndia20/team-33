// const firebaseConfig = {
//     apiKey: "",
//     authDomain: "temp-c61fc.firebaseapp.com",
//     databaseURL: "https://temp-c61fc.firebaseio.com",
//     projectId: "temp-c61fc",
//     storageBucket: "temp-c61fc.appspot.com",
//     messagingSenderId: "916547582259",
//     appId: "1:916547582259:web:c82bc0bc23513f0197a646"
// };

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


db.collection("tasks")
    .get()
    .then(function (querySnapshot) {
        querySnapshot.forEach(function (doc) {
            // doc.data() is never undefined for query doc snapshots
            let startDate = new Date();
            startDate.setDate(1);
            let endDate = new Date();
            endDate.setDate(1); endDate.setMonth(endDate.getMonth() + 1); endDate.setDate(-1);

            let template = document.querySelector("#template").innerHTML;
            let rowData = template;
            let data = doc.data();
            let recordDate = new Date(data.deadline_date);
            if (recordDate >= startDate && recordDate <= endDate) {
                rowData = rowData.replace("$name$", data.username);
                rowData = rowData.replace("$task$", data.name);
                rowData = rowData.replace("$product$", data.product);
                rowData = rowData.replace("$cquantity$", data.completed_quantity);
                let eff = (data.completed_quantity / data.quantity) * 100;
                rowData = rowData.replace("$efficiency$", eff);
                document.querySelector(".efficiencyData").innerHTML = document.querySelector(".efficiencyData").innerHTML + (rowData);
            }
        });
    })
    .catch(function (error) {
        console.log("Error getting documents: ", error);
    });

db.collection("session").get().then(function (querySnapshot) {
    querySnapshot.forEach(function (doc) {
        // doc.data() is never undefined for query doc snapshots
        let template = document.querySelector("#template").innerHTML;

        let rowData = template;
        let data = doc.data();
        rowData = rowData.replace("$agenda$", data.agenda);
        rowData = rowData.replace("$date$", data.date);
        rowData = rowData.replace("$location$", data.location);
        rowData = rowData.replace("$time$", data.time);
        document.querySelector(".sessionData").innerHTML = document.querySelector(".sessionData").innerHTML + (rowData);
    });
})
    .catch(function (error) {
        console.log("Error getting documents: ", error);
    });

db.collection("users").get().then(function (querySnapshot) {
    querySnapshot.forEach(function (doc) {
        // doc.data() is never undefined for query doc snapshots
        let template = document.querySelector("#template").innerHTML;

        let rowData = template;
        let data = doc.data();
        rowData = rowData.replace("$name$", data.username);
        rowData = rowData.replace("$phone$", data.phone);
        rowData = rowData.replace("$date$", data.Date);
        document.querySelector(".usersData").innerHTML = document.querySelector(".usersData").innerHTML + (rowData);
    });
})
    .catch(function (error) {
        console.log("Error getting documents: ", error);
    });

db.collection("admin-login").get().then(function (querySnapshot) {
    querySnapshot.forEach(function (doc) {
        // doc.data() is never undefined for query doc snapshots
        let template = document.querySelector("#template").innerHTML;

        let rowData = template;
        let data = doc.data();
        rowData = rowData.replace("$username$", data.username);
        rowData = rowData.replace("$password$", data.password);
        document.querySelector(".loginData").innerHTML = document.querySelector(".loginData").innerHTML + (rowData);
    });
})
    .catch(function (error) {
        console.log("Error getting documents: ", error);
    });
