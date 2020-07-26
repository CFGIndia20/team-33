function tasks(){
    firebase.database().ref('tasks').once('value',   function(snapshot) {
        snapshot.forEach(function(childSnapshot) {
        document.getElementsByName('Tasks').innerHtml=childSnapshot.val();
        });
      });
}