import mongoose from 'mongoose';
import  Schema   from 'mongoose';


const ScheduleFields = {

  createdby: {
    type: Schema.Types.ObjectId,
    ref:'Representative',
    required: true,
  },
  title:{
    type:String,
    required:true,
  },
  description:{
    type:String,
    required:true,
  },
  dateofcreation: {
    type: Date,
    default: Date.now,
  },
  seenbyusers:{
    type:Boolean,
    default:false,
  }
  ,
  programs: [{
    type: String,
    required: true,
  }],

};


const ScheduleSchema = mongoose.Schema(ScheduleFields , {timestamps:true});
const ScheduleModel = mongoose.model("Schedule", ScheduleSchema);

export default ScheduleModel