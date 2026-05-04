const express = require("express");
const axios = require("axios");

const app = express();
app.use(express.json());

// Function to ask OPA
async function checkAccess(input) {
  const response = await axios.post(
    "http://localhost:8181/v1/data/auth/allow",
    {
      input
    }
  );
  return response.data.result === true;
}

//  Public Route
app.get("/", (req, res) => {
  res.send("API is running");
});

// Course access route
app.post("/course-access", async (req, res) => {
  try {
    const allowed = await checkAccess(req.body);

    if (allowed) {
      return res.json({ message: "Access Granted" });
    } else {
      return res.status(403).json({ message: "Access Denied" });
    }
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

// Start Server
app.listen(3000, () => {
  console.log("Server running on port 3000");
});