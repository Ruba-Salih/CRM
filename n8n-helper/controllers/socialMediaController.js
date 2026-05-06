
const { getResponse } = require('../utils/utils');

module.exports = {
    getChatCompletions: async (req, res) => {
      console.log("New Request")
    console.log("aiClient",aiClient)
  if (!aiClient) {
    return res.status(503).json({
      error: "AI client is not connected"
    });
  }  
  console.log("Header",req.header('Message-Platform-Source'))
    let platform_source,platform_user_id
    if(req.header('Message-Platform-Source')){
        platform_source = req.header('Message-Platform-Source').split(",")[0]
        platform_user_id = req.header('Message-Platform-Source').split(",")[1]
    }

  let answer = await getResponse(
      req.body.messages,
      platform_source,
      platform_user_id
  )
  // Return the answer to n8n
  res.send(answer);
}
};