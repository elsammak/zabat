# Description: 
#   This script is to send status message to any user annonymously, User just send to bot & bot send to this user reporting him a bad behavior he did.
#   In teh end of each time interval ex. a week. Admin send reports to all people about their weekly attitudes & clear all this log     
#
# Commands:
#   hubot zabat <Full name> send <statusMessage> - Send statusMessage to this user 
#   hubot zabat show list - Show list of all available status messages
#   hubot zabat send reports - Only for admin, send reports for everyone about his current status
#   hubot zabat report admin - Only for admin, send current reports to admin mail without clearing them   
#   hubot zabat clear records - Only for admin, Clear reports of users & update historical data
#   hubot zabat clear history - Only for admin, Clear historical data
#   
# Author:
#   Elsammak
#
# Additional Requirements
#   unix mail client installed on the system

util = require 'util'
child_process = require 'child_process'
exec = child_process.exec
emailTime = null

statusMessages = {
  "Noise at the Workplace" : "http://www.castlepoint.gov.uk/Images/noise2.jpg"
  "Noise in the Kitchen" : "http://b.vimeocdn.com/ts/159/709/159709603_640.jpg"
  "Personal Interruptions" : "http://workawesome.com/wp-content/uploads/2010/04/dnd.jpg"
  "Nervous Habits" : "http://s1.hubimg.com/u/291212_f260.jpg"
  "Bad Smell" : "http://i.i.com.com/cnwk.1d/i/tim/2010/12/22/bad-smell-stinks-640_620x350.jpg"
  "Bad Breath" : "http://freshbreathesecrets.com/wp-content/uploads/2012/04/freshbreathesecrets1.jpg"
  "Roaming Around the Workplace" : "http://johnozed.com/wp-content/uploads/2009/03/30709-hoboken-nyc-008.jpg"
  "Invading Personal Privacy of Others" : "http://i-sight.com/uploads/Complainant-Interviews2.jpg"
  "Invading Work Privacy of Others" : "http://www.telecommonthly.com/wp-content/uploads/2012/03/privacy-policies.jpg"
  "Loud Music" : "http://farm3.static.flickr.com/2241/2430814612_3e35c4d1b7.jpg"
  "Load Ringtone" : "http://3.bp.blogspot.com/_YiE7n_Ne20k/SVZHpVaN_jI/AAAAAAAAF2k/GqWdp0IAtCY/s320/ringtone.gif"
  "Misuse of Others' or Company's Assets" : "http://shechive.files.wordpress.com/2010/07/misuse-5.jpg"
  "Spotted with Bad Attitudes" : "http://image.funscrape.com/images/b/bad_attitude-20659.jpg"
  "Insulting Others" : "http://2.bp.blogspot.com/_X39HLzFK070/S7zbJEEHv2I/AAAAAAAAADE/6U4m7lmaJAs/s1600/fighting1.jpg"
  "Demeaning Others" : "http://www.conflictdynamics.org/blog/wp-content/uploads/2012/02/balloon.jpg"
  "Crossing the Limits in Public" : "http://pccwomen.org/wp-content/uploads/2012/04/do-not-cross.jpg"
  "Body Sounds" : "http://ecx.images-amazon.com/images/I/61ZmoN4hZNL._SL500_AA300_.png"	
  "Lovely Smell" : "http://ecx.images-amazon.com/images/I/61ZmoN4hZNL._SL500_AA300_.png"	
  "This was Inspiring" : "http://ecx.images-amazon.com/images/I/61ZmoN4hZNL._SL500_AA300_.png"	
  "Thanks for Your Help" : "http://ecx.images-amazon.com/images/I/61ZmoN4hZNL._SL500_AA300_.png"	
  "This was Pleasantly Unexpected" : "http://ecx.images-amazon.com/images/I/61ZmoN4hZNL._SL500_AA300_.png"	
}

adminEmail = "admin@mailserver.com"

############################################## Send status message to user ########################################

#Send message to user

module.exports = (robot) ->
  robot.respond /zabat (.*) send (.*)/i, (msg) ->
    users = robot.usersForFuzzyName(msg.match[1].trim())
    user = ""
#Check for users existence

    if users.length is 1
       user = users[0]       
    else if users.length > 1
       msg.send "Too many users like that"
       return
    else
       msg.send "#{msg.match[1]}? Never heard of 'em"
       return

#Get the second parameter (message)

    user.disciplines = user.disciplines or [ ]
    status = msg.match[2].trim()
    if status == "Noise at the Workplace"
       if user.disciplines.workplaceNoise == undefined
          user.disciplines.workplaceNoise = 1
       else
          user.disciplines.workplaceNoise = user.disciplines.workplaceNoise + 1
    else if status == "Noise in the Kitchen"
       if user.disciplines.kitchenNoise == undefined
          user.disciplines.kitchenNoise = 1     
       else 
          user.disciplines.kitchenNoise = user.disciplines.kitchenNoise + 1 
    else if status == "Personal Interruptions"
       if user.disciplines.personalInterruptions == undefined
          user.disciplines.personalInterruptions = 1     
       else 
          user.disciplines.personalInterruptions = user.disciplines.personalInterruptions + 1 
    else if status == "Nervous Habits"
       if user.disciplines.nervousHabits == undefined
          user.disciplines.nervousHabits = 1     
       else 
          user.disciplines.nervousHabits = user.disciplines.nervousHabits + 1 
    else if status == "Bad Smell"
       if user.disciplines.badSmell == undefined
          user.disciplines.badSmell = 1     
       else 
          user.disciplines.badSmell = user.disciplines.badSmell + 1 
    else if status == "Bad Breath"
       if user.disciplines.badBreath == undefined
          user.disciplines.badBreath = 1     
       else 
          user.disciplines.badBreath = user.disciplines.badBreath + 1 
    else if status == "Roaming Around the Workplace"
       if user.disciplines.roamingAround == undefined
          user.disciplines.roamingAround = 1     
       else 
          user.disciplines.roamingAround = user.disciplines.roamingAround + 1 
    else if status == "Invading Personal Privacy of Others"
       if user.disciplines.invadingPersonalPrivacy == undefined
          user.disciplines.invadingPersonalPrivacy = 1     
       else 
          user.disciplines.invadingPersonalPrivacy = user.disciplines.invadingPersonalPrivacy + 1 
    else if status == "Invading Work Privacy of Others"
       if user.disciplines.invadingWorkPrivacy == undefined
          user.disciplines.invadingWorkPrivacy = 1     
       else 
          user.disciplines.invadingWorkPrivacy = user.disciplines.invadingWorkPrivacy + 1 
    else if status == "Loud Music"
       if user.disciplines.loudMusic == undefined
          user.disciplines.loudMusic = 1     
       else 
          user.disciplines.loudMusic = user.disciplines.loudMusic + 1 
    else if status == "Load Ringtone"
       if user.disciplines.loudRingtone == undefined
          user.disciplines.loudRingtone = 1     
       else 
          user.disciplines.loudRingtone = user.disciplines.loudRingtone + 1 
    else if status == "Misuse of Others' or Company's Assets"
       if user.disciplines.misuseAssets == undefined
          user.disciplines.misuseAssets = 1     
       else 
          user.disciplines.misuseAssets = user.disciplines.misuseAssets + 1 
    else if status == "Spotted with Bad Attitudes"
       if user.disciplines.badAttitudes == undefined
          user.disciplines.badAttitudes = 1     
       else 
          user.disciplines.badAttitudes = user.disciplines.badAttitudes + 1 
    else if status == "Insulting Others"
       if user.disciplines.insultingOthers == undefined
          user.disciplines.insultingOthers = 1     
       else 
          user.disciplines.insultingOthers = user.disciplines.insultingOthers + 1 
    else if status == "Demeaning Others"
       if user.disciplines.demeaningOthers == undefined
          user.disciplines.demeaningOthers = 1     
       else 
          user.disciplines.demeaningOthers = user.disciplines.demeaningOthers + 1 
    else if status == "Crossing the Limits in Public"
       if user.disciplines.crossingLimits == undefined
          user.disciplines.crossingLimits = 1     
       else 
          user.disciplines.crossingLimits = user.disciplines.crossingLimits + 1 
    else if status == "Body Sounds"
       if user.disciplines.bodySounds == undefined
          user.disciplines.bodySounds = 1     
       else 
          user.disciplines.bodySounds = user.disciplines.bodySounds + 1 
    else if status == "Lovely Smell"
       if user.disciplines.lovelySmell == undefined
          user.disciplines.lovelySmell = 1     
       else 
          user.disciplines.lovelySmell = user.disciplines.lovelySmell + 1 
    else if status == "This was Inspiring"
       if user.disciplines.inspiring == undefined
          user.disciplines.inspiring = 1     
       else 
          user.disciplines.inspiring = user.disciplines.inspiring + 1 
    else if status == "Thanks for Your Help"
       if user.disciplines.help == undefined
          user.disciplines.help = 1     
       else 
          user.disciplines.help = user.disciplines.help + 1 
    else if status == "This was Pleasantly Unexpected"
       if user.disciplines.unexpected == undefined
          user.disciplines.unexpected = 1     
       else 
          user.disciplines.unexpected = user.disciplines.unexpected + 1 
    else 
       msg.send "No such activity"
       return

#The following is the user email, in my case I used hipchat 

    replyTo = "31560_" + user.id + "@chat.hipchat.com"
    user.reply_to = replyTo
    robot.send user,statusMessages[status]
    robot.send user,"=====>#{status}<====="
    msg.send "Message sent to #{user.name}"

#save sender & his message

    user.senderHistory = user.senderHistory or ""

    if user.senderHistory == ""
      user.senderHistory = "Sender: #{msg.message.user.name} - Message: #{status}"
    else 
      user.senderHistory = user.senderHistory + " + Sender: #{msg.message.user.name} - Message: #{status}"


############################################## List all posibilities ########################################

#List all possibilities

  robot.respond /zabat show list/i, (msg) ->  
    array = ""
    for key, value of statusMessages
        array += key + "\n"
    msg.send array


############################################## Generate reports for user & sending them ########################################

#Generate report for each user

  robot.respond /zabat send reports/i, (msg) ->
    users = robot.users()     
#define message for each user
    for k, u of users
        u.disciplines = u.disciplines or [ ]
        if u.disciplines.workplaceNoise == undefined
             u.disciplines.workplaceNoise = 0 
        if u.disciplines.kitchenNoise == undefined
             u.disciplines.kitchenNoise = 0
        if u.disciplines.personalInterruptions == undefined
             u.disciplines.personalInterruptions = 0
        if u.disciplines.nervousHabits == undefined
             u.disciplines.nervousHabits = 0
        if u.disciplines.badSmell == undefined
             u.disciplines.badSmell = 0
        if u.disciplines.badBreath == undefined
             u.disciplines.badBreath = 0
        if u.disciplines.roamingAround == undefined
             u.disciplines.roamingAround = 0
        if u.disciplines.invadingPersonalPrivacy == undefined
             u.disciplines.invadingPersonalPrivacy = 0
        if u.disciplines.invadingWorkPrivacy == undefined
             u.disciplines.invadingWorkPrivacy = 0
        if u.disciplines.loudMusic == undefined
             u.disciplines.loudMusic = 0
        if u.disciplines.loudRingtone == undefined
             u.disciplines.loudRingtone = 0
        if u.disciplines.misuseAssets == undefined
             u.disciplines.misuseAssets = 0
        if u.disciplines.badAttitudes == undefined
             u.disciplines.badAttitudes = 0
        if u.disciplines.insultingOthers == undefined
             u.disciplines.insultingOthers = 0
        if u.disciplines.demeaningOthers == undefined
             u.disciplines.demeaningOthers = 0
        if u.disciplines.crossingLimits == undefined
             u.disciplines.crossingLimits = 0
        if u.disciplines.bodySounds == undefined
             u.disciplines.bodySounds = 0
        if u.disciplines.lovelySmell == undefined
             u.disciplines.lovelySmell = 0        
        if u.disciplines.inspiring == undefined
             u.disciplines.inspiring = 0        
        if u.disciplines.help == undefined
             u.disciplines.help = 0        
        if u.disciplines.unexpected == undefined
             u.disciplines.unexpected = 0     
   
        # Header message
        headerMessage = "Here is a summary of the badges you were sent this week."
        if u.disciplines.bodySounds == 0 and u.disciplines.crossingLimits == 0 and u.disciplines.demeaningOthers == 0 and u.disciplines.insultingOthers ==0 and u.disciplines.badAttitudes == 0 and u.disciplines.loudRingtone == 0 and u.disciplines.misuseAssets == 0 and u.disciplines.loudMusic == 0 and u.disciplines.invadingWorkPrivacy == 0 and  u.disciplines.invadingPersonalPrivacy == 0 and u.disciplines.roamingAround == 0 and u.disciplines.badBreath == 0 and u.disciplines.badSmell == 0 and u.disciplines.nervousHabits == 0 and u.disciplines.personalInterruptions == 0 and u.disciplines.kitchenNoise == 0 and u.disciplines.workplaceNoise == 0
           headerMessage = "You are awesome. You were not sent any negative badges this week."
      
        message = headerMessage + "\n-------------------  \nNoise at the Workplace: "+u.disciplines.workplaceNoise + "\nNoise in the Kitchen: "+u.disciplines.kitchenNoise + "\nPersonal Interruptions: "+u.disciplines.personalInterruptions + "\nNervous Habits: "+u.disciplines.nervousHabits + "\nBad Smell: "+u.disciplines.badSmell + "\nBad Breath: "+u.disciplines.badBreath + "\nRoaming Around the Workplace: "+u.disciplines.roamingAround + "\nInvading Personal Privacy of Others: "+u.disciplines.invadingPersonalPrivacy + "\nInvading Work Privacy of Others: "+u.disciplines.invadingWorkPrivacy + "\nLoud Music: "+u.disciplines.loudMusic + "\nLoad Ringtone: "+u.disciplines.loudRingtone + "\nMisuse of Others' or Company's Assets: "+u.disciplines.misuseAssets + "\nSpotted with Bad Attitudes: "+u.disciplines.badAttitudes + "\nInsulting Others: "+u.disciplines.insultingOthers + "\nDemeaning Others: "+u.disciplines.demeaningOthers + "\nCrossing the Limits in Public: "+u.disciplines.crossingLimits + "\nBody Sounds: "+u.disciplines.bodySounds + "\nLovely Smell: "+u.disciplines.lovelySmell + "\n Inspiring: "+u.disciplines.inspiring + "\nHelp others: "+u.disciplines.help + "\nUnexpected actions: "+u.disciplines.unexpected

        sendEmail u.email, "Your Badges This Week", message, msg.message.user.id
    msg.send "Reports sent"

############################################## Clear records & store historical data ################################

#Clear records & store historical data

  robot.respond /zabat clear records/i, (msg) ->
    users = robot.users()     
    for k, u of users
        u.disciplines = u.disciplines or [ ]
        u.historicalDisciplines = u.historicalDisciplines or [ ]
# set right values of disciplines
        if u.disciplines.workplaceNoise == undefined
             u.disciplines.workplaceNoise = 0 
        if u.disciplines.kitchenNoise == undefined
             u.disciplines.kitchenNoise = 0
        if u.disciplines.personalInterruptions == undefined
             u.disciplines.personalInterruptions = 0
        if u.disciplines.nervousHabits == undefined
             u.disciplines.nervousHabits = 0
        if u.disciplines.badSmell == undefined
             u.disciplines.badSmell = 0
        if u.disciplines.badBreath == undefined
             u.disciplines.badBreath = 0
        if u.disciplines.roamingAround == undefined
             u.disciplines.roamingAround = 0
        if u.disciplines.invadingPersonalPrivacy == undefined
             u.disciplines.invadingPersonalPrivacy = 0
        if u.disciplines.invadingWorkPrivacy == undefined
             u.disciplines.invadingWorkPrivacy = 0
        if u.disciplines.loudMusic == undefined
             u.disciplines.loudMusic = 0
        if u.disciplines.loudRingtone == undefined
             u.disciplines.loudRingtone = 0
        if u.disciplines.misuseAssets == undefined
             u.disciplines.misuseAssets = 0
        if u.disciplines.badAttitudes == undefined
             u.disciplines.badAttitudes = 0
        if u.disciplines.insultingOthers == undefined
             u.disciplines.insultingOthers = 0
        if u.disciplines.demeaningOthers == undefined
             u.disciplines.demeaningOthers = 0
        if u.disciplines.crossingLimits == undefined
             u.disciplines.crossingLimits = 0
        if u.disciplines.bodySounds == undefined
             u.disciplines.bodySounds = 0
        if u.disciplines.lovelySmell == undefined
             u.disciplines.lovelySmell = 0        
        if u.disciplines.inspiring == undefined
             u.disciplines.inspiring = 0        
        if u.disciplines.help == undefined
             u.disciplines.help = 0        
        if u.disciplines.unexpected == undefined
             u.disciplines.unexpected = 0 
# set right values of historical disciplines
        if u.historicalDisciplines.workplaceNoise == undefined
             u.historicalDisciplines.workplaceNoise = 0 
        if u.historicalDisciplines.kitchenNoise == undefined
             u.historicalDisciplines.kitchenNoise = 0
        if u.historicalDisciplines.personalInterruptions == undefined
             u.historicalDisciplines.personalInterruptions = 0
        if u.historicalDisciplines.nervousHabits == undefined
             u.historicalDisciplines.nervousHabits = 0
        if u.historicalDisciplines.badSmell == undefined
             u.historicalDisciplines.badSmell = 0
        if u.historicalDisciplines.badBreath == undefined
             u.historicalDisciplines.badBreath = 0
        if u.historicalDisciplines.roamingAround == undefined
             u.historicalDisciplines.roamingAround = 0
        if u.historicalDisciplines.invadingPersonalPrivacy == undefined
             u.historicalDisciplines.invadingPersonalPrivacy = 0
        if u.historicalDisciplines.invadingWorkPrivacy == undefined
             u.historicalDisciplines.invadingWorkPrivacy = 0
        if u.historicalDisciplines.loudMusic == undefined
             u.historicalDisciplines.loudMusic = 0
        if u.historicalDisciplines.loudRingtone == undefined
             u.historicalDisciplines.loudRingtone = 0
        if u.historicalDisciplines.misuseAssets == undefined
             u.historicalDisciplines.misuseAssets = 0
        if u.historicalDisciplines.badAttitudes == undefined
             u.historicalDisciplines.badAttitudes = 0
        if u.historicalDisciplines.insultingOthers == undefined
             u.historicalDisciplines.insultingOthers = 0
        if u.historicalDisciplines.demeaningOthers == undefined
             u.historicalDisciplines.demeaningOthers = 0
        if u.historicalDisciplines.crossingLimits == undefined
             u.historicalDisciplines.crossingLimits = 0
        if u.historicalDisciplines.bodySounds == undefined
             u.historicalDisciplines.bodySounds = 0
        if u.historicalDisciplines.lovelySmell == undefined
             u.historicalDisciplines.lovelySmell = 0        
        if u.historicalDisciplines.inspiring == undefined
             u.historicalDisciplines.inspiring = 0        
        if u.historicalDisciplines.help == undefined
             u.historicalDisciplines.help = 0        
        if u.historicalDisciplines.unexpected == undefined
             u.historicalDisciplines.unexpected = 0 
#start storing
        u.historicalDisciplines.workplaceNoise+= u.disciplines.workplaceNoise 
        u.historicalDisciplines.kitchenNoise+= u.disciplines.kitchenNoise
        u.historicalDisciplines.personalInterruptions+= u.disciplines.personalInterruptions
        u.historicalDisciplines.nervousHabits+= u.disciplines.nervousHabits
        u.historicalDisciplines.badSmell+= u.disciplines.badSmell
        u.historicalDisciplines.badBreath+= u.disciplines.badBreath
        u.historicalDisciplines.roamingAround+= u.disciplines.roamingAround
        u.historicalDisciplines.invadingPersonalPrivacy+= u.disciplines.invadingPersonalPrivacy
        u.historicalDisciplines.invadingWorkPrivacy+= u.disciplines.invadingWorkPrivacy
        u.historicalDisciplines.loudMusic+= u.disciplines.loudMusic
        u.historicalDisciplines.loudRingtone+= u.disciplines.loudRingtone
        u.historicalDisciplines.misuseAssets+= u.disciplines.misuseAssets
        u.historicalDisciplines.badAttitudes+= u.disciplines.badAttitudes
        u.historicalDisciplines.insultingOthers+= u.disciplines.insultingOthers
        u.historicalDisciplines.demeaningOthers+= u.disciplines.demeaningOthers
        u.historicalDisciplines.crossingLimits+= u.disciplines.crossingLimits
        u.historicalDisciplines.bodySounds+= u.disciplines.bodySounds   
        u.historicalDisciplines.lovelySmell+= u.disciplines.lovelySmell   
        u.historicalDisciplines.inspiring+= u.disciplines.inspiring   
        u.historicalDisciplines.help+= u.disciplines.help   
        u.historicalDisciplines.unexpected+= u.disciplines.unexpected   

#clear user records
        u.disciplines =  [ ]
    msg.send "Records stored & cleared!"


############################################## Send email to user ########################################

#send mail to user

  sendEmail = (recipients, subject, msg, from) ->
    mailCommand = "echo \"#{msg}\" | mail -s \"#{subject}\" -r #{from} #{recipients}"
    exec mailCommand, (error, stdout, stderr) ->
      util.print 'stdout: ' + stdout
      util.print 'stderr: ' + stderr
############################################## Clear historical data ################################

#Clear historical data

  robot.respond /zabat clear history/i, (msg) ->
    users = robot.users()     
    for k, u of users
        u.historicalDisciplines = [ ]
        u.senderHistory = ""
    msg.send "Memory cleaned!"

############################################## Send All reports to the Admin ########################################

#send reports to admin

  robot.respond /zabat report admin/i, (msg) ->
    users = robot.users()     
    message = ""
    for k, u of users
        u.disciplines = u.disciplines or [ ]
        if u.disciplines.workplaceNoise == undefined
             u.disciplines.workplaceNoise = 0 
        if u.disciplines.kitchenNoise == undefined
             u.disciplines.kitchenNoise = 0
        if u.disciplines.personalInterruptions == undefined
             u.disciplines.personalInterruptions = 0
        if u.disciplines.nervousHabits == undefined
             u.disciplines.nervousHabits = 0
        if u.disciplines.badSmell == undefined
             u.disciplines.badSmell = 0
        if u.disciplines.badBreath == undefined
             u.disciplines.badBreath = 0
        if u.disciplines.roamingAround == undefined
             u.disciplines.roamingAround = 0
        if u.disciplines.invadingPersonalPrivacy == undefined
             u.disciplines.invadingPersonalPrivacy = 0
        if u.disciplines.invadingWorkPrivacy == undefined
             u.disciplines.invadingWorkPrivacy = 0
        if u.disciplines.loudMusic == undefined
             u.disciplines.loudMusic = 0
        if u.disciplines.loudRingtone == undefined
             u.disciplines.loudRingtone = 0
        if u.disciplines.misuseAssets == undefined
             u.disciplines.misuseAssets = 0
        if u.disciplines.badAttitudes == undefined
             u.disciplines.badAttitudes = 0
        if u.disciplines.insultingOthers == undefined
             u.disciplines.insultingOthers = 0
        if u.disciplines.demeaningOthers == undefined
             u.disciplines.demeaningOthers = 0
        if u.disciplines.crossingLimits == undefined
             u.disciplines.crossingLimits = 0
        if u.disciplines.bodySounds == undefined
             u.disciplines.bodySounds = 0
        if u.disciplines.lovelySmell == undefined
             u.disciplines.lovelySmell = 0        
        if u.disciplines.inspiring == undefined
             u.disciplines.inspiring = 0        
        if u.disciplines.help == undefined
             u.disciplines.help = 0        
        if u.disciplines.unexpected == undefined
             u.disciplines.unexpected = 0 


        message += "\n\nReport for "+u.name + "\n--------------------------------\nNoise at the Workplace: "+u.disciplines.workplaceNoise + "\nNoise in the Kitchen: "+u.disciplines.kitchenNoise + "\nPersonal Interruptions: "+u.disciplines.personalInterruptions + "\nNervous Habits: "+u.disciplines.nervousHabits + "\nBad Smell: "+u.disciplines.badSmell + "\nBad Breath: "+u.disciplines.badBreath + "\nRoaming Around the Workplace: "+u.disciplines.roamingAround + "\nInvading Personal Privacy of Others: "+u.disciplines.invadingPersonalPrivacy + "\nInvading Work Privacy of Others: "+u.disciplines.invadingWorkPrivacy + "\nLoud Music: "+u.disciplines.loudMusic + "\nLoad Ringtone: "+u.disciplines.loudRingtone + "\nMisuse of Others' or Company's Assets: "+u.disciplines.misuseAssets + "\nSpotted with Bad Attitudes: "+u.disciplines.badAttitudes + "\nInsulting Others: "+u.disciplines.insultingOthers + "\nDemeaning Others: "+u.disciplines.demeaningOthers + "\nCrossing the Limits in Public: "+u.disciplines.crossingLimits + "\nBody Sounds: "+u.disciplines.bodySounds  + "\nLovely smell : "+u.disciplines.lovelySmell + "\nInspiring: "+u.disciplines.inspiring + "\nHelp: "+u.disciplines.help + "\nUnexpected: "+u.disciplines.unexpected+"\n____________________________________________"

    sendEmail adminEmail, "Total Evaluation", message, msg.message.user.id
    msg.send "Mail sent"
