const { con } = require("../db");
const { v4: uuid } = require("uuid");

function query(q, params = []) {
    return new Promise((resolve) => {
        if (!con) {
            console.error("Database connection 'con' is not initialized!");
            return resolve(null);
        }
        
        con.query(q, params, (err, result) => {
            if (err) {
                console.error("Database Query Error:", err);
                console.error("Query:", q);
                return resolve(null); // Return null instead of crashing
            }
            resolve(result);
        });
    });
}

async function sendToAi(data){

    data.requestId = uuid()
    // Send message to local AI client
    console.log("about to send request id",data.requestId)
  aiClient.emit("request_to_ai", JSON.parse(JSON.stringify(data)))
    

  // Wait for response from AI client
  const answer = await new Promise((resolve) => {
    const handler = (receivedData) => {

        console.log("sent request id",data.requestId)
        console.log("received request id",receivedData.requestId)

      if (data.requestId === receivedData.requestId) {
          console.log("MATCH !!!!!!!!!!!!!!!")
        resolve(receivedData.answer);
        aiClient.off("response_from_ai", handler);
      }
    };
    aiClient.on("response_from_ai", handler);
  });
  return answer
}


async function getResponse(messages,platform_source,platform_user_id){
    let message = messages[messages.length - 1]
    
    
    // adding previous messages in query for classifier
    if(messages[messages.length - 1].content.includes('classifier for user question')){
        if(messages.length == 1)
            message.content = `${message.content}
        

        this is the first message from customer
        `
        else if(messages.length>2)
            message.content = `${message.content}
        
        Last Customer Question before this Question is
        ((( ${messages[messages.length - 3].content} )))
        
        and you answered by this:
        ((( ${messages[messages.length - 2].content} )))
        `
        
        if(messages.length>4)
            message.content = `${message.content}
        
        and the Customer Question before even that Question is
        ((( ${messages.filter(message=>message.role=='user')[messages.filter(message=>message.role=='user').length - 3].content} )))
        `
        
        if(messages.length>6)
            message.content = `${message.content}
        
        and the Customer Question before even above Question is
        ((( ${messages.filter(message=>message.role=='user')[messages.filter(message=>message.role=='user').length - 4].content} )))
        `
    }
    
    
    // adding previous messages in query for chat
    else if(platform_source == 'messenger'){
        var last_messages = await query(
            `select * from facebook_messages 
             where lead_id = (select crm_lead_id from crm_lead_social_profiles where platform='facebook' and platform_user_id=? LIMIT 1) 
             order by id desc limit 4 offset 1`,
            [platform_user_id]
        )

        var profiles = await query(
            `select * from crm_lead_social_profiles 
             where platform = 'facebook' and platform_user_id=?`,
            [platform_user_id]
        )
        var social_profile = profiles ? profiles[0] : null;

        if(!last_messages || last_messages.length == 0)
            message.content = `${message.content}
        

        this is the first message from customer 
        Person Name if exists is: ${social_profile?.display_name}
        Person Gender if exists is: ${social_profile?.gender}
        `
        else
            message.content = `${message.content}
        
        Last Customer Chat before this
        MID || Message || Source || Replying to MID || Time
        ${last_messages.map(msg=>`${msg.facebook_message_id} ||  ${msg.message_text} || ${msg.sender} || ${msg.reply_to_message_id ? msg.reply_to_message_id : 'None' } || ${msg.created}`).join("\n")}
        
        Person Name if exists is: ${social_profile?.display_name}
        Person Gender if exists is: ${social_profile?.gender}
        
        `
    }else if(platform_source == 'instagram_messages'){
        var last_messages = await query(
            `select * from instagram_messages 
             where lead_id = (select crm_lead_id from crm_lead_social_profiles where platform='instagram' and platform_user_id=? LIMIT 1) 
             order by id desc limit 4 offset 1`,
            [platform_user_id]
        )

        var social_profile = (await query(
            `select * from crm_lead_social_profiles 
             where platform = 'instagram' and platform_user_id=?`,
            [platform_user_id]
        ))[0]

        if(last_messages.length == 0)
            message.content = `${message.content}
        

        this is the first message from customer 
        Person Name if exists is: ${social_profile?.display_name}
        Person Gender if exists is: ${social_profile?.gender}
        `
        else
            message.content = `${message.content}
        
        Last Customer Chat before this
        MID || Message || Source || Replying to MID || Time
        ${last_messages.map(msg=>`${msg.instagram_message_id} ||  ${msg.message_text} || ${msg.sender} || ${msg.reply_to_message_id ? msg.reply_to_message_id : 'None' } || ${msg.created}`).join("\n")}
        
        Person Name if exists is: ${social_profile?.display_name}
        Person Gender if exists is: ${social_profile?.gender}
        
        `
    }
    

    console.log("Final message",message.content)
    var data = {
      messages:[message],
      temperature: 0,
      max_tokens: (messages[messages.length - 1].content.includes("LOCATION_DESCRIPTION") ? 2048 : 8192),
   //   repeat_penalty: 1.1
    } 
    
    let answer = await sendToAi(data)
 return answer
}

module.exports = {query, sendToAi, getResponse};
