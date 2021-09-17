import jwt from 'jsonwebtoken'
import bcryptjs from 'bcryptjs'
import HolyPlaceModel from '../Models/Holyplace.js';
import UserModel from '../Models/User.js';
import RepresentativeModel from '../Models/Representative.js';



export const createHolyPlace = async (httpreq, httpres) => {
    try {
 
      const getHolyPlaceInfo = httpreq.body;
      const holyplace = new HolyPlaceModel(getHolyPlaceInfo);
      console.log(`holyplace ${holyplace}`)
      
      const creator = await RepresentativeModel.findById({

        _id: getHolyPlaceInfo.createdby,
      });
      console.log(`create ${creator}`)
      if(creator == null){
        return httpres
        .status(400)
        .json({ message: "Sorry Failed to Create holyplace." });
      }

      if(creator){
          if(typeof creator.holyplace == 'undefined' ){
            creator.holyplace = holyplace;
            await holyplace.save();

            await creator.save();
            console.log("holyplace Created")
            return httpres.status(201).json({ message: "holyplace Created" });         
          }
          else {
            console.log("You have already created hollyplace")
            return httpres

              .status(400)

              .json({ message: "You have already created hollyplace" });
          }
        
      } 

    } catch (error) {

      console.log(error);
      httpres.status(500).json({message:error.message})

    }


  };

// get all Holyplaces 


  export const getAllHolyPlaces = async (httpreq, httpres) => {
    try {
      const holyplaces = await HolyPlaceModel.find();
      if (holyplaces) {
          
          const lastholyplace = holyplaces.length - 1;
        
          await holyplaces.map(async (holyplace , index)=>{

          const creator = await RepresentativeModel.findById({

            _id: holyplace.createdby,

          });

          holyplace.createdby = creator;
          await holyplace.save();
          if(index == lastholyplace){

            return httpres.status(200).json({ holyplaces:  holyplaces });

          }

        });

      } else {
        return httpres.status(400).send("Sorry, didnt get any holyplaces!");
      }
  
    } catch (error) {
      console.log(error);
    }
  };


  

