
import mongoose from 'mongoose';

const options = {
  discriminatorKey: 'userrole', 
  collection: 'users', 
};


const UserFields = {

  fullName: {
    type: String,
    default: null,
    required: true,
  },


  userName: {
    type: String,
    default: null,
    required: true,
  },
  emailAddress: {
    type: String,
    default: null,
    required: true,
  },

  password: {
    type: String,
    default: null,
    required: true,
  },
  confirmPassword: {
    type: String,
    default: null,
    required: true,
  },
  userRole: {
    type: String,
    default: null,
    required: true,
  },
};


const UserSchema = new mongoose.Schema(UserFields ,options ,{timestamps:true});
const UserModel = mongoose.model("User", UserSchema);

 export default UserModel;

