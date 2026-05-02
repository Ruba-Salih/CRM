-- ==========================================================
-- CRM Ticketing System Refinement - Version 2.0
-- Description: Switching to Platform Strings, deleting crm_platforms table, 
-- and adding support for Reactions and Calls.
-- ==========================================================

SET FOREIGN_KEY_CHECKS = 0;

-- 1. Update crm_ticket_messages to support the simplified string-based platform approach
-- and new interaction types (reactions, calls).
ALTER TABLE `crm_ticket_messages` 
  DROP FOREIGN KEY `fk_msg_platform`,
  DROP COLUMN `platform_id`, 
  ADD COLUMN `platform` varchar(50) DEFAULT NULL AFTER `crm_ticket_id` 
    COMMENT 'Source platform name: whatsapp, facebook_post, facebook_message, tiktok, telegram, instagram, pstn, sms, etc.',
  MODIFY COLUMN `interaction_type` enum('message', 'comment', 'reaction', 'call') DEFAULT 'message'
    COMMENT 'Type of interaction for scoring and display',
  CHANGE COLUMN `external_id` `external_id` varchar(255) DEFAULT NULL 
    COMMENT 'The primary key ID from the source table (e.g., whatsapp_messages.id or crm_logs.id)';

-- 2. Delete the crm_platforms table as it is now redundant
DROP TABLE IF EXISTS `crm_platforms`;

-- 3. (Optional) If you have existing data, you might want to map old IDs to strings here.
-- Example: 
-- UPDATE crm_ticket_messages SET platform = 'facebook' WHERE platform_id = 1;


-- Add this to your migration script to prevent errors when adding calls/sms:
ALTER TABLE `crm_leads` 
  MODIFY COLUMN `source_platform` varchar(50) NOT NULL,
  MODIFY COLUMN `first_interaction_type` enum('comment','reaction','message','call') NOT NULL;

ALTER TABLE `crm_lead_social_profiles`
  MODIFY COLUMN `platform` enum('facebook','whatsapp','instagram','pstn','sms','tiktok', 'telegram') NOT NULL;


SET FOREIGN_KEY_CHECKS = 1;
