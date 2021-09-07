import mongoose from 'mongoose';
import  Schema  from 'mongoose';
import UserModel from './User.js';

const RepresentativeFields = {

    holyplace :{
        type:Schema.Types.ObjectId,
        ref:'Holyplaces'
      },

    allsubscriber :[{
        type:Schema.Types.ObjectId,
        ref:'AppUser'
    }],
    
    postedSchedules :[
          {
        type:Schema.Types.ObjectId,
        ref:'Schedule',
         }
      ],
}


const RepresentativeModel = UserModel.discriminator('Representative', new mongoose.Schema(RepresentativeFields));
export default RepresentativeModel;
