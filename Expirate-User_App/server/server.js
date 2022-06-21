const express = require('express')
const app = express()
const port = 3000
const mongoose = require("mongoose");

//mongodb+srv://isi:1124816@isi2003@cluster0.pjrth.mongodb.net/Store-App?retryWrites=true&w=majority

async function connectDb(){
    console.log("db trying to connect");
    await mongoose.connect("mongodb+srv://isi:1124816%40isi2003@cluster0.pjrth.mongodb.net/myFirstDatabase?retryWrites=true&w=majority");
    console.log("db connected");
}

connectDb();

//takes the post body
app.use(express.json({extended: false}))

//initial route
app.get('/', (req, res) => {
  res.send('Hello World!')
})

//signUp route
app.post('/signup', async (req, res) => {

  const {email, password} = req.body;

  const schema = new mongoose.Schema({ email: 'string', password: 'string' });
  User = mongoose.model('User', schema);

  let user = new User({
    email,
    password
  })

  await user.save();

  res.json({token: "1234567890"});

  console.log(user);
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})