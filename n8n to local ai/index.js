const io = require("socket.io-client");
const axios = require("axios");

const socket = io("https://n8n-helper.afro-tech.net", {
  transports: ["polling", "websocket"],
});

socket.on("connect", () => {
  console.log("Connected to VPS");

  socket.emit("register_ai_client", {
    token: "CR7Ra3tKIedrY1ya2AD9xa3Ds7tstYBwoXEJcfXLeirPR9CYP25eaDL4gCcSjo9H"
  });
});


socket.on("connect_error", (err) => {
  console.log("❌ connect_error:", err.message);
});

socket.on("error", (err) => {
  console.log("❌ socket error:", err);
});

socket.on("disconnect", (reason) => {
  console.log("⚠️ disconnected:", reason);
});

socket.on("reconnect_attempt", (attempt) => {
  console.log("🔄 reconnect attempt:", attempt);
});

socket.on("reconnect_failed", () => {
  console.log("❌ reconnect failed");
});


// Handle incoming AI requests from VPS
socket.on("request_to_ai", async (data) => {
  console.log("Received request:", data);

  try {
    // Call your local Qwen server
    const qwenRes = await axios.post("http://localhost:11434/v1/chat/completions", data);

    const answer = qwenRes.data.choices[0].message.content;

    // Send back to VPS
    socket.emit("response_from_ai", {
      requestId: data.requestId,
      answer
    });

  } catch (e) {
    socket.emit("response_from_ai", {
      requestId: data.requestId,
      answer: "Error: " + e.message
    });
  }
});
