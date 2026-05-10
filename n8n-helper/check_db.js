const { pool } = require('./db.js');
async function check() {
  const [profiles] = await pool.query("SELECT * FROM crm_lead_social_profiles WHERE platform_user_id='26283576554564724'");
  console.log('Profiles:', profiles.length);
  const [convs] = await pool.query("SELECT * FROM facebook_conversations c JOIN crm_lead_social_profiles p ON p.crm_lead_id = c.lead_id WHERE p.platform_user_id='26283576554564724'");
  console.log('Conversations:', convs.length);
  process.exit(0);
}
check();
