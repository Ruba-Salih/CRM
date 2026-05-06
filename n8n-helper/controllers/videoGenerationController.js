const { sendToAi } = require("../utils/utils");

module.exports = {
    videoGeneration : async (req, res) => { 
	console.log("New Request")
    console.log("aiClient",aiClient)
  if (!aiClient) {
    return res.status(503).json({
      error: "AI client is not connected"
    });
  }
  let content = req.body.messages[0].content
    console.log("contenct",content)
var data = {
	  messages:[
	  {
	    role:"user",
		content
	  }
	  ], 
	  temperature: 0,
	  max_tokens: 4096,
	}   
  console.log(req.get('AI-Agent-Request-Type'))
  let answer = await sendToAi(data)
  // Return the answer to n8n
    console.log("ANSWER",answer)
  res.send(answer);
}}