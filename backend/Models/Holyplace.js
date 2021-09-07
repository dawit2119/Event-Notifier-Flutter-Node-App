import mongoose from "mongoose";
import  Schema  from 'mongoose';

const HolyplaceFields = {
  createdby: {
    type: Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },

  name: {
    type: String,
    default: null,
    required: true,
  },
  location: {
    type: String,
    default: null,
    required: true,
  },
  history: {
    type: String,
    default: null,
    required: true,
  },
  image: {
    type: String,
    default: null,
  },
};

const HolyPlaceSchema =new mongoose.Schema(HolyplaceFields , {timestamps:true});

const HolyPlaceModel = mongoose.model("Holyplaces", HolyPlaceSchema);

export default HolyPlaceModel;
