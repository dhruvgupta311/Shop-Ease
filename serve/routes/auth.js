const express = require("express");
const User = require("../models/user.js");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

const authRouter=express.Router();
// authRouter.get('/user',(req,res)=>{
//     res.json({msg:"dhruv"});
// })




// SIGN UP
// ye sb database ke sath ho rha h use.js model use krrkr 
authRouter.post("/api/signup", async (req, res) => {  
  try{
    const {name, email, password}=req.body;
    /*
    "User": This is the name given to the model. 
    It's conventional to use uppercase for model names in user.js, 
    and it should be singular and in PascalCase.
    */
    const existingUser = await User.findOne({ email });  //mongoose property, promise(future)
    if(existingUser){
      return res.status(400).json({ msg: "User with same email already exists!" });
    }   

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();    //to save 
    // id -unique identifier
    //versions-> how many times we did chnge our file

    res.status(200).json(user); // default value is 200 so we dont need to write this thing
  }
  catch (e){
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});



// Sign In Route
authRouter.post("/api/Signin", async(req,res)=>{
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    // generate the token and a secret private key only server knows 
    // console.log(token);
    res.json({token, ...user._doc });
    // this line sends the token to the client 
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// // get user data
// if token is valid then get user daata from this api call from database
authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  // console.log(user);
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
