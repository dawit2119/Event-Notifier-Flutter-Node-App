import UserModel from "../Models/User.js";
import bcryptjs from 'bcryptjs'
// Update User Account



export const updateProfile = async (httpreq, httpres) =>{
  try {
    const updateInfo = httpreq.body;
    const checkuser = await UserModel.findOne({
      emailAddress: updateInfo.emailAddress,
    }); 
    console.log(checkuser);
    if (checkuser) {
      const encryptedPassword = await bcryptjs.hash(updateInfo.password,10)
      updateInfo.password = encryptedPassword
      await  UserModel.updateOne(checkuser, { $set: updateInfo });
      console.log('Succesfully updated!');
      return httpres.status(201).send("Succesfully updated!");
    } else {
      return httpres.status(400).send("User doesnt exist");
    }
  } catch (error) {
    return httpres.status(500).send(error.message)
  }
}

// Delete User Account

export const  deleteProfile = async (httpreq, httpres)=> {

  

  try {
    const getuser = httpreq.body;

    const checkuser = await UserModel.findOne({
      emailAddress: getuser.emailAddress,
    });

    if (checkuser) {
      const hollyplace = checkuser.createdby
      if(hollyplace){
        await HolyPlaceModel.deleteOne({createdby:checkuser.id})
      }
      await UserModel.deleteOne({ emailAddress: checkuser.emailAddress });
      console.log("Deleted!")
      return httpres.status(200).send("Succesfully Deleted!");
    } else {
      return httpres.status(400).send("User doesnt exist");
    }
  } catch (error) {}
}