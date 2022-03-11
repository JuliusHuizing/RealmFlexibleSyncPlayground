exports = async function({user}) {
    const dbName = "testdb1";
    const db = context.services.get("mongodb-atlas").db(dbName);
    const userCollection = db.collection("User");
    console.log(`user: ${JSON.stringify(user)}`);
    
    const userDoc = {
      _id: user.id,
      userName: ""
    };
    
    await userCollection.insertOne(userDoc);
  };