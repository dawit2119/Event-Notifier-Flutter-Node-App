import UserModel from '../Models/User.js'
import RepresentativeModel from '../Models/Representative.js';
import AppUserModel from '../Models/AppUser.js';
import HolyPlaceModel from '../Models/Holyplace.js';
import ScheduleModel from '../Models/Schedule.js';

export const removeRole = async(req,res)=>{
     try {
         const id = req.params.id
         const user = await UserModel.findById(id)
         if(user){
                console.log(user)
                if(user.userRole == "User"){
                    console.log(`user is app user and its name is ${user.name}`)
                    const allSubscriptions = user.allsubscription
                    if(allSubscriptions){
                        allSubscriptions.map(async(subscription)=>{
                            const representative = await RepresentativeModel.findById(subscription)
                            representative.allsubscriber.pull(id)
                            await representative.save()
                        })
                    }
                    await AppUserModel.findByIdAndDelete(id)
                    console.log("User role is removed")
                    res.status(200).json({message:"User role is removed"})
                }
                if(user.userRole=="Representative"){
                    const holyplace = await HolyPlaceModel.findOne({createdby:id})
                    if(holyplace){
                        await HolyPlaceModel.deleteOne(holyplace)

                    }
                    const allSubscribers = user.allsubscriber
                    if(allSubscribers.length){
                        allSubscribers.map(async(subscriber)=>{
                            const sub = await AppUserModel.findById(subscriber)
                            sub.allsubscription.pull(id)
                            await sub.save()
                        })

                    }
                    const postedSchedules = user.postedSchedules
                    if(postedSchedules.length){
                        postedSchedules.map(async(schedule)=>{
                            const sch = await ScheduleModel.findByIdAndDelete(schedule)
                        })
                    }
                    await RepresentativeModel.findByIdAndDelete(id);
                    console.log("representative is deleted")
                    res.status(200).json({message:"representative is deleted"})

                }
         }else {
             console.log("user doesn't exist")
             return res.status(404).json({message:"user doesn't exist"})}
     } catch (error) {
         res.status(500).json({message:error.message})
     }

}

export const toRepresentative= async(req,res)=>{
    try {
        const id = req.body.id
        const allSubscriptions = user.allsubscription
        if(allSubscriptions){
            allSubscriptions.map(async(subscription)=>{
                const representative = await RepresentativeModel.findById(subscription)
                representative.allsubscriber.pull(id)
                await representative.save()
            })
        }
        await AppUserModel.findByIdAndDelete(id)
        req.body.userRole = "Representative"
        await RepresentativeModel.create(req.body)
        console.log("user is granted to representative")
        return res.status(201).json({message:"user is granted to representative"})
    } catch (error) {
        console.log(error.message)
        return res.status(500).json({message:error.message})
    }

}
export const toAppUser = async(req,res)=>{
    try {
        id = req.body.id
        const holyplace = await HolyPlaceModel.findOne({createdby:id})
        if(holyplace){
            await HolyPlaceModel.deleteOne(holyplace)

        }
        const allSubscribers = user.allsubscriber
        if(allSubscribers.length){
            allSubscribers.map(async(subscriber)=>{
                const sub = await AppUserModel.findById(subscriber)
                sub.allsubscription.pull(id)
                await sub.save()
            })

        }
        const postedSchedules = user.postedSchedules
        if(postedSchedules.length){
            postedSchedules.map(async(schedule)=>{
                const sch = await ScheduleModel.findByIdAndDelete(schedule)
            })
        }
        await RepresentativeModel.findByIdAndDelete(id);
        req.body.rolte = "User"
        console.log("representative is revoked to User")
        res.status(201).json({message:"representative is revoked to User"})

    }

    catch (error) {
        console.log(error.message)
        return res.status({message:error.message})
    }
}
