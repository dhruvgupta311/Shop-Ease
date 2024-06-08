// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
const adminRouter = require("./routes/admin");
const dotenv = require("dotenv").config();

// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth"); 
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");


// INIT
const PORT =  3000;
const app = express();
const DB = "mongodb+srv://guptadhruv1908:Dhruv%4063755@cluster0.3k6ynop.mongodb.net/?retryWrites=true&w=majority";

// middleware -> basically used to manipulate the data
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// Connections
mongoose.connect(DB)
  .then(() => {
    console.log("Connection Successful ");
  })
  .catch((e) =>{
    console.log(e);
  });





/* get request */
// app.get("/hello-world", function (req,res){
//     // res.send('hello')  //send in a basic text format
//     res.json({hi:"hello-world"});  //send in a json format
// })

// homework1 
// app.get("/h",(req,res)=>{
//     res.json({Name:"Dhruv........"});
// });

app.listen(PORT, () => {  //"0.0.0.0" in android emmulator we need to put this 
  console.log(`connected at port ${PORT}`);
//   console.log('connected at port '+PORT+"hello");
});
