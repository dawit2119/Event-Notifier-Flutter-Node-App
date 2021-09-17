import ScheduleModel from "../Models/Schedule.js";
import RepresentativeModel  from "../Models/Representative.js";
import HolyPlaceModel from "../Models/Holyplace.js"

export const createSchedule = async (httpreq, httpres) => {
  console.log("create schedule request is comming");
  try {
    const postedSchedule = httpreq.body;
    const programs = postedSchedule.programs.split(',')
    postedSchedule.programs = programs
    console.log(postedSchedule)
    const schedule = new ScheduleModel(postedSchedule);
    await schedule.save();
    console.log(schedule);

    const creator = await RepresentativeModel.findById({
      _id: postedSchedule.createdby,
    });
    console.log("creater is found")
    const holyplace = await HolyPlaceModel.findOne({"createdby":postedSchedule.createdby})
    if(holyplace == null){
      console.log("You haven not added hollyplace")
      return httpres.status(403).send("You haven't added hollyplace")
    }
    creator.postedSchedules.push(schedule);  
    await creator.save();   
     
    if (schedule) {
      return httpres.status(201).json({ message: "Schedule Created" });
    } else {
      return httpres
        .status(400)
        .json({ message: "Sorry Failed to Create Schedule." });
    }
  } catch (error) {
    console.log(error);
  }
};


export const deleteSchedule = async (httpreq, httpres) => {
  console.log('delete request is comming')
  try {   
    const scheduleInfo = httpreq.body 

    const findSchedule = await ScheduleModel.findById(scheduleInfo.id);
    if (findSchedule) {
      await ScheduleModel.deleteOne(findSchedule);
      return httpres.status(200).send("Schedule Deleted Succesfully");
    }

    return httpres.status(404).send(`schedule not found`);
  } catch (error) {
    console.log(error);
    return httpres.status(500).send(error.message);
  }
};

export const updateSchedule = async (httpreq, httpres) => {
  console.log("update request")
  try {
    const updateInfo = httpreq.body;

    const checkSchedule = await ScheduleModel.findOne({
      _id: updateInfo.id,
    });

    if (checkSchedule) {
      await ScheduleModel.updateOne(checkSchedule, { $set: updateInfo });
      return httpres.status(201).send("Succesfully updated!");
    } else {
      return httpres.status(400).send("Schedule Doesnt exist");
    }
  } catch (error) {
    console.log(error);
    res.statu(500).send(error.message)
  }
};

export const getallSchedules = async (httpreq, httpres) => {
  try {
    const schedules = await ScheduleModel.find();
    if (schedules != null) {
      return httpres.status(200).json({ Schedules: schedules });
    } else {
      return httpres.status(400).send("Sorry, didnt get any schedule!");
    }

    // return httpres.status(200).json({"message":"schedules"})
  } catch (error) {
    console.log(error);
    res.status(500).send(error.message)
  }
};

export const allSchedules = async(req,res)=>{

  try {
    console.log("all my schedules requst is comming")
      const id = req.params.id
      const representative = await RepresentativeModel.findById(id)
      if(representative){
        console.log(representative);    
        const schedules = []
        const postedSchedules = representative.postedSchedules
        console.log(`posted schedules ${postedSchedules}`);
        if(postedSchedules.length > 0){
          postedSchedules.map(async(sch,index)=>{
            const schedule = await ScheduleModel.findById(sch);
            console.log(schedule)  
            if(schedule){
            schedules.push(schedule)
            }
            if(index == postedSchedules.length - 1){
                console.log(schedules)
                return res.status(200).json({schedules})
            }
          })
        } 
        else{
          console.log("dave")
          return res.status(200).json({schedules:[]})}
      }else{
        console.log("Representative doesn't exist")

        return res.status(404).json({messgae:"Representative doesn't exist"})}
  } catch (error) {
     console.log(error.message)
      return res.status(5000).json({message:"server error"})
  }
}

export const getNewSchedules = async(req,res)=>{
  console.log("not seen schedule request is comming")
  try {
    const id = req.params.id
    console.log("id")
    console.log(id)
    const newSchedules = []  
    const allSchedules = await ScheduleModel.find()
    if(allSchedules.length){
    allSchedules.map(async(sch,index)=>{
      if(!sch.seenbyusers){
      const repre = await RepresentativeModel.findById(sch.createdby)
      const hollyplace = await HolyPlaceModel.findOne({createdby:sch.createdby})
      console.log(hollyplace.name)
      console.log({...sch,madeby:"Dave"}._doc)
      console.log({...sch,madeby:"Dave"}.hollyplacename)
      if(repre.allsubscriber.includes(id)){
        newSchedules.push({...sch,hollyplacename:hollyplace.name})
        sch.seenbyusers = true
        await sch.save()
      }
    }if(index == allSchedules.length - 1){
      return res.status(200).json({newSchedules})
    }
    })}else return  res.status(200).json({newSchedules})
  } catch (error) {
    return res.status(500).json({message:error.message})
  }
}
export const getNotSeenNumber = async(req,res)=>{
  try {
    const id = req.params.id
    console.log(`id ${id}`) 
    var notseennumber = 0
    const allSchedules = await ScheduleModel.find()
    if(allSchedules.length){ 
    allSchedules.map(async(sch,index)=>{
      if(!sch.seenbyusers){
      console.log(sch)
      const repre = await RepresentativeModel.findById(sch.createdby)
      console.log(`repre found and notseennumber ${notseennumber}`)
      if(repre.allsubscriber.includes(id)){
        notseennumber +=1
      }
    }
    if(index == allSchedules.length - 1){
      console.log(`not seen number ${notseennumber}`)
      return res.status(200).json({notseennumber})
    }
    })}else return  res.status(200).json({notseennumber})
  } catch (error) {
    return res.status(500).json({message:error.message})
  }
}

export const getRepSchedules = async(req,res)=>{

  try {
    const id = req.params.id

    const rep = await RepresentativeModel.findById(id)
    const hollyplace = await HolyPlaceModel.findOne({createdby:id})
    const allschedules = []
    const postedSchedules = rep.postedSchedules
    if(postedSchedules.length){
        postedSchedules.map(async(id,index)=>{
          const schedule = await ScheduleModel.findById(id);
          allschedules.push({...schedule,name:hollyplace.name})
          console.log(allschedules)
          if(index == postedSchedules.length -1){
            console.log("done")
            return res.status(200).json({allschedules})
          } 
        })
    }else{return res.status(200).json({allschedules})}
  } catch (error) {
    return res.status(500).json({messae:error.message})
  }
}