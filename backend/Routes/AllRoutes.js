import { Signup, Login , getallusers } from "../Controller/AuthController.js";
import { deleteProfile, updateProfile } from "../Controller/ProfileController.js";
import { createSchedule,getRepSchedules,getNewSchedules,getNotSeenNumber,allSchedules, deleteSchedule, getallSchedules, updateSchedule } from "../Controller/ScheduleController.js";
import {createHolyPlace , getAllHolyPlaces} from "../Controller/HolyplaceController.js"
import { Subscribe  , unSubscribe,getAllSubscriptions} from "../Controller/SubscriptionController.js";
import { removeRole,toAppUser, toRepresentative } from "../Controller/adminController.js";
import express from "express";
import { VerifyCurrentToken } from "../Middleware/AuthMiddleware.js";

// Auth Router

const allroutes = express.Router() ;

allroutes.post("/RegisterUser", Signup);

allroutes.post("/LoginUser", Login);

// Profile allroutes

allroutes.delete("/DeleteProfile", VerifyCurrentToken, deleteProfile);

allroutes.put("/UpdateProfile", updateProfile);
allroutes.get("/getAllUsers" ,getallusers )

//ScheduleRoute



allroutes.post("/createSchedule", createSchedule);

allroutes.delete("/deleteschedule", deleteSchedule);

allroutes.put("/updateschedule", updateSchedule);

allroutes.get("/getallSchedules", getallSchedules);
allroutes.get("/allschedules/:id", allSchedules);
allroutes.get("/getnewschedules/:id", getNewSchedules);
allroutes.get("/getnotseennumber/:id", getNotSeenNumber);
allroutes.get("/getrepschedules/:id", getRepSchedules);

//HolyPlace 

allroutes.post('/createHolyPlace' ,createHolyPlace );

allroutes.get('/getallholyplaces' ,getAllHolyPlaces );
// Subscription 
allroutes.get('/getallsubscriptions/:id',getAllSubscriptions);
allroutes.post('/subscribe' ,Subscribe );
allroutes.post('/unsubscribe' ,unSubscribe );

//Autorization part 
allroutes.post('/removerole/:id',removeRole)
allroutes.post('/toappuser',toAppUser)
allroutes.post('/torepresentative',toRepresentative)

export default allroutes;

