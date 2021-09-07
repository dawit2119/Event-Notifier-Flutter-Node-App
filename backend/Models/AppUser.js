import mongoose from 'mongoose';
import  Schema  from 'mongoose';
import UserModel from './User.js';

const AppUserFields = {
     allsubscription :[{
        type:Schema.Types.ObjectId,
        ref:'Representative'
      }],
}


const AppUserModel = UserModel.discriminator('AppUser', new mongoose.Schema(AppUserFields));
export default AppUserModel;
