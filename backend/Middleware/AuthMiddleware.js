import jwt from "jsonwebtoken";
import dotenv from 'dotenv'
dotenv.config()
export const  VerifyCurrentToken = (req, res, next)=>{
   const tokeninheader  = req.headers.authorization;

   if (typeof tokeninheader !== 'undefined'){
       req.token = tokeninheader;
       jwt.verify(req.token  , process.env.JWT_KEY ,(err , authdata)=>{
        if(err){
          res.send(`${err}`);
        }
        else {
            console.log(authdata);
       next();
        }
    
      } );
   }
   else{
       res.send("Provide token please!");    
   }
}