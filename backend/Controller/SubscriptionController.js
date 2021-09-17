import UserModel from "../Models/User.js";
import HolyPlaceModel from '../Models/Holyplace.js'
  
export const getAllSubscriptions = async(req,res)=>{
  try {
    const id = req.params.id
    const user = await UserModel.findById(id)
    if(!user){
      return res.status(404).send("user doesn't exist")
    }
    else{
      const subscribedPlaces = [];
      const allSubscriptions = user.allsubscription
      console.log(allSubscriptions)
      if(allSubscriptions.length==0){
        return res.status(200).json({subscribedPlaces})
      }
      const numberOfSubscriptions = allSubscriptions.length-1
      allSubscriptions.map(async(subscription,index)=>{
        const subcribedPlace = await HolyPlaceModel.findOne({"createdby":subscription})
        subscribedPlaces.push(subcribedPlace)
        if(index == numberOfSubscriptions){
        return res.status(200).json({subscribedPlaces})
       
        }
      })
    } 
  } catch (error) {
    console.log(error)
  }
}
export const Subscribe = async (httpreq, httpres) => {
    try {
      
        const subscriberInfo = httpreq.body;
        const representativeId = subscriberInfo['representativeId'];
        const appUserId = subscriberInfo['appUserId']
        const checkuser = await UserModel.findOne({_id:representativeId});
        console.log(`representative ${checkuser}`)
        if( checkuser){
          console.log("checkuser is found")
            const getAppUser = await UserModel.findOne({
                _id:appUserId ,
              });
              console.log(`appUser ${getAppUser}`);
          
              const index = checkuser.allsubscriber.indexOf(appUserId);

              if( index == -1){
            checkuser.allsubscriber.push(getAppUser);
            await checkuser.save()
            getAppUser.allsubscription.push(checkuser);
            await  getAppUser.save()
              }
              
            return httpres.status(201).json({ message: " Sucessfully Subscribed" });

        } 

            return httpres
              .status(400)
              .send("failed");
        
    } catch (error) {

        console.log(error); 
    }
};
export const unSubscribe = async (httpreq, httpres) => {

  try {
    const subscriberInfo = httpreq.body;
    const representativeId = subscriberInfo['representativeId'];
    const appUserId = subscriberInfo['appUserId']
    const checkuser = await UserModel.findOne({
        _id: representativeId,
      });
    if( checkuser){
        const getAppUser = await UserModel.findOne({
            _id:appUserId ,
          });
            checkuser.allsubscriber.pull(getAppUser);
            await checkuser.save()
            getAppUser.allsubscription.pull(checkuser);
            await getAppUser.save();
    
          return httpres.status(201).json({ message: " Sucessfully UnSubscribe" });
    }

        return httpres
          .status(400)
          .send("failed");
    
} catch (error) {

    console.log(error);
    
}
};




  