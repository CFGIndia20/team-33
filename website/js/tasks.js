function tasks(){
    firebase.database().ref('tasks').once('value',   function(snapshot) {
        snapshot.forEach(function(childSnapshot) {
        //   var childKey = childSnapshot.key;
        //   var childData = childSnapshot.val();
        document.getElementsByName('Tasks').innerHtml=childSnapshot.val();
        });
      });
}