const admin = require("firebase-admin");
admin.initializeApp({projectId: "see-flutterversion"});
admin.initializeApp({projectId: "see-flutterversion"});
async function deleteAll() {
  try {
    let count = 0;
    let token;
    do {
