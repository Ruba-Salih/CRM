const { pool } = require("../db");
const { v4: uuid } = require("uuid");

async function query(q, params = []) {
    try {
        const [rows] = await pool.execute(q, params);
        return rows;
    } catch (err) {
        console.error("Database Query Error:", err);
        console.error("Query:", q);
        return null;
    }
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
    let message = messages.at(-1)
    
    
    // adding previous messages in query for classifier
    if(messages.at(-1).content.includes('classifier for user question')){
        if(messages.length == 1)
            message.content = `${message.content}
        

        this is the first message from customer
        `
        else if(messages.length>2)
            message.content = `${message.content}
        
        Last Customer Question before this Question is
        ((( ${messages.at(-3).content} )))
        
        and you answered by this:
        ((( ${messages.at(-2).content} )))
        `
        
        if(messages.length>4)
            message.content = `${message.content}
        
        and the Customer Question before even that Question is
        ((( ${messages.filter(message=>message.role=='user').at(-3).content} )))
        `
        
        if(messages.length>6)
            message.content = `${message.content}
        
        and the Customer Question before even above Question is
        ((( ${messages.filter(message=>message.role=='user').at(-4).content} )))
        `
    }
    
    
    // adding previous messages in query for chat
    else if(platform_source == 'messenger'){
        var last_messages = await query(
            `select * from facebook_messages 
             where conversation_id in 
                   (select id from facebook_conversations where facebook_user_id=?) 
             order by id desc limit 4 offset 1`,
            [platform_user_id]
        )

        var social_profile = (await query(
            `select * from crm_lead_social_profiles 
             where platform = 'facebook' and platform_user_id=?`,
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
        ${last_messages.map(msg=>`${msg.facebook_message_id} ||  ${msg.message_text} || ${msg.sender} || ${msg.reply_to_message_id ? msg.reply_to_message_id : 'None' } || ${msg.created}`).join("\n")}
        
        Person Name if exists is: ${social_profile?.display_name}
        Person Gender if exists is: ${social_profile?.gender}
        
        `
    }else if(platform_source == 'instagram_messages'){
        var last_messages = await query(
            `select * from instagram_messages 
             where conversation_id in 
                   (select id from instagram_conversations where instagram_user_id=?) 
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
      max_tokens: (messages.at(-1).content.includes("LOCATION_DESCRIPTION") ? 2048 : 8192),
   //   repeat_penalty: 1.1
    } 
    
    let answer = await sendToAi(data)
 return answer
}

module.exports = {query, sendToAi, getResponse};
